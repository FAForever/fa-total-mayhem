-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Scavenger Medium Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeaponsFile = import('/lua/aeonweapons.lua')
local ACruiseMissileWeapon = AWeaponsFile.ACruiseMissileWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

BRNT2EXM2 = Class(TLandUnit){
    Weapons = {
        rocket = Class(ACruiseMissileWeapon){
            FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
            FxMuzzleFlashScale = 3.2,
        },
        rocket2 = Class(ACruiseMissileWeapon){
            FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
            FxMuzzleFlashScale = 3.2,
        },
        robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TLandUnit.OnStopBeingBuilt(self, builder, layer)
        if self:GetAIBrain().BrainType == 'Human' then
            self:SetWeaponEnabledByLabel('rocket2', false)
            self:SetWeaponEnabledByLabel('robottalk', false)
        end
        self.AnimManip = CreateAnimator(self)
        self.Trash:Add(self.AnimManip)
        self:RemoveCommandCap('RULEUCC_Attack')
        self:SetWeaponEnabledByLabel('rocket', false)
    end,
    ActiveState = State{ Main = function(self)
        self:SetImmobile(true)
        self.AnimManip:PlayAnim(self.Blueprint.Display.AnimationTransform)
        self.AnimManip:SetRate(0.5)
        WaitFor(self.AnimManip)
        self:SetWeaponEnabledByLabel('rocket', true)
        self:AddCommandCap('RULEUCC_Attack')
    end },
    InActiveState = State{ Main = function(self)
        self:SetImmobile(true)
        self:RemoveCommandCap('RULEUCC_Attack')
        self:SetWeaponEnabledByLabel('rocket', false)
        self.AnimManip:SetRate(-1)
        self.AnimManip:PlayAnim(self.Blueprint.Display.AnimationTransform)
        self.AnimManip:SetAnimationFraction(1)
        WaitFor(self.AnimManip)
        self:SetImmobile(false)
    end },
    OnScriptBitSet = function(self, bit)
        TLandUnit.OnScriptBitSet(self, bit)
        if bit == 7 then
            ChangeState(self, self.ActiveState)
        end
    end,
    OnScriptBitClear = function(self, bit)
        TLandUnit.OnScriptBitClear(self, bit)
        if bit == 7 then
            ChangeState(self, self.InActiveState)
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        TLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['UEFHEAVYROCKET'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BRNT2EXM2', army, v):ScaleEmitter(1.0))
        end
    end,
}

TypeClass = BRNT2EXM2

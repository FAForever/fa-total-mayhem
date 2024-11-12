-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Tiger Light Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

BRNT2SNIPER = Class(TLandUnit){
    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 4.5,
            FxMuzzleFlash = EffectTemplate.TPlasmaCannonHeavyMuzzleFlash,
        },
        rockets = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TLandUnit.OnStopBeingBuilt(self, builder, layer)

        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        TLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['UEFDeath03'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Object04', army, v):ScaleEmitter(1.3))
        end
    end,
}

TypeClass = BRNT2SNIPER

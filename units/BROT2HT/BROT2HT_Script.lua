----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
--  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--
--  Summary  :  BRN Tiger Light Tank
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local AHoverLandUnit = import('/lua/aeonunits.lua').AHoverLandUnit
local AWeapons = import('/lua/aeonweapons.lua')
local ADFCannonOblivionWeapon = AWeapons.ADFCannonOblivionWeapon
local ADFDisruptorCannonWeapon = AWeapons.ADFDisruptorCannonWeapon
local ADFCannonQuantumWeapon = AWeapons.ADFCannonQuantumWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon

BROT2HT = Class(AHoverLandUnit){
    Weapons = {
        autoattack = Class(AutoAttackWeapon){ FxMuzzleFlashScale = 0.0 },
        MainGun = Class(ADFCannonOblivionWeapon){
            FxMuzzleFlashScale = 0.4,
            FxMuzzleChargeScale = 0.4,
        },
        mgweapon = Class(ADFDisruptorCannonWeapon){},
        mgweapon2 = Class(ADFCannonQuantumWeapon){ FxMuzzleFlash = EffectTemplate.AQuantumCannonMuzzle02 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        AHoverLandUnit.OnStopBeingBuilt(self, builder, layer)
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        AHoverLandUnit.OnDetachedFromTransport(self, transport, bone)
        self.SetAIAutoattackWeapon(self)
    end,
    SetAIAutoattackWeapon = function(self)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        AHoverLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['AeonUnitDeathRing01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BROT2HT', army, v):ScaleEmitter(0.75))
        end
    end,
}

TypeClass = BROT2HT

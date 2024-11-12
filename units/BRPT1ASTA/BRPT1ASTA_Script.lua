----------------------------------------------------------------------------
--
--  File     :  /data/units/XSL0201/XSL0201_script.lua
--  Author(s):  Jessica St. Croix, Greg Kohne, Aaron Lundquist
--
--  Summary  :  Seraphim Medium Tank Script
--
--  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local SDFOhCannon = import('/lua/seraphimweapons.lua').SDFOhCannon
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRPT1ASTA = Class(SLandUnit){
    Weapons = {
        MainGun = Class(SDFOhCannon){},
        autoattack = Class(AutoAttackWeapon){ FxMuzzleFlashScale = 0.0 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        SLandUnit.OnStopBeingBuilt(self, builder, layer)
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        SLandUnit.OnDetachedFromTransport(self, transport, bone)
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
        SLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['SDFExperimentalPhasonProjHit01'] do
            CreateAttachedEmitter(self, 'BRPT1ASTA', army, v):ScaleEmitter(0.7)
        end
    end,
}

TypeClass = BRPT1ASTA

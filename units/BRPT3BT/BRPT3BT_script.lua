----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/XAL0104/XAL0104_script.lua
--  Author(s):  Jessica St. Croix, Gordon Duclos
--
--  Summary  :  Seraphim Mobile Anti-Air Script
--
--  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local SLandUnit = import('/lua/seraphimunits.lua').SLandUnit
local SDFOhCannon = import('/lua/seraphimweapons.lua').SDFOhCannon
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon
local SDFHeavyQuarnonCannon = SeraphimWeapons.SDFHeavyQuarnonCannon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRPT3BT = Class(SLandUnit){
    Weapons = {
        TauCannon01 = Class(SDFOhCannon){ FxMuzzleFlashScale = 1.5 },
        FrontTurret = Class(SDFHeavyQuarnonCannon){ FxMuzzleFlashScale = 0.5 },
        autoattack = Class(AutoAttackWeapon){ FxMuzzleFlashScale = 0.0 },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        SLandUnit.OnStopBeingBuilt(self, builder, layer)
        self:CreatTheEffects()
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
    CreatTheEffects = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'muzzle', army, v):ScaleEmitter(0.15))
        end
        for k, v in EffectTemplate['OthuyAmbientEmanation'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(0.08))
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        SLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['SDFExperimentalPhasonProjHit01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BRPT3BT', army, v):ScaleEmitter(0.7))
        end
    end,
}
TypeClass = BRPT3BT

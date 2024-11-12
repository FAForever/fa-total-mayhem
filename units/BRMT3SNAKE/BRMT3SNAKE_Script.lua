-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Scavenger Medium Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local CWalkingLandUnit = import('/lua/cybranunits.lua').CWalkingLandUnit
local WeaponsFile = import('/lua/cybranweapons.lua')
local WeaponsFile2 = import('/lua/terranweapons.lua')
local TMWeaponsFile = import('/mods/fa-total-mayhem/lua/TMAeonWeapons.lua')
local CDFElectronBolterWeapon = WeaponsFile.CDFElectronBolterWeapon
local TMCSpiderLaserweapon = TMWeaponsFile.TMCSpiderLaserweapon
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TDFGaussCannonWeapon = WeaponsFile2.TDFLandGaussCannonWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRMT3SNAKE = Class(CWalkingLandUnit){
    Weapons = {
        main = Class(TMCSpiderLaserweapon){
            FxMuzzleFlash = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
            FxMuzzleFlashScale = 1.0,
        },
        MainGun = Class(CDFElectronBolterWeapon){ FxMuzzleFlashScale = 1.0 },
        HeavyBoltera = Class(CDFElectronBolterWeapon){},
        rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.7 },
        DeathWeapon = Class(SCUDeathWeapon){},
    },
    OnStopBeingBuilt = function(self, builder, layer)
        CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Object04', 'z', nil, 650, 0, 0))
        self.Trash:Add(CreateRotator(self, 'Object03', 'z', nil, -650, 0, 0))
        self:CreatTheEffects()

        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('robottalk', false)
        else
            self:SetWeaponEnabledByLabel('robottalk', true)
        end
    end,
    CreatTheEffects = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Object04', army, v):ScaleEmitter(6.00))
        end
        for k, v in TMEffectTemplate['BRMT3EXBMPOWEREFFECT'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Object03', army, v):ScaleEmitter(6.00))
        end
        for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Object04', army, v):ScaleEmitter(1))
        end
        for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Object03', army, v):ScaleEmitter(1))
        end
        for k, v in EffectTemplate['OthuyAmbientEmanation'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Object04', army, v):ScaleEmitter(0.3))
        end
        for k, v in EffectTemplate['OthuyAmbientEmanation'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Object03', army, v):ScaleEmitter(0.3))
        end
        for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(0.14))
        end
        for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'eff02', army, v):ScaleEmitter(0.14))
        end
        for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'eff03', army, v):ScaleEmitter(0.14))
        end
        for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'eff04', army, v):ScaleEmitter(0.14))
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        CWalkingLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['MadCatDeath01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(1.5))
        end
    end,
}

TypeClass = BRMT3SNAKE

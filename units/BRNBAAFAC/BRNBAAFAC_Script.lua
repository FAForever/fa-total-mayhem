-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Scavenger Medium Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

BRNBAAFAC = Class(TStructureUnit){
    Weapons = { MainGun = Class(TDFGaussCannonWeapon){
        FxMuzzleFlashScale = 0.5,
        FxMuzzleFlash = EffectTemplate.CIFCruiseMissileLaunchSmoke,
    } },
    OnStopBeingBuilt = function(self, builder, layer)
        TStructureUnit.OnStopBeingBuilt(self, builder, layer)

        self:CreatTheEffects()
    end,
    CreatTheEffects = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Dummy01', army, v):ScaleEmitter(1.35))
        end
        for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Dummy02', army, v):ScaleEmitter(1.35))
        end
        for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Dummy03', army, v):ScaleEmitter(1.35))
        end
        for k, v in EffectTemplate['SmokePlumeMedDensitySml01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Dummy04', army, v):ScaleEmitter(1.35))
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        TStructureUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['UEFDeath01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'death', army, v):ScaleEmitter(1.25))
        end
    end,
}

TypeClass = BRNBAAFAC

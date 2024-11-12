-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEB2301/UEB2301_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  UEF Heavy Gun Tower Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TStructureUnit = import('/lua/terranunits.lua').TStructureUnit
local SDFAireauBolterWeapon = import('/lua/seraphimweapons.lua').SDFAireauBolterWeapon02
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRPT1ADVNAVYGUN = Class(TStructureUnit){
    Weapons = { MainGun = Class(SDFAireauBolterWeapon){ FxMuzzleFlashScale = 2.4 } },
    OnStopBeingBuilt = function(self, builder, layer)
        TStructureUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'spinner', 'y', nil, -150, 0, 0))
        self:CreatTheEffects()
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        TStructureUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffects = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'eff02', army, v):ScaleEmitter(0.18))
        end
        for k, v in EffectTemplate['SDFSinnutheWeaponFXTrails01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'eff01', army, v):ScaleEmitter(0.18))
        end
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['SZthuthaamArtilleryHit'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BRPT1ADVNAVYGUN', army, v):ScaleEmitter(2.85))
        end
    end,
}

TypeClass = BRPT1ADVNAVYGUN

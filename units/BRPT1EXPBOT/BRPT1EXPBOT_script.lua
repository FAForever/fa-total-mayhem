-- ****************************************************************************
-- **
-- **  File     :  /units/XSLconcept/XSLconcept_script.lua
-- **  Author(s):  Drew Staltman, Jessica St. Croix, Gordon Duclos
-- **
-- **  Summary  :  Seraphim Concept Script
-- **
-- **  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local SWalkingLandUnit = import('/lua/seraphimunits.lua').SWalkingLandUnit
local SeraphimWeapons = import('/lua/seraphimweapons.lua')
local SAAOlarisCannonWeapon = SeraphimWeapons.SAAOlarisCannonWeapon
local SDFThauCannon = SeraphimWeapons.SDFThauCannon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRPT1EXPBOT = Class(SWalkingLandUnit){
    Weapons = {
        autoattack = Class(SAAOlarisCannonWeapon){ FxMuzzleFlashScale = 0.0 },
        RightAAGun = Class(SAAOlarisCannonWeapon){},
        MainTurret = Class(SDFThauCannon){},
    },
    OnStopBeingBuilt = function(self, builder, layer)
        SWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        SWalkingLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['SDFExperimentalPhasonProjHit01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BRPT1EXPBOT', army, v):ScaleEmitter(2.3))
        end
    end,
}

TypeClass = BRPT1EXPBOT

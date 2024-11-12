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
local TMWeaponsFile = import('/mods/fa-total-mayhem/lua/TMAeonWeapons.lua')
local SAAOlarisCannonWeapon = SeraphimWeapons.SAAOlarisCannonWeapon
local SDFAireauWeapon = SeraphimWeapons.SDFAireauWeapon
local SDFUltraChromaticBeamGenerator = SeraphimWeapons.SDFUltraChromaticBeamGenerator02
local TMCSpiderLaserweapon = TMWeaponsFile.TMCSpiderLaserweapon
local SDFSinnuntheWeapon = SeraphimWeapons.SDFSinnuntheWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

BRPT3SHBM = Class(SWalkingLandUnit){
    SpawnEffects = {
        '/effects/emitters/seraphim_othuy_spawn_01_emit.bp',
        '/effects/emitters/seraphim_othuy_spawn_02_emit.bp',
        '/effects/emitters/seraphim_othuy_spawn_03_emit.bp',
        '/effects/emitters/seraphim_othuy_spawn_04_emit.bp',
    },
    Weapons = {
        autoattack = Class(SAAOlarisCannonWeapon){ FxMuzzleFlashScale = 0.0 },
        frontmg1 = Class(SDFAireauWeapon){},
        topgun = Class(SDFSinnuntheWeapon){},
        BackTurret = Class(TMCSpiderLaserweapon){ FxMuzzleFlashScale = 1.4 },
        aa1 = Class(SDFUltraChromaticBeamGenerator){ FxMuzzleFlashScale = 2.4 },
        aa2 = Class(SDFUltraChromaticBeamGenerator){ FxMuzzleFlashScale = 2.4 },
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
        for k, v in TMEffectTemplate['SerT3SHBMDeath'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Arm01', army, v):ScaleEmitter(2.8))
        end
    end,
    OnDestroy = function(self)
        SWalkingLandUnit.OnDestroy(self)

        -- Don't make the energy being if not built
        if self:GetFractionComplete() ~= 1 then return end

        -- Spawn the Energy Being
        local position = self:GetPosition()
        local spiritUnit = CreateUnitHPR('XSL0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)
        local spiritUnit = CreateUnitHPR('XSL0402', self:GetArmy(), position[1], position[2], position[3], 0, 0, 0)

        -- Create effects for spawning of energy being
        for k, v in self.SpawnEffects do
            CreateAttachedEmitter(spiritUnit, -1, self:GetArmy(), v)
        end
    end,
}
TypeClass = BRPT3SHBM

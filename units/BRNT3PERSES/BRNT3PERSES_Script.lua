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
local TDFGaussCannonWeapon = import('/lua/terranweapons.lua').TDFGaussCannonWeapon
local WeaponsFile = import('/lua/terranweapons.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local TMMMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMavaEffectTemplates.lua')

BRNT3PERSES = Class(TStructureUnit){
    Weapons = {
        Gauss01 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlash = EffectTemplate.TShipGaussCannonFlash,
            FxMuzzleFlashScale = 1.15,
        },
        Gauss02 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlash = EffectTemplate.TShipGaussCannonFlash,
            FxMuzzleFlashScale = 1.15,
        },
        Gauss03 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlash = EffectTemplate.TShipGaussCannonFlash,
            FxMuzzleFlashScale = 1.15,
        },
        Gauss04 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlash = EffectTemplate.TShipGaussCannonFlash,
            FxMuzzleFlashScale = 1.15,
        },
        DeathWeapon = Class(SCUDeathWeapon){},
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TStructureUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Object05', 'y', nil, -230, 0, 0))

        self:CreatTheEffects()
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        TStructureUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffects = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['CSoothSayerAmbient'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'perimetereff', army, v):ScaleEmitter(0.25))
        end
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMMMEffectTemplate['UEFmayhemRocketHit2A'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Object42', army, v):ScaleEmitter(2.25))
        end
        for k, v in TMEffectTemplate['UEFDeath02'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Object17', army, v):ScaleEmitter(2.75))
        end
    end,
}

TypeClass = BRNT3PERSES

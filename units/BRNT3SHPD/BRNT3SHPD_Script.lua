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
local TSAMLauncher = WeaponsFile.TSAMLauncher
local TMMMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMavaEffectTemplates.lua')

BRNT3SHPD = Class(TStructureUnit){
    Weapons = {
        Gauss01 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlash = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
            FxMuzzleFlashScale = 3.75,
        },
        DeathWeapon = Class(SCUDeathWeapon){},
        MissileRack01 = Class(TSAMLauncher){},
        missile01 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlash = EffectTemplate.TPlasmaGatlingCannonMuzzleFlash,
            FxMuzzleFlashScale = 0.0,
        },
    },
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        TStructureUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMMMEffectTemplate['UEFmayhemRocketHit2A'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Turret', army, v):ScaleEmitter(2.25))
        end
    end,
}

TypeClass = BRNT3SHPD

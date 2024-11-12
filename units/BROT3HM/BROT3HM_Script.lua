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
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon

BROT3HM = Class(CWalkingLandUnit){
    Weapons = {
        autoattack = Class(AutoAttackWeapon){ FxMuzzleFlashScale = 0.0 },
        DeathWeapon = Class(SCUDeathWeapon){},
        MainGun = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 0.2,
            FxMuzzleFlash = EffectTemplate.AOblivionCannonMuzzleFlash02,
        },
        MainGun2 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1,
            FxMuzzleFlash = EffectTemplate.AIFBallisticMortarFlash02,
        },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        CWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)

        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
}

TypeClass = BROT3HM

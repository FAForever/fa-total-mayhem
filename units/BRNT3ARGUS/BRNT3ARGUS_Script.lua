-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  BRN Scavenger Medium Tank
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TWalkingLandUnit = import('/lua/terranunits.lua').TWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BRNT3ARGUS = Class(TWalkingLandUnit){
    Weapons = {
        robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
        bigguns = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 8.0,
            FxMuzzleFlash = EffectTemplate.TFlakCannonMuzzleFlash01,
        },
        medguns = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 7.5,
            FxMuzzleFlash = EffectTemplate.TRailGunMuzzleFlash01,
        },
        smallguns = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1.6,
            FxMuzzleFlash = EffectTemplate.TIonizedPlasmaGatlingCannonMuzzleFlash,
        },
        smallerguns = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 1,
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
        },
        smallerguns2 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 4.4,
            FxMuzzleFlash = EffectTemplate.OhCannonMuzzleFlash02,
        },
        smallerguns3 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 4.4,
            FxMuzzleFlash = EffectTemplate.OhCannonMuzzleFlash02,
        },
        smallerguns4 = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 4.4,
            FxMuzzleFlash = EffectTemplate.OhCannonMuzzleFlash02,
        },
        DeathWeapon = Class(SCUDeathWeapon){},
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)

        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('robottalk', false)
        else
            self:SetWeaponEnabledByLabel('robottalk', true)
        end
    end,
}

TypeClass = BRNT3ARGUS

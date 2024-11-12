-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UAL0401/UAL0401_script.lua
-- **  Author(s):  John Comes, Gordon Duclos
-- **
-- **  Summary  :  Aeon Galactic Colossus Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************
local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BROT3SHBM = Class(AWalkingLandUnit){
    Weapons = {
        MainGun = Class(TDFGaussCannonWeapon){
            FxMuzzleFlashScale = 4.85,
            FxMuzzleFlash = EffectTemplate.AIFBallisticMortarFlash02,
        },
        Riotgun = Class(TDFRiotWeapon){
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
            FxMuzzleFlashScale = 0.75,
        },
        EMPgun = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        robottalk = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0 },
        DeathWeapon = Class(SCUDeathWeapon){},
    },
    OnStopBeingBuilt = function(self, builder, layer)
        AWalkingLandUnit.OnStopBeingBuilt(self, builder, layer)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('robottalk', false)
        else
            self:SetWeaponEnabledByLabel('robottalk', true)
        end
    end,
}
TypeClass = BROT3SHBM

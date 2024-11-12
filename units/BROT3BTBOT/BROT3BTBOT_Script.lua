local AWalkingLandUnit = import('/lua/aeonunits.lua').AWalkingLandUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AWeapons = import('/lua/aeonweapons.lua')
local SCUDeathWeapon = import('/lua/sim/defaultweapons.lua').SCUDeathWeapon
local AAAZealotMissileWeapon = AWeapons.AAAZealotMissileWeapon
local TDFRiotWeapon = WeaponsFile.TDFRiotWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')

BROT3BTBOT = Class(AWalkingLandUnit){
    Weapons = {
        robottalk = Class(AAAZealotMissileWeapon){ FxMuzzleFlashScale = 0 },
        RightRiotgun = Class(TDFRiotWeapon){
            FxMuzzleFlash = EffectTemplate.TRiotGunMuzzleFxTank,
            FxMuzzleFlashScale = 0.75,
        },
        MainGun = Class(TDFRiotWeapon){
            FxMuzzleFlash = EffectTemplate.AIFBallisticMortarFlash02,
            FxMuzzleFlashScale = 2,
        },
        Rockets = Class(TDFRiotWeapon){
            FxMuzzleFlash = EffectTemplate.AIFBallisticMortarFlash02,
            FxMuzzleFlashScale = 3,
        },
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
TypeClass = BROT3BTBOT

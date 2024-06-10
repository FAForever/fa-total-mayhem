local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon
local TMCollisionBeamFile = import('/mods/fa-total-mayhem/lua/TMcollisionbeams.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')

---@class TMAnovacatbluelaserweapon : DefaultBeamWeapon
TMAnovacatbluelaserweapon = Class(DefaultBeamWeapon){
	BeamType = TMCollisionBeamFile.TMNovaCatBlueLaserBeam,
	FxMuzzleFlash = {},
	FxChargeMuzzleFlash = {},
	FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
	FxUpackingChargeEffectScale = 1,
}

---@class TMCSpiderLaserweapon : DefaultBeamWeapon
TMCSpiderLaserweapon = Class(DefaultBeamWeapon){
	BeamType = TMCollisionBeamFile.TMSpiderBeam,
	FxMuzzleFlash = EffectTemplate.SExperimentalUnstablePhasonLaserMuzzle01,
	FxChargeMuzzleFlash = {},
	FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
	FxUpackingChargeEffectScale = 2,
}

---@class TMAcougarbluelaserweapon : DefaultBeamWeapon
TMAcougarbluelaserweapon = Class(DefaultBeamWeapon){
	BeamType = TMCollisionBeamFile.TMCougarBlueLaserBeam,
	FxMuzzleFlash = {},
	FxChargeMuzzleFlash = {},
	FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
	FxUpackingChargeEffectScale = 1,
}

---@class TMAnovacatgreenlaserweapon : DefaultBeamWeapon
TMAnovacatgreenlaserweapon = Class(DefaultBeamWeapon){
	BeamType = TMCollisionBeamFile.TMNovaCatGreenLaserBeam,
	FxMuzzleFlash = {},
	FxChargeMuzzleFlash = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
	FxUpackingChargeEffects = EffectTemplate.SDFExperimentalPhasonProjChargeMuzzleFlash,
	FxUpackingChargeEffectScale = 1,
}

---@class TMAmizurabluelaserweapon : DefaultBeamWeapon
TMAmizurabluelaserweapon = Class(DefaultBeamWeapon){
	BeamType = TMCollisionBeamFile.TMMizuraBlueLaserBeam,
	FxMuzzleFlash = {},
	FxChargeMuzzleFlash = {},
	FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
	FxUpackingChargeEffectScale = 1,
}

---@class TMMadCatmk4laserweapon : DefaultBeamWeapon
TMMadCatmk4laserweapon = Class(DefaultBeamWeapon){
	BeamType = TMCollisionBeamFile.TMMadCatmk4Beam,
	FxMuzzleFlash = {},
	FxChargeMuzzleFlash = {},
	FxUpackingChargeEffects = EffectTemplate.CMicrowaveLaserCharge01,
	FxUpackingChargeEffectScale = 1,
}
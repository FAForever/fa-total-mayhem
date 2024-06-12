local WeaponFile = import('/lua/sim/DefaultWeapons.lua')
local TMCollisionBeamFile = import('/mods/fa-total-mayhem/lua/TMcollisionbeams.lua')
local EffectTemplate = import('/lua/EffectTemplates.lua')
local DefaultBeamWeapon = WeaponFile.DefaultBeamWeapon

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
---------------------------------------------
--#region Mod Compatability

local DefaultProjectileWeapon = WeaponFile.DefaultProjectileWeapon
local BareBonesWeapon = WeaponFile.BareBonesWeapon
local KamikazeWeapon = WeaponFile.KamikazeWeapon
local CollisionBeamFile = import('/lua/defaultcollisionbeams.lua')
local Explosion = import('/lua/defaultexplosions.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local Util = import('/lua/utilities.lua')
local TMNovaCatBlueLaserBeam = TMCollisionBeamFile.TMNovaCatBlueLaserBeam
local TMNovaCatGreenLaserBeam = TMCollisionBeamFile.TMNovaCatGreenLaserBeam
local TMMizuraBlueLaserBeam = TMCollisionBeamFile.TMMizuraBlueLaserBeam
local TMMadCatmk4Beam = TMCollisionBeamFile.TMMadCatmk4Beam
local TMSpiderBeam = TMCollisionBeamFile.TMSpiderBeam

--#endregion
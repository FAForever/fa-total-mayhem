local CollisionBeam = import('/lua/sim/CollisionBeam.lua').CollisionBeam
local EffectTemplate = import('/lua/EffectTemplates.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

---@class TMCollisionBeam : CollisionBeam
TMCollisionBeam = Class(CollisionBeam){
	FxImpactUnit = EffectTemplate.DefaultProjectileLandUnitImpact,
	FxImpactLand = {}, -- EffectTemplate.DefaultProjectileLandImpact,
	FxImpactWater = EffectTemplate.DefaultProjectileWaterImpact,
	FxImpactUnderWater = EffectTemplate.DefaultProjectileUnderWaterImpact,
	FxImpactAirUnit = EffectTemplate.DefaultProjectileAirUnitImpact,
	FxImpactProp = {},
	FxImpactShield = {},
	FxImpactNone = {},
}

---@class TMNovaCatBlueLaserBeam : TMCollisionBeam
TMNovaCatBlueLaserBeam = Class(TMCollisionBeam){
	TerrainImpactType = 'LargeBeam01',
	TerrainImpactScale = 0.2,
	FxBeamStartPointScale = 0.8,
	FxBeamStartPoint = EffectTemplate.SDFExperimentalPhasonProjMuzzleFlash,
	FxBeam = { '/mods/fa-total-mayhem/effects/emitters/novacat_bluelaser_emit.bp' },
	FxBeamEndPoint = TMEffectTemplate.AeonNocaCatBlueLaserHit,
	FxBeamEndPointScale = 0.5,
	SplatTexture = 'czar_mark01_albedo',
	ScorchSplatDropTime = 0.25,
}

---@class TMCougarBlueLaserBeam : TMCollisionBeam
TMCougarBlueLaserBeam = Class(TMCollisionBeam){
	TerrainImpactType = 'LargeBeam01',
	TerrainImpactScale = 0.2,
	FxBeamStartPointScale = 0.35,
	FxBeamStartPoint = EffectTemplate.SDFExperimentalPhasonProjMuzzleFlash,
	FxBeam = { '/mods/fa-total-mayhem/effects/emitters/novacat_bluelaser_emit.bp' },
	FxBeamEndPoint = TMEffectTemplate.AeonCougarBlueLaserHit,
	FxBeamEndPointScale = 0.35,
	SplatTexture = 'czar_mark01_albedo',
	ScorchSplatDropTime = 0.25,
}

---@class TMNovaCatGreenLaserBeam : TMCollisionBeam
TMNovaCatGreenLaserBeam = Class(TMCollisionBeam){
	TerrainImpactType = 'LargeBeam01',
	TerrainImpactScale = 0.2,
	FxBeamStartPointScale = 1.4,
	FxBeamStartPoint = EffectTemplate.SDFExperimentalPhasonProjMuzzleFlash,
	FxBeam = { '/mods/fa-total-mayhem/effects/emitters/novacat_greenlaser_emit.bp' },
	FxBeamEndPoint = EffectTemplate.APhasonLaserImpact01,
	FxBeamEndPointScale = 2.0,
	SplatTexture = 'czar_mark01_albedo',
	ScorchSplatDropTime = 0.25,
}

---@class TMSpiderBeam : TMCollisionBeam
TMSpiderBeam = Class(TMCollisionBeam){
	TerrainImpactType = 'LargeBeam01',
	TerrainImpactScale = 0.8,
	FxBeamStartPointScale = 1.4,
	FxBeamStartPoint = EffectTemplate.SDFExperimentalPhasonProjMuzzleFlash,
	FxBeam = { '/mods/fa-total-mayhem/effects/emitters/battlespider_laser_emit.bp' },
	FxBeamEndPoint = EffectTemplate.APhasonLaserImpact01,
	FxBeamEndPointScale = 2.0,
	SplatTexture = 'czar_mark01_albedo',
	ScorchSplatDropTime = 0.4,
}

---@class TMMizuraBlueLaserBeam : TMCollisionBeam
TMMizuraBlueLaserBeam = Class(TMCollisionBeam){
	TerrainImpactType = 'LargeBeam01',
	TerrainImpactScale = 0.2,
	FxBeamStartPointScale = 1.2,
	FxBeamStartPoint = EffectTemplate.ASDisruptorCannonMuzzle01,
	FxBeam = { '/mods/fa-total-mayhem/effects/emitters/mizura_bluelaser_emit.bp' },
	FxBeamEndPoint = TMEffectTemplate.AeonNocaCatBlueLaserHit,
	FxBeamEndPointScale = 0.07,
	SplatTexture = 'czar_mark01_albedo',
	ScorchSplatDropTime = 0.25,
}

---@class TMMadCatmk4Beam : TMCollisionBeam
TMMadCatmk4Beam = Class(TMCollisionBeam){
	TerrainImpactType = 'LargeBeam01',
	TerrainImpactScale = 0.2,
	FxBeamStartPointScale = 1.2,
	FxBeamStartPoint = EffectTemplate.CMicrowaveLaserMuzzle01,
	FxBeam = { '/mods/fa-total-mayhem/effects/emitters/madcatmk4laser_emit.bp' },
	FxBeamEndPoint = EffectTemplate.CMicrowaveLaserEndPoint01,
	FxBeamEndPointScale = 1.00,
	SplatTexture = 'czar_mark01_albedo',
	ScorchSplatDropTime = 0.25,
}
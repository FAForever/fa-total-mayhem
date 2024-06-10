local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile

--- Aeon Tech 3 Tank Hunter
---@class AeonBROT3THproj : MultiPolyTrailProjectile
AeonBROT3THproj = Class(MultiPolyTrailProjectile){
	FxImpactTrajectoryAligned = false,
	FxTrails = EffectTemplate.TIonizedPlasmaGatlingCannonFxTrails,
	PolyTrails = {},
	PolyTrailOffset = { 0, 0 },
	FxImpactUnit = TMEffectTemplate.AeonT3HeavyRocketHit01,
	FxUnitHitScale = 1,
	FxImpactProp = TMEffectTemplate.AeonT3HeavyRocketHit01,
	FxPropHitScale = 1,
	FxImpactLand = TMEffectTemplate.AeonT3HeavyRocketHit01,
	FxLandHitScale = 1,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
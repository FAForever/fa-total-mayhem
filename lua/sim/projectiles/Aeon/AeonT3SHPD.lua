local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile

--- Aeon Tech 3 Super Heavy Point Defense
---@class AeonT3SHPDproj : MultiPolyTrailProjectile
AeonT3SHPDproj = Class(MultiPolyTrailProjectile){
	FxImpactTrajectoryAligned = false,
	FxTrails = EffectTemplate.TIonizedPlasmaGatlingCannonFxTrails,
	PolyTrails = {},
	PolyTrailOffset = { 0, 0 },
	FxImpactUnit = EffectTemplate.TIonizedPlasmaGatlingCannonHit01,
	FxUnitHitScale = 7,
	FxImpactProp = EffectTemplate.TIonizedPlasmaGatlingCannonHit01,
	FxPropHitScale = 7,
	FxImpactLand = EffectTemplate.TIonizedPlasmaGatlingCannonHit01,
	FxLandHitScale = 7,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile

--- Aeon Tech 1 Experimental Mobile Artillery Child projectile
---@class AeonBROT1EXMOBART2proj : MultiPolyTrailProjectile
AeonBROT1EXMOBART2proj = Class(MultiPolyTrailProjectile){
	FxImpactTrajectoryAligned = false,
	FxTrails = EffectTemplate.TIonizedPlasmaGatlingCannonFxTrails,
	PolyTrails = {},
	PolyTrailOffset = { 0, 0 },
	FxImpactUnit = TMEffectTemplate.AeonExpT1ArtilleryHit,
	FxUnitHitScale = 1,
	FxImpactProp = TMEffectTemplate.AeonExpT1ArtilleryHit,
	FxPropHitScale = 1,
	FxImpactLand = TMEffectTemplate.AeonExpT1ArtilleryHit,
	FxLandHitScale = 1,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
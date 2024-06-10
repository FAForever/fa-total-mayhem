local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile

--- Aeon Tech 3 NovaCat Rapid Pulsegun
---@class SinglePolyTrailProjectile : MultiPolyTrailProjectile
AeonBROT3NCMPproj = Class(SinglePolyTrailProjectile){
	FxImpactTrajectoryAligned = false,
	FxTrails = EffectTemplate.TIonizedPlasmaGatlingCannonFxTrails,
	PolyTrails = {},
	PolyTrailOffset = { 0, 0 },
	FxImpactUnit = EffectTemplate.AMercyGuidedMissileSplitMissileHitUnit,
	FxUnitHitScale = 1,
	FxImpactProp = EffectTemplate.AMercyGuidedMissileSplitMissileHitUnit,
	FxPropHitScale = 1,
	FxImpactLand = EffectTemplate.AMercyGuidedMissileSplitMissileHitUnit,
	FxLandHitScale = 1,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
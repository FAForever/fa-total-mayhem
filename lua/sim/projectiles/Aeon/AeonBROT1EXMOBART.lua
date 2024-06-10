local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile

--- Aeon Tech 1 Experimental Mobile Artillery Main projectile
---@class AeonBROT3NCNlaserproj : MultiPolyTrailProjectile
AeonBROT1EXMOBARTproj = Class(MultiPolyTrailProjectile){
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
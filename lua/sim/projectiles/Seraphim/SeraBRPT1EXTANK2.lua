local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile

--- Seraphim Tech 1 Advanced Assault Tank
---@class SerBRPT1EXTANK2proj : MultiPolyTrailProjectile
SerBRPT1EXTANK2proj = Class(MultiPolyTrailProjectile){
	FxImpactTrajectoryAligned = false,
	FxTrails = EffectTemplate.SChronotronCannonProjectileFxTrails,
	PolyTrails = EffectTemplate.SChronotronCannonProjectileTrails,
	PolyTrailOffset = { 0, 0, 0 },
	FxImpactUnit = TMEffectTemplate.SerT1AdvancedTankHit01,
	FxUnitHitScale = 1.6,
	FxImpactProp = TMEffectTemplate.SerT1AdvancedTankHit01,
	FxPropHitScale = 1.6,
	FxImpactLand = TMEffectTemplate.SerT1AdvancedTankHit01,
	FxLandHitScale = 1.6,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
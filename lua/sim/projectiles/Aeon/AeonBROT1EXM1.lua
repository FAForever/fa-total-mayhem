local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile

--- Aeon Tech 1 Experimental Quadrobot maingun
---@class AeonBROT1EXM1proj : MultiPolyTrailProjectile
AeonBROT1EXM1proj = Class(MultiPolyTrailProjectile){
	PolyTrails = { '/effects/emitters/aeon_laser_trail_02_emit.bp', '/effects/emitters/default_polytrail_03_emit.bp' },
	PolyTrailOffset = { 0, 0 },
	FxImpactUnit = TMEffectTemplate.AeonT1EXM1MainHit01,
	FxUnitHitScale = 2,
	FxImpactProp = TMEffectTemplate.AeonT1EXM1MainHit01,
	FxPropHitScale = 2,
	FxImpactLand = TMEffectTemplate.AeonT1EXM1MainHit01,
	FxLandHitScale = 2,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
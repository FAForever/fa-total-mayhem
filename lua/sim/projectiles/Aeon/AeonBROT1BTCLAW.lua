local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile

--- Aeon Tech 1 Battle Tank Clawgun
---@class AeonBROT1BTCLAWproj : SinglePolyTrailProjectile
AeonBROT1BTCLAWproj = Class(SinglePolyTrailProjectile){
	PolyTrail = '/effects/emitters/aeon_laser_trail_01_emit.bp',
	FxImpactUnit = TMEffectTemplate.AeonClawHit01,
	FxUnitHitScale = 0.35,
	FxImpactProp = TMEffectTemplate.AeonClawHit01,
	FxPropHitScale = 0.35,
	FxImpactLand = TMEffectTemplate.AeonClawHit01,
	FxLandHitScale = 0.35,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
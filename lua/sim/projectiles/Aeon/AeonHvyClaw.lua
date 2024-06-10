local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile

--- Aeon Heavy Clawgun
---@class AeonHvyClawproj : MultiPolyTrailProjectile
AeonHvyClawproj = Class(MultiPolyTrailProjectile){
	FxTrails = { '/effects/emitters/oblivion_cannon_munition_01_emit.bp' },
	FxImpactUnit = TMEffectTemplate.AeonHvyClawHit01,
	FxUnitHitScale = 1.35,
	FxImpactProp = TMEffectTemplate.AeonHvyClawHit01,
	FxPropHitScale = 1.35,
	FxImpactLand = TMEffectTemplate.AeonHvyClawHit01,
	FxLandHitScale = 1.35,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
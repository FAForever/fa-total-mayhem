local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile

--- Aeon Tech 3 Rocket Defense
---@class AeonBROT3PDROproj : EmitterProjectile
AeonBROT3PDROproj = Class(EmitterProjectile){
	FxTrails = EffectTemplate.AOblivionCannonFXTrails02,
	FxImpactUnit = TMEffectTemplate.AeonBattleShipHit01,
	FxUnitHitScale = 2.4,
	FxImpactProp = TMEffectTemplate.AeonBattleShipHit01,
	FxPropHitScale = 2.4,
	FxImpactLand = TMEffectTemplate.AeonBattleShipHit01,
	FxLandHitScale = 2.4,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile

--- Aeon Tech 2 Advanced Battleship main cannons
---@class AeonBROST2ADVBATTLESHIPproj : EmitterProjectile
AeonBROST2ADVBATTLESHIPproj = Class(EmitterProjectile){
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
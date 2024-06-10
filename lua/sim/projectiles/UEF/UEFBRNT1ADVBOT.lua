local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile

--- UEF Tech 1 Advanced Battle Bot Weapon
---@class UefBRNT1ADVBOTproj : EmitterProjectile
UefBRNT1ADVBOTproj = Class(EmitterProjectile){
	FxTrails = TMEffectTemplate.BRNT1ADVBOTFXTrails01,
	FxImpactUnit = TMEffectTemplate.UEFT1ADVBOThit1,
	FxUnitHitScale = 0.5,
	FxImpactProp = TMEffectTemplate.UEFT1ADVBOThit1,
	FxPropHitScale = 0.5,
	FxImpactLand = TMEffectTemplate.UEFT1ADVBOThit1,
	FxLandHitScale = 0.5,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
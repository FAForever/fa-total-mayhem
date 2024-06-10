local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local EmitterProjectile = DefaultProjectileFile.EmitterProjectile

--- Seraphim Experimental Mega Bot Projectile
---@class SerBRPT3SHBMproj : EmitterProjectile
SerBRPT3SHBMproj = Class(EmitterProjectile){
    FxTrails = EffectTemplate.SDFSinnutheWeaponFXTrails01,
	FxImpactUnit = TMEffectTemplate.SerT3SHBMHit01,
	FxUnitHitScale = 1.6,
	FxImpactProp = TMEffectTemplate.SerT3SHBMHit01,
	FxPropHitScale = 1.6,
	FxImpactLand = TMEffectTemplate.SerT3SHBMHit01,
	FxLandHitScale = 1.6,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
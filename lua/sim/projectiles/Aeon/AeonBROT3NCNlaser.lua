local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local SinglePolyTrailProjectile = DefaultProjectileFile.SinglePolyTrailProjectile

--- Aeon Tech 3 NovaCat Quantum Charge
---@class AeonBROT3NCMproj : SinglePolyTrailProjectile
AeonBROT3NCMproj = Class(SinglePolyTrailProjectile){
	FxTrails = {
		'/effects/emitters/quantum_cannon_munition_03_emit.bp',
		'/effects/emitters/quantum_cannon_munition_04_emit.bp',
	},
	PolyTrail = '/effects/emitters/quantum_cannon_polytrail_01_emit.bp',
	FxImpactUnit = TMEffectTemplate.AeonQuantumChargeHit01,
	FxUnitHitScale = 2,
	FxImpactProp = TMEffectTemplate.AeonQuantumChargeHit01,
	FxPropHitScale = 2,
	FxImpactLand = TMEffectTemplate.AeonQuantumChargeHit01,
	FxLandHitScale = 2,
	FxTrailOffset = 0,
	FxImpactUnderWater = {},
}
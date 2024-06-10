local DefaultProjectileFile = import('/lua/sim/defaultprojectiles.lua')
local MultiPolyTrailProjectile = DefaultProjectileFile.MultiPolyTrailProjectile

--- UEF Tech 2 Advanced Battleship main cannons
---@class UefBRNST2ADVBATTLESHIPproj : MultiPolyTrailProjectile
UefBRNST2ADVBATTLESHIPproj = Class(MultiPolyTrailProjectile){
	FxTrails = {},
	PolyTrails = EffectTemplate.TGaussCannonPolyTrail,
	PolyTrailOffset = { 0, 0 },
	FxImpactUnit = TMEffectTemplate.BRNST2ADVBATTLESHIPHIT,
	FxUnitHitScale = 1.4,
	FxImpactProp = TMEffectTemplate.BRNST2ADVBATTLESHIPHIT,
	FxPropHitScale = 1.4,
	FxImpactLand = TMEffectTemplate.BRNST2ADVBATTLESHIPHIT,
	FxLandHitScale = 1.4,
	FxTrailOffset = 0,
	FxImpactWater = EffectTemplate.TNapalmHvyCarpetBombHitWater01,
	FxWaterHitScale = 2,
	FxImpactUnderWater = {},

	---@param self UefBRNST2ADVBATTLESHIPproj
	---@param TargetType string
	---@param TargetEntity Unit
	OnImpact = function(self, TargetType, TargetEntity)
		local army = self:GetArmy()

		if TargetType == 'Terrain' then
			CreateSplat(self:GetPosition(), 0, 'scorch_004_albedo', 7, 7, 250, 200, army)

			-- local blanketSides = 12
			-- local blanketAngle = (2*math.pi) / blanketSides
			-- local blanketStrength = 1
			-- local blanketVelocity = 2.25

			-- for i = 0, (blanketSides-1) do
			--    local blanketX = math.sin(i*blanketAngle)
			--    local blanketZ = math.cos(i*blanketAngle)
			--    local Blanketparts = self:CreateProjectile('/effects/entities/DestructionDust01/DestructionDust01_proj.bp', blanketX, 0.5, blanketZ, blanketX, 0, blanketZ)
			--        :SetVelocity(blanketVelocity):SetAcceleration(-0.3)
			-- end
		end
		MultiPolyTrailProjectile.OnImpact(self, TargetType, TargetEntity)
	end,
}
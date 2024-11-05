SCUDeathWeapon = Class(BareBonesWeapon){
	OnFire = function(self)
		--NOP
	end,
	Fire = function(self)
		local myBlueprint = self.Blueprint
		local myProjectile =
			self.unit:CreateProjectile(myBlueprint.ProjectileId, 0, 0, 0, nil, nil, nil):SetCollision(false)
		myProjectile:PassDamageData(self:GetDamageTable())
	end,
}

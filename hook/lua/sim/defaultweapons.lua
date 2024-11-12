
---@class SCUDeathWeapon : BareBonesWeapon
SCUDeathWeapon = Class(BareBonesWeapon){

    ---@param self SCUDeathWeapon unused
    OnFire = function(self)
        --NOP
    end,

    ---@param self SCUDeathWeapon unused
    Fire = function(self)
        local myBlueprint = self.Blueprint
        local myProjectile = self.unit:CreateProjectile(myBlueprint.ProjectileId, 0, 0, 0, nil, nil, nil):SetCollision(false)
        myProjectile:PassDamageData(self:GetDamageTable())
    end,
}

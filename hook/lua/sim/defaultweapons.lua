---@class SCUDeathWeapon : BareBonesWeapon
SCUDeathWeapon = Class(BareBonesWeapon){

    OnFire = function()
    end,

    ---@param self SCUDeathWeapon unused
    Fire = function(self)
        local bp = self.Blueprint
        local proj = self.unit:CreateProjectile(bp.ProjectileId, 0, 0, 0, nil, nil, nil):SetCollision(false)
        proj:PassDamageData(self:GetDamageTable())
    end,
}

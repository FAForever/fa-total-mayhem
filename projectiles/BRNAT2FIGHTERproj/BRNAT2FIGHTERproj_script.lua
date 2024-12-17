local UefBRNAT2FIGHTERproj = import('/mods/fa-total-mayhem/lua/TMavaprojectiles.lua').UefBRNAT2FIGHTERproj
local TrashBagAdd = TrashBag.Add

---@class BRNAT2FIGHTERproj : UefBRNAT2FIGHTERproj
BRNAT2FIGHTERproj = Class(UefBRNAT2FIGHTERproj){

    ---@param self BRNAT2FIGHTERproj
    OnCreate = function(self)
        UefBRNAT2FIGHTERproj.OnCreate(self)
        local trash = self.Trash
        TrashBagAdd(trash, ForkThread(self.UpdateThread, self))
    end,

    ---@param self BRNAT2FIGHTERproj
    UpdateThread = function(self)
        WaitSeconds(1.5)
        self:SetMaxSpeed(70)
        self:SetAcceleration(10 + Random() * 8)
        self:ChangeMaxZigZag(0.5)
        self:ChangeZigZagFrequency(2)
    end,

    ---@param self BRNAT2FIGHTERproj
    ---@param TargetType string
    ---@param TargetEntity Entity
    OnImpact = function(self, TargetType, TargetEntity)
        UefBRNAT2FIGHTERproj.OnImpact(self, TargetType, TargetEntity)
    end,
}

TypeClass = BRNAT2FIGHTERproj

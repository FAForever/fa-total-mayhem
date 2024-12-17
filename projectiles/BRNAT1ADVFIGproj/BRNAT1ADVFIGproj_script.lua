local UefBRNAT1ADVFIGproj = import('/mods/fa-total-mayhem/lua/TMavaprojectiles.lua').UefBRNAT1ADVFIGproj
local TrashBagAdd = TrashBag.Add


---@class BRNAT1ADVFIGproj : UefBRNAT1ADVFIGproj
BRNAT1ADVFIGproj = Class(UefBRNAT1ADVFIGproj){

    ---@param self BRNAT1ADVFIGproj
    OnCreate = function(self)
        UefBRNAT1ADVFIGproj.OnCreate(self)
        local trash = self.Trash
        TrashBagAdd(trash, ForkThread(self.UpdateThread, self))
    end,

    ---@param self BRNAT1ADVFIGproj
    UpdateThread = function(self)
        WaitSeconds(1.5)
        self:SetMaxSpeed(55)
        self:SetAcceleration(10 + Random() * 8)
        self:ChangeMaxZigZag(0.5)
        self:ChangeZigZagFrequency(2)
    end,

    ---@param self BRNAT1ADVFIGproj
    ---@param TargetType string
    ---@param TargetEntity Entity
    OnImpact = function(self, TargetType, TargetEntity)
        UefBRNAT1ADVFIGproj.OnImpact(self, TargetType, TargetEntity)
    end,
}

TypeClass = BRNAT1ADVFIGproj

----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/XEA3204/XEA3204_script.lua
--  Author(s):  Dru Staltman
--
--  Summary  :  UEF CDR Pod Script
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local TConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit
local EffectTemplate = import('/lua/EffectTemplates.lua')

BROAT1ENGINEERDRONE = Class(TConstructionUnit){
    OnCreate = function(self)
        TConstructionUnit.OnCreate(self)
        self.docked = true
        self.returning = false
        self:CreatTheEffects()
    end,
    SetParent = function(self, parent, podName)
        self.Parent = parent
        self.PodName = podName
        self:SetCreator(parent)
    end,
    CreatTheEffects = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['SIFInainoPlumeFxTrails01'] do
            CreateAttachedEmitter(self, 'AttachPoint', army, v):ScaleEmitter(0.22)
        end
    end,
    OnKilled = function(self, instigator, type, overkillRatio)
        if self.Parent and not self.Parent.Dead then
            self.Parent:NotifyOfPodDeath(self.PodName)
            self.Parent = nil
        end
        TConstructionUnit.OnKilled(self, instigator, type, overkillRatio)
    end,
    OnStartBuild = function(self, unitBeingBuilt, order)
        TConstructionUnit.OnStartBuild(self, unitBeingBuilt, order)
        self.returning = false
    end,
    OnStopBuild = function(self, unitBuilding)
        TConstructionUnit.OnStopBuild(self, unitBuilding)
        self.ReturnHome(self)
    end,
    OnFailedToBuild = function(self)
        TConstructionUnit.OnFailedToBuild(self)
        self.ReturnHome(self)
    end,
    OnMotionHorzEventChange = function(self, new, old)
        if self and not self.Dead then
            if self.Parent and not self.Parent.Dead then
                local myPosition = self:GetPosition()
                local parentPosition = self.Parent:GetPosition(self.Parent.PodData[self.PodName].PodAttachpoint)
                local distSq = VDist2Sq(myPosition[1], myPosition[3], parentPosition[1], parentPosition[3])
                if self.docked and distSq > 0 and not self.returning then
                    self.docked = false
                    self.Parent:ForkThread(self.Parent.NotifyOfPodStartBuild)
                    --LOG("Leaving dock! " .. distSq)
                elseif not self.docked and distSq < 2 and self.returning then
                    self.docked = true
                    self.Parent:ForkThread(self.Parent.NotifyOfPodStopBuild)
                --LOG("Docked again " .. distSq)
                elseif distSq > 2 and new == 'Stopped' then
                    self.ReturnHome(self)
                end
            end
        end
    end,
    ReturnHome = function(self)
        local parentPosition = self.Parent:GetPosition(self.Parent.PodData[self.PodName].PodAttachpoint)
        self.returning = true
        IssueClearCommands({ self })
        IssueMove({ self }, parentPosition)
    end,
}

TypeClass = BROAT1ENGINEERDRONE

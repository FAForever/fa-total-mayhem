----------------------------------------------------------------------------
-- File     :  /cdimage/units/XEA3204/XEA3204_script.lua
-- Author(s):  Dru Staltman
-- Summary  :  UEF CDR Pod Script
-- Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------
local TConstructionUnit = import('/lua/terranunits.lua').TConstructionUnit
local EffectTemplate = import('/lua/EffectTemplates.lua')

-- upvalue local functions
local CreateAttachedEmitter = CreateAttachedEmitter
local TrashBagAdd = TrashBag.Add

---@class BROAT1ENGINEERDRONE : TConstructionUnit
BROAT1ENGINEERDRONE = Class(TConstructionUnit){

	---@param self BROAT1ENGINEERDRONE
	OnCreate = function(self)
		TConstructionUnit.OnCreate(self)
		self.docked = true
		self.returning = false
		self:CreateTheEffects()
	end,

	---@param self BROAT1ENGINEERDRONE
	---@param parent Unit
	---@param podName string
	SetParent = function(self, parent, podName)
		self.Parent = parent
		self.PodName = podName
		self:SetCreator(parent)
	end,

	---@param self BROAT1ENGINEERDRONE
	CreateTheEffects = function(self)
		local army = self.Army
		local trash = self.Trash

		for _, v in EffectTemplate['SIFInainoPlumeFxTrails01'] do
			TrashBagAdd(trash,CreateAttachedEmitter(self, 'AttachPoint', army, v):ScaleEmitter(0.22))
		end
	end,

	---@param self BROAT1ENGINEERDRONE
	---@param instigator Unit
	---@param damageType DamageType
	---@param overkillRatio number
	OnKilled = function(self, instigator, damageType, overkillRatio)
		if self.Parent and not self.Parent.Dead then
			self.Parent:NotifyOfPodDeath(self.PodName)
			self.Parent = nil
		end
		TConstructionUnit.OnKilled(self, instigator, damageType, overkillRatio)
	end,

	---@param self BROAT1ENGINEERDRONE
	---@param unitBeingBuilt Unit
	---@param order string
	OnStartBuild = function(self, unitBeingBuilt, order)
		TConstructionUnit.OnStartBuild(self, unitBeingBuilt, order)
		self.returning = false
	end,

	---@param self BROAT1ENGINEERDRONE
	---@param unitBuilding Unit
	OnStopBuild = function(self, unitBuilding)
		TConstructionUnit.OnStopBuild(self, unitBuilding)
		self.ReturnHome(self)
	end,

	---@param self BROAT1ENGINEERDRONE
	OnFailedToBuild = function(self)
		TConstructionUnit.OnFailedToBuild(self)
		self.ReturnHome(self)
	end,

	---@param self BROAT1ENGINEERDRONE
	---@param new VerticalMovementState
	---@param old VerticalMovementState Unused
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

	---@param self BROAT1ENGINEERDRONE
	ReturnHome = function(self)
		local parentPosition = self.Parent:GetPosition(self.Parent.PodData[self.PodName].PodAttachpoint)
		self.returning = true
		IssueClearCommands({ self })
		IssueMove({ self }, parentPosition)
	end,
}

TypeClass = BROAT1ENGINEERDRONE

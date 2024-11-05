-- ****************************************************************************
-- **
-- **  File     :  units/URB1107/URB1107_script.lua
-- **  Author(s):  John Comes, Dave Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  Naval Cybran Hydrocarbon Power Plant Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local CEnergyCreationUnit = import('/lua/cybranunits.lua').CEnergyCreationUnit

URB1107 = Class(CEnergyCreationUnit){
	AirEffects = { '/effects/emitters/hydrocarbon_smoke_01_emit.bp' },
	AirEffectsBones = { 'Exhaust01', 'Exhaust02', 'Exhaust03', 'Exhaust04' },
	WaterEffects = { '/effects/emitters/hydrocarbon_smoke_01_emit.bp' },
	WaterEffectsBones = { 'Exhaust01', 'Exhaust02', 'Exhaust03', 'Exhaust04' },
	OnStartBuild = function(self, unitBeingBuilt, order)
		CEnergyCreationUnit.OnStartBuild(self, unitBeingBuilt, order)
		if not self.AnimationManipulator then return end
		self.AnimationManipulator:SetRate(0)
		self.AnimationManipulator:Destroy()
		self.AnimationManipulator = nil
	end,
	PlayActiveAnimation = function(self)
		CEnergyCreationUnit.PlayActiveAnimation(self)
		if not self.AnimationManipulator then
			self.AnimationManipulator = CreateAnimator(self)
			self.Trash:Add(self.AnimationManipulator)
			self.Trash:Add(CreateAttachedEmitter(self, 'Exhaust01', self:GetArmy(), '/effects/emitters/geyser_01_emit.bp'))
			self.Trash:Add(CreateAttachedEmitter(self, 'Exhaust02', self:GetArmy(), '/effects/emitters/geyser_01_emit.bp'))
			self.Trash:Add(CreateAttachedEmitter(self, 'Exhaust03', self:GetArmy(), '/effects/emitters/geyser_01_emit.bp'))
			self.Trash:Add(
				CreateAttachedEmitter(self, 'Exhaust04', self:GetArmy(), '/effects/emitters/hydrocarbon_smoke_01_emit.bp')
			)
			self.Trash:Add(
				CreateAttachedEmitter(self, 'URB02', self:GetArmy(), '/effects/emitters/underwater_vent_bubbles_01_emit.bp')
			)
			self.Trash:Add(CreateAttachedEmitter(self, 'URB02', self:GetArmy(), '/effects/emitters/geyser_01_emit.bp'))
		end
		self.AnimationManipulator:PlayAnim(self.Blueprint.Display.AnimationOpen, true)
	end,
	OnProductionPaused = function(self)
		CEnergyCreationUnit.OnProductionPaused(self)
		if not self.AnimationManipulator then return end
		self.AnimationManipulator:SetRate(0)
	end,
	OnProductionUnpaused = function(self)
		CEnergyCreationUnit.OnProductionUnpaused(self)
		if not self.AnimationManipulator then return end
		self.AnimationManipulator:SetRate(1)
	end,
}

TypeClass = URB1107

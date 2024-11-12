-- ****************************************************************************
-- **
-- **  File     :  /units/UEB1107/UEB1107_script.lua
-- **  Author(s):  Jessica St. Croix
-- **
-- **  Summary  :  UEF Hydrocarbon Power Plant Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TEnergyCreationUnit = import('/lua/terranunits.lua').TEnergyCreationUnit

UEB1107 = Class(TEnergyCreationUnit){
    DestructionPartsHighToss = { 'Exhaust01' },
    DestructionPartsLowToss = { 'Exhaust01', 'Exhaust02', 'Exhaust03', 'Exhaust04', 'Exhaust05' },
    DestructionPartsChassisToss = { 'UEB1102' },
    AirEffects = { '/effects/emitters/hydrocarbon_smoke_01_emit.bp' },
    AirEffectsBones = { 'Exhaust01' },
    WaterEffects = { '/effects/emitters/hydrocarbon_smoke_01_emit.bp' },
    WaterEffectsBones = { 'Exhaust01' },
    OnStartBuild = function(self, unitBeingBuilt, order)
        TEnergyCreationUnit.OnStartBuild(self, unitBeingBuilt, order)
        if not self.AnimationManipulator then return end
        self.AnimationManipulator:SetRate(0)
        self.AnimationManipulator:Destroy()
        self.AnimationManipulator = nil
    end,
    PlayActiveAnimation = function(self)
        TEnergyCreationUnit.PlayActiveAnimation(self)
        if not self.AnimationManipulator then
            self.AnimationManipulator = CreateAnimator(self)
            self.Trash:Add(self.AnimationManipulator)
            --self.Effect1 = CreateAttachedEmitter(self,'Exhaust01',self:GetArmy(), MyModPath .. '/hook/effects/emitters/uec1501_smoke_03_emit.bp')
            --self.Trash:Add(self.Effecct1)
        end
        self.AnimationManipulator:PlayAnim(self.Blueprint.Display.AnimationOpen, true)
    end,
    OnProductionPaused = function(self)
        TEnergyCreationUnit.OnProductionPaused(self)
        if not self.AnimationManipulator then return end
        self.AnimationManipulator:SetRate(0)
    end,
    OnProductionUnpaused = function(self)
        TEnergyCreationUnit.OnProductionUnpaused(self)

        if not self.AnimationManipulator then return end
        self.AnimationManipulator:SetRate(1)
    end,
}

TypeClass = UEB1107

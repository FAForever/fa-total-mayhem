-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/XSB1102/XSB1102_script.lua
-- **  Author(s):  Dru Staltman, Greg Kohne
-- **
-- **  Summary  :  Seraphim Hydrocarbon Power Plant Script
-- **
-- **  Copyright � 2007 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local SEnergyCreationUnit = import('/lua/seraphimunits.lua').SEnergyCreationUnit
XSB1102 = Class(SEnergyCreationUnit){
    AirEffects = { '/effects/emitters/hydrocarbon_heatshimmer_01_emit.bp' },
    AirEffectsBones = { 'Exhaust01', 'Exhaust02', 'Exhaust03', 'Exhaust04', 'Exhaust05' },
    WaterEffects = { '/effects/emitters/underwater_idle_bubbles_01_emit.bp' },
    WaterEffectsBones = { 'Exhaust01', 'Exhaust02', 'Exhaust03', 'Exhaust04', 'Exhaust05' },
    OnStopBeingBuilt = function(self, builder, layer)
        SEnergyCreationUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Turbine01', 'y', nil, 180, 0, 0))
        self.Trash:Add(CreateRotator(self, 'Turbine03', 'y', nil, 180, 0, 0))
        self.Trash:Add(CreateRotator(self, 'Turbine02', 'y', nil, 180, 0, 0))
        local effects = {}
        local bones = {}
        local scale = 5
        if self:GetCurrentLayer() == 'Water' then
            effects = self.WaterEffects
            bones = self.WaterEffectsBones
            scale = 5
        end
        for keys, values in effects do
            for keysbones, valuesbones in bones do
                self.Trash:Add(
                    CreateAttachedEmitter(self, valuesbones, self:GetArmy(), values):ScaleEmitter(scale):OffsetEmitter(0, 0, 0)
                )
            end
        end
    end,
}

TypeClass = XSB1102

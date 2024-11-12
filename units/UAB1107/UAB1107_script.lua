-- ****************************************************************************
-- **
-- **  File     :  /units/UAB1107/UAB1107_script.lua
-- **  Author(s):  Jessica St. Croix, John Comes
-- **
-- **  Summary  :  Aeon Naval Hydrocarbon Power Plant Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************
local AEnergyCreationUnit = import('/lua/aeonunits.lua').AEnergyCreationUnit

UAB1107 = Class(AEnergyCreationUnit){
    WaterEffects = { '/effects/emitters/water_heat_ambient_02_emit.bp' },
    WaterEffectsBones = { 'Vap01', 'Vap02', 'Vap03', 'Vap04' },
    OnStopBeingBuilt = function(self, builder, layer)
        AEnergyCreationUnit.OnStopBeingBuilt(self, builder, layer)
        self.Trash:Add(CreateRotator(self, 'Blade01', 'y', nil, -180, 0, -180))
        self.Trash:Add(CreateRotator(self, 'Blade03', 'y', nil, -180, 0, -180))
        self.Trash:Add(CreateRotator(self, 'Blade02', 'y', nil, -180, 0, -180))
        self.Trash:Add(CreateRotator(self, 'Blade04', 'y', nil, -180, 0, -180))
        local effects = {}
        local bones = {}
        local scale = 0.75
        if self:GetCurrentLayer() == 'Water' then
            effects = self.WaterEffects
            bones = self.WaterEffectsBones
            scale = 0.5
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

TypeClass = UAB1107

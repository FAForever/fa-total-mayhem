local EBC = '/lua/editor/EconomyBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'TM PointDefensUpgrade',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'T1 PointDefens Upgrade',
        PlatoonTemplate = 'T1PointDefensUpgrade',
        Priority = 4000,
        InstanceCount = 5,
        BuilderConditions = {
            -- When do we want to build this ?
            -- Do we need additional conditions to build it ?
            { MIBC, 'FactionIndex', { 1, 3 }}, -- 1: UEF, 2: Aeon, 3: Cybran, 4: Seraphim, 5: Nomads 
            -- Have we the eco to build it ?
            { EBC, 'GreaterThanEconTrend', { 0.4, 10.0 } }, -- relative income 4 mass, 100 energy
            { EBC, 'GreaterThanEconStorageRatio', { 0.30, 0.99}}, -- Ratio from 0 to 1. (1=100%)
            -- Don't build it if...
            -- Respect UnitCap
        },
		BuilderData = {
            NumAssistees = 2,
        },
        BuilderType = 'Any'
    },
    Builder {
        BuilderName = 'T1 PointDefens Upgrade Experimental',
        PlatoonTemplate = 'T1PointDefensUpgradeEXP',
        Priority = 4000,
        InstanceCount = 5,
        BuilderConditions = {
            -- When do we want to build this ?
            -- Do we need additional conditions to build it ?
            { MIBC, 'FactionIndex', { 1, 3 }}, -- 1: UEF, 2: Aeon, 3: Cybran, 4: Seraphim, 5: Nomads 
            -- Have we the eco to build it ?
            { EBC, 'GreaterThanEconTrend', { 0.8, 10.0 } }, -- relative income 8 mass, 100 energy
            { EBC, 'GreaterThanEconStorageRatio', { 0.40, 0.99}}, -- Ratio from 0 to 1. (1=100%)
            -- Don't build it if...
            -- Respect UnitCap
        },
		BuilderData = {
            NumAssistees = 2,
        },
        BuilderType = 'Any'
    },
	Builder {
        BuilderName = 'T2 PointDefens Upgrade',
        PlatoonTemplate = 'T2PointDefensUpgrade',
        Priority = 4000,
        InstanceCount = 5,
        BuilderConditions = {
            -- When do we want to build this ?
            -- Do we need additional conditions to build it ?
            { MIBC, 'FactionIndex', { 1, 3 }}, -- 1: UEF, 2: Aeon, 3: Cybran, 4: Seraphim, 5: Nomads 
            -- Have we the eco to build it ?
            { EBC, 'GreaterThanEconTrend', { 0.8, 10.0 } }, -- relative income 8 mass, 100 energy
            { EBC, 'GreaterThanEconStorageRatio', { 0.40, 0.99}}, -- Ratio from 0 to 1. (1=100%)
            -- Don't build it if...
            -- Respect UnitCap
        },
		BuilderData = {
            NumAssistees = 2,
        },
        BuilderType = 'Any'
    }
}	


-- Add locals for BuilderConditions
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local MaxDefense = 0.15 -- 15% of all units can be defenses (categories.STRUCTURE * categories.DEFENSE)
local TBC = '/lua/editor/threatbuildconditions.lua'

-- ===================================================-======================================================== --
-- ==                                        HEAVYASSAULT Builder                                            == --
-- ===================================================-======================================================== --
BuilderGroup{
	BuilderGroupName = 'HEAVYASSAULT Builder', -- BuilderGroupName, initalized from AIBaseTemplates in "\lua\AI\AIBaseTemplates\"
	BuildersType = 'EngineerBuilder',
	-- cheap Tech1 land bots
	Builder{
		BuilderName = 'TM1 HEAVY Bot',
		PlatoonTemplate = 'EngineerBuilder',
		Priority = 16000,
		InstanceCount = 1,
		BuilderConditions = { -- When do we want to build this ?
		{
			UCBC,
			'HaveGreaterThanUnitsWithCategory',
			{ 1, categories.STRUCTURE * categories.ENERGYPRODUCTION - categories.TECH1 },
		}, {
			EBC,
			'GreaterThanEconTrend',
			{ 0.4, 15.0 },
		}, { -- relative income -- Have we the eco to build it ? -- Do we need additional conditions to build it ?
		EBC, 'GreaterThanEconStorageRatio', { 0.30, 0.90 } }, { -- Don't build it if... -- Ratio from 0 to 1. (1=100%)
		UCBC, 'HaveLessThanUnitsWithCategory', {
			3,
			categories.MOBILE * categories.LAND * categories.TECH1 * categories.HEAVYASSAULT,
		} }, { UCBC, 'UnitCapCheckLess', { 0.99 } } },
		BuilderType = 'Any',
		BuilderData = {
			Construction = {
				DesiresAssist = true,
				NumAssistees = 2,
				BuildClose = false,
				AdjacencyCategory = 'SHIELD STRUCTURE',
				BuildStructures = { 'H1CheapBot' },
				Location = 'LocationType',
			},
		},
	},
	-- Tech1 Gunships
	Builder{
		BuilderName = 'TM1 HEAVY Gunship 1st',
		PlatoonTemplate = 'EngineerBuilder',
		Priority = 16000,
		InstanceCount = 1,
		BuilderConditions = { -- When do we want to build this ?
		{
			UCBC,
			'HaveGreaterThanUnitsWithCategory',
			{ 3, categories.STRUCTURE * categories.LAND * categories.FACTORY },
		}, {
			EBC,
			'GreaterThanEconTrend',
			{ 0.4, 15.0 },
		}, { -- relative income -- Have we the eco to build it ? -- Do we need additional conditions to build it ?
		EBC, 'GreaterThanEconStorageRatio', { 0.30, 0.90 } }, { -- Don't build it if... -- Ratio from 0 to 1. (1=100%)
		UCBC, 'HaveLessThanUnitsWithCategory', {
			3,
			categories.MOBILE * categories.AIR * categories.TECH1 * categories.HEAVYASSAULT,
		} }, { UCBC, 'UnitCapCheckLess', { 0.99 } } },
		BuilderType = 'Any',
		BuilderData = {
			Construction = {
				DesiresAssist = true,
				NumAssistees = 2,
				BuildClose = false,
				AdjacencyCategory = 'SHIELD STRUCTURE',
				BuildStructures = { 'H1GunShip' },
				Location = 'LocationType',
			},
		},
	},
	Builder{
		BuilderName = 'TM1 HEAVY Gunship 2nd',
		PlatoonTemplate = 'EngineerBuilder',
		Priority = 16000,
		InstanceCount = 1,
		BuilderConditions = { -- When do we want to build this ?
		{
			UCBC,
			'HaveGreaterThanUnitsWithCategory',
			{ 3, categories.STRUCTURE * categories.ENERGYPRODUCTION - categories.TECH1 },
		}, { -- Do we need additional conditions to build it ?
		UCBC, 'PoolGreaterAtLocation', {
			'LocationType',
			1,
			'ENGINEER TECH1',
		} }, { EBC, 'GreaterThanEconTrend', { 2.0, 40.0 } }, { -- relative income -- Have we the eco to build it ?
		EBC, 'GreaterThanEconStorageRatio', { 0.35, 0.90 } }, { -- Don't build it if... -- Ratio from 0 to 1. (1=100%)
		UCBC, 'HaveLessThanUnitsWithCategory', {
			3,
			categories.MOBILE * categories.AIR * categories.TECH1 * categories.HEAVYASSAULT,
		} }, { UCBC, 'UnitCapCheckLess', { 0.99 } } },
		BuilderType = 'Any',
		BuilderData = {
			Construction = {
				DesiresAssist = true,
				NumAssistees = 2,
				BuildClose = false,
				AdjacencyCategory = 'SHIELD STRUCTURE',
				BuildStructures = { 'H1GunShip' },
				Location = 'LocationType',
			},
		},
	},
}
-- ===================================================-======================================================== --
-- ==                                         FACTORY Builder                                                == --
-- ===================================================-======================================================== --
BuilderGroup{
	BuilderGroupName = 'FACTORY Builder', -- BuilderGroupName, initalized from AIBaseTemplates in "\lua\AI\AIBaseTemplates\"
	BuildersType = 'FactoryBuilder',
	Builder{
		BuilderName = 'U3 T1 HardTanks Panic',
		PlatoonTemplate = 'T3 Tech1 Mayhem Tank',
		Priority = 18700,
		BuilderConditions = { -- When do we want to build this ?
		{ TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 5, 'Land' } }, -- Respect UnitCap
		{ UCBC, 'UnitCapCheckLess', { 0.97 } } },
		BuilderType = 'Land',
	},
	Builder{
		BuilderName = 'U3 T1 HardTanks Spam',
		PlatoonTemplate = 'T3 Tech1 Mayhem Tank',
		Priority = 500,
		BuilderConditions = { -- When do we want to build this ?
		-- Do we need additional conditions to build it ?
		-- Have we the eco to build it ?
		{ EBC, 'GreaterThanEconTrend', { 0.0, 0.0 } }, { -- relative income
		EBC, 'GreaterThanEconStorageRatio', { 0.05, 0.90 } }, { -- Don't build it if... -- Ratio from 0 to 1. (1=100%)
		UCBC, 'LocationFactoriesBuildingLess', {
			'LocationType',
			1,
			'MOBILE TECH1 MK3',
		} }, { UCBC, 'UnitCapCheckLess', { 0.90 } } }, -- Respect UnitCap
		BuilderType = 'Land',
	},
}
-- ===================================================-======================================================== --
-- ==                                         HEAVYASSAULT Former                                            == --
-- ===================================================-======================================================== --
BuilderGroup{
	BuilderGroupName = 'HEAVYASSAULT Former', -- BuilderGroupName, initalized from AIBaseTemplates in "\lua\AI\AIBaseTemplates\"
	BuildersType = 'PlatoonFormBuilder', -- BuilderTypes are: EngineerBuilder, FactoryBuilder, PlatoonFormBuilder.
	-- land
	Builder{
		BuilderName = 'TM1 HEAVY Land Fearless',
		PlatoonTemplate = 'TM1 HEAVYASSAULT LAND', -- Template Name. These units will be formed. See: "UvesoPlatoonTemplatesLand.lua"
		Priority = 500, -- Priority. 1000 is normal.
		InstanceCount = 2, -- Number of plattons that will be formed.
		BuilderData = {
			NeverGuardBases = true,
			NeverGuardEngineers = true,
			UseFormation = 'AttackFormation',
			ThreatWeights = { IgnoreStrongerTargetsRatio = 100.0 },
		},
		BuilderConditions = { -- When do we want to build this ?
		{
			UCBC,
			'HaveGreaterThanUnitsWithCategory',
			{ 0, categories.MOBILE * categories.LAND * categories.TECH1 * categories.HEAVYASSAULT },
		} },
		-- Do we need additional conditions to build it ?
		-- Have we the eco to build it ?
		-- Don't build it if...
		BuilderType = 'Any', -- Build with "Land" "Air" "Sea" "Gate" or "All" Factories. - "Any" forms a Platoon.
	},
	-- Air
	Builder{
		BuilderName = 'TM1 HEAVY Air Anti-Resource',
		PlatoonTemplate = 'TM1 HEAVYASSAULT AIR', -- Template Name. These units will be formed. See: "UvesoPlatoonTemplatesLand.lua"
		Priority = 500,
		InstanceCount = 2,
		BuilderData = {
			SearchRadius = 10000,
			DistressRange = 500,
			PrioritizedCategories = {
				'ENERGYPRODUCTION DRAGBUILD',
				'ENGINEER',
				'MASSEXTRACTION',
				'MOBILE LAND',
				'MASSFABRICATION',
				'SHIELD',
				'ANTIAIR STRUCTURE',
				'DEFENSE STRUCTURE',
				'STRUCTURE',
				'COMMAND',
				'MOBILE ANTIAIR',
				'ALLUNITS',
			},
		},
		BuilderConditions = { -- When do we want to build this ?
		{
			UCBC,
			'HaveGreaterThanUnitsWithCategory',
			{ 0, categories.MOBILE * categories.AIR * categories.TECH1 * categories.HEAVYASSAULT },
		} },
		-- Do we need additional conditions to build it ?
		-- Have we the eco to build it ?
		-- Don't build it if...
		BuilderType = 'Any', -- Build with "Land" "Air" "Sea" "Gate" or "All" Factories. - "Any" forms a Platoon.
	},
}

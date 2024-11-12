PlatoonTemplate{
    Name = 'T1PointDefensUpgrade',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = { { 'brnt1hpd', 0, 1, 'support', 'None' } },
        Cybran = { { 'brmt1pd', 0, 1, 'support', 'None' } },
    },
}

PlatoonTemplate{
    Name = 'T1PointDefensUpgradeEXP',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = { { 'brnt1expd', 0, 1, 'support', 'None' } },
        Cybran = { { 'brmt1expd', 0, 1, 'support', 'None' } },
    },
}

PlatoonTemplate{
    Name = 'T2PointDefensUpgrade',
    Plan = 'UnitUpgradeAI',
    FactionSquads = {
        UEF = { { 'brnt2epd', 0, 1, 'support', 'None' } },
        Cybran = { { 'brmt2pd', 0, 1, 'support', 'None' } },
    },
}

-- earth structure upgrades

table.insert(StructureUpgradeTemplates[1], { 'brnt1hpd', 'brnt1hpdt2' }) -- UEF PD Upgrade from TECH1 to TECH2
table.insert(StructureUpgradeTemplates[1], { 'brnt1expd', 'brnt1expdt2' }) -- UEF EXPD Upgrade from TECH1 to TECH2
table.insert(StructureUpgradeTemplates[1], { 'brnt2epd', 'brnt2epdt3' }) -- UEF EXPD Upgrade from TECH2 to TECH3
-- alien structure upgrades

-- recycler structure upgrades
table.insert(StructureUpgradeTemplates[3], { 'brmt1pd', 'brmt1pdt2' }) -- Cybran PD Upgrade from TECH1 to TECH2
table.insert(StructureUpgradeTemplates[3], { 'brmt1expd', 'brmt1expdt2' }) -- Cybran EXPD Upgrade from TECH1 to TECH2
table.insert(StructureUpgradeTemplates[3], { 'brmt2pd', 'brmt3pd' })


-- Cybran T2PD Upgrade from TECH2 to TECH3

-- seraphim structure upgrades
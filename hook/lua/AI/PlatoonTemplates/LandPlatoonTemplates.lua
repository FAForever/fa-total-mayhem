-- Builder
PlatoonTemplate{
    Name = 'T1 Tech1 Mayhem Tank',
    FactionSquads = {
        UEF = { { 'brnt1ht', 1, 1, 'Attack', 'none' } }, -- Predator MK1 (Heavy Tank)
        Aeon = { { 'brot1mt', 1, 1, 'attack', 'none' } }, -- Lintea MK1 (Medium Tank)
        Cybran = { { 'brmt1bt', 1, 1, 'attack', 'none' } }, -- Reaper MK1 (Battle Tank)
        Seraphim = { { 'brpt1bt', 1, 1, 'attack', 'none' } }, -- Hethaam MK1 (Battle Tank)
    },
}

PlatoonTemplate{
    Name = 'T2 Tech1 Mayhem Tank',
    FactionSquads = {
        UEF = { { 'brnt1htt2', 1, 1, 'Attack', 'none' } }, -- Predator MK2 (Heavy Tank)
        Aeon = { { 'brot1mtt2', 1, 1, 'attack', 'none' } }, -- Lintea MK2 (Medium Tank)
        Cybran = { { 'brmt1btt2', 1, 1, 'attack', 'none' } }, -- Reaper MK2 (Battle Tank)
        Seraphim = { { 'brpt3bt', 1, 1, 'attack', 'none' } }, -- Hethaam MK2 (Battle Tank)
    },
}

PlatoonTemplate{
    Name = 'T3 Tech1 Mayhem Tank',
    FactionSquads = {
        UEF = { { 'brnt1htt3', 1, 1, 'Attack', 'none' } }, -- Predator MK3 (Heavy Tank)
        Aeon = { { 'brot1mtt3', 1, 1, 'attack', 'none' } }, -- Lintea MK3 (Medium Tank)
        Cybran = { { 'brmt1btt3', 1, 1, 'attack', 'none' } }, -- Reaper MK3 (Battle Tank)
        Seraphim = { { 'brpt1htt3', 1, 1, 'attack', 'none' } }, -- Hethaam MK3 (Battle Tank)
    },
}

-- Former
PlatoonTemplate{
    Name = 'TM1 HEAVYASSAULT LAND',
    Plan = 'AttackForceAI',
    GlobalSquads = {
        { categories.MOBILE * categories.LAND * categories.TECH1 * categories.HEAVYASSAULT, 1, 10, 'Attack', 'none' },
    },
}

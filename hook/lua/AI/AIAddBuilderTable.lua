
local OLDAddGlobalBaseTemplate = AddGlobalBaseTemplate


---@param aiBrain AIBrain
---@param locationType string
---@param baseBuilderName string
function AddGlobalBaseTemplate(aiBrain, locationType, baseBuilderName)
    -- Don't use this with AI-Uveso
    if not aiBrain.Uveso then
        SPEW('Total Mayhem: Injecting BuilderGroups')
        AddGlobalBuilderGroup(aiBrain, locationType, 'HEAVYASSAULT Builder')
        AddGlobalBuilderGroup(aiBrain, locationType, 'FACTORY Builder')
        AddGlobalBuilderGroup(aiBrain, locationType, 'TM PointDefensUpgrade')
        SPEW('Total Mayhem: Injecting FormerGroups')
        AddGlobalBuilderGroup(aiBrain, locationType, 'HEAVYASSAULT Former')
    end
    OLDAddGlobalBaseTemplate(aiBrain, locationType, baseBuilderName)
end

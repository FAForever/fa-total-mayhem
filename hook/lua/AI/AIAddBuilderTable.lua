local OLDAddGlobalBaseTemplate = AddGlobalBaseTemplate

---@param aiBrain AIBrain
---@param locationType string
---@param baseBuilderName string
function AddGlobalBaseTemplate(aiBrain, locationType, baseBuilderName)
    -- Don't use this with AI-Uveso
    if not aiBrain.Uveso then
        SPEW('Total Mayhem: Injecting BuilderGroups')
        AddGlobalBuilderGroup(aiBrain, locationType, 'Total Mayhem HEAVYASSAULT Builder')
        AddGlobalBuilderGroup(aiBrain, locationType, 'Total Mayhem FactoryBuilder')
        SPEW('Total Mayhem: Injecting FormerGroups')
        AddGlobalBuilderGroup(aiBrain, locationType, 'Total Mayhem Former')
    end
    OLDAddGlobalBaseTemplate(aiBrain, locationType, baseBuilderName)
end

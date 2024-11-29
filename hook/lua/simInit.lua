-- Hook for modfiles validator
local OldBeginSessionTotalMayhem = BeginSession
function BeginSession()
    OldBeginSessionTotalMayhem()
    ValidateModFilesTotalMayhem()
end

-- Hook for AIBuilders
local OLDSetupSessionTotalMayhem = SetupSession
function SetupSession()
    OLDSetupSessionTotalMayhem()
    import('/mods/fa-total-mayhem/lua/AI/AIBuilders/TotalMayhemBuilder.lua')
end

function ValidateModFilesTotalMayhem()
    local ModName = '* ' .. 'Total Mayhem'
    local ModDirectory = 'fa-total-mayhem'
    local Files = 2186
    local Bytes = 755174592
    LOG(
        '' .. ModName .. ': [' .. string.gsub(debug.getinfo(1).source, '.*\\(.*.lua)', '%1') .. ', line:' .. debug.getinfo(
            1
        ).currentline .. '] - Running from: ' .. debug.getinfo(1).source .. '.'
    )
    LOG(
        '' .. ModName .. ': [' .. string.gsub(debug.getinfo(1).source, '.*\\(.*.lua)', '%1') .. ', line:' .. debug.getinfo(
            1
        ).currentline .. '] - Checking directory /mods/ for ' .. ModDirectory .. '...'
    )
    local FilesInFolder = DiskFindFiles('/mods/', '*.*')
    local modfoundcount = 0
    for _, FilepathAndName in FilesInFolder do
        if string.find(FilepathAndName, 'mod_info.lua') then
            if string.gsub(FilepathAndName, '.*/(.*)/.*', '%1') == string.lower(ModDirectory) then
                modfoundcount = modfoundcount + 1
                LOG(
                    '' .. ModName .. ': [' .. string.gsub(
                        debug.getinfo(1).source,
                        '.*\\(.*.lua)',
                        '%1'
                    ) .. ', line:' .. debug.getinfo(1).currentline .. '] - Found directory: ' .. FilepathAndName .. '.'
                )
            end
        end
    end
    if modfoundcount == 1 then
        LOG(
            '' .. ModName .. ': [' .. string.gsub(
                debug.getinfo(1).source,
                '.*\\(.*.lua)',
                '%1'
            ) .. ', line:' .. debug.getinfo(
                1
            ).currentline .. '] - Check OK. Found ' .. modfoundcount .. ' ' .. ModDirectory .. ' directory.'
        )
    else
        LOG(
            '' .. ModName .. ': [' .. string.gsub(
                debug.getinfo(1).source,
                '.*\\(.*.lua)',
                '%1'
            ) .. ', line:' .. debug.getinfo(
                1
            ).currentline .. '] - Check FAILED! Found ' .. modfoundcount .. ' ' .. ModDirectory .. ' directories.'
        )
    end
    LOG(
        '' .. ModName .. ': [' .. string.gsub(debug.getinfo(1).source, '.*\\(.*.lua)', '%1') .. ', line:' .. debug.getinfo(
            1
        ).currentline .. '] - Checking files and filesize for ' .. ModDirectory .. '...'
    )
    local FilesInFolder = DiskFindFiles('/mods/' .. ModDirectory .. '/', '*.*')
    local filecount = 0
    local bytecount = 0
    for _, FilepathAndName in FilesInFolder do
        if not string.find(FilepathAndName, '.git') then
            filecount = filecount + 1
            local fileinfo = DiskGetFileInfo(FilepathAndName)
            bytecount = bytecount + fileinfo.SizeBytes
        end
    end
    local FAIL = false
    if filecount < Files then
        LOG(
            '' .. ModName .. ': [' .. string.gsub(
                debug.getinfo(1).source,
                '.*\\(.*.lua)',
                '%1'
            ) .. ', line:' .. debug.getinfo(
                1
            ).currentline .. '] - Check FAILED! Directory: ' .. ModDirectory .. ' - Missing ' .. (Files - filecount) .. ' files! (' .. filecount .. '/' .. Files .. ')'
        )
        FAIL = true
    elseif filecount > Files then
        LOG(
            '' .. ModName .. ': [' .. string.gsub(
                debug.getinfo(1).source,
                '.*\\(.*.lua)',
                '%1'
            ) .. ', line:' .. debug.getinfo(
                1
            ).currentline .. '] - Check FAILED! Directory: ' .. ModDirectory .. ' - Found ' .. (filecount - Files) .. ' odd files! (' .. filecount .. '/' .. Files .. ')'
        )
        FAIL = true
    end
    if bytecount < Bytes then
        LOG(
            '' .. ModName .. ': [' .. string.gsub(
                debug.getinfo(1).source,
                '.*\\(.*.lua)',
                '%1'
            ) .. ', line:' .. debug.getinfo(
                1
            ).currentline .. '] - Check FAILED! Directory: ' .. ModDirectory .. ' - Missing ' .. (Bytes - bytecount) .. ' bytes! (' .. bytecount .. '/' .. Bytes .. ')'
        )
        FAIL = true
    elseif bytecount > Bytes then
        LOG(
            '' .. ModName .. ': [' .. string.gsub(
                debug.getinfo(1).source,
                '.*\\(.*.lua)',
                '%1'
            ) .. ', line:' .. debug.getinfo(
                1
            ).currentline .. '] - Check FAILED! Directory: ' .. ModDirectory .. ' - Found ' .. (bytecount - Bytes) .. ' odd bytes! (' .. bytecount .. '/' .. Bytes .. ')'
        )
        FAIL = true
    end
    if not FAIL then
        LOG(
            '' .. ModName .. ': [' .. string.gsub(
                debug.getinfo(1).source,
                '.*\\(.*.lua)',
                '%1'
            ) .. ', line:' .. debug.getinfo(
                1
            ).currentline .. '] - Check OK! files: ' .. filecount .. ', bytecount: ' .. bytecount .. '.'
        )
    end
end

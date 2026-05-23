script_name("FOV Change")
script_author("Shazanxz")

local imgui = require 'imgui'
local inicfg = require 'inicfg'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local ini_name = "FOVSettings.ini"

local ini = inicfg.load({
    main = {
        enabled = true,
        fov = 90.0
    }
}, ini_name)
inicfg.save(ini, ini_name)

local window      = imgui.ImBool(false)
local fov_enabled = imgui.ImBool(ini.main.enabled)
local fov_value   = imgui.ImFloat(ini.main.fov)

local DEFAULT_FOV   = 70.0
local SNIPER_WEAPONS = { [34] = true, [35] = true }

local wasSniper = false

local function applyFOV()
    local ped = playerPed
    local weapon = ped and getCurrentCharWeapon(ped) or 0
    local isSniper = SNIPER_WEAPONS[weapon] == true

    if isSniper then
        if not wasSniper then
            cameraSetLerpFov(DEFAULT_FOV, DEFAULT_FOV, 1, true)
        end
        wasSniper = true
        return
    end
    if wasSniper then
        wasSniper = false
        if fov_enabled.v then
            cameraSetLerpFov(fov_value.v, fov_value.v, 1, true)
        end
    end

    if fov_enabled.v then
        cameraSetLerpFov(fov_value.v, fov_value.v, 999999, true)
    else
        cameraSetLerpFov(DEFAULT_FOV, DEFAULT_FOV, 999999, true)
    end
end

local function save()
    ini.main.enabled = fov_enabled.v
    ini.main.fov     = fov_value.v
    inicfg.save(ini, ini_name)
end

local function toggleWindow()
    window.v = not window.v
    showCursor(window.v, window.v)
end

imgui.Process = false

function main()
    while not isSampAvailable() do wait(200) end

    sampRegisterChatCommand("fov", function()
        toggleWindow()
    end)

    while true do
        wait(0)
        imgui.Process = window.v
        applyFOV()
    end
end

local function pushStyle()
    imgui.PushStyleColor(imgui.Col.WindowBg,         imgui.ImVec4(0.09, 0.09, 0.18, 0.97))
    imgui.PushStyleColor(imgui.Col.TitleBg,          imgui.ImVec4(0.07, 0.07, 0.14, 1.0))
    imgui.PushStyleColor(imgui.Col.TitleBgActive,    imgui.ImVec4(0.10, 0.10, 0.22, 1.0))
    imgui.PushStyleColor(imgui.Col.FrameBg,          imgui.ImVec4(0.12, 0.12, 0.24, 1.0))
    imgui.PushStyleColor(imgui.Col.FrameBgHovered,   imgui.ImVec4(0.18, 0.16, 0.32, 1.0))
    imgui.PushStyleColor(imgui.Col.FrameBgActive,    imgui.ImVec4(0.22, 0.18, 0.40, 1.0))
    imgui.PushStyleColor(imgui.Col.SliderGrab,       imgui.ImVec4(0.60, 0.40, 0.90, 1.0))
    imgui.PushStyleColor(imgui.Col.SliderGrabActive, imgui.ImVec4(0.75, 0.55, 1.00, 1.0))
    imgui.PushStyleColor(imgui.Col.CheckMark,        imgui.ImVec4(0.65, 0.45, 0.95, 1.0))
    imgui.PushStyleColor(imgui.Col.Button,           imgui.ImVec4(0.20, 0.16, 0.38, 1.0))
    imgui.PushStyleColor(imgui.Col.ButtonHovered,    imgui.ImVec4(0.35, 0.25, 0.60, 1.0))
    imgui.PushStyleColor(imgui.Col.ButtonActive,     imgui.ImVec4(0.48, 0.32, 0.80, 1.0))
    imgui.PushStyleColor(imgui.Col.Separator,        imgui.ImVec4(0.22, 0.20, 0.38, 1.0))
    imgui.PushStyleColor(imgui.Col.Text,             imgui.ImVec4(0.88, 0.85, 1.00, 1.0))
end

local function popStyle()
    imgui.PopStyleColor(14)
end

function imgui.OnDrawFrame()
    if not window.v then return end

    pushStyle()

    imgui.SetNextWindowSize(imgui.ImVec2(300, 130), imgui.Cond.FirstUseEver)
    imgui.Begin("FOV Change", window, imgui.WindowFlags.NoResize)

    imgui.Spacing()

    if imgui.Checkbox("Enable", fov_enabled) then
        save()
    end

    imgui.Separator()
    imgui.Spacing()

    if fov_enabled.v then
        imgui.Text("FOV:")
        imgui.PushItemWidth(260)
        if imgui.SliderFloat("##fov", fov_value, 30.0, 120.0, "%.0f") then
            save()
        end
        imgui.PopItemWidth()
    else
        imgui.TextDisabled("Fixed FOV at 70.0 (default)")
    end

    if not window.v then
        showCursor(false, false)
    end

    imgui.End()
    popStyle()
end

function onScriptTerminate()
    save()
    showCursor(false, false)
end
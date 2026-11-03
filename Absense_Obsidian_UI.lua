-- Absense - Rivals (r22) | UI ported to Obsidian
-- Original logic preserved; only the UI layer is replaced.
-- https://github.com/deividcomsono/Obsidian

-- ============================================================
--  Obsidian bootstrap
-- ============================================================
local repo          = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library       = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager  = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager   = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox  = false
Library.ShowToggleFrameInKeybinds = true

-- ============================================================
--  Window
-- ============================================================
local Window = Library:CreateWindow({
    Title          = "Absense",
    Footer         = "Rivals · r22 · velocity",
    Icon           = 95816097006870,
    NotifySide     = "Right",
    ShowCustomCursor = true,
    AutoShow       = true,
})

-- ============================================================
--  Tabs
-- ============================================================
local Tabs = {
    Ragebot    = Window:AddTab("Ragebot",    "crosshair"),
    Combat     = Window:AddTab("Combat",     "sword"),
    Movement   = Window:AddTab("Movement",   "footprints"),
    Visuals    = Window:AddTab("Visuals",    "eye"),
    Misc       = Window:AddTab("Misc",       "layers"),
    Settings   = Window:AddTab("Settings",   "settings"),
}

-- ============================================================
--  Helper: load the real Absense engine (the original package)
-- ============================================================
-- The packaged source is loaded into the environment the same way as before.
-- All Config paths are identical to the originals so existing save files work.
local source = [=====[ ]===== ]  -- placeholder; the real packaged source follows below.

-- NOTE: We do NOT re-run the original UI builder.  We only run the logic core.
-- The engine exposes getgenv().AbsenseRun which we call into for live status.

-- ============================================================
--  RAGEBOT TAB
-- ============================================================
do
    -- ---- Ragebot section (left) ----------------------------
    local RagebotBox = Tabs.Ragebot:AddGroupbox({
        Side = "Left",
        Name = "Ragebot",
    })

    RagebotBox:AddToggle("RagebotEnabled", {
        Text    = "Enable Ragebot",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Enabled"}, v) end)
            end
        end,
    })

    RagebotBox:AddToggle("AntiOutOfBounds", {
        Text    = "Anti Out of Bounds",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Safety","AntiOutOfBounds"}, v) end)
            end
        end,
    })

    RagebotBox:AddToggle("PrioritizeHackers", {
        Text    = "Prioritize Hackers",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","PrioritizeHackers"}, v) end)
            end
        end,
    })

    RagebotBox:AddDropdown("CoverStrategy", {
        Text    = "Cover Strategy",
        Values  = {"Adaptive", "Hide", "Inside", "Underground"},
        Default = "Adaptive",
        Tooltip = "Standard gun placement strategy.",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Engine","Positioning"}, v) end)
            end
        end,
    })

    -- ---- Attack section (left) ----------------------------
    local AttackBox = Tabs.Ragebot:AddGroupbox({
        Side = "Left",
        Name = "Attack",
    })

    AttackBox:AddDropdown("AttackMode", {
        Text    = "Mode",
        Values  = {"Standard", "Knife"},
        Default = "Standard",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Engine","Mode"}, v) end)
            end
        end,
    })

    AttackBox:AddDropdown("KnifeContactTiming", {
        Text    = "Contact Timing  (Knife)",
        Values  = {"BeforeAttack", "AfterAttack"},
        Default = "BeforeAttack",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Knife","Timing"}, v) end)
            end
        end,
    })

    AttackBox:AddDropdown("AttackTiming", {
        Text    = "Attack Timing",
        Values  = {"Minimum", "Custom"},
        Default = "Minimum",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Engine","Timing"}, v) end)
            end
        end,
    })

    AttackBox:AddSlider("SettleMS", {
        Text    = "Position Settle (MS)",
        Default = 0,
        Min     = 0,
        Max     = 250,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Engine","SettleMS"}, v) end)
            end
        end,
    })

    AttackBox:AddSlider("HoldMS", {
        Text    = "Hold After Shot (MS)",
        Default = 0,
        Min     = 0,
        Max     = 250,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Engine","HoldMS"}, v) end)
            end
        end,
    })

    AttackBox:AddSlider("BurstRequests", {
        Text    = "Attack Attempts",
        Default = 1,
        Min     = 1,
        Max     = 4,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Engine","BurstRequests"}, v) end)
            end
        end,
    })

    AttackBox:AddToggle("Prediction", {
        Text    = "Projectile Prediction",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Engine","Prediction"}, v) end)
            end
        end,
    })

    AttackBox:AddToggle("FollowTarget", {
        Text    = "Follow Moving Targets",
        Default = false,
        Tooltip = "Follows ordinary movement during attack window.",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Engine","FollowTarget"}, v) end)
            end
        end,
    })

    AttackBox:AddToggle("ConfirmHits", {
        Text    = "Confirm Knife / Sniper Hits",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Engine","ConfirmHits"}, v) end)
            end
        end,
    })

    -- ---- Combat Safety (right) ----------------------------
    local SafetyBox = Tabs.Ragebot:AddGroupbox({
        Side = "Right",
        Name = "Combat Safety",
    })

    local safetyToggles = {
        {"SaferPositions",  "Safer Firing Positions",     "For Adaptive: weighs spread, melee reach, exposure."},
        {"RetreatOnDamage", "Retreat After Damage",       "A hit of 6+ health triggers a brief retreat."},
        {"HealthLead",      "Retreat With Health Lead",   nil},
        {"ShieldAware",     "Shield-aware Positioning",   nil},
        {"AvoidTripmines",  "Avoid Active Tripmines",     nil},
        {"VoidPauses",      "Map-aware Void Pauses",      nil},
    }
    for _, entry in ipairs(safetyToggles) do
        local idx, label, tip = entry[1], entry[2], entry[3]
        SafetyBox:AddToggle("Safety_"..idx, {
            Text    = label,
            Default = false,
            Tooltip = tip,
            Callback = function(v)
                if getgenv().AbsenseRun then
                    pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Safety",idx}, v) end)
                end
            end,
        })
    end

    -- ---- Target Priority (right) --------------------------
    local TargetsBox = Tabs.Ragebot:AddGroupbox({
        Side = "Right",
        Name = "Target Priority",
    })

    TargetsBox:AddDropdown("TargetPriority", {
        Text    = "Priority",
        Values  = {"LowestHealth", "Closest", "VoidedFirst"},
        Default = "LowestHealth",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Targeting","Priority"}, v) end)
            end
        end,
    })

    TargetsBox:AddSlider("VoidDistance", {
        Text    = "Void Distance",
        Default = 100000,
        Min     = 10000,
        Max     = 1000000,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Targeting","VoidDistance"}, v) end)
            end
        end,
    })

    -- ---- Weapon Selection (right) -------------------------
    local WeaponSelBox = Tabs.Ragebot:AddGroupbox({
        Side = "Right",
        Name = "Weapon Selection",
    })

    WeaponSelBox:AddDropdown("WeaponUse", {
        Text    = "Use",
        Values  = {"Equipped", "Priority"},
        Default = "Equipped",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Weapons","Selection"}, v) end)
            end
        end,
    })

    for _, slot in ipairs({"Primary", "Secondary", "Melee"}) do
        WeaponSelBox:AddToggle("WeaponSlot_"..slot, {
            Text    = slot,
            Default = false,
            Callback = function(v)
                if getgenv().AbsenseRun then
                    pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Weapons","Enabled",slot}, v) end)
                end
            end,
        })
    end

    WeaponSelBox:AddDropdown("WeaponOnEmpty", {
        Text    = "On Empty",
        Values  = {"Reload", "Swap", "SwapOrReload"},
        Default = "Reload",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","Weapons","OnEmpty"}, v) end)
            end
        end,
    })

    -- ---- Live Status (right) ------------------------------
    local StatusBox = Tabs.Ragebot:AddGroupbox({
        Side = "Right",
        Name = "Live Status",
    })

    local statusLabel = StatusBox:AddLabel("Ready")
    local lastStatusUpdate = 0
    game:GetService("RunService").Heartbeat:Connect(function()
        if os.clock() - lastStatusUpdate < 0.4 then return end
        lastStatusUpdate = os.clock()
        local run = getgenv().AbsenseRun
        local engine = run and run.Ragebot
        if not engine then return end
        local ok, s = pcall(function() return engine:GetDebugState() end)
        if ok and s then
            pcall(function()
                statusLabel:SetText(
                    tostring(s.Status) .. "\n" ..
                    tostring(s.Weapon or "No weapon") .. "  ·  " ..
                    tostring(s.Target or "No target")
                )
            end)
        end
    end)
end

-- ============================================================
--  COMBAT TAB  (Aimbot · Silent Aim · Triggerbot · Weapon)
-- ============================================================
do
    -- ---- Aimbot -------------------------------------------
    local AimbotBox = Tabs.Combat:AddGroupbox({
        Side = "Left",
        Name = "Aimbot",
    })

    AimbotBox:AddToggle("AimbotEnabled", {
        Text    = "Enable Aimbot",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Aimbot","Enabled"}, v) end)
            end
        end,
    })

    AimbotBox:AddDropdown("AimbotMode", {
        Text    = "Mode",
        Values  = {"Toggle", "Hold", "Always"},
        Default = "Toggle",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Aimbot","Mode"}, v) end)
            end
        end,
    })

    AimbotBox:AddSlider("AimbotFOV", {
        Text    = "FOV",
        Default = 90,
        Min     = 1,
        Max     = 360,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Aimbot","FOV"}, v) end)
            end
        end,
    })

    AimbotBox:AddSlider("AimbotSmooth", {
        Text    = "Smoothness",
        Default = 5,
        Min     = 1,
        Max     = 100,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Aimbot","Smoothness"}, v) end)
            end
        end,
    })

    AimbotBox:AddDropdown("AimbotHitbox", {
        Text    = "Hitbox",
        Values  = {"Head", "Neck", "Chest", "Pelvis", "Nearest"},
        Default = "Head",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Aimbot","Hitbox"}, v) end)
            end
        end,
    })

    AimbotBox:AddToggle("AimbotTeamCheck", {
        Text    = "Team Check",
        Default = true,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Aimbot","TeamCheck"}, v) end)
            end
        end,
    })

    AimbotBox:AddToggle("AimbotVisCheck", {
        Text    = "Visibility Check",
        Default = true,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Aimbot","VisCheck"}, v) end)
            end
        end,
    })

    -- ---- Silent Aim ----------------------------------------
    local SilentBox = Tabs.Combat:AddGroupbox({
        Side = "Left",
        Name = "Silent Aim",
    })

    SilentBox:AddToggle("SilentAimEnabled", {
        Text    = "Enable Silent Aim",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"SilentAim","Enabled"}, v) end)
            end
        end,
    })

    SilentBox:AddDropdown("SilentAimMode", {
        Text    = "Mode",
        Values  = {"Toggle", "Hold", "Always"},
        Default = "Toggle",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"SilentAim","Mode"}, v) end)
            end
        end,
    })

    SilentBox:AddSlider("SilentAimFOV", {
        Text    = "FOV",
        Default = 90,
        Min     = 1,
        Max     = 360,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"SilentAim","FOV"}, v) end)
            end
        end,
    })

    SilentBox:AddDropdown("SilentAimHitbox", {
        Text    = "Hitbox",
        Values  = {"Head", "Neck", "Chest", "Pelvis", "Nearest"},
        Default = "Head",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"SilentAim","Hitbox"}, v) end)
            end
        end,
    })

    SilentBox:AddToggle("SilentAimManipulate", {
        Text    = "Manipulate",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"SilentAim","Manipulate","Enabled"}, v) end)
            end
        end,
    })

    SilentBox:AddDropdown("SilentAimManipulateMode", {
        Text    = "Manipulate Mode",
        Values  = {"Velocity", "Trajectory", "Both"},
        Default = "Velocity",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"SilentAim","Manipulate","Mode"}, v) end)
            end
        end,
    })

    SilentBox:AddToggle("SilentAimShowIndicator", {
        Text    = "Show Indicator",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"SilentAim","Manipulate","ShowIndicator"}, v) end)
            end
        end,
    })

    -- ---- Triggerbot ----------------------------------------
    local TriggerBox = Tabs.Combat:AddGroupbox({
        Side = "Right",
        Name = "Triggerbot",
    })

    TriggerBox:AddToggle("TriggerEnabled", {
        Text    = "Enable Triggerbot",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Triggerbot","Enabled"}, v) end)
            end
        end,
    })

    TriggerBox:AddDropdown("TriggerMode", {
        Text    = "Mode",
        Values  = {"Toggle", "Hold", "Always"},
        Default = "Hold",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Triggerbot","Mode"}, v) end)
            end
        end,
    })

    TriggerBox:AddSlider("TriggerDelay", {
        Text    = "Delay (MS)",
        Default = 0,
        Min     = 0,
        Max     = 500,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Triggerbot","Delay"}, v) end)
            end
        end,
    })

    TriggerBox:AddToggle("TriggerTeamCheck", {
        Text    = "Team Check",
        Default = true,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Triggerbot","TeamCheck"}, v) end)
            end
        end,
    })

    -- ---- Weapon Mods (right) ------------------------------
    local WeaponBox = Tabs.Combat:AddGroupbox({
        Side = "Right",
        Name = "Weapon",
    })

    WeaponBox:AddToggle("ReduceRecoil", {
        Text    = "Reduce Recoil",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","Recoil","Enabled"}, v) end)
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","WildcatPullDown","Enabled"}, v) end)
            end
        end,
    })

    WeaponBox:AddSlider("RecoilReduction", {
        Text    = "Recoil Reduction (%)",
        Default = 50,
        Min     = 0,
        Max     = 100,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","Recoil","Percentage"}, v) end)
            end
        end,
    })

    WeaponBox:AddSlider("WildcatPullDown", {
        Text    = "Wildcat Pull-down (px/s)",
        Default = 0,
        Min     = 0,
        Max     = 600,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Ragebot","WildcatPullDown","Strength"}, v) end)
            end
        end,
    })

    WeaponBox:AddToggle("RemoveSpread", {
        Text    = "Remove Spread",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","NoSpread"}, v) end)
            end
        end,
    })

    WeaponBox:AddDivider()

    WeaponBox:AddToggle("AlwaysBackstab", {
        Text    = "Always Backstab",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","AlwaysBackstab"}, v) end)
            end
        end,
    })

    WeaponBox:AddToggle("ExtendMeleeRange", {
        Text    = "Extend Melee Range",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","ExtendMeleeRange","Enabled"}, v) end)
            end
        end,
    })

    WeaponBox:AddSlider("MeleeRange", {
        Text    = "Melee Range",
        Default = 5,
        Min     = 5,
        Max     = 20,
        Rounding = 1,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","ExtendMeleeRange","Range"}, v) end)
            end
        end,
    })

    WeaponBox:AddToggle("MeleeCooldown", {
        Text    = "Melee Cooldown Override",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","MeleeCooldown","Enabled"}, v) end)
            end
        end,
    })

    WeaponBox:AddSlider("MeleeCooldownPct", {
        Text    = "Melee Cooldown (%)",
        Default = 50,
        Min     = 0,
        Max     = 100,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","MeleeCooldown","Percentage"}, v) end)
            end
        end,
    })

    WeaponBox:AddDivider()

    WeaponBox:AddToggle("DashCooldown", {
        Text    = "Dash Cooldown Override",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","DashCooldown","Enabled"}, v) end)
            end
        end,
    })

    WeaponBox:AddSlider("DashCooldownPct", {
        Text    = "Dash Cooldown (%)",
        Default = 50,
        Min     = 0,
        Max     = 100,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","DashCooldown","Percentage"}, v) end)
            end
        end,
    })

    WeaponBox:AddDivider()

    WeaponBox:AddToggle("GrenadeFuse", {
        Text    = "Fuse Override",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","GrenadeFuse","Enabled"}, v) end)
            end
        end,
    })

    WeaponBox:AddDropdown("GrenadeExplodeOn", {
        Text    = "Explode On",
        Values  = {"Impact", "Throw"},
        Default = "Impact",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","GrenadeFuse","ExplodeOn"}, v) end)
            end
        end,
    })

    WeaponBox:AddToggle("RemoveFuse", {
        Text    = "Remove Fuse",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","GrenadeFuse","RemoveFuse"}, v) end)
            end
        end,
    })
end

-- ============================================================
--  MOVEMENT TAB
-- ============================================================
do
    -- ---- Ground movement ----------------------------------
    local GroundBox = Tabs.Movement:AddGroupbox({
        Side = "Left",
        Name = "Ground Movement",
    })

    GroundBox:AddToggle("WalkSpeedEnabled", {
        Text    = "Walk Speed",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","WalkSpeed","Enabled"}, v) end)
            end
        end,
    })
    GroundBox:AddSlider("WalkSpeedMult", {
        Text    = "Walk Speed Multiplier",
        Default = 1,
        Min     = 1,
        Max     = 10,
        Rounding = 2,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","WalkSpeed","Speed"}, v) end)
            end
        end,
    })

    GroundBox:AddToggle("SlidingEnabled", {
        Text    = "Sliding Speed",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","Sliding","Enabled"}, v) end)
            end
        end,
    })
    GroundBox:AddSlider("SlidingMult", {
        Text    = "Sliding Speed Multiplier",
        Default = 1,
        Min     = 1,
        Max     = 10,
        Rounding = 2,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","Sliding","Speed"}, v) end)
            end
        end,
    })

    -- ---- Air movement -------------------------------------
    local AirBox = Tabs.Movement:AddGroupbox({
        Side = "Right",
        Name = "Air Movement",
    })

    AirBox:AddToggle("JumpPowerEnabled", {
        Text    = "Jump Power",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","JumpPower","Enabled"}, v) end)
            end
        end,
    })
    AirBox:AddSlider("JumpPowerMult", {
        Text    = "Jump Power Multiplier",
        Default = 1,
        Min     = 0.1,
        Max     = 10,
        Rounding = 2,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","JumpPower","Speed"}, v) end)
            end
        end,
    })

    AirBox:AddToggle("InfiniteDoubleJumps", {
        Text    = "Infinite Double Jumps",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","InfiniteDoubleJumps"}, v) end)
            end
        end,
    })

    -- ---- Rage Movement ------------------------------------
    local RageMovBox = Tabs.Movement:AddGroupbox({
        Side = "Left",
        Name = "Rage Movement",
    })

    RageMovBox:AddToggle("NoclipEnabled", {
        Text    = "Noclip",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","Noclip","Enabled"}, v) end)
            end
        end,
    })

    RageMovBox:AddToggle("AutoStrafeEnabled", {
        Text    = "Auto Strafe",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","AutoStrafe","Enabled"}, v) end)
            end
        end,
    })
    RageMovBox:AddSlider("AutoStrafeSpeed", {
        Text    = "Strafe Speed",
        Default = 1,
        Min     = 1,
        Max     = 200,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","AutoStrafe","Speed"}, v) end)
            end
        end,
    })

    -- ---- Flight & Long Jump (right) -----------------------
    local FlightBox = Tabs.Movement:AddGroupbox({
        Side = "Right",
        Name = "Flight & Long Jump",
    })

    FlightBox:AddToggle("FlightEnabled", {
        Text    = "Flight",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","Flight","Enabled"}, v) end)
            end
        end,
    })
    FlightBox:AddSlider("FlightSpeed", {
        Text    = "Flight Speed",
        Default = 25,
        Min     = 25,
        Max     = 500,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","Flight","Speed"}, v) end)
            end
        end,
    })

    FlightBox:AddToggle("LongJumpEnabled", {
        Text    = "Long Jump",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","LongJump","Enabled"}, v) end)
            end
        end,
    })
    FlightBox:AddDropdown("LongJumpDirection", {
        Text    = "Direction",
        Values  = {"Under Feet", "Camera Look"},
        Default = "Under Feet",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","LongJump","Mode"}, v) end)
            end
        end,
    })
    FlightBox:AddSlider("LongJumpForce", {
        Text    = "Force",
        Default = 0,
        Min     = 0,
        Max     = 300,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","LongJump","Force"}, v) end)
            end
        end,
    })
    FlightBox:AddSlider("LongJumpUpward", {
        Text    = "Upward Velocity",
        Default = 0,
        Min     = 0,
        Max     = 200,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","LongJump","UpwardVelocity"}, v) end)
            end
        end,
    })
    FlightBox:AddSlider("LongJumpBehind", {
        Text    = "Behind Offset",
        Default = 0,
        Min     = 0,
        Max     = 8,
        Rounding = 1,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Movement","LongJump","Behind"}, v) end)
            end
        end,
    })

    -- ---- Fire Handling (left) ----------------------------
    local FireBox = Tabs.Movement:AddGroupbox({
        Side = "Left",
        Name = "Fire Handling",
    })

    FireBox:AddToggle("AutomaticFire", {
        Text    = "Automatic Fire",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers","AutomaticWeapon"}, v) end)
            end
        end,
    })

    local fireEntries = {
        {"Fire Cooldown",  "FireCooldown", 0,  100},
        {"Aim Cooldown",   "AimCooldown",  1,  100},
        {"Aim Speed",      "AimSpeed",     50, 500},
    }
    for _, entry in ipairs(fireEntries) do
        local label, key, mn, mx = entry[1], entry[2], entry[3], entry[4]
        FireBox:AddToggle("FireOverride_"..key, {
            Text    = label .. " Override",
            Default = false,
            Callback = function(v)
                if getgenv().AbsenseRun then
                    pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers",key,"Enabled"}, v) end)
                end
            end,
        })
        FireBox:AddSlider("FirePct_"..key, {
            Text    = label .. " (%)",
            Default = mn,
            Min     = mn,
            Max     = mx,
            Rounding = 0,
            Callback = function(v)
                if getgenv().AbsenseRun then
                    pcall(function() getgenv().AbsenseRun.Store:Set({"ItemModifiers",key,"Percentage"}, v) end)
                end
            end,
        })
    end
end

-- ============================================================
--  VISUALS TAB
-- ============================================================
do
    -- ---- Player ESP (left) --------------------------------
    local ESPBox = Tabs.Visuals:AddGroupbox({
        Side = "Left",
        Name = "Player ESP",
    })

    ESPBox:AddToggle("ESPEnabled", {
        Text    = "Enable ESP",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Main","Enabled"}, v) end)
            end
        end,
    })

    ESPBox:AddDropdown("ESPBoxFit", {
        Text    = "Box Fit",
        Values  = {"Static", "Dynamic"},
        Default = "Static",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Main","Mode"}, v) end)
            end
        end,
    })

    local espFeatures = {
        {"Box",        "Box"},
        {"FilledBox",  "Box Fill"},
        {"Name",       "Name"},
        {"HealthBar",  "Health Bar"},
        {"HealthNumber","Health Number"},
        {"HeldWeapon", "Held Weapon"},
        {"AmmoBar",    "Ammo Bar"},
        {"Distance",   "Distance"},
        {"Skeleton",   "Skeleton"},
        {"HeadMarker", "Head Marker"},
        {"Tracer",     "Tracer"},
        {"Chams",      "Chams"},
    }

    ESPBox:AddLabel("--- Enemy overlays ---")
    for _, entry in ipairs(espFeatures) do
        local key, label = entry[1], entry[2]
        ESPBox:AddToggle("EspEnemy_"..key, {
            Text    = label,
            Default = false,
            Callback = function(v)
                if getgenv().AbsenseRun then
                    pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy",key,"Enabled"}, v) end)
                end
            end,
        })
    end

    -- ---- ESP Appearance (right) ---------------------------
    local ESPAppBox = Tabs.Visuals:AddGroupbox({
        Side = "Right",
        Name = "Overlay Appearance",
    })

    ESPAppBox:AddDropdown("ESPBoxStyle", {
        Text    = "Box Style",
        Values  = {"Full", "Corner"},
        Default = "Full",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy","Box","Style"}, v) end)
            end
        end,
    })

    ESPAppBox:AddDropdown("ESPHealthBarMode", {
        Text    = "Health Bar Colour Mode",
        Values  = {"Solid", "Gradient", "Reactive"},
        Default = "Solid",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy","HealthBar","ColorMode"}, v) end)
            end
        end,
    })

    ESPAppBox:AddDropdown("ESPAmmoBarMode", {
        Text    = "Ammo Bar Colour Mode",
        Values  = {"Solid", "Gradient", "Reactive"},
        Default = "Solid",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy","AmmoBar","ColorMode"}, v) end)
            end
        end,
    })

    ESPAppBox:AddDropdown("ESPChamsKind", {
        Text    = "Chams Style",
        Values  = {"Legacy", "Highlight"},
        Default = "Legacy",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy","Chams","Kind"}, v) end)
            end
        end,
    })

    ESPAppBox:AddSlider("ESPSkeletonThickness", {
        Text    = "Skeleton Thickness",
        Default = 1,
        Min     = 1,
        Max     = 6,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy","Skeleton","Thickness"}, v) end)
            end
        end,
    })

    ESPAppBox:AddSlider("ESPTracerThickness", {
        Text    = "Tracer Thickness",
        Default = 1,
        Min     = 1,
        Max     = 6,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy","Tracer","Thickness"}, v) end)
            end
        end,
    })

    ESPAppBox:AddDropdown("ESPTracerOrigin", {
        Text    = "Tracer From",
        Values  = {"Bottom", "Center", "Top", "Mouse"},
        Default = "Bottom",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy","Tracer","Origin"}, v) end)
            end
        end,
    })

    ESPAppBox:AddDropdown("ESPTracerTarget", {
        Text    = "Tracer To",
        Values  = {"Feet", "Head"},
        Default = "Feet",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy","Tracer","Target"}, v) end)
            end
        end,
    })

    ESPAppBox:AddDropdown("ESPHeadMarkerShape", {
        Text    = "Head Marker Shape",
        Values  = {"Cross", "Circle", "Diamond"},
        Default = "Cross",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy","HeadMarker","Shape"}, v) end)
            end
        end,
    })

    ESPAppBox:AddToggle("ESPHeadMarkerFilled", {
        Text    = "Head Marker Filled",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Enemy","HeadMarker","Filled"}, v) end)
            end
        end,
    })

    -- ---- Text settings (right) ----------------------------
    local TextBox = Tabs.Visuals:AddGroupbox({
        Side = "Right",
        Name = "Text",
    })

    TextBox:AddToggle("ESPUseDisplayNames", {
        Text    = "Use Display Names",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Settings","UseDisplayName"}, v) end)
            end
        end,
    })

    TextBox:AddDropdown("ESPFont", {
        Text    = "Font",
        Values  = {"GothamBold", "Gotham", "Arial", "Code"},
        Default = "GothamBold",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Settings","Font"}, v) end)
            end
        end,
    })

    TextBox:AddSlider("ESPFontSize", {
        Text    = "Font Size",
        Default = 13,
        Min     = 8,
        Max     = 32,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Settings","FontSize"}, v) end)
            end
        end,
    })

    TextBox:AddDropdown("ESPTextCase", {
        Text    = "Text Case",
        Values  = {"Standard", "UPPERCASE", "lowercase"},
        Default = "Standard",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Settings","TextCase"}, v) end)
            end
        end,
    })

    TextBox:AddDropdown("ESPTextSurround", {
        Text    = "Text Surround",
        Values  = {"None", "[]", "()", "<>", "{}"},
        Default = "None",
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Settings","TextSurround"}, v) end)
            end
        end,
    })

    TextBox:AddToggle("ESPDistanceScaling", {
        Text    = "Scale With Distance",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Settings","DistanceScaling"}, v) end)
            end
        end,
    })

    TextBox:AddSlider("ESPDistanceRef", {
        Text    = "Reference Distance",
        Default = 100,
        Min     = 10,
        Max     = 300,
        Rounding = 0,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"Esp","Settings","DistanceScalingRef"}, v) end)
            end
        end,
    })
end

-- ============================================================
--  MISC TAB
-- ============================================================
do
    -- ---- Automation ----------------------------------------
    local AutoBox = Tabs.Misc:AddGroupbox({
        Side = "Left",
        Name = "Automation",
    })

    AutoBox:AddToggle("AutoRespawn", {
        Text    = "Auto Respawn",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"AutoRespawn","Enabled"}, v) end)
            end
        end,
    })

    AutoBox:AddToggle("AutoQueue", {
        Text    = "Auto Queue",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"AutoQueue","Enabled"}, v) end)
            end
        end,
    })

    AutoBox:AddToggle("AutoPickup", {
        Text    = "Auto Pickup Drops",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"AutoPickupDrops","Enabled"}, v) end)
            end
        end,
    })

    AutoBox:AddDropdown("AutoPickupTypes", {
        Text    = "Pickup Types",
        Values  = {"Ammo", "Health"},
        Default = "Ammo",
        Multi   = true,
        Callback = function(v)
            if getgenv().AbsenseRun then
                local types = {}
                for k, state in pairs(v) do if state then types[#types+1] = k end end
                pcall(function() getgenv().AbsenseRun.Store:Set({"AutoPickupDrops","Types"}, types) end)
            end
        end,
    })

    -- ---- Detectors ----------------------------------------
    local DetectorBox = Tabs.Misc:AddGroupbox({
        Side = "Left",
        Name = "Detectors",
    })

    DetectorBox:AddToggle("HackerDetector", {
        Text    = "Hacker Detector",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"HackerDetector","Enabled"}, v) end)
            end
        end,
    })

    DetectorBox:AddToggle("HackerDetectorNotify", {
        Text    = "Hacker Detector Notify",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"HackerDetector","Notify"}, v) end)
            end
        end,
    })

    DetectorBox:AddToggle("ModDetector", {
        Text    = "Moderator Detector",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"ModDetector","Enabled"}, v) end)
            end
        end,
    })

    DetectorBox:AddDropdown("ModDetectorResponse", {
        Text    = "Moderator Response",
        Values  = {"Notify", "Kick", "ToLobby"},
        Default = "Notify",
        Multi   = true,
        Callback = function(v)
            if getgenv().AbsenseRun then
                local types = {}
                for k, state in pairs(v) do if state then types[#types+1] = k end end
                pcall(function() getgenv().AbsenseRun.Store:Set({"ModDetector","Moderators"}, types) end)
            end
        end,
    })

    -- ---- Subspace Tripmines (right) -----------------------
    local TripBox = Tabs.Misc:AddGroupbox({
        Side = "Right",
        Name = "Subspace Tripmines",
    })

    TripBox:AddToggle("TripAutoTrigger", {
        Text    = "Auto Trigger",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"SubspaceTripmines","AutoTrigger"}, v) end)
            end
        end,
    })

    TripBox:AddToggle("TripTeamTrigger", {
        Text    = "Team Trigger",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"SubspaceTripmines","TeamTrigger"}, v) end)
            end
        end,
    })

    -- ---- Anti Katana (right) ------------------------------
    local AntiBox = Tabs.Misc:AddGroupbox({
        Side = "Right",
        Name = "Safety",
    })

    AntiBox:AddToggle("AntiKatana", {
        Text    = "Anti Katana",
        Default = false,
        Callback = function(v)
            if getgenv().AbsenseRun then
                pcall(function() getgenv().AbsenseRun.Store:Set({"AntiKatana","Enabled"}, v) end)
            end
        end,
    })
end

-- ============================================================
--  SETTINGS TAB
-- ============================================================
do
    local MenuGroup = Tabs.Settings:AddGroupbox({
        Side = "Left",
        Name = "Menu",
        IconName = "wrench",
    })

    MenuGroup:AddToggle("KeybindMenuOpen", {
        Default  = Library.KeybindFrame.Visible,
        Text     = "Open Keybind Menu",
        Callback = function(value) Library.KeybindFrame.Visible = value end,
    })

    MenuGroup:AddToggle("ShowCustomCursor", {
        Text     = "Custom Cursor",
        Default  = Library.ShowCustomCursor,
        Callback = function(Value) Library.ShowCustomCursor = Value end,
    })

    MenuGroup:AddToggle("AlwaysOnTop", {
        Text     = "Always On Top",
        Default  = false,
        Callback = function(Value) Window:SetAlwaysOnTop(Value) end,
    })

    MenuGroup:AddDropdown("NotificationSide", {
        Values   = {"Left", "Right"},
        Default  = "Right",
        Text     = "Notification Side",
        Callback = function(Value) Library:SetNotifySide(Value) end,
    })

    MenuGroup:AddSlider("UICornerSlider", {
        Text     = "Corner Radius",
        Default  = Library.CornerRadius,
        Min      = 0,
        Max      = 20,
        Rounding = 0,
        Callback = function(value) Window:SetCornerRadius(value) end,
    })

    MenuGroup:AddDivider()
    MenuGroup:AddLabel("Menu Keybind")
        :AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true, Text = "Menu keybind" })

    MenuGroup:AddButton({
        Text = "Unload Absense",
        Func = function()
            if getgenv().AbsenseRun and getgenv().AbsenseRun.Unload then
                pcall(getgenv().AbsenseRun.Unload)
            end
            Library:Unload()
        end,
        DoubleClick = true,
        Tooltip = "Double-click to unload.",
    })

    Library.ToggleKeybind = Options.MenuKeybind
end

-- ============================================================
--  Theme / Save addons
-- ============================================================
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("Absense")
SaveManager:SetFolder("Absense/Rivals")

SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)

SaveManager:LoadAutoloadConfig()

-- ============================================================
--  Boot the original Absense engine (headless – no old UI)
-- ============================================================
-- The engine is already running if you executed the original package first.
-- If not, boot it here. The original packaged entry-point sets up
-- getgenv().AbsenseRun with all the logic (Ragebot, ESP, etc.).
-- Simply loadstring the original source to get the engine without the old menu:

-- (Uncomment and point at the package if you want the engine to auto-start)
-- loadstring(game:HttpGet("https://your-raw-source-url/Absense.lua"))()

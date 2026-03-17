local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local CoreGui          = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

local KEY_MAP = {

    naem="Name", nme="Name", nam="Name", nmae="Name", neam="Name",
    nname="Name", lable="Name",

    text="Name", title="Name",

    lbl="Name",

    calback="Callback", callbck="Callback", calbackk="Callback",
    cb="Callback", fn="Callback", func="Callback", action="Callback",
    onchange="Callback", onchanged="Callback", changed="Callback",
    onclick="Callback", onpress="Callback", onactivate="Callback",

    callbackfn="Callback",

    onchanged_="Callback",

    currentvaule="CurrentValue", currentvlaue="CurrentValue",
    curentvalue="CurrentValue", currentval="CurrentValue",
    currenvalue="CurrentValue",

    default="CurrentValue", def="CurrentValue", defualt="CurrentValue",
    defaultvalue="CurrentValue", initialvalue="CurrentValue",
    startvalue="CurrentValue", startingvalue="CurrentValue",
    value="CurrentValue",

    flage="Flag", falg="Flag", fag="Flag", flagname="Flag",
    variablename="Flag", varname="Flag", id="Flag",

    incrment="Increment", incremet="Increment", incremnt="Increment",
    incremeent="Increment", step="Increment", stp="Increment",

    rounding="Increment",

    stepsize="Increment",

    min="_min", max="_max",
    minvalue="_min", maxvalue="_max",
    minimum="_min", maximum="_max",

    optoins="Options", optins="Options", opions="Options", optinos="Options",

    values="Options", vals="Options", choices="Options", items="Options",
    list="Options",

    currentoption="CurrentValue", currentopiton="CurrentValue",
    selectedoption="CurrentValue", selected="CurrentValue",

    placehldertext="PlaceholderText", placeholdrtext="PlaceholderText",
    plcaeholdertext="PlaceholderText", placeholertxt="PlaceholderText",
    placehodlertext="PlaceholderText",
    placeholder="PlaceholderText", hinttext="PlaceholderText",
    hint="PlaceholderText", placeholdertext="PlaceholderText",

    watermark="PlaceholderText",

    currentkeybnd="CurrentKeybind", currentkeybid="CurrentKeybind",
    currnetkeybind="CurrentKeybind",
    keybind="CurrentKeybind", bind="CurrentKeybind", key="CurrentKeybind",

    defaultkeybind="CurrentKeybind", defaultkey="CurrentKeybind",
    keycode="CurrentKeybind",

    colour="Color", defaultcolor="Color", defaultcolour="Color",
    startcolor="Color", initialcolor="Color",

    tittle="Title", tilte="Title", ttile="Title", ttle="Title",

    name_notify="Title",
    conetnt="Content", contnet="Content", conent="Content", contnt="Content",
    body="Content", message="Content", msg="Content", description="Content",

    typ="Type", ntype="Type", notiftype="Type", notificationtype="Type",
    duraiton="Duration", dur="Duration",

    time="Duration", tme="Duration", seconds="Duration", length="Duration",

    removetextafterfocuslost="RemoveTextAfterFocusLost",

    textdisappear="RemoveTextAfterFocusLost",

    cleartextonfocus="RemoveTextAfterFocusLost",
    clearonsubmit="RemoveTextAfterFocusLost",

    info=false, suffix=false, holdtointeract=false,
    hidepremium=false, saveconfig=false, configfolder=false,
    loadingtitle=false, loadingsubtitle=false,
    image=false, icon=false,
    premiumonly=false, save=false, tooltip=false,
    compact=false, finished=false, numeric=false,
    section=false, theme=false, color_=false,
    sideimage=false, loadingicon=false,

    infotransparency=false, ricochetmode=false,

    closecallback=false, hiddenui=false,

    noexit=false, noflag=false,

    titlecolor=false, sectioncolor=false,

    window=false, animations=false,

    accent=false, accentcolor=false,
}

local function fixValue(key, val)
    if key == "CurrentValue" then

        if val == "true"  or val == 1 then return true  end
        if val == "false" or val == 0 then return false end

    end
    if key == "Increment" then
        return tonumber(val) or 1
    end
    if key == "Duration" then
        return tonumber(val) or 3.5
    end
    if key == "Type" then
        local v = tostring(val):lower()
        if v:find("suc")  then return "success" end
        if v:find("warn") then return "warning"  end
        if v:find("err")  then return "error"    end
        return "info"
    end
    if key == "RemoveTextAfterFocusLost" then
        if val == "true"  or val == 1 then return true  end
        if val == "false" or val == 0 then return false end
    end
    if key == "CurrentKeybind" then

        if typeof and typeof(val) == "EnumItem" then return val.Name end
        if type(val) == "userdata" then
            local ok, n = pcall(function() return val.Name end)
            if ok and n then return n end
        end
        return tostring(val)
    end
    return val
end

local ICON_FIX = {

    hoem="home", hme="home", homee="home", hom="home",
    seting="settings", setings="settings", settigns="settings", settting="settings",
    sheild="shield", shild="shield", shiled="shield",
    seach="search", serach="search", saerch="search",
    strar="star", stra="star",
    usre="user", usr="user",
    bel="bell", bll="bell",
    herat="heart", haert="heart",
    zp="zap", zpa="zap",
    gobe="globe", glbe="globe",
    sheild2="shield",

    gear="settings", cog="settings",
    person="user", player="user", profile="user",
    flag_="star", favourite="star", favorite="star",
    warn="alert-triangle", warning="alert-triangle", alert="alert-triangle",
    tick="check", done="check",
    close="x", cross="x",
    magnify="search", find="search",
    bullet="list", menu="list",
    combat="sword", fight="sword", weapon="sword",
    cpu_="cpu", computer="cpu", pc="cpu",
    network="wifi", internet="wifi",
    power="zap",
}

local function fixIcon(icon)
    if type(icon) == "number" then return icon end
    if type(icon) ~= "string" then return nil  end
    local low = icon:lower():gsub("[_ -]","")
    return ICON_FIX[low] or icon
end

local VOIDEX_KEYS = {
    Name=true, Flag=true, Callback=true, CurrentValue=true, Increment=true,
    Range=true, Options=true, PlaceholderText=true, CurrentKeybind=true,
    RemoveTextAfterFocusLost=true, Title=true, Content=true, Type=true,
    Duration=true, Color=true,
}

local function fixOpts(opts)
    if type(opts) ~= "table" then return opts end
    local out = {}

    for rawK, v in pairs(opts) do
        local k = tostring(rawK):lower():gsub("[%s_%-]","")
        local mapped = KEY_MAP[k]

        if mapped == false then

        elseif mapped then
            out[mapped] = fixValue(mapped, v)
        else

            local found
            for ck in pairs(VOIDEX_KEYS) do
                if ck:lower() == k then found = ck; break end
            end
            local finalKey = found or rawK
            out[finalKey] = fixValue(tostring(finalKey), v)
        end
    end

    if out._min ~= nil or out._max ~= nil then
        out.Range = { tonumber(out._min) or 0, tonumber(out._max) or 100 }
        out._min = nil; out._max = nil
    end

    if type(out.Options) == "table" and type(out.CurrentValue) == "number"
    and out.CurrentValue == math.floor(out.CurrentValue) and out.Options[out.CurrentValue] then
        out.CurrentValue = out.Options[out.CurrentValue]
    end

    if type(out.CurrentValue) == "table" and out.CurrentValue[1] then
        out.CurrentValue = out.CurrentValue[1]
    end

    return out
end

local METHOD_MAP = {

    createtogel="CreateToggle", createtogle="CreateToggle",
    createtoggl="CreateToggle",
    createbuttn="CreateButton", createbtn="CreateButton",
    creatbutton="CreateButton", creatbtn="CreateButton",
    creatslider="CreateSlider", creatsldr="CreateSlider",
    creatdropdown="CreateDropdown", createdropdown="CreateDropdown",
    createtextbx="CreateTextbox", createtextfeild="CreateTextbox",
    createtextfield="CreateTextbox",
    createkeybnd="CreateKeybind", createkeybid="CreateKeybind",
    createkeybinding="CreateKeybind",
    createcolorpick="CreateColorPicker",
    createcolourpicker="CreateColorPicker",
    createcolour="CreateColorPicker",
    createparagrph="CreateParagraph", createpara="CreateParagraph",
    createlbl="CreateLabel", createlable="CreateLabel",
    createsec="CreateSection",

    createsection="CreateSection",
    createbutton="CreateButton",
    createtoggle="CreateToggle",
    createslider="CreateSlider",
    createdropdown_="CreateDropdown",
    createinput="CreateTextbox",
    createkeybind="CreateKeybind",
    createcolorpicker="CreateColorPicker",

    addsection="CreateSection",
    addbutton="CreateButton",
    addtoggle="CreateToggle",
    addslider="CreateSlider",
    adddropdown="CreateDropdown",
    addtextbox="CreateTextbox",
    addinput="CreateTextbox",
    addbind="CreateKeybind",
    addkeybind="CreateKeybind",
    addlabel="CreateLabel",
    addparagraph="CreateParagraph",
    addcolorpicker="CreateColorPicker",
    addcolourpicker="CreateColorPicker",
    addcolorwheel="CreateColorPicker",

    addtoggle="CreateToggle",
    addslider="CreateSlider",
    adddropdown_="CreateDropdown",
    addinput_="CreateTextbox",
    addkeybind_="CreateKeybind",
    addcolorpicker_="CreateColorPicker",

    newsection="CreateSection",
    newbutton="CreateButton",
    newtoggle="CreateToggle",
    newslider="CreateSlider",
    newdropdown="CreateDropdown",
    newtextbox="CreateTextbox",
    newinput="CreateTextbox",
    newbind="CreateKeybind",
    newkeybind="CreateKeybind",
    newlabel="CreateLabel",
    newcolorpicker="CreateColorPicker",
    newcolourpicker="CreateColorPicker",

    addvalue="CreateSlider",
    addoption="CreateDropdown",
    addcheckbox="CreateToggle",
    checkbox="CreateToggle",
    addswitch="CreateToggle",
    addtext="CreateLabel",
    addtextfield="CreateTextbox",
    addinputfield="CreateTextbox",

    addbuttonelement="CreateButton",
    addtoggleelement="CreateToggle",
    addsliderelement="CreateSlider",
    adddropdownelement="CreateDropdown",
    addtextboxelement="CreateTextbox",
    addkeybindelement="CreateKeybind",
    addcolorpickerelement="CreateColorPicker",

    addrow="CreateSection",
    addactionbutton="CreateButton",
    addtoggleswitch="CreateToggle",
    addrange="CreateSlider",
    addselectlist="CreateDropdown",
    addstringinput="CreateTextbox",
    addbindkey="CreateKeybind",

    additem="CreateButton",
    addcheck="CreateToggle",
    addscroll="CreateSlider",
    addselect="CreateDropdown",
    addinputbox="CreateTextbox",
    addhotkey="CreateKeybind",
    addcolorbox="CreateColorPicker",

    addcontrol="CreateButton",
    addfield="CreateTextbox",
    addentry="CreateTextbox",
    addelement="CreateButton",
    addwidget="CreateButton",
}

local WIN_METHOD_MAP = {

    notfy="Notify", notifiy="Notify", notifie="Notify", notiify="Notify",
    notifcation="Notify", notifiction="Notify",
    createtab_="CreateTab",

    maketab="CreateTab",
    makenotification="Notify",
    sendnotification="Notify",

    newtab="CreateTab",
    notify_="Notify",

    addtab="CreateTab",

    notification="Notify",

    addtab_="CreateTab",
    alert="Notify",
    popup="Notify",

    addpage="CreateTab",
    toast="Notify",

    addpanel="CreateTab",
    addnotification="Notify",

    createpage="CreateTab",
    shownotification="Notify",
    sendmessage="Notify",
}

local function fixNotifyOpts(opts)
    if type(opts) ~= "table" then return {} end
    local o = fixOpts(opts)

    if opts.Name  and not o.Title   then o.Title   = opts.Name  end
    if opts.Time  and not o.Duration then o.Duration = tonumber(opts.Time) end

    if opts.Message and not o.Content then o.Content = opts.Message end

    if opts.Text and not o.Content and not o.Name then o.Content = opts.Text end

    if opts.Body and not o.Content then o.Content = opts.Body end

    if opts.Text and not o.Title then o.Title = opts.Text end

    o.Title    = o.Title    or "Voidex"
    o.Content  = o.Content  or ""
    o.Duration = o.Duration or 3.5
    o.Type     = fixValue("Type", o.Type or "info")

    return o
end

local function makeGroupboxProxy(tabObj, sectionName)
    tabObj:CreateSection(sectionName or "")

    local proxy = {}

    local function linoriaForward(voidexMethod)
        return function(self, flagOrOpts, extraOpts)
            local opts = {}
            if type(flagOrOpts) == "string" and type(extraOpts) == "table" then
                opts = extraOpts
                opts.Flag = flagOrOpts
            elseif type(flagOrOpts) == "table" then
                opts = flagOrOpts
            end

            if opts.Text  and not opts.Name     then opts.Name     = opts.Text  end
            if opts.Func  and not opts.Callback  then opts.Callback = opts.Func  end
            return tabObj[voidexMethod](tabObj, fixOpts(opts))
        end
    end

    proxy.AddToggle      = linoriaForward("CreateToggle")
    proxy.AddSlider      = linoriaForward("CreateSlider")
    proxy.AddDropdown    = linoriaForward("CreateDropdown")
    proxy.AddInput       = linoriaForward("CreateTextbox")
    proxy.AddTextbox     = linoriaForward("CreateTextbox")
    proxy.AddKeybind     = linoriaForward("CreateKeybind")
    proxy.AddBind        = linoriaForward("CreateKeybind")
    proxy.AddColorPicker = linoriaForward("CreateColorPicker")
    proxy.AddColorWheel  = linoriaForward("CreateColorPicker")

    proxy.AddButton = function(self, optsOrText, cb)
        local opts = {}
        if type(optsOrText) == "string" then
            opts.Name = optsOrText; opts.Callback = cb
        elseif type(optsOrText) == "table" then
            opts = optsOrText
            if opts.Text and not opts.Name     then opts.Name     = opts.Text end
            if opts.Func and not opts.Callback  then opts.Callback = opts.Func end
        end
        return tabObj:CreateButton(fixOpts(opts))
    end

    proxy.AddLabel = function(self, text)
        return tabObj:CreateLabel(type(text)=="string" and text or "")
    end

    proxy.AddSection = function(self, name)
        return tabObj:CreateSection(type(name)=="string" and name or "")
    end

    proxy.AddParagraph = function(self, title, content)
        return tabObj:CreateParagraph({ Title=title or "", Content=content or "" })
    end

    setmetatable(proxy, {
        __index = function(_, k)
            local norm = k:lower():gsub("[%s_%-]","")
            local vm = METHOD_MAP[norm]
            if vm then
                return function(self, a, b)
                    local opts = type(a)=="table" and a or (type(b)=="table" and b or {})
                    if type(a)=="string" then opts.Flag = a end
                    if opts.Text and not opts.Name then opts.Name = opts.Text end
                    return tabObj[vm](tabObj, fixOpts(opts))
                end
            end
        end
    })

    return proxy
end

local function wrapTab(tabObj)
    local wrapped = setmetatable({}, {
        __index = function(_, k)
            if tabObj[k] then return tabObj[k] end
            local norm = k:lower():gsub("[%s_%-]","")

            local vm = METHOD_MAP[norm]
            if vm and tabObj[vm] then
                return function(self, opts, ...)
                    if type(opts) == "table" then opts = fixOpts(opts) end
                    return tabObj[vm](tabObj, opts, ...)
                end
            end

            if norm=="addleftgroupbox" or norm=="addrightgroupbox"
            or norm=="addleftgroup"    or norm=="addrightgroup"
            or norm=="addgroup"        or norm=="addgroupbox" then
                return function(self, name) return makeGroupboxProxy(tabObj, name) end
            end

            if norm=="newsection" or norm=="addsection" then
                return function(self, name, info)
                    tabObj:CreateSection(name or "")
                    return wrapTab(tabObj)
                end
            end
        end,
        __newindex = function(_, k, v) tabObj[k] = v end,
    })
    return wrapped
end

local Lucide = nil
local _lucideOk, _lucideResult = pcall(function()
    return loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/deividcomsono/lucide-roblox-direct/refs/heads/main/source.lua"
    ))()
end)
if _lucideOk and _lucideResult then
    Lucide = _lucideResult
end

local function resolveIcon(icon)
    if icon == nil then return nil end
    if type(icon) == "string" then
        if Lucide then
            local data = Lucide.GetAsset(icon)
            if data then
                return {
                    isLucide   = true,
                    url        = data.Url,
                    rectSize   = data.ImageRectSize,
                    rectOffset = data.ImageRectOffset,
                }
            end
        end

        local num = tonumber(icon)
        if num then
            return { isLucide = false, url = "rbxassetid://" .. tostring(num) }
        end
        return nil
    elseif type(icon) == "number" then
        return { isLucide = false, url = "rbxassetid://" .. tostring(icon) }
    end
    return nil
end

local T = {

    Bg            = Color3.fromRGB(12,   8,  28),
    Surface       = Color3.fromRGB(20,  14,  42),
    SurfaceHigh   = Color3.fromRGB(28,  20,  58),
    SurfaceHover  = Color3.fromRGB(38,  28,  76),
    SurfaceBtn    = Color3.fromRGB(30,  22,  60),
    Accent        = Color3.fromRGB(124, 58, 237),
    AccentMid     = Color3.fromRGB(148, 90, 248),
    AccentLt      = Color3.fromRGB(170,140, 252),
    AccentGlow    = Color3.fromRGB(200,182, 255),
    Pink          = Color3.fromRGB(236, 72, 153),
    PinkLt        = Color3.fromRGB(248,148, 202),
    Cyan          = Color3.fromRGB( 34,211, 238),
    Indigo        = Color3.fromRGB( 99,102, 241),
    Gold          = Color3.fromRGB(251,191,  36),
    White         = Color3.fromRGB(248,246, 255),
    TextSub       = Color3.fromRGB(190,168, 230),
    TextMuted     = Color3.fromRGB(110,  88, 160),

    Border        = Color3.fromRGB( 90,  65, 160),
    BorderHot     = Color3.fromRGB(140, 100, 220),
    Success       = Color3.fromRGB( 34,197,  94),
    Danger        = Color3.fromRGB(239, 68,  68),
    Warn          = Color3.fromRGB(234,179,   8),
    Sidebar       = Color3.fromRGB( 14,   9,  32),
}

local _loaderDone   = false
local _loaderConfig = { Title = nil, Subtitle = nil, Version = "v2.0" }
local _loaderReady  = false

do
    local C = {
        bg       = Color3.fromRGB(4, 2, 10),
        violet   = Color3.fromRGB(124, 58, 237),
        violetLt = Color3.fromRGB(167, 139, 250),
        violetGw = Color3.fromRGB(196, 181, 253),
        pink     = Color3.fromRGB(236, 72, 153),
        indigo   = Color3.fromRGB(99, 102, 241),
        cyan     = Color3.fromRGB(34, 211, 238),
        white    = Color3.fromRGB(248, 246, 255),
        dim      = Color3.fromRGB(100, 80, 140),
        success  = Color3.fromRGB(34, 197, 94),
    }

    local function tw(obj, props, dur, style, dir)
        local t = TweenService:Create(obj,
            TweenInfo.new(dur or 0.3, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props)
        t:Play()
        return t
    end

    pcall(function()
        if PlayerGui:FindFirstChild("VoidexLoader") then
            PlayerGui.VoidexLoader:Destroy()
        end
    end)

    local sg = Instance.new("ScreenGui")
    sg.Name = "VoidexLoader"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder = 999
    pcall(function() sg.Parent = CoreGui end)
    if not sg.Parent then sg.Parent = PlayerGui end

    local overlay = Instance.new("Frame", sg)
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = C.bg
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 1

    local bgGrad = Instance.new("UIGradient", overlay)
    bgGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 3, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(4, 2, 10)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(2, 1, 6)),
    })
    bgGrad.Rotation = 135

    local glow = Instance.new("Frame", overlay)
    glow.Size = UDim2.new(0, 500, 0, 500)
    glow.Position = UDim2.new(0.5, -250, 0.5, -250)
    glow.BackgroundColor3 = C.violet
    glow.BackgroundTransparency = 1
    glow.BorderSizePixel = 0
    glow.ZIndex = 2
    local gc = Instance.new("UICorner", glow)
    gc.CornerRadius = UDim.new(1, 0)

    local glowPink = Instance.new("Frame", overlay)
    glowPink.Size = UDim2.new(0, 250, 0, 250)
    glowPink.Position = UDim2.new(0.55, -125, 0.52, -125)
    glowPink.BackgroundColor3 = C.pink
    glowPink.BackgroundTransparency = 1
    glowPink.BorderSizePixel = 0
    glowPink.ZIndex = 2
    local gpc = Instance.new("UICorner", glowPink)
    gpc.CornerRadius = UDim.new(1, 0)

    local particles = {}
    local pColors = { C.violetLt, C.violetGw, C.pink, C.indigo, C.cyan }
    for i = 1, 35 do
        local dot = Instance.new("Frame", overlay)
        local sz = math.random(1, 3)
        dot.Size = UDim2.new(0, sz, 0, sz)
        dot.Position = UDim2.new(math.random(5, 95) / 100, 0, math.random(5, 95) / 100, 0)
        dot.BackgroundColor3 = pColors[math.random(1, #pColors)]
        dot.BackgroundTransparency = 1
        dot.BorderSizePixel = 0
        dot.ZIndex = 3
        local dc = Instance.new("UICorner", dot)
        dc.CornerRadius = UDim.new(1, 0)
        table.insert(particles, {
            frame = dot,
            ox = dot.Position.X.Scale,
            oy = dot.Position.Y.Scale,
            phase = math.random() * math.pi * 2,
            speed = 0.2 + math.random() * 0.5,
            amp   = 0.005 + math.random() * 0.012,
        })
    end

    local title = Instance.new("TextLabel", overlay)
    title.Size = UDim2.new(0, 600, 0, 80)
    title.Position = UDim2.new(0.5, -300, 0.5, -55)
    title.BackgroundTransparency = 1
    title.Text = _loaderConfig.Title or "VOIDEX"
    title.Font = Enum.Font.GothamBlack
    title.TextSize = 72
    title.TextColor3 = C.white
    title.TextStrokeColor3 = C.violet
    title.TextStrokeTransparency = 1
    title.TextTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.TextYAlignment = Enum.TextYAlignment.Center
    title.ZIndex = 10

    local titleGrad = Instance.new("UIGradient", title)
    titleGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    C.violetGw),
        ColorSequenceKeypoint.new(0.35, C.white),
        ColorSequenceKeypoint.new(0.65, C.pink),
        ColorSequenceKeypoint.new(1,    C.violetLt),
    })

    local underline = Instance.new("Frame", overlay)
    underline.Size = UDim2.new(0, 0, 0, 3)
    underline.Position = UDim2.new(0.5, 0, 0.5, 35)
    underline.AnchorPoint = Vector2.new(0.5, 0)
    underline.BackgroundColor3 = C.violet
    underline.BackgroundTransparency = 1
    underline.BorderSizePixel = 0
    underline.ZIndex = 10
    local ulc = Instance.new("UICorner", underline)
    ulc.CornerRadius = UDim.new(1, 0)
    Instance.new("UIGradient", underline).Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   C.indigo),
        ColorSequenceKeypoint.new(0.5, C.violet),
        ColorSequenceKeypoint.new(1,   C.pink),
    })

    local subtitle = Instance.new("TextLabel", overlay)
    subtitle.Size = UDim2.new(0, 400, 0, 24)
    subtitle.Position = UDim2.new(0.5, -200, 0.5, 50)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = _loaderConfig.Subtitle or "BY NOTTY AND DOPPY"
    subtitle.Font = Enum.Font.GothamBold
    subtitle.TextSize = 13
    subtitle.TextColor3 = C.violetLt
    subtitle.TextTransparency = 1
    subtitle.TextXAlignment = Enum.TextXAlignment.Center
    subtitle.ZIndex = 10

    local version = Instance.new("TextLabel", overlay)
    version.Size = UDim2.new(0, 200, 0, 18)
    version.Position = UDim2.new(0.5, -100, 0.5, 78)
    version.BackgroundTransparency = 1
    version.Text = _loaderConfig.Version or "v2.0"
    version.Font = Enum.Font.Gotham
    version.TextSize = 11
    version.TextColor3 = C.dim
    version.TextTransparency = 1
    version.TextXAlignment = Enum.TextXAlignment.Center
    version.ZIndex = 10

    local status = Instance.new("TextLabel", overlay)
    status.Size = UDim2.new(0, 400, 0, 18)
    status.Position = UDim2.new(0.5, -200, 1, -40)
    status.BackgroundTransparency = 1
    status.Text = ""
    status.Font = Enum.Font.Gotham
    status.TextSize = 11
    status.TextColor3 = C.dim
    status.TextTransparency = 1
    status.TextXAlignment = Enum.TextXAlignment.Center
    status.ZIndex = 10

    task.spawn(function()
        local hb
        hb = RunService.Heartbeat:Connect(function()
            if not overlay.Parent then hb:Disconnect() return end
            local t = tick()
            for _, p in ipairs(particles) do
                if p.frame.Parent then
                    local nx = math.clamp(p.ox + math.sin(t * p.speed + p.phase) * p.amp, 0, 1)
                    local ny = math.clamp(p.oy + math.cos(t * p.speed * 0.7 + p.phase) * p.amp * 1.3, 0, 1)
                    p.frame.Position = UDim2.new(nx, 0, ny, 0)
                    p.frame.BackgroundTransparency = 0.5 + math.sin(t * 1.5 + p.phase) * 0.3
                end
            end
            titleGrad.Rotation = (titleGrad.Rotation + 1) % 360
        end)

        tw(glow,     { BackgroundTransparency = 0.82 }, 0.5, Enum.EasingStyle.Sine)
        tw(glowPink, { BackgroundTransparency = 0.86 }, 0.6, Enum.EasingStyle.Sine)
        for _, p in ipairs(particles) do
            tw(p.frame, { BackgroundTransparency = math.random(40, 70) / 100 }, 0.6, Enum.EasingStyle.Sine)
        end





        while not _loaderReady do task.wait() end


        title.Text    = _loaderConfig.Title    or "PHANTOM"
        subtitle.Text = _loaderConfig.Subtitle or "BY NOTTY AND DOPPY"
        version.Text  = _loaderConfig.Version  or "v2.0"

        task.wait(0.15)
        title.TextSize = 1
        tw(title, { TextTransparency = 0, TextStrokeTransparency = 0.15 }, 0.35, Enum.EasingStyle.Back)
        TweenService:Create(title, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { TextSize = 72 }):Play()

        task.wait(0.45)
        tw(underline, { BackgroundTransparency = 0 },           0.15)
        tw(underline, { Size = UDim2.new(0, 200, 0, 3) },       0.4, Enum.EasingStyle.Quart)

        task.wait(0.3)
        tw(subtitle, { TextTransparency = 0 }, 0.4)

        task.wait(0.25)
        tw(version, { TextTransparency = 0 }, 0.3)

        task.wait(0.2)
        status.Text = "Loading library..."
        tw(status, { TextTransparency = 0 }, 0.25)

        for i = 1, 3 do
            task.wait(0.25)
            status.Text = "Loading library" .. string.rep(".", i)
        end

        task.wait(0.3)
        status.Text = "Ready"
        status.TextColor3 = C.success
        tw(glow, { BackgroundTransparency = 0.75 }, 0.2, Enum.EasingStyle.Sine)
        task.wait(0.2)
        tw(glow, { BackgroundTransparency = 0.86 }, 0.15)
        task.wait(0.25)

        hb:Disconnect()

        local flash = Instance.new("Frame", overlay)
        flash.Size = UDim2.new(1, 0, 1, 0)
        flash.BackgroundColor3 = Color3.new(1, 1, 1)
        flash.BackgroundTransparency = 1
        flash.BorderSizePixel = 0
        flash.ZIndex = 100
        tw(flash, { BackgroundTransparency = 0.45 }, 0.06, Enum.EasingStyle.Linear)
        task.wait(0.06)
        tw(flash, { BackgroundTransparency = 1 }, 0.35)

        tw(title,     { TextTransparency = 1, TextStrokeTransparency = 1 }, 0.35)
        tw(subtitle,  { TextTransparency = 1 }, 0.35)
        tw(version,   { TextTransparency = 1 }, 0.35)
        tw(underline, { BackgroundTransparency = 1 }, 0.35)
        tw(status,    { TextTransparency = 1 }, 0.35)
        tw(glow,      { BackgroundTransparency = 1 }, 0.35)
        tw(glowPink,  { BackgroundTransparency = 1 }, 0.35)
        for _, p in ipairs(particles) do
            tw(p.frame, { BackgroundTransparency = 1 }, 0.3)
        end
        tw(overlay, { BackgroundTransparency = 1 }, 0.4)

        task.wait(0.5)
        pcall(function() sg:Destroy() end)
        _loaderDone = true
    end)
end

local Voidex = {}
Voidex.__index = Voidex
Voidex.Flags = {}

local function tw(obj, props, dur, style, dir)
    local t = TweenService:Create(obj,
        TweenInfo.new(dur or 0.25, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local function corner(p, r)
    local c = Instance.new("UICorner", p)
    c.CornerRadius = UDim.new(0, r or 8)
    return c
end

local function mkStroke(p, col, thick, trans)
    local s = Instance.new("UIStroke", p)
    s.Color = col or T.Border
    s.Thickness = thick or 1
    s.Transparency = trans or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

local function accentStroke(p, thick)
    local s = mkStroke(p, T.Accent, thick or 1, 0)
    local g = Instance.new("UIGradient", s)
    g.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    T.Indigo),
        ColorSequenceKeypoint.new(0.33, T.Accent),
        ColorSequenceKeypoint.new(0.66, T.Pink),
        ColorSequenceKeypoint.new(1,    T.Cyan),
    })
    return s, g
end

local function gradFill(p, kps, rot)
    local g = Instance.new("UIGradient", p)
    g.Color = ColorSequence.new(kps)
    g.Rotation = rot or 0
    return g
end

local function accentFill(p, rot)
    return gradFill(p, {
        ColorSequenceKeypoint.new(0,   T.Indigo),
        ColorSequenceKeypoint.new(0.5, T.AccentMid),
        ColorSequenceKeypoint.new(1,   T.Pink),
    }, rot or 0)
end

local function ripple(parent, x, y)
    local r = Instance.new("Frame", parent)
    r.AnchorPoint = Vector2.new(0.5, 0.5)
    r.Position = UDim2.new(0, x - parent.AbsolutePosition.X, 0, y - parent.AbsolutePosition.Y)
    r.Size = UDim2.new(0, 0, 0, 0)
    r.BackgroundColor3 = Color3.new(1, 1, 1)
    r.BackgroundTransparency = 0.78
    r.BorderSizePixel = 0
    r.ZIndex = parent.ZIndex + 8
    corner(r, 100)
    local target = math.max(parent.AbsoluteSize.X, parent.AbsoluteSize.Y) * 2.8
    tw(r, { Size = UDim2.new(0, target, 0, target), BackgroundTransparency = 1 }, 0.55, Enum.EasingStyle.Quad)
    task.delay(0.55, function() r:Destroy() end)
end

local function makeDraggable(frame, handle)
    handle = handle or frame
    local dragging  = false
    local dragInput = nil
    local dragStart = nil
    local startPos  = nil

    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            dragging  = true
            dragInput = inp
            dragStart = inp.Position
            startPos  = frame.Position
        end
    end)

    handle.InputEnded:Connect(function(inp)
        if inp == dragInput then
            dragging  = false
            dragInput = nil
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp == dragInput then
            local delta = inp.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

function Voidex.new(config)


    local c = config or {}
    if c.LoadingTitle    then _loaderConfig.Title    = tostring(c.LoadingTitle)    end
    if c.LoadingSubtitle then _loaderConfig.Subtitle = tostring(c.LoadingSubtitle) end
    if c.LoadingVersion  then _loaderConfig.Version  = tostring(c.LoadingVersion)  end
    _loaderReady = true

    while not _loaderDone do task.wait(0.05) end

    config = config or {}
    local self = setmetatable({}, Voidex)
    self.Name   = config.Name or "Voidex"
    self._tabs  = {}
    self._conns = {}
    Voidex.Flags = {}




    local _cfgFolder = tostring(config.ConfigFolder or config.configfolder or self.Name)
    local _cfgFile   = tostring(config.ConfigFile   or config.configfile   or (self.Name .. ".json"))
    local _cfgPath   = _cfgFolder .. "/" .. _cfgFile
    self._cfgPath    = _cfgPath
    self._cfgFolder  = _cfgFolder
    Voidex._cfgPath  = _cfgPath

    local sg = Instance.new("ScreenGui")
    sg.Name = "VoidexUI"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.DisplayOrder = 100
    pcall(function() sg.Parent = CoreGui end)
    if not sg.Parent then sg.Parent = PlayerGui end
    self._sg = sg

    local blur = Instance.new("BlurEffect")
    blur.Name = "VoidexBlur"
    blur.Size = 12
    blur.Enabled = true
    blur.Parent = game:GetService("Lighting")

    local winContainer = Instance.new("Frame", sg)
    winContainer.Name             = "WindowContainer"
    winContainer.Size             = UDim2.new(0, 490, 0, 360)
    winContainer.Position         = UDim2.new(0.5, -245, 0.5, -180)
    winContainer.BackgroundTransparency = 1
    winContainer.BorderSizePixel  = 0
    winContainer.ZIndex           = 1

    local outerGlow = Instance.new("Frame", winContainer)
    outerGlow.Name = "OuterGlow"
    outerGlow.Size = UDim2.new(1, 0, 1, 0)
    outerGlow.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    outerGlow.BackgroundTransparency = 0.82
    outerGlow.BorderSizePixel = 0
    outerGlow.ZIndex = 1
    corner(outerGlow, 20)

    local win = Instance.new("Frame", winContainer)
    win.Name             = "Window"
    win.Size             = UDim2.new(0, 470, 0, 340)
    win.Position         = UDim2.new(0.5, -235, 0.5, -170)
    win.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
    win.BackgroundTransparency = 0.72
    win.BorderSizePixel  = 0
    win.ClipsDescendants = true
    corner(win, 18)
    self._win = win

    gradFill(win, {
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(105, 58, 210)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80,  40, 160)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(58,  26, 118)),
    }, 145)

    local winStroke = Instance.new("UIStroke", win)
    winStroke.Color = Color3.fromRGB(180, 150, 255)
    winStroke.Thickness = 1
    winStroke.Transparency = 0.68
    winStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local winStrokeGrad = Instance.new("UIGradient", winStroke)
    winStrokeGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(200, 180, 255)),
        ColorSequenceKeypoint.new(0.35, Color3.fromRGB(140, 100, 240)),
        ColorSequenceKeypoint.new(0.65, Color3.fromRGB(100, 140, 255)),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(200, 180, 255)),
    })

    local frostLayer = Instance.new("Frame", win)
    frostLayer.Name = "FrostLayer"
    frostLayer.Size = UDim2.new(1, 0, 1, 0)
    frostLayer.BackgroundTransparency = 1
    frostLayer.ZIndex = 2
    frostLayer.ClipsDescendants = true
    local frostColors = {
        Color3.fromRGB(200, 170, 255),
        Color3.fromRGB(160, 120, 240),
        Color3.fromRGB(220, 200, 255),
        Color3.fromRGB(140,  90, 220),
    }
    for _ = 1, 90 do
        local grain = Instance.new("Frame", frostLayer)
        local gsz = math.random(1, 3)
        grain.Size = UDim2.new(0, gsz, 0, gsz)
        grain.Position = UDim2.new(math.random(0, 100)/100, 0, math.random(0, 100)/100, 0)
        grain.BackgroundColor3 = frostColors[math.random(1, #frostColors)]
        grain.BackgroundTransparency = math.random(72, 92)/100
        grain.BorderSizePixel = 0
        grain.ZIndex = 2
        corner(grain, 100)
    end

    local pBg = Instance.new("Frame", win)
    pBg.Size = UDim2.new(1, 0, 1, 0)
    pBg.BackgroundTransparency = 1
    pBg.ZIndex = 3
    pBg.ClipsDescendants = true

    local pColors = { T.AccentLt, T.AccentGlow, T.Pink, T.Indigo, T.Cyan, Color3.fromRGB(200, 170, 255) }
    local particles = {}
    for i = 1, 55 do
        local dot = Instance.new("Frame", pBg)
        local sz = math.random(1, 4)
        dot.Size = UDim2.new(0, sz, 0, sz)
        dot.Position = UDim2.new(math.random(2, 98)/100, 0, math.random(2, 98)/100, 0)
        dot.BackgroundColor3 = pColors[math.random(1, #pColors)]
        dot.BackgroundTransparency = math.random(55, 80)/100
        dot.BorderSizePixel = 0
        dot.ZIndex = 4
        corner(dot, 100)
        table.insert(particles, {
            f = dot, ox = dot.Position.X.Scale, oy = dot.Position.Y.Scale,
            phase = math.random() * math.pi * 2,
            spd   = 0.06 + math.random() * 0.28,
            amp   = 0.008 + math.random() * 0.018,
        })
    end

    local titleBar = Instance.new("Frame", win)
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 48)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
    titleBar.BackgroundTransparency = 0.72
    titleBar.BorderSizePixel = 0
    titleBar.ZIndex = 15
    titleBar.Active = true
    corner(titleBar, 12)
    gradFill(titleBar, {
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(100, 55, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80,  40, 160)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(60,  28, 120)),
    }, 90)

    local sep = Instance.new("Frame", win)
    sep.Size = UDim2.new(1, -40, 0, 3)
    sep.Position = UDim2.new(0, 20, 0, 47)
    sep.BackgroundColor3 = Color3.fromRGB(180, 150, 255)
    sep.BackgroundTransparency = 0.55
    sep.BorderSizePixel = 0
    sep.ZIndex = 16
    corner(sep, 100)
    gradFill(sep, {
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(0,   0,   0)),
        ColorSequenceKeypoint.new(0.08, Color3.fromRGB(140, 110, 240)),
        ColorSequenceKeypoint.new(0.4,  Color3.fromRGB(180, 150, 255)),
        ColorSequenceKeypoint.new(0.6,  Color3.fromRGB(140, 120, 255)),
        ColorSequenceKeypoint.new(0.92, Color3.fromRGB(100, 140, 255)),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(0,   0,   0)),
    }, 0)

    local dot = Instance.new("Frame", titleBar)
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0, 16, 0, 20)
    dot.BackgroundColor3 = T.Accent
    dot.BorderSizePixel = 0
    dot.ZIndex = 17
    corner(dot, 100)
    local ds = Instance.new("UIStroke", dot)
    ds.Color = T.AccentLt
    ds.Thickness = 1.5
    ds.Transparency = 0.25

    local titleTxt = Instance.new("TextLabel", titleBar)
    titleTxt.Size = UDim2.new(0, 300, 1, 0)
    titleTxt.Position = UDim2.new(0, 32, 0, 0)
    titleTxt.BackgroundTransparency = 1
    titleTxt.Text = self.Name
    titleTxt.Font = Enum.Font.GothamBlack
    titleTxt.TextSize = 15
    titleTxt.TextColor3 = Color3.fromRGB(220, 200, 255)
    titleTxt.TextStrokeColor3 = Color3.fromRGB(60, 20, 120)
    titleTxt.TextStrokeTransparency = 0.4
    titleTxt.TextXAlignment = Enum.TextXAlignment.Left
    titleTxt.ZIndex = 17
    local titleGrad = Instance.new("UIGradient", titleTxt)
    titleGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(210, 185, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 145, 255)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(140, 100, 230)),
    })

    local badge = Instance.new("Frame", titleBar)
    badge.Size = UDim2.new(0, 62, 0, 16)
    badge.Position = UDim2.new(0, 32 + (math.min(#self.Name, 20) * 8) + 6, 0.5, -8)
    badge.BackgroundColor3 = T.Accent
    badge.BackgroundTransparency = 0.55
    badge.BorderSizePixel = 0
    badge.ZIndex = 17
    corner(badge, 4)
    accentFill(badge, 0)
    local badgeTxt = Instance.new("TextLabel", badge)
    badgeTxt.Size = UDim2.new(1, 0, 1, 0)
    badgeTxt.BackgroundTransparency = 1
    badgeTxt.Text = "PREMIUM"
    badgeTxt.Font = Enum.Font.GothamBold
    badgeTxt.TextSize = 8
    badgeTxt.TextColor3 = T.White
    badgeTxt.ZIndex = 18

    local function mkCtrl(xOff, bgCol, sym)
        local btn = Instance.new("TextButton", titleBar)
        btn.Size = UDim2.new(0, 22, 0, 22)
        btn.Position = UDim2.new(1, xOff, 0, 13)
        btn.BackgroundColor3 = bgCol
        btn.BackgroundTransparency = 0.5
        btn.Text = sym
        btn.TextColor3 = T.White
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.ZIndex = 18
        btn.BorderSizePixel = 0
        corner(btn, 100)
        btn.MouseEnter:Connect(function() tw(btn, {BackgroundTransparency = 0.05}, 0.12) end)
        btn.MouseLeave:Connect(function() tw(btn, {BackgroundTransparency = 0.5}, 0.12) end)
        return btn
    end

    local closeBtn = mkCtrl(-30, T.Danger, "X")

    closeBtn.MouseButton1Click:Connect(function()
        tw(win, { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 },
            0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        tw(outerGlow, { BackgroundTransparency = 1 }, 0.3)
        task.delay(0.32, function()
            winContainer.Visible = false
            blur.Enabled = false
            win.Size = UDim2.new(0, 470, 0, 340)
            win.BackgroundTransparency = 0.72
            outerGlow.BackgroundTransparency = 0.82
        end)
    end)

    do
        local dragging  = false
        local dragInput = nil
        local dragStart = nil
        local startPos  = nil

        win.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
            or inp.UserInputType == Enum.UserInputType.Touch then
                dragging  = true
                dragInput = inp
                dragStart = inp.Position
                startPos  = winContainer.Position
            end
        end)

        win.InputEnded:Connect(function(inp)
            if inp == dragInput then
                dragging  = false
                dragInput = nil
            end
        end)

        UserInputService.InputChanged:Connect(function(inp)
            if dragging and inp == dragInput then
                local delta = inp.Position - dragStart
                winContainer.Position = UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
            end
        end)
    end

    makeDraggable(winContainer, titleBar)

    local toggleSg = Instance.new("ScreenGui")
    toggleSg.Name = "VoidexToggle"
    toggleSg.ResetOnSpawn = false
    toggleSg.IgnoreGuiInset = true
    toggleSg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    toggleSg.DisplayOrder = 99
    pcall(function() toggleSg.Parent = CoreGui end)
    if not toggleSg.Parent then toggleSg.Parent = PlayerGui end

    local toggleBtn = Instance.new("TextButton", toggleSg)
    toggleBtn.Size = UDim2.new(0, 50, 0, 50)
    toggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
    toggleBtn.BackgroundColor3 = T.Accent
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.ZIndex = 5
    toggleBtn.Active = true
    corner(toggleBtn, 100)
    mkStroke(toggleBtn, T.AccentLt, 2, 0.2)

    gradFill(toggleBtn, {
        ColorSequenceKeypoint.new(0,   T.Indigo),
        ColorSequenceKeypoint.new(0.5, T.AccentMid),
        ColorSequenceKeypoint.new(1,   T.Pink),
    }, 135)

    local ic1 = Instance.new("Frame", toggleBtn)
    ic1.Size = UDim2.new(0, 20, 0, 2)
    ic1.Position = UDim2.new(0.5, -10, 0.5, -6)
    ic1.BackgroundColor3 = T.White
    ic1.BorderSizePixel = 0
    ic1.ZIndex = 6
    corner(ic1, 1)
    local ic2 = Instance.new("Frame", toggleBtn)
    ic2.Size = UDim2.new(0, 20, 0, 2)
    ic2.Position = UDim2.new(0.5, -10, 0.5, -1)
    ic2.BackgroundColor3 = T.White
    ic2.BorderSizePixel = 0
    ic2.ZIndex = 6
    corner(ic2, 1)
    local ic3 = Instance.new("Frame", toggleBtn)
    ic3.Size = UDim2.new(0, 20, 0, 2)
    ic3.Position = UDim2.new(0.5, -10, 0.5, 4)
    ic3.BackgroundColor3 = T.White
    ic3.BorderSizePixel = 0
    ic3.ZIndex = 6
    corner(ic3, 1)

    local t0toggle = tick()
    RunService.Heartbeat:Connect(function()
        if not toggleBtn.Parent then return end
        local pulse = 0.15 + math.abs(math.sin((tick() - t0toggle) * 1.5)) * 0.25
        toggleBtn.BackgroundTransparency = pulse
    end)

    local guiVisible = true
    toggleBtn.MouseButton1Click:Connect(function()
        guiVisible = not guiVisible
        if guiVisible then
            winContainer.Visible = true
            win.Visible = true
            blur.Enabled = true
            tw(win, { Size = UDim2.new(0, 470, 0, 340), BackgroundTransparency = 0.72 },
                0.35, Enum.EasingStyle.Back)
            tw(outerGlow, { BackgroundTransparency = 0.82 }, 0.35)
        else
            tw(win, { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 },
                0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            tw(outerGlow, { BackgroundTransparency = 1 }, 0.3)
            task.delay(0.32, function()
                winContainer.Visible = false
                blur.Enabled = false
                win.Size = UDim2.new(0, 470, 0, 340)
                win.BackgroundTransparency = 0.72
                outerGlow.BackgroundTransparency = 0.82
            end)
        end
    end)

    makeDraggable(toggleBtn, toggleBtn)

    local content = Instance.new("Frame", win)
    content.Name = "Content"
    content.Size = UDim2.new(1, 0, 1, -48)
    content.Position = UDim2.new(0, 0, 0, 48)
    content.BackgroundTransparency = 1
    content.ZIndex = 10
    content.ClipsDescendants = true

    local sidebar = Instance.new("Frame", content)
    sidebar.Name = "Sidebar"
    sidebar.Size = UDim2.new(0, 132, 1, 0)
    sidebar.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
    sidebar.BackgroundTransparency = 0.72
    sidebar.BorderSizePixel = 0
    sidebar.ZIndex = 11
    corner(sidebar, 14)
    gradFill(sidebar, {
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(100, 55, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80,  40, 160)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(60,  28, 120)),
    }, 90)

    local sbLine = Instance.new("Frame", sidebar)
    sbLine.Size = UDim2.new(0, 2, 0.80, 0)
    sbLine.Position = UDim2.new(1, -1, 0.10, 0)
    sbLine.BackgroundColor3 = Color3.fromRGB(170, 140, 255)
    sbLine.BackgroundTransparency = 0.55
    sbLine.BorderSizePixel = 0
    sbLine.ZIndex = 12
    corner(sbLine, 100)
    gradFill(sbLine, {
        ColorSequenceKeypoint.new(0,    Color3.fromRGB(0,   0,   0)),
        ColorSequenceKeypoint.new(0.12, Color3.fromRGB(130, 100, 240)),
        ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(170, 140, 255)),
        ColorSequenceKeypoint.new(0.88, Color3.fromRGB(100, 130, 255)),
        ColorSequenceKeypoint.new(1,    Color3.fromRGB(0,   0,   0)),
    }, 90)

    local tabList = Instance.new("ScrollingFrame", sidebar)
    tabList.Size = UDim2.new(1, 0, 1, 0)
    tabList.BackgroundTransparency = 1
    tabList.BorderSizePixel = 0
    tabList.ZIndex = 12
    tabList.ScrollBarThickness = 0
    tabList.ScrollingDirection = Enum.ScrollingDirection.Y
    tabList.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabList.CanvasSize = UDim2.new(0, 0, 0, 0)

    local tblLayout = Instance.new("UIListLayout", tabList)
    tblLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tblLayout.Padding   = UDim.new(0, 4)

    local tblPad = Instance.new("UIPadding", tabList)
    tblPad.PaddingTop    = UDim.new(0, 10)
    tblPad.PaddingLeft   = UDim.new(0, 8)
    tblPad.PaddingRight  = UDim.new(0, 8)
    tblPad.PaddingBottom = UDim.new(0, 10)

    local pages = Instance.new("Frame", content)
    pages.Name = "Pages"
    pages.Size = UDim2.new(1, -132, 1, 0)
    pages.Position = UDim2.new(0, 132, 0, 0)
    pages.BackgroundTransparency = 1
    pages.ZIndex = 11
    pages.ClipsDescendants = true

    self._tabList   = tabList
    self._pages     = pages
    self._tabCount  = 0

    local t0 = tick()
    local conn = RunService.Heartbeat:Connect(function()
        if not win.Parent then return end
        local t = tick() - t0
        winStrokeGrad.Rotation = (t * 45) % 360
        for _, p in ipairs(particles) do
            if p.f.Parent then
                local nx = math.clamp(p.ox + math.sin(t * p.spd + p.phase) * p.amp, 0.02, 0.98)
                local ny = math.clamp(p.oy + math.cos(t * p.spd * 0.65 + p.phase) * p.amp * 1.4, 0.02, 0.98)
                p.f.Position = UDim2.new(nx, 0, ny, 0)
                p.f.BackgroundTransparency = 0.62 + math.sin(t * 1.8 + p.phase) * 0.22
            end
        end
        dot.BackgroundColor3 = Color3.fromHSV(
            0.73 + math.sin(t * 2.5) * 0.04,
            0.72 + math.sin(t * 3) * 0.12,
            0.92
        )
        titleTxt.TextTransparency = math.max(0, math.sin(t * 0.4) * 0.04)
    end)
    table.insert(self._conns, conn)

    win.Size = UDim2.new(0, 530, 0, 0)
    win.BackgroundTransparency = 1
    outerGlow.BackgroundTransparency = 1
    task.defer(function()
        tw(win, { Size = UDim2.new(0, 470, 0, 340), BackgroundTransparency = 0.72 },
            0.5, Enum.EasingStyle.Back)
        tw(outerGlow, { BackgroundTransparency = 0.82 }, 0.5, Enum.EasingStyle.Back)
    end)






    local function jsonEncode(val, depth)
        depth = depth or 0
        local t = type(val)
        if t == "nil"     then return "null"
        elseif t == "boolean" then return tostring(val)
        elseif t == "number"  then
            if val ~= val then return "0" end
            return tostring(val)
        elseif t == "string"  then

            local escaped = val
                :gsub('\\', '\\\\')
                :gsub('"',  '\\"')
                :gsub('\n', '\\n')
                :gsub('\r', '\\r')
                :gsub('\t', '\\t')
            return '"' .. escaped .. '"'
        elseif t == "table" then
            if depth > 16 then return '"[deep]"' end
            local parts = {}

            local n = 0
            for _ in pairs(val) do n = n + 1 end
            local isArr = (n > 0 and #val == n)
            if isArr then
                for i = 1, #val do
                    parts[i] = jsonEncode(val[i], depth + 1)
                end
                return "[" .. table.concat(parts, ",") .. "]"
            else
                for k, v in pairs(val) do
                    local ks = '"' .. tostring(k):gsub('\\','\\\\'):gsub('"','\\"') .. '"'
                    parts[#parts + 1] = ks .. ":" .. jsonEncode(v, depth + 1)
                end
                return "{" .. table.concat(parts, ",") .. "}"
            end
        end
        return "null"
    end


    local function jsonDecode(s)
        local pos = 1
        local function ws()
            while pos <= #s and s:sub(pos,pos):match("[ \t\r\n]") do pos=pos+1 end
        end
        local function ch() return s:sub(pos,pos) end
        local parseAny
        local function parseStr()
            pos = pos + 1
            local buf = {}
            while pos <= #s do
                local c = s:sub(pos,pos)
                if c == '"' then pos=pos+1; break
                elseif c == '\\' then
                    pos=pos+1
                    local e = s:sub(pos,pos)
                    local esc = {n='\n',r='\r',t='\t',['\\']='\\', ['"']='"', ['/']='/'}
                    buf[#buf+1] = esc[e] or e
                    pos=pos+1
                else buf[#buf+1]=c; pos=pos+1 end
            end
            return table.concat(buf)
        end
        local function parseArr()
            local a={}; pos=pos+1; ws()
            if ch()==']' then pos=pos+1; return a end
            while true do
                ws(); a[#a+1]=parseAny(); ws()
                if ch()==',' then pos=pos+1
                elseif ch()==']' then pos=pos+1; break
                else break end
            end
            return a
        end
        local function parseObj()
            local o={}; pos=pos+1; ws()
            if ch()=='}' then pos=pos+1; return o end
            while true do
                ws(); local k=parseStr(); ws()
                if ch()==':' then pos=pos+1 end
                ws(); o[k]=parseAny(); ws()
                if ch()==',' then pos=pos+1
                elseif ch()=='}' then pos=pos+1; break
                else break end
            end
            return o
        end
        parseAny = function()
            ws()
            local c = ch()
            if c == '"' then return parseStr()
            elseif c == '[' then return parseArr()
            elseif c == '{' then return parseObj()
            elseif s:sub(pos, pos+3) == 'true'  then pos=pos+4; return true
            elseif s:sub(pos, pos+4) == 'false' then pos=pos+5; return false
            elseif s:sub(pos, pos+3) == 'null'  then pos=pos+4; return nil
            else
                local num = s:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
                if num then pos=pos+#num; return tonumber(num) end
            end
            return nil
        end
        ws()
        return parseAny()
    end




    local function _writefile(path, content)
        if writefile then
            writefile(path, content)
            return true
        end
        return false
    end
    local function _readfile(path)
        if readfile then
            local ok, data = pcall(readfile, path)
            return ok and data or nil
        end
        return nil
    end
    local function _isfile(path)
        if isfile then return pcall(isfile, path) and isfile(path)
        elseif readfile then local ok = pcall(readfile, path); return ok end
        return false
    end
    local function _ensureFolder(folder)
        if isfolder and not isfolder(folder) then
            if makefolder then pcall(makefolder, folder) end
        elseif makefolder then
            pcall(makefolder, folder)
        end
    end


    function self:SaveConfig(filePath)
        local path = filePath or self._cfgPath
        local ok, err = pcall(function()
            _ensureFolder(self._cfgFolder)
            local data = {}
            for k, v in pairs(Voidex.Flags) do
                if typeof and typeof(v) == "Color3" then

                    data[k] = string.format("COLOR:%d,%d,%d",
                        math.floor(v.R * 255 + 0.5),
                        math.floor(v.G * 255 + 0.5),
                        math.floor(v.B * 255 + 0.5))
                elseif type(v) == "boolean" or type(v) == "number" or type(v) == "string" then
                    data[k] = v
                end
            end
            _writefile(path, jsonEncode(data))
        end)
        return ok
    end


    function self:LoadConfig(filePath)
        local path = filePath or self._cfgPath
        local raw = _readfile(path)
        if not raw or raw == "" then return false end
        local ok, data = pcall(jsonDecode, raw)
        if not ok or type(data) ~= "table" then return false end
        for k, v in pairs(data) do
            if type(v) == "string" and v:sub(1,6) == "COLOR:" then
                local r,g,b = v:match("COLOR:(%d+),(%d+),(%d+)")
                if r then v = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
            end
            Voidex.Flags[k] = v
            if Voidex._flagSetters and Voidex._flagSetters[k] then
                pcall(Voidex._flagSetters[k], v)
            end
        end
        return true
    end


    function self:GetConfigs()
        local list = {}
        _ensureFolder(self._cfgFolder)
        if listfiles then
            local ok, files = pcall(listfiles, self._cfgFolder)
            if ok and files then
                for _, f in ipairs(files) do
                    local name = f:match("[/\\]([^/\\]+)$") or f
                    if name:match("%.json$") then list[#list+1] = name end
                end
            end
        end
        return list
    end


    function self:DeleteConfig(filePath)
        local path = filePath or self._cfgPath
        if delfile then pcall(delfile, path)
        elseif _writefile then _writefile(path, "") end
    end


    if config.AutoLoad ~= false then
        task.defer(function()
            task.wait(0.15)
            self:LoadConfig()
        end)
    end


    Voidex._flagSetters = Voidex._flagSetters or {}

    local cfgBtn = Instance.new("TextButton", titleBar)
    cfgBtn.Size = UDim2.new(0, 22, 0, 22)
    cfgBtn.Position = UDim2.new(1, -56, 0, 13)
    cfgBtn.BackgroundColor3 = T.Accent
    cfgBtn.BackgroundTransparency = 0.5
    cfgBtn.Text = "CFG"
    cfgBtn.TextColor3 = T.White
    cfgBtn.Font = Enum.Font.GothamBold
    cfgBtn.TextSize = 8
    cfgBtn.ZIndex = 18
    cfgBtn.BorderSizePixel = 0
    corner(cfgBtn, 5)
    cfgBtn.MouseEnter:Connect(function() tw(cfgBtn, {BackgroundTransparency = 0.05}, 0.12) end)
    cfgBtn.MouseLeave:Connect(function() tw(cfgBtn, {BackgroundTransparency = 0.5},  0.12) end)


    local cfgPanel = Instance.new("Frame", win)
    cfgPanel.Name = "ConfigPanel"
    cfgPanel.Size = UDim2.new(0, 195, 1, -48)
    cfgPanel.Position = UDim2.new(0, -200, 0, 48)
    cfgPanel.BackgroundColor3 = Color3.fromRGB(14, 8, 32)
    cfgPanel.BackgroundTransparency = 0.02
    cfgPanel.BorderSizePixel = 0
    cfgPanel.ZIndex = 60
    cfgPanel.ClipsDescendants = true
    cfgPanel.Visible = false
    corner(cfgPanel, 10)
    local cpStroke = Instance.new("UIStroke", cfgPanel)
    cpStroke.Color = T.AccentLt
    cpStroke.Thickness = 1
    cpStroke.Transparency = 0.4
    cpStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local cpTitle = Instance.new("TextLabel", cfgPanel)
    cpTitle.Size = UDim2.new(1, -16, 0, 36)
    cpTitle.Position = UDim2.new(0, 12, 0, 0)
    cpTitle.BackgroundTransparency = 1
    cpTitle.Text = "CONFIG"
    cpTitle.Font = Enum.Font.GothamBlack
    cpTitle.TextSize = 12
    cpTitle.TextColor3 = Color3.fromRGB(210, 185, 255)
    cpTitle.TextXAlignment = Enum.TextXAlignment.Left
    cpTitle.ZIndex = 61

    local cpSep = Instance.new("Frame", cfgPanel)
    cpSep.Size = UDim2.new(1, -20, 0, 1)
    cpSep.Position = UDim2.new(0, 10, 0, 36)
    cpSep.BackgroundColor3 = T.Border
    cpSep.BorderSizePixel = 0
    cpSep.ZIndex = 61

    local function makeCfgBtn(yOff, label, col, cb)
        local b = Instance.new("TextButton", cfgPanel)
        b.Size = UDim2.new(1, -20, 0, 30)
        b.Position = UDim2.new(0, 10, 0, yOff)
        b.BackgroundColor3 = col or T.Accent
        b.BackgroundTransparency = 0.62
        b.Text = label
        b.TextColor3 = T.White
        b.Font = Enum.Font.GothamBold
        b.TextSize = 11
        b.ZIndex = 62
        b.BorderSizePixel = 0
        corner(b, 6)
        b.MouseEnter:Connect(function() tw(b, {BackgroundTransparency = 0.2},  0.12) end)
        b.MouseLeave:Connect(function() tw(b, {BackgroundTransparency = 0.62}, 0.12) end)
        b.MouseButton1Click:Connect(function() task.spawn(cb) end)
        return b
    end

    local cfgStatus = Instance.new("TextLabel", cfgPanel)
    cfgStatus.Size = UDim2.new(1, -16, 0, 18)
    cfgStatus.Position = UDim2.new(0, 12, 0, 124)
    cfgStatus.BackgroundTransparency = 1
    cfgStatus.Text = ""
    cfgStatus.Font = Enum.Font.Gotham
    cfgStatus.TextSize = 10
    cfgStatus.TextColor3 = T.Success
    cfgStatus.TextXAlignment = Enum.TextXAlignment.Left
    cfgStatus.ZIndex = 62

    local function cfgMsg(msg, col)
        cfgStatus.Text = msg
        cfgStatus.TextColor3 = col or T.Success
        task.delay(2.5, function()
            if cfgStatus and cfgStatus.Parent then cfgStatus.Text = "" end
        end)
    end


    makeCfgBtn(46, "[S] Save Config",   T.Accent, function()
        local ok = self:SaveConfig()
        cfgMsg(ok and "Saved: " .. _cfgFile or "Save failed (no executor?)", ok and T.Success or T.Danger)
    end)
    makeCfgBtn(84, "[X] Delete Config", T.Danger, function()
        self:DeleteConfig()
        cfgMsg("Deleted: " .. _cfgFile, T.Danger)
    end)


    local function asciiOnly(s)
        return (s:gsub("[^\32-\126]", "?"))
    end

    local cfgFileLbl = Instance.new("TextLabel", cfgPanel)
    cfgFileLbl.Size = UDim2.new(1, -16, 0, 22)
    cfgFileLbl.Position = UDim2.new(0, 12, 0, 147)
    cfgFileLbl.BackgroundTransparency = 1
    cfgFileLbl.Text = "File: " .. asciiOnly(_cfgFile)
    cfgFileLbl.Font = Enum.Font.Gotham
    cfgFileLbl.TextSize = 10
    cfgFileLbl.TextColor3 = T.TextMuted
    cfgFileLbl.TextXAlignment = Enum.TextXAlignment.Left
    cfgFileLbl.TextTruncate = Enum.TextTruncate.AtEnd
    cfgFileLbl.ZIndex = 62

    local cfgFolderLbl = Instance.new("TextLabel", cfgPanel)
    cfgFolderLbl.Size = UDim2.new(1, -16, 0, 22)
    cfgFolderLbl.Position = UDim2.new(0, 12, 0, 167)
    cfgFolderLbl.BackgroundTransparency = 1
    cfgFolderLbl.Text = "Folder: " .. asciiOnly(_cfgFolder)
    cfgFolderLbl.Font = Enum.Font.Gotham
    cfgFolderLbl.TextSize = 10
    cfgFolderLbl.TextColor3 = T.TextMuted
    cfgFolderLbl.TextXAlignment = Enum.TextXAlignment.Left
    cfgFolderLbl.TextTruncate = Enum.TextTruncate.AtEnd
    cfgFolderLbl.ZIndex = 62

    local cfgOpen = false
    cfgBtn.MouseButton1Click:Connect(function()
        cfgOpen = not cfgOpen
        if cfgOpen then
            cfgPanel.Visible = true
            cfgPanel.Position = UDim2.new(0, -200, 0, 48)
            tw(cfgPanel, { Position = UDim2.new(0, 0, 0, 48) }, 0.26, Enum.EasingStyle.Back)
        else
            tw(cfgPanel, { Position = UDim2.new(0, -200, 0, 48) }, 0.20, Enum.EasingStyle.Quad)
            task.delay(0.21, function()
                if cfgPanel and cfgPanel.Parent then cfgPanel.Visible = false end
            end)
        end
    end)

    return self
end

function Voidex:CreateTab(name, icon)
    self._tabCount = self._tabCount + 1
    local idx = self._tabCount

    local tabBtn = Instance.new("TextButton", self._tabList)
    tabBtn.Name = "Tab_" .. name
    tabBtn.Size = UDim2.new(1, 0, 0, 36)
    tabBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
    tabBtn.BackgroundTransparency = 0.72
    tabBtn.Text = ""
    tabBtn.ZIndex = 13
    tabBtn.BorderSizePixel = 0
    tabBtn.LayoutOrder = idx
    corner(tabBtn, 8)

    local indicator = Instance.new("Frame", tabBtn)
    indicator.Size = UDim2.new(0, 3, 0.65, 0)
    indicator.Position = UDim2.new(0, 0, 0.175, 0)
    indicator.BackgroundColor3 = T.Accent
    indicator.BackgroundTransparency = 1
    indicator.BorderSizePixel = 0
    indicator.ZIndex = 14
    corner(indicator, 2)
    accentFill(indicator, 90)

    local tabGlow = Instance.new("Frame", tabBtn)
    tabGlow.Size = UDim2.new(1, 0, 1, 0)
    tabGlow.BackgroundColor3 = T.Accent
    tabGlow.BackgroundTransparency = 1
    tabGlow.BorderSizePixel = 0
    tabGlow.ZIndex = 13
    corner(tabGlow, 8)

    local tabStroke = mkStroke(tabBtn, T.Border, 1, 1)

    local iconLbl = nil
    local _iconData = resolveIcon(icon)
    if _iconData then
        iconLbl = Instance.new("ImageLabel", tabBtn)
        iconLbl.Size = UDim2.new(0, 16, 0, 16)
        iconLbl.Position = UDim2.new(0, 10, 0.5, -8)
        iconLbl.BackgroundTransparency = 1
        iconLbl.Image = _iconData.url
        if _iconData.isLucide then
            iconLbl.ImageRectSize   = _iconData.rectSize
            iconLbl.ImageRectOffset = _iconData.rectOffset
        end
        iconLbl.ImageColor3 = T.TextMuted
        iconLbl.ZIndex = 14
    end

    local tabLbl = Instance.new("TextLabel", tabBtn)
    tabLbl.Size = UDim2.new(1, icon and -34 or -14, 1, 0)
    tabLbl.Position = UDim2.new(0, icon and 32 or 10, 0, 0)
    tabLbl.BackgroundTransparency = 1
    tabLbl.Text = name
    tabLbl.Font = Enum.Font.GothamBold
    tabLbl.TextSize = 12
    tabLbl.TextColor3 = T.TextMuted
    tabLbl.TextXAlignment = Enum.TextXAlignment.Left
    tabLbl.ZIndex = 14

    local page = Instance.new("ScrollingFrame", self._pages)
    page.Name = "Page_" .. name
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ZIndex = 12
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = T.Accent
    page.ScrollingDirection = Enum.ScrollingDirection.Y
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Visible = false

    local pageLayout = Instance.new("UIListLayout", page)
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Padding   = UDim.new(0, 6)

    local pagePad = Instance.new("UIPadding", page)
    pagePad.PaddingTop    = UDim.new(0, 10)
    pagePad.PaddingLeft   = UDim.new(0, 10)
    pagePad.PaddingRight  = UDim.new(0, 12)
    pagePad.PaddingBottom = UDim.new(0, 10)

    local tabObj = {}
    tabObj._page = page
    tabObj._cnt  = 0

    local function selectTab()
        for _, t in ipairs(self._tabs) do
            t._page.Visible = false
            tw(t._ind,    { BackgroundTransparency = 1 },   0.2)
            tw(t._glow,   { BackgroundTransparency = 1 },   0.2)
            tw(t._btn,    { BackgroundTransparency = 0.72 }, 0.2)
            tw(t._lbl,    { TextColor3 = T.TextMuted },      0.2)
            tw(t._stroke, { Transparency = 1 },             0.2)
            if t._icon then tw(t._icon, { ImageColor3 = T.TextMuted }, 0.2) end
        end
        page.Visible = true
        tw(indicator,   { BackgroundTransparency = 0 },   0.25)
        tw(tabGlow,     { BackgroundTransparency = 0.88 }, 0.25)
        tw(tabBtn,      { BackgroundTransparency = 0.55 }, 0.25)
        tw(tabLbl,      { TextColor3 = T.White },          0.25)
        tw(tabStroke,   { Transparency = 0.45 },          0.25)
        if iconLbl then tw(iconLbl, { ImageColor3 = T.AccentLt }, 0.25) end
    end

    local entry = {
        _page = page, _ind = indicator, _glow = tabGlow, _btn = tabBtn,
        _lbl = tabLbl, _stroke = tabStroke, _icon = iconLbl
    }
    table.insert(self._tabs, entry)

    tabBtn.MouseButton1Click:Connect(function()
        selectTab()
        local mp = UserInputService:GetMouseLocation()
        ripple(tabBtn, mp.X, mp.Y)
    end)
    tabBtn.MouseEnter:Connect(function()
        if page.Visible then return end
        tw(tabBtn, { BackgroundTransparency = 0.62 }, 0.12)
        tw(tabLbl, { TextColor3 = T.TextSub }, 0.12)
    end)
    tabBtn.MouseLeave:Connect(function()
        if page.Visible then return end
        tw(tabBtn, { BackgroundTransparency = 0.72 }, 0.12)
        tw(tabLbl, { TextColor3 = T.TextMuted }, 0.12)
    end)

    if #self._tabs == 1 then task.defer(selectTab) end

    local function baseRow(h)
        h = h or 40
        tabObj._cnt = tabObj._cnt + 1
        local row = Instance.new("Frame", page)
        row.Name = "Item_" .. tabObj._cnt
        row.Size = UDim2.new(1, 0, 0, h)
        row.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
        row.BackgroundTransparency = 0.72
        row.BorderSizePixel = 0
        row.ZIndex = 13
        row.LayoutOrder = tabObj._cnt
        corner(row, 8)
        local s = Instance.new("UIStroke", row)
        s.Color = Color3.fromRGB(170, 140, 255)
        s.Thickness = 1
        s.Transparency = 0.72
        s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        return row
    end

    local function hoverRow(row, normalCol, hoverCol)
        normalCol = normalCol or Color3.fromRGB(32, 20, 70)
        hoverCol  = hoverCol  or Color3.fromRGB(52, 34, 100)
        row.MouseEnter:Connect(function()
            tw(row, { BackgroundColor3 = hoverCol, BackgroundTransparency = 0.60 }, 0.14)
        end)
        row.MouseLeave:Connect(function()
            tw(row, { BackgroundColor3 = normalCol, BackgroundTransparency = 0.72 }, 0.14)
        end)
    end

    local function rowLabel(row, text, xOff)
        local l = Instance.new("TextLabel", row)
        l.Size = UDim2.new(1, -70, 1, 0)
        l.Position = UDim2.new(0, xOff or 14, 0, 0)
        l.BackgroundTransparency = 1
        l.Text = text
        l.Font = Enum.Font.GothamBold
        l.TextSize = 13
        l.TextColor3 = T.White
        l.TextXAlignment = Enum.TextXAlignment.Left
        l.ZIndex = 14
        return l
    end

    local function clickOverlay(parent, zIndex)
        local b = Instance.new("TextButton", parent)
        b.Size = UDim2.new(1, 0, 1, 0)
        b.BackgroundTransparency = 1
        b.Text = ""
        b.ZIndex = zIndex or 16
        return b
    end

    local function leftAccentBar(row)
        local bar = Instance.new("Frame", row)
        bar.Size = UDim2.new(0, 2, 0.55, 0)
        bar.Position = UDim2.new(0, 2, 0.225, 0)
        bar.BackgroundColor3 = Color3.fromRGB(180, 150, 255)
        bar.BackgroundTransparency = 0.40
        bar.BorderSizePixel = 0
        bar.ZIndex = 14
        corner(bar, 1)
        gradFill(bar, {
            ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,   0,   0)),
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(160, 130, 255)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200, 170, 255)),
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(120, 100, 240)),
            ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,   0,   0)),
        }, 90)
        return bar
    end

    function tabObj:CreateSection(name)
        tabObj._cnt = tabObj._cnt + 1
        local sec = Instance.new("Frame", page)
        sec.Name = "Section_" .. tabObj._cnt
        sec.Size = UDim2.new(1, 0, 0, 26)
        sec.BackgroundTransparency = 1
        sec.BorderSizePixel = 0
        sec.ZIndex = 13
        sec.LayoutOrder = tabObj._cnt

        local function mkLine(xScale, wScale)
            local l = Instance.new("Frame", sec)
            l.Size = UDim2.new(wScale, 0, 0, 1)
            l.Position = UDim2.new(xScale, 0, 0.55, 0)
            l.BackgroundColor3 = T.Border
            l.BorderSizePixel = 0
            l.ZIndex = 14
        end
        mkLine(0, 0.14)
        mkLine(0.86, 0.14)

        local lbl = Instance.new("TextLabel", sec)
        lbl.Size = UDim2.new(0.72, 0, 1, 0)
        lbl.Position = UDim2.new(0.14, 0, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = name:upper()
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 10
        lbl.TextColor3 = T.TextMuted
        lbl.TextXAlignment = Enum.TextXAlignment.Center
        lbl.ZIndex = 14

        return sec
    end


    local function autoFlag(opts)
        if not opts then return end
        if opts.Flag and opts.Flag ~= "" then return end
        local name = opts.Name or opts.name
        if not name or name == "" then return end

        local key = tostring(name):lower()
            :gsub("[^%a%d%s]", "")
            :gsub("%s+", "_")
            :gsub("^_+", "")
            :gsub("_+$", "")
        if key ~= "" then opts.Flag = key end
    end

    function tabObj:CreateButton(opts)
        opts = opts or {}
        local row = baseRow(40)
        row.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
        row.BackgroundTransparency = 0.72
        leftAccentBar(row)

        gradFill(row, {
            ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 55, 200)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB( 60, 28, 120)),
        }, 0)

        local lbl = rowLabel(row, opts.Name or "Button")
        lbl.Size = UDim2.new(1, -20, 1, 0)
        lbl.Position = UDim2.new(0, 16, 0, 0)

        local arrow = Instance.new("TextLabel", row)
        arrow.Size = UDim2.new(0, 24, 1, 0)
        arrow.Position = UDim2.new(1, -28, 0, 0)
        arrow.BackgroundTransparency = 1
        arrow.Text = ">"
        arrow.Font = Enum.Font.GothamBold
        arrow.TextSize = 16
        arrow.TextColor3 = T.TextMuted
        arrow.ZIndex = 14

        local over = clickOverlay(row)
        over.MouseEnter:Connect(function()
            tw(row,   { BackgroundColor3 = Color3.fromRGB(60, 38, 120), BackgroundTransparency = 0.60 }, 0.14)
            tw(lbl,   { TextColor3 = T.AccentGlow },         0.14)
            tw(arrow, { TextColor3 = T.AccentLt },           0.14)
            accentFill(lbl, 0)
        end)
        over.MouseLeave:Connect(function()
            tw(row,   { BackgroundColor3 = Color3.fromRGB(38, 24, 80), BackgroundTransparency = 0.72 }, 0.14)
            tw(lbl,   { TextColor3 = T.White },             0.14)
            tw(arrow, { TextColor3 = T.TextMuted },         0.14)
        end)
        over.MouseButton1Click:Connect(function()
            local mp = UserInputService:GetMouseLocation()
            ripple(row, mp.X, mp.Y)
            tw(row, { BackgroundColor3 = Color3.fromRGB(60, 38, 120), BackgroundTransparency = 0.60 }, 0.06)
            task.delay(0.12, function()
                tw(row, { BackgroundColor3 = Color3.fromRGB(38, 24, 80), BackgroundTransparency = 0.72 }, 0.2)
            end)
            if opts.Callback then task.spawn(opts.Callback) end
        end)
    end

    function tabObj:CreateToggle(opts)
        opts = opts or {}
        autoFlag(opts)
        local flag  = opts.Flag
        local value = opts.CurrentValue or false
        if flag then Voidex.Flags[flag] = value end

        local row = baseRow(42)
        hoverRow(row)
        leftAccentBar(row)
        rowLabel(row, opts.Name or "Toggle")

        local track = Instance.new("Frame", row)
        track.Size = UDim2.new(0, 46, 0, 24)
        track.Position = UDim2.new(1, -58, 0.5, -12)
        track.BackgroundColor3 = T.Border
        track.BorderSizePixel = 0
        track.ZIndex = 14
        corner(track, 12)
        local trackStroke = mkStroke(track, T.Border, 1.5, 0.4)

        local tGrad = Instance.new("UIGradient", track)
        tGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, T.Indigo),
            ColorSequenceKeypoint.new(1, T.Pink),
        })
        tGrad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1)
        })

        local knob = Instance.new("Frame", track)
        knob.Size = UDim2.new(0, 18, 0, 18)
        knob.Position = UDim2.new(0, 3, 0.5, -9)
        knob.BackgroundColor3 = T.TextSub
        knob.BorderSizePixel = 0
        knob.ZIndex = 15
        corner(knob, 100)
        local knobStroke = mkStroke(knob, T.White, 2, 0.82)

        local knobGlow = Instance.new("UIStroke", knob)
        knobGlow.Thickness = 4
        knobGlow.Color = T.Accent
        knobGlow.Transparency = 1

        local function setToggle(v, animate)
            value = v
            if flag then Voidex.Flags[flag] = v end
            local dur = animate == false and 0 or 0.28

            if v then
                tw(track, { BackgroundColor3 = T.Accent },   dur, Enum.EasingStyle.Quart)
                tw(knob,  { Position = UDim2.new(0, 25, 0.5, -9), BackgroundColor3 = T.White }, dur, Enum.EasingStyle.Back)
                tw(knobStroke,  { Transparency = 0.5 },  dur)
                tw(knobGlow,    { Transparency = 0.5 },  dur)
                tw(trackStroke, { Color = T.AccentLt, Transparency = 0 }, dur)
                tGrad.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0) })
            else
                tw(track, { BackgroundColor3 = T.Border },  dur, Enum.EasingStyle.Quart)
                tw(knob,  { Position = UDim2.new(0, 3,  0.5, -9), BackgroundColor3 = T.TextSub }, dur, Enum.EasingStyle.Back)
                tw(knobStroke,  { Transparency = 0.82 }, dur)
                tw(knobGlow,    { Transparency = 1 },    dur)
                tw(trackStroke, { Color = T.Border, Transparency = 0.4 }, dur)
                tGrad.Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) })
            end

            if opts.Callback then task.spawn(opts.Callback, v) end
        end

        setToggle(value, false)

        local over = clickOverlay(row, 16)
        over.MouseButton1Click:Connect(function()
            setToggle(not value)
            local mp = UserInputService:GetMouseLocation()
            ripple(row, mp.X, mp.Y)
        end)

        local obj = {}
        function obj:Set(v) setToggle(v) end
        if flag then
            Voidex._flagSetters = Voidex._flagSetters or {}
            Voidex._flagSetters[flag] = function(v) setToggle(v, false) end
        end
        return obj
    end

    function tabObj:CreateSlider(opts)
        opts = opts or {}
        autoFlag(opts)
        local flag  = opts.Flag
        local mn    = opts.Range and opts.Range[1] or opts.MinValue   or 0
        local mx    = opts.Range and opts.Range[2] or opts.MaxValue   or 100
        local incr  = opts.Increment   or 1
        local value = opts.CurrentValue or mn
        if flag then Voidex.Flags[flag] = value end

        local row = baseRow(56)
        hoverRow(row)
        leftAccentBar(row)

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0.6, 0, 0, 22)
        lbl.Position = UDim2.new(0, 16, 0, 6)
        lbl.BackgroundTransparency = 1
        lbl.Text = opts.Name or "Slider"
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 13
        lbl.TextColor3 = T.White
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 14

        local valLbl = Instance.new("TextLabel", row)
        valLbl.Size = UDim2.new(0.35, 0, 0, 22)
        valLbl.Position = UDim2.new(0.63, 0, 0, 6)
        valLbl.BackgroundTransparency = 1
        valLbl.Text = tostring(value)
        valLbl.Font = Enum.Font.GothamBold
        valLbl.TextSize = 12
        valLbl.TextColor3 = T.AccentLt
        valLbl.TextXAlignment = Enum.TextXAlignment.Right
        valLbl.ZIndex = 14

        local trackBg = Instance.new("Frame", row)
        trackBg.Size = UDim2.new(1, -28, 0, 5)
        trackBg.Position = UDim2.new(0, 14, 1, -16)
        trackBg.BackgroundColor3 = T.Border
        trackBg.BorderSizePixel = 0
        trackBg.ZIndex = 14
        corner(trackBg, 3)

        local fill = Instance.new("Frame", trackBg)
        fill.Size = UDim2.new(0, 0, 1, 0)
        fill.BackgroundColor3 = T.Accent
        fill.BorderSizePixel = 0
        fill.ZIndex = 15
        corner(fill, 3)
        accentFill(fill, 0)

        local thumb = Instance.new("Frame", trackBg)
        thumb.Size = UDim2.new(0, 14, 0, 14)
        thumb.AnchorPoint = Vector2.new(0.5, 0.5)
        thumb.Position = UDim2.new(0, 0, 0.5, 0)
        thumb.BackgroundColor3 = T.White
        thumb.BorderSizePixel = 0
        thumb.ZIndex = 16
        corner(thumb, 100)
        mkStroke(thumb, T.AccentLt, 2, 0.2)

        local thumbGlow = Instance.new("UIStroke", thumb)
        thumbGlow.Thickness = 5
        thumbGlow.Color = T.Accent
        thumbGlow.Transparency = 0.65

        local function updateSlider(v)
            v = math.clamp(math.round(v / incr) * incr, mn, mx)
            value = v
            if flag then Voidex.Flags[flag] = v end
            local a = (v - mn) / (mx - mn)
            tw(fill,  { Size = UDim2.new(a, 0, 1, 0) },          0.08, Enum.EasingStyle.Linear)
            tw(thumb, { Position = UDim2.new(a, 0, 0.5, 0) },    0.08, Enum.EasingStyle.Linear)
            valLbl.Text = tostring(v)
            if opts.Callback then task.spawn(opts.Callback, v) end
        end

        updateSlider(value)

        local hitArea = Instance.new("TextButton", trackBg)
        hitArea.Size = UDim2.new(1, 20, 1, 24)
        hitArea.Position = UDim2.new(0, -10, 0, -12)
        hitArea.BackgroundTransparency = 1
        hitArea.Text = ""
        hitArea.ZIndex = 18

        local dragging = false
        hitArea.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1
            or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                local abs = trackBg.AbsolutePosition
                local sz  = trackBg.AbsoluteSize
                local rel = math.clamp((inp.Position.X - abs.X) / sz.X, 0, 1)
                updateSlider(mn + (mx - mn) * rel)
                tw(thumb, { Size = UDim2.new(0, 17, 0, 17) }, 0.1)
                tw(thumbGlow, { Transparency = 0.3 }, 0.1)
            end
        end)
        UserInputService.InputEnded:Connect(function(inp)
            if (inp.UserInputType == Enum.UserInputType.MouseButton1
            or inp.UserInputType == Enum.UserInputType.Touch) and dragging then
                dragging = false
                tw(thumb, { Size = UDim2.new(0, 14, 0, 14) }, 0.1)
                tw(thumbGlow, { Transparency = 0.65 }, 0.1)
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement
            or inp.UserInputType == Enum.UserInputType.Touch) then
                local abs = trackBg.AbsolutePosition
                local sz  = trackBg.AbsoluteSize
                local rel = math.clamp((inp.Position.X - abs.X) / sz.X, 0, 1)
                updateSlider(mn + (mx - mn) * rel)
            end
        end)

        local obj = {}
        function obj:Set(v) updateSlider(v) end
        if flag then
            Voidex._flagSetters = Voidex._flagSetters or {}
            Voidex._flagSetters[flag] = function(v) updateSlider(tonumber(v) or mn) end
        end
        return obj
    end

    function tabObj:CreateTextbox(opts)
        opts = opts or {}
        autoFlag(opts)
        local flag  = opts.Flag
        local value = opts.CurrentValue or ""
        if flag then Voidex.Flags[flag] = value end

        local row = baseRow(42)
        hoverRow(row)
        leftAccentBar(row)

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0.38, 0, 1, 0)
        lbl.Position = UDim2.new(0, 14, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = opts.Name or "Input"
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 13
        lbl.TextColor3 = T.White
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.ZIndex = 14

        local inputBox = Instance.new("Frame", row)
        inputBox.Size = UDim2.new(0.54, 0, 0, 26)
        inputBox.Position = UDim2.new(0.44, 0, 0.5, -13)
        inputBox.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
        inputBox.BackgroundTransparency = 0.72
        inputBox.BorderSizePixel = 0
        inputBox.ZIndex = 14
        corner(inputBox, 6)
        local ibStroke = Instance.new("UIStroke", inputBox)
        ibStroke.Color = Color3.fromRGB(110, 70, 200)
        ibStroke.Thickness = 1
        ibStroke.Transparency = 0.40
        ibStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local textBox = Instance.new("TextBox", inputBox)
        textBox.Size = UDim2.new(1, -16, 1, 0)
        textBox.Position = UDim2.new(0, 8, 0, 0)
        textBox.BackgroundTransparency = 1
        textBox.Text = value
        textBox.PlaceholderText = opts.PlaceholderText or "Enter value..."
        textBox.Font = Enum.Font.Gotham
        textBox.TextSize = 12
        textBox.TextColor3 = T.White
        textBox.PlaceholderColor3 = T.TextMuted
        textBox.TextXAlignment = Enum.TextXAlignment.Left
        textBox.ZIndex = 15
        textBox.ClearTextOnFocus = opts.RemoveTextAfterFocusLost ~= false

        textBox.Focused:Connect(function()
            tw(ibStroke, { Color = T.Accent, Transparency = 0 }, 0.18)
            tw(inputBox, { BackgroundColor3 = Color3.fromRGB(80, 40, 160), BackgroundTransparency = 0.60 }, 0.18)
        end)
        textBox.FocusLost:Connect(function(enter)
            tw(ibStroke, { Color = T.Border, Transparency = 0.35 }, 0.18)
            tw(inputBox, { BackgroundColor3 = Color3.fromRGB(80, 40, 160), BackgroundTransparency = 0.72 }, 0.18)
            value = textBox.Text
            if flag then Voidex.Flags[flag] = value end
            if opts.Callback then task.spawn(opts.Callback, value, enter) end
        end)
    end

    function tabObj:CreateDropdown(opts)
        opts = opts or {}
        autoFlag(opts)
        local flag    = opts.Flag
        local options = opts.Options or {}
        local value   = opts.CurrentValue or (options[1] or "Select...")
        if flag then Voidex.Flags[flag] = value end

        tabObj._cnt = tabObj._cnt + 1
        local order = tabObj._cnt

        local container = Instance.new("Frame", page)
        container.Name = "DD_" .. order
        container.Size = UDim2.new(1, 0, 0, 42)
        container.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
        container.BackgroundTransparency = 0.72
        container.BorderSizePixel = 0
        container.ZIndex = 20
        container.LayoutOrder = order
        corner(container, 8)
        local ddStroke = Instance.new("UIStroke", container)
        ddStroke.Color = Color3.fromRGB(110, 70, 200)
        ddStroke.Thickness = 1
        ddStroke.Transparency = 0.40
        ddStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        leftAccentBar(container)

        local lbl = rowLabel(container, opts.Name or "Dropdown")
        lbl.ZIndex = 21

        local selBox = Instance.new("Frame", container)
        selBox.Size = UDim2.new(0, 118, 0, 26)
        selBox.Position = UDim2.new(1, -130, 0.5, -13)
        selBox.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
        selBox.BackgroundTransparency = 0.72
        selBox.BorderSizePixel = 0
        selBox.ZIndex = 21
        corner(selBox, 6)
        local sbStroke = Instance.new("UIStroke", selBox)
        sbStroke.Color = Color3.fromRGB(110, 70, 200)
        sbStroke.Thickness = 1
        sbStroke.Transparency = 0.40
        sbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local selLbl = Instance.new("TextLabel", selBox)
        selLbl.Size = UDim2.new(1, -22, 1, 0)
        selLbl.Position = UDim2.new(0, 8, 0, 0)
        selLbl.BackgroundTransparency = 1
        selLbl.Text = value
        selLbl.Font = Enum.Font.Gotham
        selLbl.TextSize = 11
        selLbl.TextColor3 = T.AccentLt
        selLbl.TextXAlignment = Enum.TextXAlignment.Left
        selLbl.TextTruncate = Enum.TextTruncate.AtEnd
        selLbl.ZIndex = 22

        local arrow = Instance.new("TextLabel", selBox)
        arrow.Size = UDim2.new(0, 18, 1, 0)
        arrow.Position = UDim2.new(1, -20, 0, 0)
        arrow.BackgroundTransparency = 1
        arrow.Text = "v"
        arrow.Font = Enum.Font.GothamBold
        arrow.TextSize = 11
        arrow.TextColor3 = T.TextSub
        arrow.ZIndex = 22

        local dropClip = Instance.new("Frame", container)
        dropClip.Name = "DropClip"
        dropClip.Size = UDim2.new(0, 118, 0, 0)
        dropClip.Position = UDim2.new(1, -130, 1, 3)
        dropClip.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
        dropClip.BackgroundTransparency = 0.72
        dropClip.BorderSizePixel = 0
        dropClip.ZIndex = 35
        dropClip.ClipsDescendants = true
        dropClip.Visible = false
        corner(dropClip, 7)
        local dfStroke = Instance.new("UIStroke", dropClip)
        dfStroke.Color = Color3.fromRGB(130, 80, 220)
        dfStroke.Thickness = 1
        dfStroke.Transparency = 0.35
        dfStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local dropFrame = Instance.new("ScrollingFrame", dropClip)
        dropFrame.Name = "DropScroll"
        dropFrame.Size = UDim2.new(1, 0, 1, 0)
        dropFrame.BackgroundTransparency = 1
        dropFrame.BorderSizePixel = 0
        dropFrame.ZIndex = 36
        dropFrame.ScrollBarThickness = 3
        dropFrame.ScrollBarImageColor3 = Color3.fromRGB(140, 100, 220)
        dropFrame.ScrollBarImageTransparency = 0.3
        dropFrame.ScrollingDirection = Enum.ScrollingDirection.Y
        dropFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        dropFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        dropFrame.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
        dropFrame.ScrollingEnabled = true

        local dropLayout = Instance.new("UIListLayout", dropFrame)
        dropLayout.SortOrder = Enum.SortOrder.LayoutOrder
        local dropPad = Instance.new("UIPadding", dropFrame)
        dropPad.PaddingTop = UDim.new(0, 4)
        dropPad.PaddingBottom = UDim.new(0, 4)

        local function buildOptions()
            for _, child in ipairs(dropFrame:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
            for i, opt in ipairs(options) do
                local btn = Instance.new("TextButton", dropFrame)
                btn.Size = UDim2.new(1, 0, 0, 26)
                btn.BackgroundColor3 = T.SurfaceHigh
                btn.BackgroundTransparency = 1
                btn.Text = ""
                btn.ZIndex = 36
                btn.LayoutOrder = i

                local ol = Instance.new("TextLabel", btn)
                ol.Size = UDim2.new(1, -16, 1, 0)
                ol.Position = UDim2.new(0, 8, 0, 0)
                ol.BackgroundTransparency = 1
                ol.Text = opt
                ol.Font = Enum.Font.Gotham
                ol.TextSize = 11
                ol.TextColor3 = opt == value and T.AccentLt or T.TextSub
                ol.TextXAlignment = Enum.TextXAlignment.Left
                ol.ZIndex = 37

                btn.MouseEnter:Connect(function()
                    btn.BackgroundTransparency = 0.55
                end)
                btn.MouseLeave:Connect(function()
                    btn.BackgroundTransparency = 1
                end)
                btn.MouseButton1Click:Connect(function()
                    value = opt
                    selLbl.Text = opt
                    if flag then Voidex.Flags[flag] = opt end
                    for _, c in ipairs(dropFrame:GetChildren()) do
                        if c:IsA("TextButton") then
                            local cl = c:FindFirstChildOfClass("TextLabel")
                            if cl then cl.TextColor3 = cl.Text == opt and T.AccentLt or T.TextSub end
                        end
                    end
                    if opts.Callback then task.spawn(opts.Callback, opt) end
                    tw(dropClip, { Size = UDim2.new(0, 118, 0, 0) }, 0.2)
                    task.delay(0.2, function() dropClip.Visible = false end)
                    tw(arrow, { Rotation = 0 }, 0.2)
                    isOpen = false
                end)
            end
        end

        buildOptions()
        local isOpen = false
        local totalH = #options * 26 + 8

        local over = clickOverlay(container, 25)
        over.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                dropClip.Visible = true
                dropClip.Size = UDim2.new(0, 118, 0, 0)
                dropFrame.CanvasPosition = Vector2.new(0, 0)
                tw(dropClip, { Size = UDim2.new(0, 118, 0, math.min(totalH, 130)) }, 0.25, Enum.EasingStyle.Back)
                tw(arrow, { Rotation = 180 }, 0.2)
            else
                tw(dropClip, { Size = UDim2.new(0, 118, 0, 0) }, 0.2)
                task.delay(0.2, function() dropClip.Visible = false end)
                tw(arrow, { Rotation = 0 }, 0.2)
            end
        end)

        local obj = {}
        function obj:Set(v) value = v; selLbl.Text = v; if flag then Voidex.Flags[flag] = v end end
        function obj:Refresh(newOpts) options = newOpts; totalH = #newOpts * 26 + 8; buildOptions() end
        if flag then
            Voidex._flagSetters = Voidex._flagSetters or {}
            Voidex._flagSetters[flag] = function(v) obj:Set(tostring(v)) end
        end
        return obj
    end

    function tabObj:CreateColorPicker(opts)
        opts = opts or {}
        autoFlag(opts)
        local flag  = opts.Flag
        local value = opts.Color or Color3.fromRGB(255, 255, 255)
        if flag then Voidex.Flags[flag] = value end

        local row = baseRow(42)
        hoverRow(row)
        leftAccentBar(row)
        rowLabel(row, opts.Name or "Color Picker")

        local swatch = Instance.new("Frame", row)
        swatch.Size = UDim2.new(0, 30, 0, 20)
        swatch.Position = UDim2.new(1, -42, 0.5, -10)
        swatch.BackgroundColor3 = value
        swatch.BorderSizePixel = 0
        swatch.ZIndex = 14
        corner(swatch, 5)
        mkStroke(swatch, T.Border, 1, 0.3)

        local pickerOpen = false
        local pickerFrame = nil

        local over = clickOverlay(row, 16)
        over.MouseButton1Click:Connect(function()
            if pickerOpen and pickerFrame then
                tw(pickerFrame, { Size = UDim2.new(0, 230, 0, 0) }, 0.2)
                task.delay(0.2, function() if pickerFrame then pickerFrame:Destroy(); pickerFrame = nil end end)
                pickerOpen = false
                return
            end
            pickerOpen = true

            pickerFrame = Instance.new("Frame", row)
            pickerFrame.Size = UDim2.new(0, 230, 0, 0)
            pickerFrame.Position = UDim2.new(0, 0, 1, 5)
            pickerFrame.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
            pickerFrame.BackgroundTransparency = 0.72
            pickerFrame.BorderSizePixel = 0
            pickerFrame.ZIndex = 55
            pickerFrame.ClipsDescendants = true
            corner(pickerFrame, 9)
            local pfStroke = Instance.new("UIStroke", pickerFrame)
            pfStroke.Color = Color3.fromRGB(130, 80, 220)
            pfStroke.Thickness = 1
            pfStroke.Transparency = 0.35
            pfStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local pPad = Instance.new("UIPadding", pickerFrame)
            pPad.PaddingAll = UDim.new(0, 10)
            local pList = Instance.new("UIListLayout", pickerFrame)
            pList.SortOrder = Enum.SortOrder.LayoutOrder
            pList.Padding   = UDim.new(0, 8)

            local ph = Instance.new("TextLabel", pickerFrame)
            ph.Size = UDim2.new(1, 0, 0, 14)
            ph.BackgroundTransparency = 1
            ph.Text = "PRESETS"
            ph.Font = Enum.Font.GothamBold
            ph.TextSize = 9
            ph.TextColor3 = T.TextMuted
            ph.ZIndex = 56
            ph.LayoutOrder = 1

            local presetGrid = Instance.new("Frame", pickerFrame)
            presetGrid.Size = UDim2.new(1, 0, 0, 52)
            presetGrid.BackgroundTransparency = 1
            presetGrid.ZIndex = 56
            presetGrid.LayoutOrder = 2

            local gl = Instance.new("UIGridLayout", presetGrid)
            gl.CellSize = UDim2.new(0, 28, 0, 20)
            gl.CellPadding = UDim2.new(0, 5, 0, 5)

            local presets = {
                Color3.fromRGB(239,68,68),   Color3.fromRGB(249,115,22),
                Color3.fromRGB(234,179,8),   Color3.fromRGB(34,197,94),
                Color3.fromRGB(6,182,212),   Color3.fromRGB(99,102,241),
                Color3.fromRGB(124,58,237),  Color3.fromRGB(236,72,153),
                Color3.fromRGB(248,246,255), Color3.fromRGB(15,10,30),
            }

            for _, col in ipairs(presets) do
                local sw = Instance.new("TextButton", presetGrid)
                sw.Size = UDim2.new(0, 28, 0, 20)
                sw.BackgroundColor3 = col
                sw.Text = ""
                sw.BorderSizePixel = 0
                sw.ZIndex = 57
                corner(sw, 4)
                sw.MouseEnter:Connect(function() tw(sw, {Size = UDim2.new(0, 30, 0, 22)}, 0.08) end)
                sw.MouseLeave:Connect(function() tw(sw, {Size = UDim2.new(0, 28, 0, 20)}, 0.08) end)
                sw.MouseButton1Click:Connect(function()
                    value = col
                    swatch.BackgroundColor3 = col
                    if flag then Voidex.Flags[flag] = col end
                    if opts.Callback then task.spawn(opts.Callback, col) end
                end)
            end

            tw(pickerFrame, { Size = UDim2.new(0, 230, 0, 115) }, 0.28, Enum.EasingStyle.Back)
        end)

        local obj = {}
        function obj:Set(v) value = v; swatch.BackgroundColor3 = v; if flag then Voidex.Flags[flag] = v end end
        if flag then
            Voidex._flagSetters = Voidex._flagSetters or {}
            Voidex._flagSetters[flag] = function(v)
                if typeof and typeof(v) == "Color3" then
                    value = v; swatch.BackgroundColor3 = v
                    if flag then Voidex.Flags[flag] = v end
                end
            end
        end
        return obj
    end

    function tabObj:CreateKeybind(opts)
        opts = opts or {}
        autoFlag(opts)
        local flag    = opts.Flag
        local keyval  = opts.CurrentKeybind or "None"
        if flag then Voidex.Flags[flag] = keyval end

        local row = baseRow(42)
        hoverRow(row)
        leftAccentBar(row)
        rowLabel(row, opts.Name or "Keybind")

        local keyBox = Instance.new("Frame", row)
        keyBox.Size = UDim2.new(0, 82, 0, 26)
        keyBox.Position = UDim2.new(1, -94, 0.5, -13)
        keyBox.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
        keyBox.BackgroundTransparency = 0.72
        keyBox.BorderSizePixel = 0
        keyBox.ZIndex = 14
        corner(keyBox, 6)
        local kbStroke = Instance.new("UIStroke", keyBox)
        kbStroke.Color = Color3.fromRGB(110, 70, 200)
        kbStroke.Thickness = 1
        kbStroke.Transparency = 0.40
        kbStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local keyLbl = Instance.new("TextLabel", keyBox)
        keyLbl.Size = UDim2.new(1, 0, 1, 0)
        keyLbl.BackgroundTransparency = 1
        keyLbl.Text = keyval
        keyLbl.Font = Enum.Font.GothamBold
        keyLbl.TextSize = 11
        keyLbl.TextColor3 = T.AccentLt
        keyLbl.ZIndex = 15

        local listening = false
        local listenerConn = nil
        local over = clickOverlay(row, 16)
        over.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            keyLbl.Text = "..."
            keyLbl.TextColor3 = T.Gold
            tw(kbStroke, { Color = T.Gold, Transparency = 0 }, 0.15)
            tw(keyBox, { BackgroundColor3 = Color3.fromRGB(80, 40, 160), BackgroundTransparency = 0.60 }, 0.15)

            listenerConn = UserInputService.InputBegan:Connect(function(inp, gpe)
                if gpe then return end
                if inp.UserInputType == Enum.UserInputType.Keyboard then
                    keyval = tostring(inp.KeyCode.Name)
                    keyLbl.Text = keyval
                    keyLbl.TextColor3 = T.AccentLt
                    tw(kbStroke, { Color = T.Border, Transparency = 0.4 }, 0.15)
                    tw(keyBox, { BackgroundColor3 = Color3.fromRGB(80, 40, 160), BackgroundTransparency = 0.72 }, 0.15)
                    if flag then Voidex.Flags[flag] = keyval end
                    if opts.Callback then task.spawn(opts.Callback, inp.KeyCode) end
                    listening = false
                    listenerConn:Disconnect()
                end
            end)
        end)

        local obj = {}
        function obj:Set(v)
            keyval = tostring(v)
            keyLbl.Text = keyval
            if flag then Voidex.Flags[flag] = keyval end
        end
        if flag then
            Voidex._flagSetters = Voidex._flagSetters or {}
            Voidex._flagSetters[flag] = function(v) obj:Set(v) end
        end
        return obj
    end

    function tabObj:CreateLabel(text)
        tabObj._cnt = tabObj._cnt + 1
        local row = Instance.new("Frame", page)
        row.Name = "Label_" .. tabObj._cnt
        row.Size = UDim2.new(1, 0, 0, 26)
        row.BackgroundTransparency = 1
        row.BorderSizePixel = 0
        row.ZIndex = 13
        row.LayoutOrder = tabObj._cnt

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(1, -16, 1, 0)
        lbl.Position = UDim2.new(0, 8, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text or ""
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 12
        lbl.TextColor3 = T.TextSub
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextWrapped = true
        lbl.ZIndex = 14
    end

    function tabObj:CreateParagraph(opts)
        opts = opts or {}
        tabObj._cnt = tabObj._cnt + 1

        local container = Instance.new("Frame", page)
        container.Name = "Para_" .. tabObj._cnt
        container.Size = UDim2.new(1, 0, 0, 0)
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
        container.BackgroundTransparency = 0.72
        container.BorderSizePixel = 0
        container.ZIndex = 13
        container.LayoutOrder = tabObj._cnt
        corner(container, 8)
        local paraStroke = Instance.new("UIStroke", container)
        paraStroke.Color = Color3.fromRGB(110, 75, 200)
        paraStroke.Thickness = 1
        paraStroke.Transparency = 0.40
        paraStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        local pad = Instance.new("UIPadding", container)
        pad.PaddingTop    = UDim.new(0, 10)
        pad.PaddingBottom = UDim.new(0, 10)
        pad.PaddingLeft   = UDim.new(0, 10)
        pad.PaddingRight  = UDim.new(0, 10)

        local layout = Instance.new("UIListLayout", container)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding   = UDim.new(0, 4)

        local titleLbl = nil
        if opts.Title and opts.Title ~= "" then
            titleLbl = Instance.new("TextLabel", container)
            titleLbl.Size = UDim2.new(1, 0, 0, 0)
            titleLbl.AutomaticSize = Enum.AutomaticSize.Y
            titleLbl.BackgroundTransparency = 1
            titleLbl.Text = opts.Title
            titleLbl.Font = Enum.Font.GothamBold
            titleLbl.TextSize = 13
            titleLbl.TextColor3 = T.AccentLt
            titleLbl.TextXAlignment = Enum.TextXAlignment.Left
            titleLbl.TextWrapped = true
            titleLbl.ZIndex = 14
            titleLbl.LayoutOrder = 1
        end

        local body = Instance.new("TextLabel", container)
        body.Size = UDim2.new(1, 0, 0, 0)
        body.AutomaticSize = Enum.AutomaticSize.Y
        body.BackgroundTransparency = 1
        body.Text = opts.Content or ""
        body.Font = Enum.Font.Gotham
        body.TextSize = 12
        body.TextColor3 = T.TextSub
        body.TextXAlignment = Enum.TextXAlignment.Left
        body.TextWrapped = true
        body.ZIndex = 14
        body.LayoutOrder = 2

        local obj = {}
        function obj:Set(newOpts)
            newOpts = newOpts or {}
            if newOpts.Title ~= nil and titleLbl then
                titleLbl.Text = newOpts.Title
            end
            if newOpts.Content ~= nil then
                body.Text = newOpts.Content
            end
        end
        return obj
    end

    local _raw = {}
    for _, m in ipairs({
        "CreateButton","CreateToggle","CreateSlider","CreateDropdown",
        "CreateColorPicker","CreateTextbox","CreateKeybind","CreateParagraph"
    }) do
        _raw[m] = tabObj[m]
        tabObj[m] = function(self, opts, ...)
            if type(opts) == "table" then opts = fixOpts(opts) end
            return _raw[m](tabObj, opts, ...)
        end
    end

    tabObj.CreateTextBox      = tabObj.CreateTextbox
    tabObj.CreateInput        = tabObj.CreateTextbox
    tabObj.CreateTextField    = tabObj.CreateTextbox
    tabObj.CreateBind         = tabObj.CreateKeybind
    tabObj.CreateColorPickr   = tabObj.CreateColorPicker
    tabObj.CreateColourPicker = tabObj.CreateColorPicker
    tabObj.CreateCheck        = tabObj.CreateToggle
    tabObj.CreateCheckbox     = tabObj.CreateToggle
    tabObj.CreateBtn          = tabObj.CreateButton
    tabObj.CreateLbl          = tabObj.CreateLabel
    tabObj.CreateSec          = tabObj.CreateSection
    tabObj.CreatePara         = tabObj.CreateParagraph

    tabObj.CreateInput        = tabObj.CreateTextbox

    tabObj.AddSection      = function(self, opts)
        local name = type(opts)=="table" and (opts.Name or opts.name or opts.Text or "") or tostring(opts or "")
        return tabObj:CreateSection(name)
    end
    tabObj.AddButton       = function(self, opts) return tabObj:CreateButton(opts)       end
    tabObj.AddToggle       = function(self, opts) return tabObj:CreateToggle(opts)       end
    tabObj.AddSlider       = function(self, opts) return tabObj:CreateSlider(opts)       end
    tabObj.AddDropdown     = function(self, opts) return tabObj:CreateDropdown(opts)     end
    tabObj.AddTextbox      = function(self, opts) return tabObj:CreateTextbox(opts)      end
    tabObj.AddInput        = function(self, opts) return tabObj:CreateTextbox(opts)      end
    tabObj.AddBind         = function(self, opts) return tabObj:CreateKeybind(opts)      end
    tabObj.AddKeybind      = function(self, opts) return tabObj:CreateKeybind(opts)      end
    tabObj.AddColorPicker  = function(self, opts) return tabObj:CreateColorPicker(opts)  end
    tabObj.AddColorWheel   = tabObj.AddColorPicker
    tabObj.AddColourPicker = tabObj.AddColorPicker
    tabObj.AddLabel        = function(self, txt)  return tabObj:CreateLabel(txt)         end
    tabObj.AddParagraph    = function(self, opts) return tabObj:CreateParagraph(opts)    end

    tabObj.NewSection  = function(self, name, info)
        tabObj:CreateSection(name or "")
        return tabObj
    end
    tabObj.NewButton   = function(self, name, info, cb)
        return tabObj:CreateButton({ Name=name, Callback=cb })
    end
    tabObj.NewToggle   = function(self, name, info, default, cb)
        if type(default) == "function" then cb = default; default = false end
        return tabObj:CreateToggle({ Name=name, CurrentValue=default or false, Callback=cb })
    end
    tabObj.NewSlider   = function(self, name, info, max, default, cb)
        return tabObj:CreateSlider({ Name=name, Range={0, max or 100}, CurrentValue=default or 0, Callback=cb })
    end
    tabObj.NewDropdown = function(self, name, info, options, cb)
        return tabObj:CreateDropdown({ Name=name, Options=options or {}, Callback=cb })
    end
    tabObj.NewTextBox  = function(self, name, info, cb)
        return tabObj:CreateTextbox({ Name=name, Callback=cb })
    end
    tabObj.NewInput    = tabObj.NewTextBox
    tabObj.NewBind     = function(self, name, info, default, cb)
        if type(default) == "function" then cb = default; default = "None" end
        return tabObj:CreateKeybind({ Name=name, CurrentKeybind=tostring(default or "None"), Callback=cb })
    end
    tabObj.NewKeybind  = tabObj.NewBind
    tabObj.NewLabel    = function(self, text) return tabObj:CreateLabel(text) end
    tabObj.NewColorPicker = function(self, name, info, default, cb)
        if type(default) == "function" then cb = default; default = Color3.new(1,1,1) end
        return tabObj:CreateColorPicker({ Name=name, Color=default, Callback=cb })
    end

    tabObj.AddLeftGroupbox   = function(self, name) return makeGroupboxProxy(tabObj, name) end
    tabObj.AddRightGroupbox  = function(self, name) return makeGroupboxProxy(tabObj, name) end
    tabObj.AddLeftGroup      = tabObj.AddLeftGroupbox
    tabObj.AddRightGroup     = tabObj.AddRightGroupbox
    tabObj.AddGroupbox       = tabObj.AddLeftGroupbox
    tabObj.AddGroup          = tabObj.AddLeftGroupbox

    tabObj.AddValue        = function(self, opts) return tabObj:CreateSlider(opts)    end
    tabObj.AddOption       = function(self, opts) return tabObj:CreateDropdown(opts)  end
    tabObj.AddCheckbox     = function(self, opts) return tabObj:CreateToggle(opts)    end
    tabObj.AddSwitch       = tabObj.AddCheckbox
    tabObj.AddText         = function(self, txt)  return tabObj:CreateLabel(txt)      end
    tabObj.AddTextField    = function(self, opts) return tabObj:CreateTextbox(opts)   end
    tabObj.AddInputField   = tabObj.AddTextField

    tabObj.AddButtonElement       = function(self, opts) return tabObj:CreateButton(opts)      end
    tabObj.AddToggleElement       = function(self, opts) return tabObj:CreateToggle(opts)      end
    tabObj.AddSliderElement       = function(self, opts) return tabObj:CreateSlider(opts)      end
    tabObj.AddDropdownElement     = function(self, opts) return tabObj:CreateDropdown(opts)    end
    tabObj.AddTextboxElement      = function(self, opts) return tabObj:CreateTextbox(opts)     end
    tabObj.AddKeybindElement      = function(self, opts) return tabObj:CreateKeybind(opts)     end
    tabObj.AddColorPickerElement  = function(self, opts) return tabObj:CreateColorPicker(opts) end

    tabObj.AddRow            = function(self, name) return tabObj:CreateSection(name or "") end
    tabObj.AddActionButton   = function(self, opts) return tabObj:CreateButton(opts)      end
    tabObj.AddToggleSwitch   = function(self, opts) return tabObj:CreateToggle(opts)      end
    tabObj.AddRange          = function(self, opts) return tabObj:CreateSlider(opts)      end
    tabObj.AddSelectList     = function(self, opts) return tabObj:CreateDropdown(opts)    end
    tabObj.AddStringInput    = function(self, opts) return tabObj:CreateTextbox(opts)     end
    tabObj.AddBindKey        = function(self, opts) return tabObj:CreateKeybind(opts)     end

    tabObj.AddItem     = function(self, opts) return tabObj:CreateButton(opts)      end
    tabObj.AddCheck    = function(self, opts) return tabObj:CreateToggle(opts)      end
    tabObj.AddScroll   = function(self, opts) return tabObj:CreateSlider(opts)      end
    tabObj.AddSelect   = function(self, opts) return tabObj:CreateDropdown(opts)    end
    tabObj.AddInputBox = function(self, opts) return tabObj:CreateTextbox(opts)     end
    tabObj.AddHotkey   = function(self, opts) return tabObj:CreateKeybind(opts)     end
    tabObj.AddColorBox = function(self, opts) return tabObj:CreateColorPicker(opts) end

    return wrapTab(tabObj)
end

local _notifyY = 20
local _notifySlots = {}

function Voidex:Notify(opts)
    opts = opts or {}
    local title    = opts.Title    or "Voidex"
    local content  = opts.Content  or ""
    local duration = opts.Duration or 3.5
    local nType    = opts.Type     or "info"

    local nsg = Instance.new("ScreenGui")
    nsg.Name = "VoidexNotif_" .. tostring(math.random(100000, 999999))
    nsg.ResetOnSpawn = false
    nsg.IgnoreGuiInset = true
    nsg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    nsg.DisplayOrder = 200
    pcall(function() nsg.Parent = CoreGui end)
    if not nsg.Parent then nsg.Parent = PlayerGui end

    local colMap = {
        info = T.Accent, success = T.Success,
        warning = T.Warn, error = T.Danger,
    }
    local accent = colMap[nType] or T.Accent

    local slot = 1
    for i = 1, 8 do
        if not _notifySlots[i] then slot = i; break end
    end
    _notifySlots[slot] = true

    local yOff = (slot - 1) * 82 + 20

    local notif = Instance.new("Frame", nsg)
    notif.Name = "Notif"
    notif.Size = UDim2.new(0, 290, 0, 72)
    notif.Position = UDim2.new(0, -300, 0, yOff)
    notif.BackgroundColor3 = Color3.fromRGB(80, 40, 160)
    notif.BackgroundTransparency = 0.72
    notif.BorderSizePixel = 0
    notif.ZIndex = 50
    notif.ClipsDescendants = true
    corner(notif, 10)
    local nStroke = mkStroke(notif, accent, 1, 0.3)
    local nStrokeGrad = Instance.new("UIGradient", nStroke)
    nStrokeGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, accent),
        ColorSequenceKeypoint.new(1, T.Pink),
    })

    gradFill(notif, {
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(100, 55, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB( 80, 40, 160)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB( 60, 28, 120)),
    }, 135)

    local aBar = Instance.new("Frame", notif)
    aBar.Size = UDim2.new(0, 3, 0.65, 0)
    aBar.Position = UDim2.new(0, 0, 0.175, 0)
    aBar.BackgroundColor3 = accent
    aBar.BorderSizePixel = 0
    aBar.ZIndex = 51
    corner(aBar, 2)

    local nTitle = Instance.new("TextLabel", notif)
    nTitle.Size = UDim2.new(1, -20, 0, 22)
    nTitle.Position = UDim2.new(0, 14, 0, 8)
    nTitle.BackgroundTransparency = 1
    nTitle.Text = title
    nTitle.Font = Enum.Font.GothamBold
    nTitle.TextSize = 13
    nTitle.TextColor3 = T.White
    nTitle.TextXAlignment = Enum.TextXAlignment.Left
    nTitle.ZIndex = 51

    local nContent = Instance.new("TextLabel", notif)
    nContent.Size = UDim2.new(1, -20, 0, 30)
    nContent.Position = UDim2.new(0, 14, 0, 30)
    nContent.BackgroundTransparency = 1
    nContent.Text = content
    nContent.Font = Enum.Font.Gotham
    nContent.TextSize = 11
    nContent.TextColor3 = T.TextSub
    nContent.TextXAlignment = Enum.TextXAlignment.Left
    nContent.TextWrapped = true
    nContent.ZIndex = 51

    local prog = Instance.new("Frame", notif)
    prog.Size = UDim2.new(1, -20, 0, 2)
    prog.Position = UDim2.new(0, 10, 1, -2)
    prog.BackgroundColor3 = accent
    prog.BorderSizePixel = 0
    prog.ZIndex = 52
    corner(prog, 1)
    accentFill(prog, 0)

    local hbConn
    local t0 = tick()
    hbConn = RunService.Heartbeat:Connect(function()
        if not notif.Parent then hbConn:Disconnect() return end
        local t = tick() - t0
        nStrokeGrad.Rotation = (t * 60) % 360
    end)

    tw(notif, { Position = UDim2.new(0, 10, 0, yOff) }, 0.38, Enum.EasingStyle.Back)

    tw(prog, { Size = UDim2.new(0, 0, 0, 2) }, duration, Enum.EasingStyle.Linear)

    task.delay(duration, function()
        hbConn:Disconnect()
        tw(notif, { Position = UDim2.new(0, -300, 0, yOff), BackgroundTransparency = 1 }, 0.28)
        task.delay(0.28, function()
            _notifySlots[slot] = nil
            nsg:Destroy()
        end)
    end)
end

Voidex.GetIcon = function(name)
    if Lucide then return Lucide.GetAsset(name) end
    return nil
end
Voidex.Icons = Lucide and Lucide.Icons or {}

local _rawNotify = Voidex.Notify
Voidex.Notify = function(self, opts)
    return _rawNotify(self, fixNotifyOpts(opts))
end

local _rawCreateTab = Voidex.CreateTab
Voidex.CreateTab = function(self, name, icon)
    return _rawCreateTab(self, name, fixIcon(icon))
end

local _rawNew = Voidex.new
Voidex.new = function(config)
    config = fixOpts(config or {})
    if config.Title and not config.Name then config.Name = config.Title end
    return _rawNew(config)
end

Voidex.MakeNotification = function(self, opts)
    local o = type(opts) == "table" and opts or {}
    if o.Name    and not o.Title    then o.Title    = o.Name             end
    if o.Time    and not o.Duration then o.Duration = tonumber(o.Time)   end
    if o.Message and not o.Content  then o.Content  = o.Message          end
    return self:Notify(fixNotifyOpts(o))
end

Voidex.SendNotification = function(self, opts)
    return self:Notify(fixNotifyOpts(opts))
end
Voidex.Notification = Voidex.SendNotification

Voidex.ShowNotification = Voidex.MakeNotification

Voidex.Alert  = function(self, opts) return self:Notify(fixNotifyOpts(opts)) end
Voidex.Popup  = Voidex.Alert

Voidex.Toast  = function(self, opts) return self:Notify(fixNotifyOpts(opts)) end

Voidex.AddNotification = function(self, opts) return self:Notify(fixNotifyOpts(opts)) end

Voidex.SendMessage = function(self, opts) return self:Notify(fixNotifyOpts(opts)) end

Voidex.MakeTab = function(self, opts)
    local name = type(opts) == "table" and (opts.Name or opts.Title or "Tab") or tostring(opts or "Tab")
    local icon = type(opts) == "table" and (opts.Icon or opts.Image) or nil
    return self:CreateTab(name, icon)
end

Voidex.NewTab = function(self, name, icon)
    return self:CreateTab(tostring(name or "Tab"), icon)
end

Voidex.AddTab = function(self, name, icon)
    return self:CreateTab(tostring(name or "Tab"), icon)
end

local _voidexAddTab = Voidex.AddTab
Voidex.AddTab = function(self, nameOrOpts, icon)
    if type(nameOrOpts) == "table" then
        local name = nameOrOpts.Title or nameOrOpts.Name or "Tab"
        local ic   = nameOrOpts.Icon or nameOrOpts.Image
        return self:CreateTab(name, ic)
    end
    return self:CreateTab(tostring(nameOrOpts or "Tab"), icon)
end

Voidex.AddPage = function(self, name, icon)
    return self:CreateTab(tostring(name or "Tab"), icon)
end

Voidex.AddPanel = function(self, name)
    return self:CreateTab(tostring(name or "Tab"))
end

Voidex.CreatePage = function(self, name)
    return self:CreateTab(tostring(name or "Tab"))
end

Voidex.CreateWindow = Voidex.new
Voidex.MakeWindow   = Voidex.new
Voidex.CreateLib    = function(self, name, theme)
    return Voidex.new({ Name = tostring(name or "Voidex") })
end
Voidex.Init      = Voidex.new
Voidex.CreateGui = Voidex.new
Voidex.CreateUI  = Voidex.new

for norm, mapped in pairs(WIN_METHOD_MAP) do
    if not rawget(Voidex, mapped) then
    elseif not rawget(Voidex, norm) then
        Voidex[norm] = Voidex[mapped]
    end
end

return Voidex

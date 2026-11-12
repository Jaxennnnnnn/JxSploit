--[[
	JxSploit UI by Jaxen  (v3)
	Splash -> main menu (FE shit / TROLL / MISC)
	Category pages are empty: add your own buttons inside the Content frames.
	RightShift hides/shows the UI.
]]

---------------------------------------------------------------- whitelist
-- only these usernames can run the script; everyone else gets nothing
local JX_WHITELIST = {
	"silent_yuno",
	"ExyhJexy",
}
local jxWhitelisted = false
do
	local wlPlayers = game:GetService("Players")
	local me = wlPlayers.LocalPlayer
	while not me do
		task.wait()
		me = wlPlayers.LocalPlayer
	end
	for _, name in ipairs(JX_WHITELIST) do
		if string.lower(me.Name) == string.lower(name) then
			jxWhitelisted = true
			break
		end
	end
end
if not jxWhitelisted then
	return
end

print("[JxSploit] script version: 16 (Kidnap Van: top-of-screen banner + shining outline)")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

---------------------------------------------------------------- setup
local function getParent()
	local ok, h = pcall(function()
		return gethui and gethui()
	end)
	if ok and typeof(h) == "Instance" then
		return h
	end
	return lp:WaitForChild("PlayerGui")
end

local root = getParent()
local old = root:FindFirstChild("JxSploit")
if old then
	old:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "JxSploit"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = root

local WHITE = Color3.fromRGB(255, 255, 255)
local BLUE = Color3.fromRGB(35, 90, 215)
local V2 = Vector2.new

local cam = workspace.CurrentCamera
local vp = cam and cam.ViewportSize or Vector2.new(1280, 720)
local uiScale = math.clamp(math.min(vp.Y / 480, vp.X / 820), 0.55, 1)

local Quint, Quad, Out, In = Enum.EasingStyle.Quint, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, Enum.EasingDirection.In

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props) do
		o[k] = v
	end
	o.Parent = parent
	return o
end

local function tw(o, t, props, style, dir, delay)
	local info = TweenInfo.new(t, style or Quint, dir or Out, 0, false, delay or 0)
	local x = TweenService:Create(o, info, props)
	x:Play()
	return x
end

local function label(parent, text, size, pos, sz, anchor)
	return new("TextLabel", {
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = size,
		TextColor3 = WHITE,
		TextWrapped = true,
		AnchorPoint = anchor or V2(0, 0),
		Position = pos,
		Size = sz,
	}, parent)
end

local function line(parent, pos, sz, anchor)
	return new("Frame", {
		BackgroundColor3 = BLUE,
		BorderSizePixel = 0,
		AnchorPoint = anchor or V2(0, 0),
		Position = pos,
		Size = sz,
	}, parent)
end

-- soft glow: transparency hits 1 halfway, so there are no hard edges
local function glow(parent, color, anchor, pos, size, rot, a)
	local f = new("Frame", {
		BackgroundColor3 = color,
		BorderSizePixel = 0,
		AnchorPoint = anchor,
		Position = pos,
		Size = size,
		ZIndex = 0,
	}, parent)
	new("UIGradient", {
		Rotation = rot,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, a),
			NumberSequenceKeypoint.new(0.5, 1),
			NumberSequenceKeypoint.new(1, 1),
		}),
	}, f)
	return f
end

-- Panel: CanvasGroup (fade + clipping) -> gradient bg frame -> glows -> content
local function makePanel(name, w, h)
	local p = new("CanvasGroup", {
		Name = name,
		AnchorPoint = V2(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(w, h),
		BackgroundTransparency = 1,
		GroupTransparency = 1,
	}, gui)
	new("UICorner", { CornerRadius = UDim.new(0, math.floor(h * 0.19)) }, p)
	new("UIScale", { Name = "S", Scale = uiScale }, p)

	local bg = new("Frame", {
		Name = "Bg",
		BackgroundColor3 = WHITE,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 0,
	}, p)
	new("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 12, 30)),
	}, bg)

	glow(p, Color3.fromRGB(15, 70, 200), V2(0, 0), UDim2.fromScale(0, 0), UDim2.fromScale(0.3, 0.36), 45, 0.2)
	glow(p, Color3.fromRGB(0, 40, 110), V2(1, 1), UDim2.fromScale(1, 1), UDim2.fromScale(0.55, 0.95), 215, 0.5)
	glow(p, Color3.fromRGB(0, 30, 90), V2(1, 0.5), UDim2.fromScale(1, 0.5), UDim2.fromScale(0.2, 1), 180, 0.7)
	return p
end

---------------------------------------------------------------- splash (identical layout to reference)
local messages = {
	"How are you doing? I love u <3",
	"Oxide? More like SUICI- :D",
	"did you know Jaxen is such a cooool person",
	"Did you know? Wait i forgot 1 sec",
	"Jaxen loves attention seeking,\nbest script to get it.",
	"Im so inlove with you~ your so inlove with mee",
	"I JUST SHIT MY PAAANTS",
	"did you know? Making fun of peoples looks\nIS NOT FUNNY.",
	"Jaxen? More like Michael Jackson (laugh)",
	"Jaxen loves his best friend, he's funny",
	"DECODE: Tkhox sc cesmsnkv! :D",
}

local SW, SH = 620, 382
local splash = makePanel("Splash", SW, SH)

local sTitle = label(splash, "JxSploit", math.floor(SH * 0.19), UDim2.fromScale(0.5, 0.41), UDim2.fromScale(0.9, 0.26), V2(0.5, 0.5))
local sLine = line(splash, UDim2.fromScale(0.5, 0.54), UDim2.new(0, 0, 0, 2), V2(0.5, 0.5))
local sSub = label(splash, "", math.floor(SH * 0.052), UDim2.fromScale(0.49, 0.6), UDim2.fromScale(0.17, 0.12), V2(0.5, 0.5))
local sideL = line(splash, UDim2.fromScale(0.4, 0.6), UDim2.new(0, 0, 0, 2), V2(1, 0.5))
local sideR = line(splash, UDim2.fromScale(0.58, 0.6), UDim2.new(0, 0, 0, 2), V2(0, 0.5))
sSub.TextTransparency = 1

local function showSub(text, flanked)
	sSub.Text = text
	local finalPos = flanked and UDim2.fromScale(0.49, 0.6) or UDim2.fromScale(0.5, 0.6)
	sSub.Size = flanked and UDim2.fromScale(0.17, 0.12) or UDim2.fromScale(0.84, 0.2)
	sSub.Position = finalPos + UDim2.fromScale(0, 0.03)
	tw(sSub, 0.5, { TextTransparency = 0, Position = finalPos })
	local w = flanked and UDim2.new(0.335, 0, 0, 2) or UDim2.new(0, 0, 0, 2)
	tw(sideL, 0.6, { Size = w })
	tw(sideR, 0.6, { Size = w })
end

local function hideSub()
	tw(sSub, 0.25, { TextTransparency = 1, Position = sSub.Position - UDim2.fromScale(0, 0.03) }, Quad, In)
	tw(sideL, 0.3, { Size = UDim2.new(0, 0, 0, 2) }, Quad, In)
	tw(sideR, 0.3, { Size = UDim2.new(0, 0, 0, 2) }, Quad, In)
end

---------------------------------------------------------------- menu (identical layout to reference)
local MW, MH = 560, 345
local menu = makePanel("Menu", MW, MH)
menu.Visible = false

local handle = new("Frame", {
	BackgroundTransparency = 1,
	Size = UDim2.fromScale(1, 0.22),
	Active = true,
}, menu)

-- smooth drag (lerped)
do
	local dragging, startInput, startPos, target
	handle.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startInput = i.Position
			startPos = menu.Position
			target = menu.Position
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if
			dragging
			and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch)
		then
			local d = i.Position - startInput
			target = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
	RunService.RenderStepped:Connect(function(dt)
		if target then
			menu.Position = menu.Position:Lerp(target, math.clamp(dt * 18, 0, 1))
		end
	end)
end

local mTitle = label(menu, "JxSploit", math.floor(MH * 0.125), UDim2.fromScale(0.075, 0.13), UDim2.fromScale(0.6, 0.16), V2(0, 0.5))
mTitle.TextXAlignment = Enum.TextXAlignment.Left
local mLine = line(menu, UDim2.fromScale(0.075, 0.205), UDim2.new(0, 0, 0, 2))

-- home (category buttons)
local home = new("CanvasGroup", {
	BackgroundTransparency = 1,
	Size = UDim2.fromScale(1, 1),
}, menu)

-- page (category content)
local page = new("CanvasGroup", {
	BackgroundTransparency = 1,
	Size = UDim2.fromScale(1, 1),
	Visible = false,
	GroupTransparency = 1,
}, menu)

local pageTitle = label(page, "", math.floor(MH * 0.085), UDim2.fromScale(0.075, 0.28), UDim2.fromScale(0.5, 0.12), V2(0, 0.5))
pageTitle.TextXAlignment = Enum.TextXAlignment.Left

local back = new("TextButton", {
	Text = "< Back",
	Font = Enum.Font.GothamBold,
	TextSize = math.floor(MH * 0.05),
	TextColor3 = WHITE,
	BackgroundColor3 = Color3.fromRGB(12, 36, 90),
	AnchorPoint = V2(1, 0.5),
	Position = UDim2.fromScale(0.925, 0.28),
	Size = UDim2.fromScale(0.2, 0.1),
	AutoButtonColor = false,
}, page)
new("UICorner", { CornerRadius = UDim.new(0, 8) }, back)

local contents = {}
local function makeContent(key)
	local c = new("ScrollingFrame", {
		Name = key .. "Content",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.075, 0.37),
		Size = UDim2.fromScale(0.85, 0.57),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 3,
		Visible = false,
	}, page)
	new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, c)
	-- add your features here, e.g. new("TextButton", {...}, c)
	contents[key] = c
	return c
end

-- page transitions
local busy = false
local function goPage(key, shownName)
	if busy then
		return
	end
	busy = true
	pageTitle.Text = shownName
	for k, c in pairs(contents) do
		c.Visible = (k == key)
	end
	tw(home, 0.25, { GroupTransparency = 1, Position = UDim2.fromScale(-0.06, 0) }, Quint, In)
	task.wait(0.22)
	home.Visible = false
	page.Position = UDim2.fromScale(0.06, 0)
	page.GroupTransparency = 1
	page.Visible = true
	tw(page, 0.4, { GroupTransparency = 0, Position = UDim2.fromScale(0, 0) })
	task.wait(0.25)
	busy = false
end

local function goHome()
	if busy then
		return
	end
	busy = true
	tw(page, 0.25, { GroupTransparency = 1, Position = UDim2.fromScale(0.06, 0) }, Quint, In)
	task.wait(0.22)
	page.Visible = false
	home.Position = UDim2.fromScale(-0.06, 0)
	home.GroupTransparency = 1
	home.Visible = true
	tw(home, 0.4, { GroupTransparency = 0, Position = UDim2.fromScale(0, 0) })
	task.wait(0.25)
	busy = false
end

back.MouseButton1Click:Connect(goHome)
back.MouseEnter:Connect(function()
	tw(back, 0.2, { BackgroundColor3 = Color3.fromRGB(25, 70, 160) })
end)
back.MouseLeave:Connect(function()
	tw(back, 0.2, { BackgroundColor3 = Color3.fromRGB(12, 36, 90) })
end)

-- category buttons: rounded glass cards with blue accents and clear hierarchy
local rows = {}
local categoryInfo = {
    FE = { subtitle = "FE FEATURES", accent = Color3.fromRGB(65, 145, 255) },
    TROLL = { subtitle = "TROLLING TOOLS", accent = Color3.fromRGB(95, 125, 255) },
    MISC = { subtitle = "EXTRA UTILITIES", accent = Color3.fromRGB(45, 190, 235) },
}

local function softLayer(parent, color, rot, a0, power)
    local pts = {}
    for i = 0, 10 do
        local t = i / 10
        pts[#pts + 1] = NumberSequenceKeypoint.new(t, 1 - a0 * (1 - t) ^ power)
    end
    local f = new("Frame", {
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }, parent)
    new("UICorner", { CornerRadius = UDim.new(0, 13) }, f)
    new("UIGradient", { Rotation = rot, Transparency = NumberSequence.new(pts) }, f)
    return f
end

local function categoryButton(text, key, shownName, index)
    makeContent(key)
    local info = categoryInfo[key] or { subtitle = "OPEN CATEGORY", accent = BLUE }
    local baseY = 0.252 + (index - 1) * 0.1765
    local row = new("CanvasGroup", {
        BackgroundTransparency = 1,
        AnchorPoint = V2(0.5, 0.5),
        Position = UDim2.fromScale(0.078 + 0.4135, baseY + 0.087),
        Size = UDim2.fromScale(0.827, 0.158),
        GroupTransparency = 0,
    }, home)
    local rs = new("UIScale", { Scale = 1 }, row)

    local body = new("Frame", {
        Name = "Card",
        BackgroundColor3 = Color3.fromRGB(3, 10, 26),
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
        ClipsDescendants = true,
    }, row)
    new("UICorner", { CornerRadius = UDim.new(0, 13) }, body)
    -- smooth gradient: dark base + several soft glow layers at different angles
    -- (stacked layers hide the colour banding a single dark gradient gets)
    softLayer(body, Color3.fromRGB(30, 78, 170), 0, 0.85, 2.2)
    softLayer(body, Color3.fromRGB(70, 120, 235), 25, 0.22, 3)
    softLayer(body, Color3.fromRGB(0, 0, 0), 270, 0.45, 1.6)

    -- soft top highlight
    local shine = new("Frame", {
        BackgroundColor3 = WHITE,
        BackgroundTransparency = 0.93,
        BorderSizePixel = 0,
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.new(1, 0, 0.42, 0),
    }, body)
    new("UICorner", { CornerRadius = UDim.new(0, 13) }, shine)
    new("UIGradient", {
        Rotation = 90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.2),
            NumberSequenceKeypoint.new(1, 1),
        }),
    }, shine)

    local title = label(body, text, math.floor(MH * 0.082), UDim2.fromScale(0.055, 0.43), UDim2.fromScale(0.76, 0.43), V2(0, 0.5))
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextYAlignment = Enum.TextYAlignment.Center

    local subtitle = label(body, info.subtitle, math.floor(MH * 0.029), UDim2.fromScale(0.058, 0.77), UDim2.fromScale(0.76, 0.2), V2(0, 0.5))
    subtitle.TextColor3 = Color3.fromRGB(145, 174, 220)
    subtitle.TextTransparency = 0.12
    subtitle.TextXAlignment = Enum.TextXAlignment.Left

    local hl = new("Frame", {
        BackgroundColor3 = info.accent,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1, 1),
    }, body)
    new("UICorner", { CornerRadius = UDim.new(0, 13) }, hl)

    local b = new("TextButton", {
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 5,
    }, row)

    b.MouseEnter:Connect(function()
        tw(hl, 0.2, { BackgroundTransparency = 0.9 })
        tw(rs, 0.2, { Scale = 1.015 })
    end)
    b.MouseLeave:Connect(function()
        tw(hl, 0.2, { BackgroundTransparency = 1 })
        tw(rs, 0.2, { Scale = 1 })
    end)
    b.MouseButton1Down:Connect(function()
        tw(rs, 0.1, { Scale = 0.985 })
    end)
    b.MouseButton1Up:Connect(function()
        tw(rs, 0.2, { Scale = 1.015 }, Enum.EasingStyle.Back)
    end)
    b.MouseButton1Click:Connect(function()
        goPage(key, shownName)
    end)

    rows[#rows + 1] = row
end

categoryButton("FE shit", "FE", "FE", 1)
categoryButton("TROLL", "TROLL", "TROLL", 2)
categoryButton("MISC", "MISC", "MISC", 3)

---------------------------------------------------------------- FEATURES: Fly Cars
local CAS = game:GetService("ContextActionService")

local FLY_SPEED = 95
local flyEnabled = false
local flyConn
local flySeat
local flyVel = Vector3.zero
local btnUp, btnDown, spaceUp = false, false, false
local joyVec = Vector2.zero

-- on-screen controls (touch): joystick bottom-left, UP/DOWN above the jump button
local flyUI = new("Frame", {
	Name = "FlyControls",
	BackgroundTransparency = 1,
	Size = UDim2.fromScale(1, 1),
	Visible = false,
}, gui)

local joyBase = new("Frame", {
	BackgroundColor3 = WHITE,
	BackgroundTransparency = 0,
	AnchorPoint = V2(0, 1),
	Position = UDim2.new(0, 70, 1, -18),
	Size = UDim2.fromOffset(150, 150),
	Active = true,
}, flyUI)
new("UICorner", { CornerRadius = UDim.new(0.5, 0) }, joyBase)
new("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 78, 165)),
		ColorSequenceKeypoint.new(0.55, Color3.fromRGB(4, 16, 40)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 7, 20)),
	}),
}, joyBase)
local joyStroke = new("UIStroke", { Color = Color3.fromRGB(4, 16, 40), Thickness = 3, Transparency = 0.08 }, joyBase)
new("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 78, 165)),
		ColorSequenceKeypoint.new(0.55, Color3.fromRGB(4, 16, 40)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 7, 20)),
	}),
}, joyStroke)

-- Centre J control: matching navy gradient, with no extra middle ring
local joyThumb = new("Frame", {
	BackgroundColor3 = WHITE,
	AnchorPoint = V2(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(64, 64),
}, joyBase)
new("UICorner", { CornerRadius = UDim.new(0.5, 0) }, joyThumb)
new("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 78, 165)),
		ColorSequenceKeypoint.new(0.55, Color3.fromRGB(4, 16, 40)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 7, 20)),
	}),
}, joyThumb)
local joyThumbStroke = new("UIStroke", { Color = Color3.fromRGB(4, 16, 40), Thickness = 2.5, Transparency = 0.05 }, joyThumb)
new("UIGradient", {
	Rotation = 90,
	Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 78, 165)),
		ColorSequenceKeypoint.new(0.55, Color3.fromRGB(4, 16, 40)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 7, 20)),
	}),
}, joyThumbStroke)
local joyJ = label(joyThumb, "J", 32, UDim2.fromScale(0.5, 0.5), UDim2.fromScale(1, 1), V2(0.5, 0.5))
joyJ.TextStrokeColor3 = Color3.fromRGB(0, 12, 35)
joyJ.TextStrokeTransparency = 0.45

local joyInput
local function joyUpdate(input)
	local center = joyBase.AbsolutePosition + joyBase.AbsoluteSize / 2
	local delta = Vector2.new(input.Position.X, input.Position.Y) - center
	local radius = joyBase.AbsoluteSize.X / 2
	local m = math.min(delta.Magnitude, radius)
	local dir = delta.Magnitude > 0 and delta.Unit or Vector2.zero
	joyVec = dir * (m / radius)
	joyThumb.Position = UDim2.new(0.5, dir.X * m, 0.5, dir.Y * m)
end
local function joyReset()
	joyInput = nil
	joyVec = Vector2.zero
	tw(joyThumb, 0.15, { Position = UDim2.fromScale(0.5, 0.5) })
	tw(joyStroke, 0.25, { Transparency = 0.35 })
end
joyBase.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
		joyInput = i
		tw(joyStroke, 0.1, { Transparency = 0 })
		joyUpdate(i)
	end
end)
UIS.InputChanged:Connect(function(i)
	if joyInput and i == joyInput then
		joyUpdate(i)
	end
end)
UIS.InputEnded:Connect(function(i)
	if joyInput and i == joyInput then
		joyReset()
	end
end)

local function chevron(parent, down)
	local holder = new("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = V2(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.4),
		Size = UDim2.fromOffset(32, 20),
	}, parent)
	local function arm(x, rot)
		local f = new("Frame", {
			BackgroundColor3 = WHITE,
			BorderSizePixel = 0,
			AnchorPoint = V2(0.5, 0.5),
			Position = UDim2.new(0.5, x, 0.5, 0),
			Size = UDim2.fromOffset(19, 5),
			Rotation = rot,
		}, holder)
		new("UICorner", { CornerRadius = UDim.new(0.5, 0) }, f)
	end
	if down then
		arm(-6, 45)
		arm(6, -45)
	else
		arm(-6, -45)
		arm(6, 45)
	end
end

local function holdButton(text, y, down, setter)
	local b = new("TextButton", {
		Text = "",
		BackgroundColor3 = WHITE,
		AutoButtonColor = false,
		AnchorPoint = V2(1, 1),
		Position = UDim2.new(1, -230, 1, y),
		Size = UDim2.fromOffset(76, 66),
	}, flyUI)
	new("UICorner", { CornerRadius = UDim.new(0.28, 0) }, b)
	new("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 78, 165)),
			ColorSequenceKeypoint.new(0.55, Color3.fromRGB(4, 16, 40)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 7, 20)),
		}),
	}, b)
	local stroke = new("UIStroke", { Color = Color3.fromRGB(60, 130, 255), Thickness = 2, Transparency = 0.35 }, b)

	chevron(b, down)
	local lbl = label(b, text, 11, UDim2.fromScale(0.5, 0.8), UDim2.fromScale(1, 0.25), V2(0.5, 0.5))
	lbl.TextTransparency = 0.25

	local hl = new("Frame", {
		BackgroundColor3 = Color3.fromRGB(90, 160, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
	}, b)
	new("UICorner", { CornerRadius = UDim.new(0.28, 0) }, hl)

	local sc = new("UIScale", { Scale = 1 }, b)
	b.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
			setter(true)
			tw(hl, 0.1, { BackgroundTransparency = 0.78 })
			tw(stroke, 0.1, { Transparency = 0 })
			tw(sc, 0.1, { Scale = 0.94 })
		end
	end)
	b.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
			setter(false)
			tw(hl, 0.25, { BackgroundTransparency = 1 })
			tw(stroke, 0.25, { Transparency = 0.35 })
			tw(sc, 0.25, { Scale = 1 }, Enum.EasingStyle.Back)
		end
	end)
end
holdButton("UP", -148, false, function(v)
	btnUp = v
end)
holdButton("DOWN", -74, true, function(v)
	btnDown = v
end)

-- vehicle GUI hiding: anything that turns on after you sit gets hidden, and comes back when you leave
local PlayerGui = lp:WaitForChild("PlayerGui")
local EXCLUDE = { JxSploit = true, TouchGui = true }
local guiSnap, hiddenGuis = {}, {}

local function snapshotGuis()
	for _, g in ipairs(PlayerGui:GetChildren()) do
		if g:IsA("ScreenGui") then
			guiSnap[g] = g.Enabled
		end
	end
end

local function hideNewGuis()
	for _, g in ipairs(PlayerGui:GetChildren()) do
		if g:IsA("ScreenGui") and not EXCLUDE[g.Name] and g.Enabled and guiSnap[g] ~= true then
			hiddenGuis[g] = true
			g.Enabled = false
			print("[JxSploit] hid vehicle GUI: " .. g.Name)
		end
	end
end

local function restoreGuis()
	for g in pairs(hiddenGuis) do
		if g.Parent then
			g.Enabled = true
		end
	end
	hiddenGuis = {}
end

-- seat enter / leave
local function enterSeatState(seat)
	flySeat = seat
	local root = seat.AssemblyRootPart or seat
	flyVel = root.AssemblyLinearVelocity
	flyUI.Visible = UIS.TouchEnabled
	CAS:BindActionAtPriority("JxFlyUp", function(_, state)
		spaceUp = (state == Enum.UserInputState.Begin)
		return Enum.ContextActionResult.Sink
	end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Space)
end

local function leaveSeatState()
	flySeat = nil
	flyUI.Visible = false
	joyReset()
	btnUp, btnDown, spaceUp = false, false, false
	CAS:UnbindAction("JxFlyUp")
	restoreGuis()
end

-- input -> world direction (camera relative; looking up + forward = climb)
local function moveDir()
	local c = workspace.CurrentCamera
	if not c then
		return Vector3.zero
	end
	local cf = c.CFrame
	local fwd, right, vert = 0, 0, 0
	if not UIS:GetFocusedTextBox() then
		if UIS:IsKeyDown(Enum.KeyCode.W) then fwd += 1 end
		if UIS:IsKeyDown(Enum.KeyCode.S) then fwd -= 1 end
		if UIS:IsKeyDown(Enum.KeyCode.D) then right += 1 end
		if UIS:IsKeyDown(Enum.KeyCode.A) then right -= 1 end
		if UIS:IsKeyDown(Enum.KeyCode.E) or spaceUp then vert += 1 end
		if UIS:IsKeyDown(Enum.KeyCode.Q) or UIS:IsKeyDown(Enum.KeyCode.LeftShift) then vert -= 1 end
	end
	fwd += -joyVec.Y
	right += joyVec.X
	if btnUp then vert += 1 end
	if btnDown then vert -= 1 end

	local d = cf.LookVector * fwd + cf.RightVector * right + Vector3.yAxis * vert * 0.8
	if d.Magnitude > 1 then
		d = d.Unit
	end
	return d
end

local function stepFlight(dt, seat)
	local root = seat.AssemblyRootPart or seat
	if root.Anchored then
		return
	end
	local d = moveDir()
	flyVel = flyVel:Lerp(d * FLY_SPEED, math.clamp(dt * 3.5, 0, 1))
	root.AssemblyLinearVelocity = flyVel
	root.AssemblyAngularVelocity = Vector3.zero

	-- orientation: face the direction you're heading, nose tilts with climb/dive
	local sc = seat.CFrame
	local flatLook = Vector3.new(sc.LookVector.X, 0, sc.LookVector.Z)
	local heading = flatLook.Magnitude > 0.01 and flatLook.Unit or Vector3.new(0, 0, -1)
	local hv = Vector3.new(d.X, 0, d.Z)
	if hv.Magnitude > 0.15 then
		heading = hv.Unit
	end
	local pitch = math.rad(math.clamp(flyVel.Y / FLY_SPEED * 25, -25, 25))
	local goal = CFrame.lookAt(sc.Position, sc.Position + heading) * CFrame.Angles(pitch, 0, 0)
	local newSeat = sc:Lerp(goal, math.clamp(dt * 5, 0, 1))
	root.CFrame = newSeat * (sc:Inverse() * root.CFrame)
end

local lastSnap = 0
local function flyTick(dt)
	local char = lp.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local seat = hum and hum.SeatPart
	if seat and (seat:IsA("VehicleSeat") or seat:IsA("Seat")) then
		if flySeat ~= seat then
			enterSeatState(seat)
		end
		hideNewGuis()
		stepFlight(dt, seat)
	else
		if flySeat then
			leaveSeatState()
		end
		lastSnap += dt
		if lastSnap > 0.4 then
			lastSnap = 0
			snapshotGuis()
		end
	end
end

local function setFly(on)
	flyEnabled = on
	if on then
		snapshotGuis()
		if not flyConn then
			flyConn = RunService.Heartbeat:Connect(flyTick)
		end
	else
		if flyConn then
			flyConn:Disconnect()
			flyConn = nil
		end
		if flySeat then
			leaveSeatState()
		end
	end
	print("[JxSploit] Fly Cars " .. (on and "ON" or "OFF"))
end

gui.Destroying:Connect(function()
	setFly(false)
end)

---------------------------------------------------------------- feature buttons (shared state between FE + TROLL)
local featureViews, featureHandlers, featureState = {}, {}, {}

local function setFeature(key, on)
	featureState[key] = on
	for _, v in ipairs(featureViews[key] or {}) do
		v(on)
	end
	local h = featureHandlers[key]
	if h then
		task.spawn(h, on)
	end
end

local ROW_OFF = Color3.fromRGB(3, 14, 36)
local ROW_ON = Color3.fromRGB(8, 34, 86)

local function addFeature(content, key, title, desc, order)
	local row = new("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = ROW_OFF,
		LayoutOrder = order,
		Size = UDim2.new(1, -8, 0, 80),
	}, content)
	new("UICorner", { CornerRadius = UDim.new(0.1, 0) }, row) -- 10% smoothed edges
	local stroke = new("UIStroke", { Color = Color3.fromRGB(35, 90, 215), Thickness = 1.5, Transparency = 0.65 }, row)

	local t = label(row, title, 21, UDim2.fromOffset(14, 8), UDim2.new(1, -90, 0, 26))
	t.TextXAlignment = Enum.TextXAlignment.Left

	local d = label(row, desc, 14, UDim2.fromOffset(14, 36), UDim2.new(1, -28, 0, 40))
	d.Font = Enum.Font.Gotham
	d.TextTransparency = 0.45 -- low opacity description
	d.TextXAlignment = Enum.TextXAlignment.Left
	d.TextYAlignment = Enum.TextYAlignment.Top

	local pill = new("Frame", {
		BackgroundColor3 = Color3.fromRGB(25, 35, 58),
		AnchorPoint = V2(1, 0),
		Position = UDim2.new(1, -12, 0, 10),
		Size = UDim2.fromOffset(54, 22),
	}, row)
	new("UICorner", { CornerRadius = UDim.new(0.5, 0) }, pill)
	local pillText = label(pill, "OFF", 12, UDim2.fromScale(0, 0), UDim2.fromScale(1, 1))

	featureViews[key] = featureViews[key] or {}
	table.insert(featureViews[key], function(on)
		pillText.Text = on and "ON" or "OFF"
		tw(row, 0.3, { BackgroundColor3 = on and ROW_ON or ROW_OFF })
		tw(pill, 0.3, { BackgroundColor3 = on and BLUE or Color3.fromRGB(25, 35, 58) })
		tw(stroke, 0.3, { Transparency = on and 0.15 or 0.65 })
	end)

	row.MouseButton1Down:Connect(function()
		tw(row, 0.1, { BackgroundColor3 = Color3.fromRGB(14, 50, 115) })
	end)
	row.MouseButton1Click:Connect(function()
		setFeature(key, not featureState[key])
	end)
	return row
end

local FLY_DESC = "Soo you remember those flying tesla cars? Yeah lets turn your car into that! :D"
featureHandlers.flycars = setFly
addFeature(contents.FE, "flycars", "Fly Cars", FLY_DESC, 1)
addFeature(contents.TROLL, "flycars", "Fly Cars", FLY_DESC, 1)

---------------------------------------------------------------- FEATURES: Aura Lights (PropMaker)
do
	local RS = game:GetService("ReplicatedStorage")

	-- Aura configuration
	local AURA_COUNT = 6
	local AURA_RADIUS = 5
	local AURA_DEPTH = 6
	local MOVE_DIST = 4
	local SPIN_STEP = math.rad(30)

	local GAP_START = 0.18
	local GAP_MIN = 0.12
	local GAP_MAX = 0.4

	local SETTLE = 0.35
	local MATCH_DIST = 14
	local PROP_NAME = "LightsSpotLightRed"

	local HIDE_TOOL = true
	local TOOL_DEPTH = 8

	local auraEnabled = false
	local auraDelete = true
	local auraToken = 0
	local auraBusy = false

	local gap = GAP_START
	local spin = 0
	local pending = {}
	local slots = {}
	local deleting = {}
	local lastGroundY

	local spawnedList = {}
	local seenProps = {}
	local claimed = {}

	local watchConn
	local holdConn
	local holdCache = {}

	local hits = 0
	local misses = 0

	local function RE()
		return RS:FindFirstChild("RE")
	end

	--------------------------------------------------
	-- PROP DETECTION

	local function propPos(m)
		if not m or not m.Parent then
			return nil
		end

		local touch = m:FindFirstChild("Touch")

		if touch and touch:IsA("BasePart") then
			return touch.Position
		end

		if m:IsA("BasePart") then
			return m.Position
		end

		if m:IsA("Model") then
			return m:GetPivot().Position
		end

		return nil
	end

	local function startWatch()
		if watchConn then
			return
		end

		local root = workspace:FindFirstChild("WorkspaceCom") or workspace

		watchConn = root.DescendantAdded:Connect(function(i)
			if i.Name ~= "Touch" then
				return
			end

			local model = i.Parent

			if not model or seenProps[model] then
				return
			end

			seenProps[model] = true
			table.insert(spawnedList, { m = model })
		end)
	end

	local function stopWatch()
		if watchConn then
			watchConn:Disconnect()
			watchConn = nil
		end

		spawnedList = {}
		seenProps = {}
		claimed = {}
		pending = {}
		slots = {}
		deleting = {}
	end

	--------------------------------------------------
	-- TOOL EQUIPPING

	local function auraEquip()
		local char = lp.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")

		if not hum then
			return nil
		end

		local tool = char:FindFirstChild("PropMaker")
			or lp.Backpack:FindFirstChild("PropMaker")

		if not tool then
			local re = RE()
			local fn = re and re:FindFirstChild("1Too1l")

			if fn then
				pcall(function()
					fn:InvokeServer("PickingTools", "PropMaker")
				end)
			end

			local start = os.clock()

			repeat
				task.wait(0.1)

				char = lp.Character
				tool = (char and char:FindFirstChild("PropMaker"))
					or lp.Backpack:FindFirstChild("PropMaker")

			until tool or os.clock() - start > 3
		end

		if tool and tool.Parent ~= char then
			hum:EquipTool(tool)
		end

		local start = os.clock()

		repeat
			task.wait(0.05)
			char = lp.Character
		until (char and char:FindFirstChild("PropMaker"))
			or os.clock() - start > 2

		return char and char:FindFirstChild("PropMaker")
	end

	local function auraOpenMenu()
		local re = RE()
		local sel = re and re:FindFirstChild("1Clea1rTool1s")

		if sel then
			pcall(function()
				sel:FireServer("OpenPropMenu")
			end)
		end

		local remotes = RS:FindFirstChild("Remotes")
		local tel = remotes and remotes:FindFirstChild("TelemetryClientInteraction")

		if tel then
			pcall(function()
				tel:FireServer("filterClick", {
					name = "Lights",
					itemType = "Props"
				})
			end)
		end
	end

	--------------------------------------------------
	-- PROPMAKER HIDING

	local function stopHold()
		if holdConn then
			holdConn:Disconnect()
			holdConn = nil
		end

		holdCache = {}
	end

	local function holdTool(tool)
		if not HIDE_TOOL or not tool then
			return
		end

		local char = lp.Character
		if not char then
			return
		end

		-- Remove the local hand grip so the local positioning
		-- attempt does not immediately get overwritten.
		for _, armName in ipairs({"RightHand", "Right Arm"}) do
			local arm = char:FindFirstChild(armName)
			local grip = arm and arm:FindFirstChild("RightGrip")

			if grip then
				grip:Destroy()
			end
		end

		local base = tool:FindFirstChild("Handle")
			or tool:FindFirstChildWhichIsA("BasePart", true)

		if not base then
			return
		end

		if holdCache.tool ~= tool then
			local parts = {}

			for _, d in ipairs(tool:GetDescendants()) do
				if d:IsA("BasePart") then
					d.CanCollide = false

					if d ~= base then
						parts[d] = base.CFrame:ToObjectSpace(d.CFrame)
					end
				end
			end

			holdCache = {
				tool = tool,
				base = base,
				parts = parts
			}
		end

		if holdConn then
			return
		end

		holdConn = RunService.Heartbeat:Connect(function()
			local c = lp.Character
			local hrp = c and c:FindFirstChild("HumanoidRootPart")
			local cache = holdCache

			if not (
				hrp
				and cache.tool
				and cache.tool.Parent == c
				and cache.base
				and cache.base.Parent
			) then
				return
			end

			local groundY = lastGroundY or (hrp.Position.Y - 3)
			local y = groundY - TOOL_DEPTH

			local pin = CFrame.new(
				hrp.Position.X,
				y,
				hrp.Position.Z
			)

			cache.base.CFrame = pin
			cache.base.AssemblyLinearVelocity = Vector3.zero
			cache.base.AssemblyAngularVelocity = Vector3.zero

			for part, offset in pairs(cache.parts) do
				if part.Parent then
					part.CFrame = pin * offset
				end
			end
		end)
	end

	--------------------------------------------------
	-- RAYCASTING

	local function rayDown(origin, ignore)
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = ignore

		pcall(function()
			params.RespectCanCollide = true
		end)

		return workspace:Raycast(
			origin,
			Vector3.new(0, -500, 0),
			params
		)
	end

	--------------------------------------------------
	-- PLACEMENT

	local function auraPlaceOne(tool, target, idx)
		local re = RE()
		local sel = re and re:FindFirstChild("1Clea1rTool1s")
		local maker = tool:FindFirstChild("Tool_PropMake")

		if not (sel and maker) then
			return
		end

		local ok = pcall(function()
			sel:FireServer(
				"RequestingPropName",
				PROP_NAME,
				"Lights"
			)

			maker:FireServer(
				target.part,
				target.pos
			)
		end)

		if ok then
			table.insert(pending, {
				pos = target.pos,
				t = os.clock(),
				idx = idx
			})
		end
	end

	--------------------------------------------------
	-- DELETION

	local function auraDeleteProp(tool, model)
		local re = RE()
		local props = re and re:FindFirstChild("Props")
		local maker = tool:FindFirstChild("Tool_PropMake")
		local touch = model:FindFirstChild("Touch")

		if not (props and maker and touch) then
			return
		end

		pcall(function()
			maker:FireServer(touch, touch.Position)
		end)

		local remotes = RS:FindFirstChild("Remotes")
		local tel = remotes and remotes:FindFirstChild("TelemetryClientInteraction")

		if tel then
			pcall(function()
				tel:FireServer("propAdjusted", {
					controlsUsed = {},
					duration = 0.5,
					propDeleted = true,
					propName = PROP_NAME
				})
			end)
		end

		local resume = model:FindFirstChild("ResumePropBehavior")

		if resume then
			task.spawn(function()
				pcall(function()
					resume:InvokeServer()
				end)
			end)
		end

		pcall(function()
			props:FireServer("DeleteProp")
		end)
	end

	--------------------------------------------------
	-- SLOT TRACKING (one entry per light)

	local VERIFY_TIMEOUT = 1.5
	local REPLACE_DIST = 1.5
	local DELETE_RETRY = 2

	local function slotAlive(i)
		local s = slots[i]
		return s ~= nil
			and s.model ~= nil
			and s.model.Parent ~= nil
			and not deleting[s.model]
	end

	local function requestDelete(tool, model)
		if not model or not model.Parent or deleting[model] then
			return
		end

		deleting[model] = os.clock()
		auraDeleteProp(tool, model)
	end

	local function deleteSlot(tool, i)
		local s = slots[i]
		slots[i] = nil

		if s and s.model then
			requestDelete(tool, s.model)
		end
	end

	local function retryStuck(tool)
		local now = os.clock()

		for model, t in pairs(deleting) do
			if not model.Parent then
				deleting[model] = nil
			elseif now - t > DELETE_RETRY then
				deleting[model] = now
				auraDeleteProp(tool, model)
			end
		end
	end

	--------------------------------------------------
	-- MATCHING NEW PROPS

	local function claimAndVerify(tool)
		local now = os.clock()

		for i = #pending, 1, -1 do
			if now - pending[i].t > 2.5 then
				table.remove(pending, i)

				misses += 1
				gap = math.min(GAP_MAX, gap + 0.025)
			end
		end

		for i = #spawnedList, 1, -1 do
			local model = spawnedList[i].m

			if not model.Parent then
				table.remove(spawnedList, i)

			elseif not claimed[model] then
				local position = propPos(model)

				if position then
					local bestIndex
					local bestDistance

					for j, request in ipairs(pending) do
						local distance = (
							request.pos - position
						).Magnitude

						if distance < MATCH_DIST
							and (not bestDistance or distance < bestDistance)
						then
							bestIndex = j
							bestDistance = distance
						end
					end

					if bestIndex then
						local request = table.remove(pending, bestIndex)

						claimed[model] = true

						hits += 1

						if hits % 4 == 0 then
							gap = math.max(GAP_MIN, gap - 0.01)
						end

						if slotAlive(request.idx) then
							-- slot already has a light (late spawn from
							-- a retried request): remove the duplicate
							if tool then
								requestDelete(tool, model)
							end
						else
							slots[request.idx] = {
								model = model,
								pos = request.pos
							}
						end
					end
				end
			end
		end
	end

	--------------------------------------------------
	-- DELETE TRACKED PROPS (used when turning off)

	local function deleteAll(tool)
		claimAndVerify(tool)

		for i = 1, AURA_COUNT do
			if slots[i] then
				deleteSlot(tool, i)
				task.wait(gap)
			end
		end

		-- catch any light that spawned late from a pending request
		task.wait(0.3)
		claimAndVerify(tool)

		for i = 1, AURA_COUNT do
			deleteSlot(tool, i)
		end

		retryStuck(tool)
	end

	--------------------------------------------------
	-- BUILD SIX TARGETS

	local function buildTargets(char, hrp)
		local ignore = {char}

		local hum = char:FindFirstChildOfClass("Humanoid")
		local seat = hum and hum.SeatPart

		if seat then
			table.insert(
				ignore,
				seat:FindFirstAncestorOfClass("Model") or seat
			)
		end

		local center = hrp.Position
		local centerResult = rayDown(center, ignore)

		if not centerResult then
			return nil
		end

		lastGroundY = centerResult.Position.Y

		local look = Vector3.new(
			hrp.CFrame.LookVector.X,
			0,
			hrp.CFrame.LookVector.Z
		)

		look = look.Magnitude > 0.01
			and look.Unit
			or Vector3.new(0, 0, -1)

		local targets = {}

		for i = 1, AURA_COUNT do
			local angle = spin
				+ (i - 1) * (math.pi * 2 / AURA_COUNT)

			local direction = CFrame.Angles(0, angle, 0) * look
			local point = center + direction * AURA_RADIUS

			local result = rayDown(
				Vector3.new(point.X, center.Y, point.Z),
				ignore
			)

			local ground = result or centerResult

			targets[i] = {
				part = ground.Instance,

				pos = Vector3.new(
					point.X,
					ground.Position.Y - AURA_DEPTH,
					point.Z
				)
			}
		end

		return targets
	end

	--------------------------------------------------
	-- REPLACE ONE LIGHT

	local function replaceSlot(token, tool, i, target)
		if auraDelete then
			deleteSlot(tool, i)
		else
			-- leave the old light behind, stop tracking it
			slots[i] = nil
		end

		for attempt = 1, 2 do
			if not auraEnabled or token ~= auraToken then
				return false
			end

			auraPlaceOne(tool, target, i)

			local start = os.clock()

			repeat
				task.wait(0.05)
				claimAndVerify(tool)

				if slotAlive(i) then
					return true
				end
			until os.clock() - start > VERIFY_TIMEOUT
		end

		return false
	end

	--------------------------------------------------
	-- MAIN CYCLE

	local function auraCycle(token, moving)
		if auraBusy then
			return
		end

		auraBusy = true

		local success, err = pcall(function()
			local char = lp.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local tool = hrp and auraEquip()

			if not (hrp and tool) then
				return
			end

			holdTool(tool)
			retryStuck(tool)

			if moving then
				spin += SPIN_STEP
			end

			local tried = {}

			for _ = 1, AURA_COUNT do
				if not auraEnabled or token ~= auraToken then
					return
				end

				char = lp.Character
				hrp = char and char:FindFirstChild("HumanoidRootPart")

				if not hrp then
					return
				end

				-- rebuilt every step so each light uses the
				-- player's current position
				local targets = buildTargets(char, hrp)

				if not targets then
					return
				end

				claimAndVerify(tool)

				local pick
				local pickDist

				for i, target in ipairs(targets) do
					if not tried[i] then
						local d = slotAlive(i)
							and (slots[i].pos - target.pos).Magnitude
							or math.huge

						if d > REPLACE_DIST
							and (not pickDist or d > pickDist)
						then
							pick = i
							pickDist = d
						end
					end
				end

				if not pick then
					break
				end

				tried[pick] = true
				replaceSlot(token, tool, pick, targets[pick])
				task.wait(gap)
			end
		end)

		if not success then
			warn("[JxSploit] Aura error:", err)
		end

		auraBusy = false
	end

	--------------------------------------------------
	-- FOLLOW PLAYER

	local function allFilled()
		for i = 1, AURA_COUNT do
			if not slotAlive(i) then
				return false
			end
		end

		return true
	end

	local function auraLoop(token)
		local lastCenter

		while auraEnabled and token == auraToken do
			local char = lp.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")

			if hrp then
				local moved = not lastCenter
					or (hrp.Position - lastCenter).Magnitude > MOVE_DIST

				if moved or not allFilled() then
					if moved then
						lastCenter = hrp.Position
					end

					auraCycle(token, moved)

					if misses >= 8 and hits == 0 then
						warn(
							"[JxSploit] Aura: unable to verify spawned props."
						)

						setFeature("auralights", false)
						return
					end
				end
			end

			task.wait(0.1)
		end
	end

	--------------------------------------------------
	-- TOGGLE

	local function setAura(on)
		auraEnabled = on
		auraToken += 1

		local token = auraToken

		if on then
			gap = GAP_START
			hits = 0
			misses = 0

			startWatch()

			task.spawn(function()
				local tool = auraEquip()

				if not tool then
					warn("[JxSploit] Aura Lights: couldn't get PropMaker")
					setFeature("auralights", false)
					return
				end

				if token ~= auraToken then
					return
				end

				holdTool(tool)
				auraOpenMenu()

				task.wait(0.3)
				auraLoop(token)
			end)

		else
			task.spawn(function()
				while auraBusy do
					task.wait(0.1)
				end

				if auraDelete then
					local tool = auraEquip()

					if tool then
						deleteAll(tool)
					end
				end

				stopWatch()
				stopHold()

				local char = lp.Character
				local hum = char and char:FindFirstChildOfClass("Humanoid")

				if hum then
					hum:UnequipTools()
				end
			end)
		end

		print("[JxSploit] Aura Lights " .. (on and "ON" or "OFF"))
	end

	gui.Destroying:Connect(function()
		auraEnabled = false
		auraToken += 1

		stopWatch()
		stopHold()
	end)

	featureHandlers.auralights = setAura

	addFeature(
		contents.FE,
		"auralights",
		"Aura Lights",
		"Six red lights following your position.",
		2
	)

	featureHandlers.auradelete = function(on)
		auraDelete = on
	end

	addFeature(
		contents.FE,
		"auradelete",
		"Aura: Delete As You Move",
		"ON: move lights one at a time. OFF: leave old lights behind.",
		3
	)

	setFeature("auradelete", true)
end

---------------------------------------------------------------- FEATURES: Kidnap Van (speed-void)
do
	-- Uses whatever vehicle you're ALREADY sitting in (not a spawned Semi/Van -
	-- those are Anchored, dead end, speed can't fix that). Turns Fly Cars on for
	-- you automatically. Once a second real player sits in the same vehicle,
	-- waits 1s then cranks the fly speed absurdly high to try to clip it through
	-- the map/floor. After ~100 studs it deletes the vehicle and teleports you
	-- back to where you started, leaving whoever's still in it behind.

	local BOOST_SPEED = 50000 -- "light speed" - absurdly high to try to tunnel through geometry
	local BOOST_DELAY = 1 -- wait this long after the 2nd person sits before boosting
	local BOOST_DISTANCE = 100 -- studs of boosted travel before cleanup
	local WAIT_TIMEOUT = 60 -- give up if nobody ever gets seated with you

	-- instruction banner: a HUD overlay at the top of the screen (not inside the menu)
	local banner = new("CanvasGroup", {
		Name = "KidnapBanner",
		AnchorPoint = V2(0.5, 0),
		Position = UDim2.fromScale(0.5, 0.06),
		Size = UDim2.fromOffset(460, 64),
		BackgroundTransparency = 1,
		GroupTransparency = 1,
		Visible = false, -- hidden until a message is shown (the outline ignores GroupTransparency)
	}, gui)
	new("UICorner", { CornerRadius = UDim.new(0, 16) }, banner)
	new("UIScale", { Scale = uiScale }, banner)

	local bannerBg = new("Frame", {
		BackgroundColor3 = WHITE,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
	}, banner)
	new("UICorner", { CornerRadius = UDim.new(0, 16) }, bannerBg)
	new("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 36, 95)),
		}),
	}, bannerBg)

	-- thin shining white outline
	local bannerStroke = new("UIStroke", {
		Color = WHITE,
		Thickness = 1,
		Transparency = 0.55,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, banner)
	local shineTween = TweenService:Create(
		bannerStroke,
		TweenInfo.new(1.1, Quad, Enum.EasingDirection.InOut, -1, true),
		{ Transparency = 0.05 }
	)
	shineTween:Play()

	local bannerText = label(
		banner,
		"Spawn ANY vehicle ;)\n(Recommended: Vans, Trucks & Busses)",
		15,
		UDim2.fromScale(0.5, 0.5),
		UDim2.fromScale(0.88, 0.8),
		V2(0.5, 0.5)
	)
	bannerText.TextScaled = true
	new("UITextSizeConstraint", { MaxTextSize = 15, MinTextSize = 10 }, bannerText)

	local function setBanner(text)
		bannerText.Text = text
	end
	local bannerShown = false
	local function showBanner()
		bannerShown = true
		banner.Visible = true
		tw(banner, 0.3, { GroupTransparency = 0 })
	end
	local function hideBanner()
		bannerShown = false
		local fade = tw(banner, 0.3, { GroupTransparency = 1 })
		fade.Completed:Connect(function()
			if not bannerShown then
				banner.Visible = false
			end
		end)
	end

	local running = false

	local function vehicleOf(seat)
		return seat and seat:FindFirstAncestorOfClass("Model")
	end

	local function otherRiderSeated(myVehicle)
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= lp then
				local c = plr.Character
				local h = c and c:FindFirstChildOfClass("Humanoid")
				local seat = h and h.SeatPart
				if seat and vehicleOf(seat) == myVehicle then
					return true
				end
			end
		end
		return false
	end

	local function run()
		if running then
			return
		end
		running = true

		local success, err = pcall(function()
			local char = lp.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if not (hrp and hum) then
				return
			end
			local startCFrame = hrp.CFrame

			local flyWasOn = featureState.flycars == true
			if not flyWasOn then
				setFeature("flycars", true)
			end

			showBanner()
			print("[JxSploit] Kidnap Van: get in a vehicle - waiting for someone to join you...")
			setBanner("You have 1 Minute to kidnap someone :3, make them seated in order to kill")
			local t0 = os.clock()
			local seat, vehicle
			repeat
				task.wait(0.1)
				seat = hum.SeatPart
				vehicle = seat and (seat:IsA("VehicleSeat") or seat:IsA("Seat")) and vehicleOf(seat)
			until (seat and vehicle and otherRiderSeated(vehicle)) or os.clock() - t0 > WAIT_TIMEOUT

			if not (seat and vehicle) then
				print("[JxSploit] Kidnap Van: timed out waiting")
				if not flyWasOn then
					setFeature("flycars", false)
				end
				return
			end
			if not otherRiderSeated(vehicle) then
				print("[JxSploit] Kidnap Van: nobody joined in time")
				if not flyWasOn then
					setFeature("flycars", false)
				end
				return
			end

			print("[JxSploit] Kidnap Van: someone's in - boosting in " .. BOOST_DELAY .. "s")
			setBanner("Unfortunately, we're not gonna give them free wifi, we will give them free death tho >:D!")
			task.wait(BOOST_DELAY)

			local root = seat.AssemblyRootPart or seat
			if root.Anchored then
				print("[JxSploit] Kidnap Van: this vehicle is Anchored too - can't boost it")
				if not flyWasOn then
					setFeature("flycars", false)
				end
				return
			end

			local oldSpeed = FLY_SPEED
			FLY_SPEED = BOOST_SPEED
			local burstStart = root.Position

			local bt0 = os.clock()
			while root.Parent and hum.SeatPart == seat and os.clock() - bt0 < 6 do
				if (root.Position - burstStart).Magnitude >= BOOST_DISTANCE then
					break
				end
				task.wait()
			end

			FLY_SPEED = oldSpeed

			-- get yourself out and back home before cleaning up the vehicle
			pcall(function()
				hum.Sit = false
			end)
			task.wait(0.15)
			if hrp.Parent then
				pcall(function()
					hrp.AssemblyLinearVelocity = Vector3.zero
					hrp.CFrame = startCFrame
				end)
			end

			if vehicle.Parent then
				local RS = game:GetService("ReplicatedStorage")
				local re = RS:FindFirstChild("RE")
				local car = re and re:FindFirstChild("1Ca1r")
				if car then
					pcall(function()
						car:FireServer("DeleteAllVehicles")
					end)
				end
				task.wait(0.2)
				if vehicle.Parent then
					pcall(function()
						vehicle:Destroy()
					end)
				end
			end

			if not flyWasOn then
				setFeature("flycars", false)
			end
		end)
		if not success then
			warn("[JxSploit] Kidnap Van error:", err)
		end

		setBanner("Spawn ANY vehicle ;)\n(Recommended: Vans, Trucks & Busses)")
		hideBanner()
		running = false
		setFeature("kidnapvan", false)
		print("[JxSploit] Kidnap Van finished")
	end

	gui.Destroying:Connect(function()
		running = false
	end)

	featureHandlers.kidnapvan = function(on)
		if on then
			if running then
				return
			end
			task.spawn(run)
		else
			running = false
		end
	end
	addFeature(contents.TROLL, "kidnapvan", "KIDNAP VAN >:)", "Free wifi!", 3)
end

---------------------------------------------------------------- toggle
UIS.InputBegan:Connect(function(i, gpe)
	if not gpe and i.KeyCode == Enum.KeyCode.RightShift then
		gui.Enabled = not gui.Enabled
	end
end)

---------------------------------------------------------------- intro sequence
task.spawn(function()
	local sc = splash.S
	sc.Scale = uiScale * 0.88
	sTitle.TextTransparency = 1
	sTitle.Position = UDim2.fromScale(0.5, 0.46)

	-- panel pops in
	tw(splash, 0.7, { GroupTransparency = 0 })
	tw(sc, 1.0, { Scale = uiScale })
	-- title slides up, line draws out, subtitle follows
	tw(sTitle, 0.9, { TextTransparency = 0, Position = UDim2.fromScale(0.5, 0.41) }, Quint, Out, 0.15)
	tw(sLine, 1.0, { Size = UDim2.new(0.7, 0, 0, 2) }, Quint, Out, 0.35)
	task.wait(0.7)
	showSub("by Jaxen", true)
	task.wait(2.2)

	-- swap to a random message
	hideSub()
	task.wait(0.35)
	showSub(messages[math.random(#messages)], false)
	task.wait(2.9)

	-- splash leaves
	tw(splash, 0.55, { GroupTransparency = 1 }, Quint, In)
	tw(sc, 0.55, { Scale = uiScale * 1.07 }, Quint, In)
	task.wait(0.6)
	splash:Destroy()

	-- menu enters
	local msc = menu.S
	msc.Scale = uiScale * 0.9
	menu.Visible = true
	mTitle.TextTransparency = 1
	mTitle.Position = UDim2.fromScale(0.075, 0.16)
	for _, r in ipairs(rows) do
		r.GroupTransparency = 1
		r.Position = r.Position - UDim2.fromScale(0.08, 0)
	end

	tw(menu, 0.6, { GroupTransparency = 0 })
	tw(msc, 0.9, { Scale = uiScale })
	tw(mTitle, 0.8, { TextTransparency = 0, Position = UDim2.fromScale(0.075, 0.13) }, Quint, Out, 0.1)
	tw(mLine, 0.9, { Size = UDim2.new(0.645, 0, 0, 2) }, Quint, Out, 0.25)
	for i, r in ipairs(rows) do
		tw(r, 0.7, {
			GroupTransparency = 0,
			Position = r.Position + UDim2.fromScale(0.08, 0),
		}, Quint, Out, 0.3 + 0.09 * (i - 1))
	end
end)

--[[
	JxSploit UI by Jaxen  (v3)
	Splash -> main menu (FE shit / TROLL / MISC)
	Category pages are empty: add your own buttons inside the Content frames.
	RightShift hides/shows the UI.
]]

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
	"Oxide? More like Ox-ide-n't :D",
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

-- category buttons: rectangular, blue bevel on top, dark navy body
local rows = {}
local function categoryButton(text, key, shownName, index)
	makeContent(key)
	local baseY = 0.252 + (index - 1) * 0.1765
	local row = new("CanvasGroup", {
		BackgroundTransparency = 1,
		AnchorPoint = V2(0.5, 0.5),
		Position = UDim2.fromScale(0.078 + 0.4135, baseY + 0.087),
		Size = UDim2.fromScale(0.827, 0.174),
	}, home)
	local rs = new("UIScale", { Scale = 1 }, row)

	local body = new("Frame", { BackgroundColor3 = WHITE, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1) }, row)
	new("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 58, 118)),
			ColorSequenceKeypoint.new(0.22, Color3.fromRGB(2, 9, 24)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(1, 5, 15)),
		}),
	}, body)
	-- right-side shadow like the reference
	new("Frame", {
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		AnchorPoint = V2(1, 0),
		Position = UDim2.fromScale(1, 0),
		Size = UDim2.new(0.03, 0, 1, 0),
	}, row)
	-- hover highlight
	local hl = new("Frame", {
		BackgroundColor3 = Color3.fromRGB(70, 140, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
	}, row)

	local b = new("TextButton", {
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = math.floor(MH * 0.125),
		TextColor3 = WHITE,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false,
		Size = UDim2.fromScale(1, 1),
	}, row)
	new("UIPadding", { PaddingLeft = UDim.new(0.03, 0) }, b)

	b.MouseEnter:Connect(function()
		tw(hl, 0.25, { BackgroundTransparency = 0.84 })
	end)
	b.MouseLeave:Connect(function()
		tw(hl, 0.25, { BackgroundTransparency = 1 })
		tw(rs, 0.2, { Scale = 1 })
	end)
	b.MouseButton1Down:Connect(function()
		tw(rs, 0.12, { Scale = 0.97 })
	end)
	b.MouseButton1Up:Connect(function()
		tw(rs, 0.25, { Scale = 1 }, Enum.EasingStyle.Back)
	end)
	b.MouseButton1Click:Connect(function()
		goPage(key, shownName)
	end)

	rows[#rows + 1] = row
end

categoryButton("FE shit", "FE", "FE", 1)
categoryButton("TROLL", "TROLL", "TROLL", 2)
categoryButton("MISC", "MISC", "MISC", 3)

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

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
	BackgroundColor3 = Color3.fromRGB(0, 12, 30),
	BackgroundTransparency = 0.3,
	AnchorPoint = V2(0, 1),
	Position = UDim2.new(0, 70, 1, -18),
	Size = UDim2.fromOffset(150, 150),
	Active = true,
}, flyUI)
new("UICorner", { CornerRadius = UDim.new(0.5, 0) }, joyBase)
new("UIStroke", { Color = BLUE, Thickness = 2, Transparency = 0.4 }, joyBase)
local joyThumb = new("Frame", {
	BackgroundColor3 = BLUE,
	BackgroundTransparency = 0.15,
	AnchorPoint = V2(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(62, 62),
}, joyBase)
new("UICorner", { CornerRadius = UDim.new(0.5, 0) }, joyThumb)
local joyJ = label(joyThumb, "J", 34, UDim2.fromScale(0.5, 0.5), UDim2.fromScale(1, 1), V2(0.5, 0.5))
joyJ.TextTransparency = 0.05

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
end
joyBase.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
		joyInput = i
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

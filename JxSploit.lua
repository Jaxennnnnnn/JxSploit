--[[
	JxSploit UI by Jaxen  (v2)
	Splash screen -> main menu (FE shit / TROLL / MISC)
	Category pages are empty: add your own buttons inside the Content frames.
	RightShift hides/shows the UI.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
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
local BLUE = Color3.fromRGB(45, 110, 255)

-- shrink the UI on small phone screens
local cam = workspace.CurrentCamera
local uiScale = cam and math.clamp(cam.ViewportSize.Y / 650, 0.6, 1) or 1

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props) do
		o[k] = v
	end
	o.Parent = parent
	return o
end

local function tween(o, t, props)
	local tw = TweenService:Create(o, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function label(parent, text, size, pos, sz, anchor)
	return new("TextLabel", {
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = size,
		TextColor3 = WHITE,
		TextWrapped = true,
		AnchorPoint = anchor or Vector2.new(0, 0),
		Position = pos,
		Size = sz,
	}, parent)
end

local function line(parent, pos, sz, anchor)
	return new("Frame", {
		BackgroundColor3 = BLUE,
		BorderSizePixel = 0,
		AnchorPoint = anchor or Vector2.new(0, 0),
		Position = pos,
		Size = sz,
	}, parent)
end

-- Panel = invisible CanvasGroup (handles fade + rounded clipping)
--         + background frame with the gradient (ONLY the background gets the gradient)
--         + blue glow frames. Content goes on top as normal children.
local function makePanel(name, w, h)
	local p = new("CanvasGroup", {
		Name = name,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(w, h),
		BackgroundTransparency = 1,
		GroupTransparency = 1,
	}, gui)
	new("UICorner", { CornerRadius = UDim.new(0, 34) }, p)
	new("UIScale", { Scale = uiScale }, p)

	local bg = new("Frame", {
		Name = "Bg",
		BackgroundColor3 = WHITE,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 0,
	}, p)
	new("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 20, 48)),
	}, bg)

	-- top-left glow
	local g1 = new("Frame", {
		BackgroundColor3 = Color3.fromRGB(20, 90, 255),
		BorderSizePixel = 0,
		Size = UDim2.fromScale(0.35, 0.32),
		ZIndex = 0,
	}, p)
	new("UIGradient", {
		Rotation = 45,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.25),
			NumberSequenceKeypoint.new(1, 1),
		}),
	}, g1)

	-- right edge glow
	local g2 = new("Frame", {
		BackgroundColor3 = Color3.fromRGB(0, 70, 190),
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.fromScale(1, 0),
		Size = UDim2.fromScale(0.2, 1),
		ZIndex = 0,
	}, p)
	new("UIGradient", {
		Rotation = 0,
		Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(1, 0.45),
		}),
	}, g2)

	return p
end

---------------------------------------------------------------- splash
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

local splash = makePanel("Splash", 420, 220)

label(splash, "JxSploit", 54, UDim2.fromScale(0.5, 0.36), UDim2.fromScale(0.9, 0.3), Vector2.new(0.5, 0.5))
line(splash, UDim2.fromScale(0.5, 0.56), UDim2.new(0.7, 0, 0, 2), Vector2.new(0.5, 0.5))

local sub = label(splash, "", 20, UDim2.fromScale(0.5, 0.74), UDim2.fromScale(0.86, 0.3), Vector2.new(0.5, 0.5))
local sideL = line(splash, UDim2.fromScale(0.05, 0.74), UDim2.new(0.25, 0, 0, 2), Vector2.new(0, 0.5))
local sideR = line(splash, UDim2.fromScale(0.95, 0.74), UDim2.new(0.25, 0, 0, 2), Vector2.new(1, 0.5))

local function setSub(text, flanked)
	sub.Text = text
	sideL.Visible = flanked
	sideR.Visible = flanked
	sub.Size = flanked and UDim2.fromScale(0.3, 0.3) or UDim2.fromScale(0.86, 0.3)
end

---------------------------------------------------------------- menu
local menu = makePanel("Menu", 340, 300)
menu.Visible = false

-- drag handle (top strip)
local handle = new("Frame", {
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 0, 66),
	Active = true,
}, menu)

do
	local dragging, startInput, startPos
	handle.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startInput = i.Position
			startPos = menu.Position
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
			menu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
		end
	end)
end

local title = label(menu, "JxSploit", 34, UDim2.fromOffset(22, 14), UDim2.fromOffset(220, 40))
title.TextXAlignment = Enum.TextXAlignment.Left
line(menu, UDim2.fromOffset(22, 62), UDim2.new(0.75, 0, 0, 2))

-- main category list
local home = new("Frame", {
	BackgroundTransparency = 1,
	Position = UDim2.fromOffset(22, 80),
	Size = UDim2.new(1, -44, 1, -100),
}, menu)
new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, home)

-- category page
local page = new("Frame", {
	BackgroundTransparency = 1,
	Position = UDim2.fromOffset(22, 70),
	Size = UDim2.new(1, -44, 1, -90),
	Visible = false,
}, menu)

local pageTitle = label(page, "", 26, UDim2.fromOffset(0, 0), UDim2.new(1, -90, 0, 36))
pageTitle.TextXAlignment = Enum.TextXAlignment.Left

local back = new("TextButton", {
	Text = "< Back",
	Font = Enum.Font.GothamBold,
	TextSize = 16,
	TextColor3 = WHITE,
	BackgroundColor3 = Color3.fromRGB(12, 36, 90),
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, 0, 0, 3),
	Size = UDim2.fromOffset(78, 30),
	AutoButtonColor = true,
}, page)
new("UICorner", { CornerRadius = UDim.new(0, 8) }, back)

local contents = {}
local function makeContent(key)
	local c = new("ScrollingFrame", {
		Name = key .. "Content",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(0, 44),
		Size = UDim2.new(1, 0, 1, -44),
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

local function openPage(key, shownName)
	home.Visible = false
	page.Visible = true
	pageTitle.Text = shownName
	for k, c in pairs(contents) do
		c.Visible = (k == key)
	end
end

back.MouseButton1Click:Connect(function()
	page.Visible = false
	home.Visible = true
end)

local NORMAL = ColorSequence.new(Color3.fromRGB(35, 85, 175), Color3.fromRGB(3, 12, 32))
local HOVER = ColorSequence.new(Color3.fromRGB(55, 115, 215), Color3.fromRGB(6, 20, 50))

local function categoryButton(text, key, shownName, order)
	makeContent(key)

	-- row = gradient background only; the text lives in a separate button on top
	local row = new("Frame", {
		BackgroundColor3 = WHITE,
		BorderSizePixel = 0,
		LayoutOrder = order,
		Size = UDim2.new(1, 0, 0, 56),
	}, home)
	new("UICorner", { CornerRadius = UDim.new(0, 8) }, row)
	local g = new("UIGradient", { Rotation = 90, Color = NORMAL }, row)
	new("UIStroke", { Color = Color3.fromRGB(40, 100, 220), Thickness = 1, Transparency = 0.5 }, row)

	local b = new("TextButton", {
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamBold,
		TextSize = 24,
		TextColor3 = WHITE,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutoButtonColor = false,
		Size = UDim2.fromScale(1, 1),
	}, row)
	new("UIPadding", { PaddingLeft = UDim.new(0, 16) }, b)

	b.MouseEnter:Connect(function()
		g.Color = HOVER
	end)
	b.MouseLeave:Connect(function()
		g.Color = NORMAL
	end)
	b.MouseButton1Click:Connect(function()
		openPage(key, shownName)
	end)
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
	setSub("by Jaxen", true)
	tween(splash, 0.5, { GroupTransparency = 0 })
	task.wait(1.8)

	tween(splash, 0.3, { GroupTransparency = 0.6 }).Completed:Wait()
	setSub(messages[math.random(#messages)], false)
	tween(splash, 0.3, { GroupTransparency = 0 })
	task.wait(2.6)

	tween(splash, 0.5, { GroupTransparency = 1 }).Completed:Wait()
	splash:Destroy()

	menu.Visible = true
	tween(menu, 0.5, { GroupTransparency = 0 })
end)

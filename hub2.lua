-- FABIXX HUB | Finalny Skrypt

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Ustawienia kosy Butterfly
local MESH_ID = "rbxassetid://74868690845752"
local TEXTURE_ID = "rbxassetid://88812690352277"

-- Czyszczenie starych instancji
if CoreGui:FindFirstChild("FabixxHubFull") then CoreGui.FabixxHubFull:Destroy() end
if workspace:FindFirstChild("CS2_Butterfly_Model") then workspace.CS2_Butterfly_Model:Destroy() end

---------------------------------------------------------
-- 1. EKRAN ŁADOWANIA (FULLSCREEN LOADING)
---------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FabixxHubFull"
ScreenGui.ResetOnSpawn = false

local success, _ = pcall(function() ScreenGui.Parent = CoreGui end)
if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.ZIndex = 100
LoadingFrame.Parent = ScreenGui

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Size = UDim2.new(1, 0, 0, 50)
LoadingTitle.Position = UDim2.new(0, 0, 0.4, -40)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "FABIXX HUB"
LoadingTitle.TextColor3 = Color3.fromRGB(255, 140, 0)
LoadingTitle.TextSize = 32
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.ZIndex = 101
LoadingTitle.Parent = LoadingFrame

local LoadingSub = Instance.new("TextLabel")
LoadingSub.Size = UDim2.new(1, 0, 0, 20)
LoadingSub.Position = UDim2.new(0, 0, 0.4, 15)
LoadingSub.BackgroundTransparency = 1
LoadingSub.Text = "Ładowanie skryptów i zasobów..."
LoadingSub.TextColor3 = Color3.fromRGB(180, 180, 200)
LoadingSub.TextSize = 14
LoadingSub.Font = Enum.Font.Gotham
LoadingSub.ZIndex = 101
LoadingSub.Parent = LoadingFrame

-- Pasek ładowania
local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 300, 0, 8)
BarBg.Position = UDim2.new(0.5, -150, 0.4, 55)
BarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
BarBg.BorderSizePixel = 0
BarBg.ZIndex = 101
BarBg.Parent = LoadingFrame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(0, 4)
BarBgCorner.Parent = BarBg

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
BarFill.BorderSizePixel = 0
BarFill.ZIndex = 102
BarFill.Parent = BarBg

local BarFillCorner = Instance.new("UICorner")
BarFillCorner.CornerRadius = UDim.new(0, 4)
BarFillCorner.Parent = BarFill

---------------------------------------------------------
-- 2. GŁÓWNE OKNO GUI (WIĘKSZE & ZWIJANE)
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 340)
MainFrame.Position = UDim2.new(0.5, -260, 0.4, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 140, 0)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Pasek górny
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -70, 1, 0)
TitleText.Position = UDim2.new(0, 14, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "FABIXX HUB <font color=\"#FF8C00\">| Script Menu</font>"
TitleText.RichText = true
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 14
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Przycisk Zamknij (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -32, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Przycisk Zwijania (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
MinimizeBtn.Position = UDim2.new(1, -64, 0, 6)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 12
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	if isMinimized then
		TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 38)}):Play()
		MinimizeBtn.Text = "+"
	else
		TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 340)}):Play()
		MinimizeBtn.Text = "—"
	end
end)

---------------------------------------------------------
-- TWORZENIE SEKCJI (ZAKŁADKI I PRZYCISKI)
---------------------------------------------------------
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 130, 1, -48)
TabBar.Position = UDim2.new(0, 6, 0, 42)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 8)
TabCorner.Parent = TabBar

local ContentContainer = Instance.new("Frame")
ContentContainer.Size = UDim2.new(1, -150, 1, -48)
ContentContainer.Position = UDim2.new(0, 142, 0, 42)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

local cs2Page = Instance.new("Folder")
cs2Page.Parent = ContentContainer

local playerPage = Instance.new("Folder")
playerPage.Parent = ContentContainer

local function showCS2()
	for _, v in ipairs(cs2Page:GetChildren()) do v.Visible = true end
	for _, v in ipairs(playerPage:GetChildren()) do v.Visible = false end
end

local function showPlayer()
	for _, v in ipairs(cs2Page:GetChildren()) do v.Visible = false end
	for _, v in ipairs(playerPage:GetChildren()) do v.Visible = true end
end

local cs2TabBtn = Instance.new("TextButton")
cs2TabBtn.Size = UDim2.new(0.9, 0, 0, 36)
cs2TabBtn.Position = UDim2.new(0.05, 0, 0, 10)
cs2TabBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
cs2TabBtn.Text = "Wizualne / CS2"
cs2TabBtn.TextColor3 = Color3.fromRGB(15, 15, 20)
cs2TabBtn.TextSize = 12
cs2TabBtn.Font = Enum.Font.GothamBold
cs2TabBtn.Parent = TabBar

local t1c = Instance.new("UICorner")
t1c.CornerRadius = UDim.new(0, 6)
t1c.Parent = cs2TabBtn

local playerTabBtn = Instance.new("TextButton")
playerTabBtn.Size = UDim2.new(0.9, 0, 0, 36)
playerTabBtn.Position = UDim2.new(0.05, 0, 0, 52)
playerTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
playerTabBtn.Text = "Postać"
playerTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
playerTabBtn.TextSize = 12
playerTabBtn.Font = Enum.Font.GothamSemibold
playerTabBtn.Parent = TabBar

local t2c = Instance.new("UICorner")
t2c.CornerRadius = UDim.new(0, 6)
t2c.Parent = playerTabBtn

cs2TabBtn.MouseButton1Click:Connect(function()
	cs2TabBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
	cs2TabBtn.TextColor3 = Color3.fromRGB(15, 15, 20)
	playerTabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
	playerTabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
	showCS2()
end)

playerTabBtn.MouseButton1Click:Connect(function()
	playerTabBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
	playerTabBtn.TextColor3 = Color3.fromRGB(15, 15, 20)
	cs2TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
	cs2TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
	showPlayer()
end)

---------------------------------------------------------
-- ZAWARTOŚĆ ZAKŁADKI CS2
---------------------------------------------------------
local toggleCS2Btn = Instance.new("TextButton")
toggleCS2Btn.Size = UDim2.new(0.96, 0, 0, 42)
toggleCS2Btn.Position = UDim2.new(0.02, 0, 0, 10)
toggleCS2Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
toggleCS2Btn.Text = "Butterfly (VISUAL)"
toggleCS2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleCS2Btn.TextSize = 13
toggleCS2Btn.Font = Enum.Font.GothamBold
toggleCS2Btn.Visible = true
toggleCS2Btn.Parent = cs2Page

local c3 = Instance.new("UICorner")
c3.CornerRadius = UDim.new(0, 8)
c3.Parent = toggleCS2Btn

---------------------------------------------------------
-- ZAWARTOŚĆ ZAKŁADKI POSTAĆ
---------------------------------------------------------
local function createPlayerButton(name, posY)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.96, 0, 0, 40)
	btn.Position = UDim2.new(0.02, 0, 0, posY)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 13
	btn.Font = Enum.Font.GothamSemibold
	btn.Visible = false
	btn.Parent = playerPage
	
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = btn
	return btn
end

local speedBtn = createPlayerButton("Szybkość (Speed: 50)", 10)
local flyBtn = createPlayerButton("Fly: WYŁĄCZONY", 58)
local noclipBtn = createPlayerButton("Noclip: WYŁĄCZONY", 106)
local spinBtn = createPlayerButton("Spinbot: WYŁĄCZONY", 154)

---------------------------------------------------------
-- ANIMACJA PASKU ŁADOWANIA (LOADING)
---------------------------------------------------------
task.spawn(function()
	TweenService:Create(BarFill, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()
	task.wait(1.3)
	TweenService:Create(LoadingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
	TweenService:Create(LoadingTitle, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	TweenService:Create(LoadingSub, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
	TweenService:Create(BarBg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
	TweenService:Create(BarFill, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
	task.wait(0.5)
	LoadingFrame:Destroy()
	MainFrame.Visible = true
end)

---------------------------------------------------------
-- LOGIKA FUNKCJI (Skrypty)
---------------------------------------------------------
speedBtn.MouseButton1Click:Connect(function()
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.WalkSpeed = 50
	end
end)

-- Fly (Płynne sterowanie kamerą)
local flying = false
local flySpeed = 50
local bv = nil
local bg = nil

flyBtn.MouseButton1Click:Connect(function()
	flying = not flying
	local char = LocalPlayer.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then return end
	
	local root = char.HumanoidRootPart
	local hum = char.Humanoid
	
	if flying then
		flyBtn.Text = "Fly: WŁĄCZONY"
		flyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
		
		bv = Instance.new("BodyVelocity")
		bv.Name = "FabixxFlyBV"
		bv.MaxForce = Vector3.new(1, 1, 1) * 100000
		bv.Velocity = Vector3.new(0, 0, 0)
		bv.Parent = root
		
		bg = Instance.new("BodyGyro")
		bg.Name = "FabixxFlyBG"
		bg.MaxTorque = Vector3.new(1, 1, 1) * 100000
		bg.CFrame = root.CFrame
		bg.Parent = root
		
		hum.PlatformStand = true
	else
		flyBtn.Text = "Fly: WYŁĄCZONY"
		flyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
		
		if root:FindFirstChild("FabixxFlyBV") then root.FabixxFlyBV:Destroy() end
		if root:FindFirstChild("FabixxFlyBG") then root.FabixxFlyBG:Destroy() end
		hum.PlatformStand = false
	end
end)

RunService.RenderStepped:Connect(function()
	if flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local char = LocalPlayer.Character
		local root = char.HumanoidRootPart
		local cam = workspace.CurrentCamera
		
		local currentBV = root:FindFirstChild("FabixxFlyBV")
		local currentBG = root:FindFirstChild("FabixxFlyBG")
		
		if currentBV and currentBG then
			currentBG.CFrame = cam.CFrame
			local moveDirection = Vector3.new(0, 0, 0)
			
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then
				moveDirection = moveDirection + cam.CFrame.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then
				moveDirection = moveDirection - cam.CFrame.LookVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then
				moveDirection = moveDirection - cam.CFrame.RightVector
			end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then
				moveDirection = moveDirection + cam.CFrame.RightVector
			end
			
			currentBV.Velocity = moveDirection * flySpeed
		end
	end
end)

-- Noclip
local noclipActive = false
noclipBtn.MouseButton1Click:Connect(function()
	noclipActive = not noclipActive
	if noclipActive then
		noclipBtn.Text = "Noclip: WŁĄCZONY"
		noclipBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	else
		noclipBtn.Text = "Noclip: WYŁĄCZONY"
		noclipBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
	end
end)

RunService.Stepped:Connect(function()
	if noclipActive and LocalPlayer.Character then
		for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- Spinbot
local spinActive = false
spinBtn.MouseButton1Click:Connect(function()
	spinActive = not spinActive
	if spinActive then
		spinBtn.Text = "Spinbot: WŁĄCZONY"
		spinBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	else
		spinBtn.Text = "Spinbot: WYŁĄCZONY"
		spinBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
	end
end)

RunService.RenderStepped:Connect(function()
	if spinActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local root = LocalPlayer.Character.HumanoidRootPart
		root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(35), 0)
	end
end)

-- CS2 Butterfly Visual
local isCS2Active = false

local knifePart = Instance.new("Part")
knifePart.Name = "CS2_Butterfly_Model"
knifePart.Size = Vector3.new(0.2, 1.2, 0.2)
knifePart.CanCollide = false
knifePart.Anchored = true
knifePart.Transparency = 1
knifePart.Parent = workspace

local knifeMesh = Instance.new("SpecialMesh")
knifeMesh.MeshId = MESH_ID
knifeMesh.TextureId = TEXTURE_ID
knifeMesh.MeshType = Enum.MeshType.FileMesh
knifeMesh.Scale = Vector3.new(1, 1, 1)
knifeMesh.Parent = knifePart

toggleCS2Btn.MouseButton1Click:Connect(function()
	isCS2Active = not isCS2Active
	if isCS2Active then
		toggleCS2Btn.Text = "Butterfly (VISUAL): AKTYWNY"
		toggleCS2Btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	else
		toggleCS2Btn.Text = "Butterfly (VISUAL)"
		toggleCS2Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
		knifePart.Transparency = 1
	end
end)

RunService.RenderStepped:Connect(function()
	if not isCS2Active then return end
	local char = LocalPlayer.Character
	if not char then return end
	
	for _, partName in ipairs({"Right Arm", "Left Arm", "RightLowerArm", "RightUpperArm", "RightHand", "LeftLowerArm", "LeftUpperArm", "LeftHand"}) do
		local arm = char:FindFirstChild(partName)
		if arm and arm:IsA("BasePart") then
			arm.LocalTransparencyModifier = 0
		end
	end

	local tool = char:FindFirstChildOfClass("Tool")
	if tool then
		for _, part in ipairs(tool:GetDescendants()) do
			if part:IsA("BasePart") then
				part.LocalTransparencyModifier = 1
			end
		end

		local rightHand = char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
		if rightHand then
			knifePart.Transparency = 0
			knifePart.CFrame = rightHand.CFrame * CFrame.new(0, -0.8, -0.3) * CFrame.Angles(math.rad(-90), math.rad(180), 0)
		end
	else
		knifePart.Transparency = 1
	end
end)

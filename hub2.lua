-- FABIXX HUB V3 | RGB UI + Speedometer (KM/H) + Advanced Bhop + Viewmodel

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Czyszczenie starych instancji GUI
if CoreGui:FindFirstChild("FabixxHubV3") then CoreGui.FabixxHubV3:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FabixxHubV3"
ScreenGui.ResetOnSpawn = false

local success, _ = pcall(function() ScreenGui.Parent = CoreGui end)
if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

---------------------------------------------------------
-- GŁÓWNE OKNO GUI (RGB STYL)
---------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 480, 0, 320)
MainFrame.Position = UDim2.new(0.5, -240, 0.4, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Tęczowa obramówka (RGB Stroke)
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Pasek górny
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 42)
TitleBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -160, 1, 0)
TitleText.Position = UDim2.new(0, 14, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "FABIXX HUB <font color=\"#00FFCC\">| V3</font>"
TitleText.RichText = true
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 15
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- LICZNIK KM/H NA GÓRZE
local Speedometer = Instance.new("TextLabel")
Speedometer.Size = UDim2.new(0, 100, 0, 26)
Speedometer.Position = UDim2.new(1, -130, 0, 8)
Speedometer.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
Speedometer.Text = "0 KM/H"
Speedometer.TextColor3 = Color3.fromRGB(0, 255, 128)
Speedometer.TextSize = 12
Speedometer.Font = Enum.Font.GothamBold
Speedometer.Parent = TitleBar

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 6)
SpeedCorner.Parent = Speedometer

-- Przycisk Zamknij (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -32, 0, 8)
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

---------------------------------------------------------
-- ZAWARTOŚĆ (PRZYCISKI FUNKCJI)
---------------------------------------------------------
local ContentContainer = Instance.new("ScrollingFrame")
ContentContainer.Size = UDim2.new(1, -20, 1, -58)
ContentContainer.Position = UDim2.new(0, 10, 0, 50)
ContentContainer.BackgroundTransparency = 1
ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 200)
ContentContainer.ScrollBarThickness = 4
ContentContainer.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)
UIList.Parent = ContentContainer

local function createButton(name, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 42)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 13
	btn.Font = Enum.Font.GothamSemibold
	btn.Parent = ContentContainer
	
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = btn
	
	btn.MouseButton1Click:Connect(callback)
	return btn
end

---------------------------------------------------------
-- TĘCZOWY EFEKT RGB (Płynna zmiana barw w kółko)
---------------------------------------------------------
RunService.RenderStepped:Connect(function()
	local hue = tick() % 5 / 5
	local rgbColor = Color3.fromHSV(hue, 1, 1)
	MainStroke.Color = rgbColor
end)

---------------------------------------------------------
-- LICZNIK PRĘDKOŚCI (KM/H) & WIDOCZNE RĘCE
---------------------------------------------------------
RunService.RenderStepped:Connect(function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		local vel = char.HumanoidRootPart.Velocity
		local speed = math.floor(Vector3.new(vel.X, 0, vel.Z).Magnitude)
		-- Przeliczenie jednostek Roblox na fikcyjne km/h
		local kmh = math.floor(speed * 0.6) 
		Speedometer.Text = kmh .. " KM/H"
	end
	
	-- Widoczne ręce (Naprawa przezroczystości narzędzi)
	if char then
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
					part.LocalTransparencyModifier = 0
				end
			end
		end
	end
end)

---------------------------------------------------------
-- IMPLEMENTACJA FUNKCJI
---------------------------------------------------------

-- 1. ADVANCED BUNNY HOP (Z wspinaniem i zachowaniem pędu)
local bhopActive = false
createButton("Bunny Hop (Advanced): WYŁĄCZONY", function(btn)
	bhopActive = not bhopActive
	if bhopActive then
		btn.Text = "Bunny Hop (Advanced): WŁĄCZONY"
		btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	else
		btn.Text = "Bunny Hop (Advanced): WYŁĄCZONY"
		btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
	end
end)

RunService.Heartbeat:Connect(function()
	if not bhopActive then return end
	local char = LocalPlayer.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")
	
	if hum and root then
		-- Sprawdzanie czy gracz trzyma spację i porusza się
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) and hum.MoveDirection.Magnitude > 0 then
			if hum.FloorMaterial ~= Enum.Material.Air then
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
				-- Dodanie dynamicznego przyspieszenia w kierunku ruchu (pozwala "wspinać się" i nabierać prędkości)
				root.Velocity = Vector3.new(hum.MoveDirection.X * 35, root.Velocity.Y + 2, hum.MoveDirection.Z * 35)
			end
		end
	end
end)

-- 2. SZYBKOŚĆ (SPEED 50)
createButton("Zwiększ Szybkość (Speed: 50)", function()
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.WalkSpeed = 50
	end
end)

-- 3. NOCLIP
local noclipActive = false
createButton("Noclip: WYŁĄCZONY", function(btn)
	noclipActive = not noclipActive
	if noclipActive then
		btn.Text = "Noclip: WŁĄCZONY"
		btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
	else
		btn.Text = "Noclip: WYŁĄCZONY"
		btn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
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

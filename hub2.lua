-- FABIXX HUB | Modern GUI + Loading Screen + Dance Emote

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
-- 2. GŁÓWNE OKNO GUI
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

local playerPage = Instance.new

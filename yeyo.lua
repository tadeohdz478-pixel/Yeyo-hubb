-- Servicios
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Personaje
local hrp
local function onChar(char)
	hrp = char:WaitForChild("HumanoidRootPart")
end
onChar(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(onChar)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "YeyoHub"
gui.ResetOnSpawn = false

pcall(function()
	gui.Parent = game:GetService("CoreGui")
end)
if not gui.Parent then
	gui.Parent = player:WaitForChild("PlayerGui")
end

-- Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 170)
frame.Position = UDim2.new(0.1, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.BorderSizePixel = 0
frame.Parent = gui

-- Barra superior
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 32)
topBar.BackgroundColor3 = Color3.fromRGB(15,15,15)
topBar.Parent = frame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 8, 0, 0)
title.BackgroundTransparency = 1
title.Text = "YEYO HUB"
title.TextColor3 = Color3.fromRGB(255,255,0)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Botón minimizar
local mini = Instance.new("TextButton")
mini.Size = UDim2.new(0, 32, 0, 32)
mini.Position = UDim2.new(1, -64, 0, 0)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(40,40,40)
mini.TextColor3 = Color3.new(1,1,1)
mini.Font = Enum.Font.GothamBold
mini.TextSize = 22
mini.Parent = topBar

-- Botón cerrar
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 32, 0, 32)
close.Position = UDim2.new(1, -32, 0, 0)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200,0,0)
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.TextSize = 18
close.Parent = topBar

close.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Botones
local save = Instance.new("TextButton")
save.Size = UDim2.new(1, -20, 0, 40)
save.Position = UDim2.new(0, 10, 0, 50)
save.Text = "SAVE TP"
save.BackgroundColor3 = Color3.fromRGB(255,255,0)
save.TextColor3 = Color3.fromRGB(0,0,0)
save.Font = Enum.Font.GothamBold
save.TextSize = 14
save.Parent = frame

local tp = Instance.new("TextButton")
tp.Size = UDim2.new(1, -20, 0, 40)
tp.Position = UDim2.new(0, 10, 0, 105)
tp.Text = "TP"
tp.BackgroundColor3 = Color3.fromRGB(255,255,0)
tp.TextColor3 = Color3.fromRGB(0,0,0)
tp.Font = Enum.Font.GothamBold
tp.TextSize = 14
tp.Parent = frame

-- Funciones TP
local savedCFrame
save.MouseButton1Click:Connect(function()
	if hrp then
		savedCFrame = hrp.CFrame
		save.Text = "GUARDADO ✔"
		task.wait(1)
		save.Text = "SAVE TP"
	end
end)

tp.MouseButton1Click:Connect(function()
	if savedCFrame and hrp then
		hrp.CFrame = savedCFrame
	end
end)

-- Minimizar
local minimized = false
mini.MouseButton1Click:Connect(function()
	minimized = not minimized
	save.Visible = not minimized
	tp.Visible = not minimized
	frame.Size = minimized and UDim2.new(0,240,0,32) or UDim2.new(0,240,0,170)
end)

-- DRAG MOUSE + TOUCH
local dragging = false
local dragStart, startPos

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

topBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
	or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

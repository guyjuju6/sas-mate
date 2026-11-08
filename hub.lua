--[[
  ____        ____     __  __       _
 / ___|  __ _/ ___|   |  \/  | __ _| |_ ___
 \___ \ / _` \___ \   | |\/| |/ _` | __/ _ \
  ___) | (_| |___) |  | |  | | (_| | ||  __/
 |____/ \__,_|____/   |_|  |_|\__,_|\__\___| V1
                                           
                         a project by JuJu
                                    Nov. 2026,
]]
 
 -- [[ Variables ]]
--
local Players     = game:GetService("Players")
local Lighting    = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Character   = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid    = Character:WaitForChild("Humanoid")
local Camera      = workspace.CurrentCamera


-- [[ Tables ]]
--
local Funcs       = {}
local library


-- [[ Configuration ]]
--
local Config = {

	walkSpeed     = 16,
	jumpPower     = 50,
	infiniteJump  = false,
	zoomDistance  = 140,
	FOV           = 70,
	clearFog      = false,
	globalShadows = true,

}


-- UI Funcs
--
function Funcs:Notify(Title, Message)
	library:Notify(Title, Message)
end

function Funcs:ProgressBar(Title, Steps)
	local Bar = library:ProgressBar(Title, Steps)
	for _ = 1, Steps do
		Bar:Update()
		task.wait(0.1)
	end
end


-- MARK: Player Funcs
--
function Funcs:Walkspeed(Value)
	if not Humanoid or not Humanoid.Parent then
		Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		Humanoid = Character:WaitForChild("Humanoid")
	end
	Humanoid.WalkSpeed = Value
end


function Funcs:JumpPower(Value)
	if not Humanoid or not Humanoid.Parent then
		Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		Humanoid = Character:WaitForChild("Humanoid")
	end
	if not Humanoid.UseJumpPower then
		Humanoid.UseJumpPower = true
	end
	Humanoid.JumpPower = Value
end


function Funcs:ZoomDistance(Value)
	LocalPlayer.CameraMaxZoomDistance = Value
end


function Funcs:FOV(Value)
	Camera = workspace.CurrentCamera
	if Camera then
		Camera.FieldOfView = Value
	end
end


local DefaultFog = {
	FogEnd = Lighting.FogEnd,
	FogStart = Lighting.FogStart,
}


function Funcs:ClearFog(Value)
	if Value then
		Lighting.FogEnd = 1000000
		Lighting.FogStart = 1000000
	else
		Lighting.FogEnd = DefaultFog.FogEnd
		Lighting.FogStart = DefaultFog.FogStart
	end
end


function Funcs:GlobalShadows(Value)
	Lighting.GlobalShadows = Value
end

LocalPlayer.CharacterAdded:Connect(function(Value)
	Character = Value
	Humanoid = Value:WaitForChild("Humanoid")
	Humanoid.WalkSpeed = Config.walkSpeed
	Humanoid.JumpPower = Config.jumpPower
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
	if Config.infiniteJump and Humanoid and Humanoid.Parent then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	Camera = workspace.CurrentCamera
	if Camera then
		Camera.FieldOfView = Config.FOV
	end
end)


-- MARK: UI Init
--
do
	local HttpService = game:GetService("HttpService")
	if typeof(isfolder) == "function" and typeof(makefolder) == "function" then
		if not isfolder("Sas") then
			pcall(makefolder, "Sas")
		end
	end
	if typeof(isfile) == "function" and typeof(writefile) == "function" then
		if not isfile("Sas/Theme.txt") then
			pcall(writefile, "Sas/Theme.txt", HttpService:JSONEncode({
				main = "35, 35, 35",
				secondary = "40, 40, 40",
				accent = "31, 31, 31",
				textcolor = "225, 225, 225",
			}))
		end
	end
end

library = loadstring(game:HttpGet("https://raw.githubusercontent.com/guyjuju6/sas-mate/refs/heads/main/ui-library.lua"))()
local UI = library:Create("Sas Mate", "Lumber Tycoon 2")
local Tab, Section


-- MARK: Player Tab
--
Tab = UI:Tab("Player", "5012544693")

-- [[ Section 1 ]]
--
Section = Tab:Section("Movement")


Section:Slider("Walk Speed", Config.walkSpeed, 16, 100, false, function(Value)
	Config.walkSpeed = Value
	Funcs:Walkspeed(Value)
end)


Section:Slider("Jump Power", Config.jumpPower, 50, 200, false, function(Value)
	Config.jumpPower = Value
	Funcs:JumpPower(Value)
end)


Section:Toggle("Infinite Jump", Config.infiniteJump, function(Value)
	Config.infiniteJump = Value
end)


-- [[ Section 2 ]]
--
Section = Tab:Section("Camera")

Section:Slider("Zoom Distance", Config.zoomDistance, 10, 1000, false, function(Value)
	Config.zoomDistance = Value
	Funcs:ZoomDistance(Value)
end)


Section:Slider("FOV", Config.FOV, 30, 120, false, function(Value)
	Config.FOV = Value
	Funcs:FOV(Value)
end)


Section:Toggle("Clear Fog", Config.clearFog, function(Value)
	Config.clearFog = Value
	Funcs:ClearFog(Value)
end)


Section:Toggle("Global Shadows", Config.globalShadows, function(Value)
	Config.globalShadows = Value
	Funcs:GlobalShadows(Value)
end)

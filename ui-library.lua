local library = {flags = {}, destroyed = false, toggled = true, opentab = nil, currentnoti = nil, tabs = {}}
local mouse = game:GetService"Players".LocalPlayer:GetMouse()

isswitching = false
function SwitchTab(info)
	if isswitching then return end
	if library.opentab == nil then
		info.Visible = true
		library.opentab = info
		return
	end
	isswitching = true
	library.opentab.Visible = false
	info.Visible = true
	library.opentab = info
	isswitching = false
end

function drag(frame, hold) -- Skidded from Kiriot or Wally ~V3rmillion~
	if not hold then
		hold = frame
	end
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	hold.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function library:Create(title, gamename)
    if game:WaitForChild"CoreGui":FindFirstChild"Nightfall" then
        game.CoreGui:FindFirstChild"Nightfall":Destroy()
    end

	local themes = {
		main = "35, 35, 35",
		secondary = "40, 40, 40", 
		accent = "31, 31, 31", 
		textcolor = "225, 225, 225",
	}

	if not isfile("Theme.txt") then
		writefile("Theme.txt", game:GetService("HttpService"):JSONEncode(themes))
	end

	local NewTheme = isfile("Theme.txt") and game:GetService("HttpService"):JSONDecode(readfile("Theme.txt")) or themes

	for i,v in next, NewTheme do
		local split = string.split(v, ',')
		themes[i] = Color3.fromRGB(tonumber(split[1]), tonumber(split[2]), tonumber(split[3]))
	end
    
	local Nightfall = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local MainC = Instance.new("UICorner")
	local Top = Instance.new("Frame")
	local MainC_2 = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local GameTitle = Instance.new("TextLabel")
	local TopBar = Instance.new("Frame")
	local MainC_3 = Instance.new("UICorner")
	local Side = Instance.new("Frame")
	local MainC_4 = Instance.new("UICorner")
	local TabHolder = Instance.new("ScrollingFrame")
	local SideBar = Instance.new("Frame")
	local TabHolderLL = Instance.new("UIListLayout")
	local TabHolderP = Instance.new("UIPadding")

	Nightfall.Name = "Nightfall"
	Nightfall.Parent = game:WaitForChild"CoreGui"... (20 KB left)

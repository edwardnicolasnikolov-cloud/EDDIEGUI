--// EDDIE EXECUTOR-STYLE GUI
--// Tabs: Local, Utility, Overpowered (owner + key-locked)
--// Owner Id:
local OWNER_ID = 9823669849
local KEY_PASSWORD = "eddiegui"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local isOwner = (LocalPlayer.UserId == OWNER_ID)
local opUnlocked = false

----------------------------------------------------------
-- LAUNCHER BUTTON
----------------------------------------------------------
local launcherGui = Instance.new("ScreenGui")
launcherGui.Name = "EddieLauncher"
launcherGui.ResetOnSpawn = false
launcherGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 140, 0, 40)
openBtn.Position = UDim2.new(0, 20, 0.8, 0)
openBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
openBtn.BorderSizePixel = 0
openBtn.Text = "Eddie GUI"
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 16
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Parent = launcherGui

----------------------------------------------------------
-- MAIN EXECUTOR-STYLE WINDOW
----------------------------------------------------------
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "EddieExecutorGUI"
mainGui.ResetOnSpawn = false
mainGui.Enabled = false
mainGui.Parent = LocalPlayer.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 320)
mainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = mainGui

-- top bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 28)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 8, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.Text = "Eddie Executor"
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeMain = Instance.new("TextButton")
closeMain.Size = UDim2.new(0, 28, 1, 0)
closeMain.Position = UDim2.new(1, -30, 0, 0)
closeMain.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
closeMain.BorderSizePixel = 0
closeMain.Font = Enum.Font.GothamBold
closeMain.TextSize = 14
closeMain.Text = "X"
closeMain.TextColor3 = Color3.new(1,1,1)
closeMain.Parent = titleBar

----------------------------------------------------------
-- TABS (TOP BAR)
----------------------------------------------------------
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 26)
tabBar.Position = UDim2.new(0, 0, 0, 28)
tabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
tabBar.BorderSizePixel = 0
tabBar.Parent = mainFrame

local tabs = {"Local", "Utility", "Overpowered"}
local pages = {}
local tabButtons = {}
local currentTab = "Local"

local function createPage(name)
	local page = Instance.new("Frame")
	page.Size = UDim2.new(1, -20, 1, -64)
	page.Position = UDim2.new(0, 10, 0, 54)
	page.BackgroundColor3 = Color3.fromRGB(20,20,20)
	page.BorderSizePixel = 0
	page.Visible = false
	page.Parent = mainFrame
	pages[name] = page
	return page
end

local function setTab(name)
	currentTab = name
	for n, page in pairs(pages) do
		page.Visible = (n == name)
	end
	for n,btn in pairs(tabButtons) do
		btn.BackgroundColor3 = (n == name) and Color3.fromRGB(40,40,40) or Color3.fromRGB(25,25,25)
	end
end

for i, name in ipairs(tabs) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 120, 1, 0)
	btn.Position = UDim2.new(0, 10 + (i-1)*125, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	btn.BorderSizePixel = 0
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.Text = name
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Parent = tabBar
	tabButtons[name] = btn

	createPage(name)
end

setTab("Local")

----------------------------------------------------------
-- SIMPLE CONSOLE-LIKE LAYOUT PER PAGE
----------------------------------------------------------
local function addConsoleLayout(page, helpText)
	local help = Instance.new("TextLabel")
	help.Size = UDim2.new(1, 0, 0, 36)
	help.Position = UDim2.new(0, 0, 0, 0)
	help.BackgroundTransparency = 1
	help.Font = Enum.Font.Gotham
	help.TextSize = 14
	help.TextWrapped = true
	help.TextColor3 = Color3.fromRGB(220,220,220)
	help.TextXAlignment = Enum.TextXAlignment.Left
	help.TextYAlignment = Enum.TextYAlignment.Top
	help.Text = helpText
	help.Parent = page

	local inputBox = Instance.new("TextBox")
	inputBox.Size = UDim2.new(1, -110, 0, 34)
	inputBox.Position = UDim2.new(0, 0, 0, 40)
	inputBox.BackgroundColor3 = Color3.fromRGB(15,15,15)
	inputBox.BorderSizePixel = 0
	inputBox.Font = Enum.Font.Code
	inputBox.TextSize = 14
	inputBox.TextColor3 = Color3.new(1,1,1)
	inputBox.ClearTextOnFocus = false
	inputBox.PlaceholderText = "type a command here..."
	inputBox.Parent = page

	local execBtn = Instance.new("TextButton")
	execBtn.Size = UDim2.new(0, 100, 0, 34)
	execBtn.Position = UDim2.new(1, -100, 0, 40)
	execBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
	execBtn.BorderSizePixel = 0
	execBtn.Font = Enum.Font.GothamBold
	execBtn.TextSize = 14
	execBtn.TextColor3 = Color3.new(1,1,1)
	execBtn.Text = "Execute"
	execBtn.Parent = page

	local output = Instance.new("TextLabel")
	output.Size = UDim2.new(1, 0, 1, -84)
	output.Position = UDim2.new(0, 0, 0, 80)
	output.BackgroundColor3 = Color3.fromRGB(10,10,10)
	output.BorderSizePixel = 0
	output.Font = Enum.Font.Code
	output.TextSize = 13
	output.TextColor3 = Color3.fromRGB(200,200,200)
	output.TextXAlignment = Enum.TextXAlignment.Left
	output.TextYAlignment = Enum.TextYAlignment.Top
	output.TextWrapped = true
	output.Text = "Output:\n"
	output.Parent = page

	return inputBox, execBtn, output
end

local localPage = pages["Local"]
local utilPage  = pages["Utility"]
local opPage    = pages["Overpowered"]

local localBox, localExec, localOut = addConsoleLayout(localPage,
	"Local commands (everyone): speed <n>, jump <n>, fly, noclip, reset")
local utilBox, utilExec, utilOut   = addConsoleLayout(utilPage,
	"Utility commands (everyone): esp, unesp, fullbright, xray")
local opBox, opExec, opOut         = addConsoleLayout(opPage,
	"Overpowered (owner + key only): god, ungod, killaura, stopkillaura, fling")

----------------------------------------------------------
-- RAINBOW TEXT ON TAB LABELS (EXECUTOR VIBE)
----------------------------------------------------------
task.spawn(function()
	while true do
		for h=0,255,4 do
			local c = Color3.fromHSV(h/255,1,1)
			for _,btn in pairs(tabButtons) do
				btn.TextColor3 = c
			end
			task.wait(0.02)
		end
	end
end)

----------------------------------------------------------
-- KEY SYSTEM POPUP (FOR OVERPOWERED TAB)
----------------------------------------------------------
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 280, 0, 150)
keyFrame.Position = UDim2.new(0.5, -140, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(12,12,12)
keyFrame.BorderSizePixel = 0
keyFrame.Visible = false
keyFrame.Parent = mainGui

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 30)
keyTitle.BackgroundColor3 = Color3.fromRGB(20,20,20)
keyTitle.BorderSizePixel = 0
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 15
keyTitle.Text = "Overpowered Key"
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -20, 0, 30)
keyBox.Position = UDim2.new(0, 10, 0, 40)
keyBox.BackgroundColor3 = Color3.fromRGB(18,18,18)
keyBox.BorderSizePixel = 0
keyBox.Font = Enum.Font.Code
keyBox.TextSize = 14
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.PlaceholderText = "enter key..."
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyFrame

local checkBtn = Instance.new("TextButton")
checkBtn.Size = UDim2.new(0.5, -15, 0, 28)
checkBtn.Position = UDim2.new(0, 10, 0, 80)
checkBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
checkBtn.BorderSizePixel = 0
checkBtn.Font = Enum.Font.GothamBold
checkBtn.TextSize = 13
checkBtn.Text = "Check Key"
checkBtn.TextColor3 = Color3.new(1,1,1)
checkBtn.Parent = keyFrame

local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0.5, -15, 0, 28)
verifyBtn.Position = UDim2.new(0.5, 5, 0, 80)
verifyBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
verifyBtn.BorderSizePixel = 0
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 13
verifyBtn.Text = "Verify Key"
verifyBtn.TextColor3 = Color3.new(1,1,1)
verifyBtn.Parent = keyFrame

local keyStatus = Instance.new("TextLabel")
keyStatus.Size = UDim2.new(1, -20, 0, 26)
keyStatus.Position = UDim2.new(0, 10, 0, 115)
keyStatus.BackgroundTransparency = 1
keyStatus.Font = Enum.Font.Gotham
keyStatus.TextSize = 13
keyStatus.TextColor3 = Color3.fromRGB(230,230,230)
keyStatus.Text = "Owner-only access."
keyStatus.Parent = keyFrame

checkBtn.MouseButton1Click:Connect(function()
	if keyBox.Text == KEY_PASSWORD then
		keyStatus.Text = "Key looks correct."
	else
		keyStatus.Text = "Wrong key."
	end
end)

verifyBtn.MouseButton1Click:Connect(function()
	if not isOwner then
		keyStatus.Text = "You are not the owner."
		return
	end

	if keyBox.Text == KEY_PASSWORD then
		opUnlocked = true
		keyStatus.Text = "Key verified. Overpowered unlocked."
		task.delay(0.8, function()
			keyFrame.Visible = false
			setTab("Overpowered")
		end)
	else
		keyStatus.Text = "Verification failed."
	end
end)

----------------------------------------------------------
-- TAB BUTTON CLICK LOGIC (WITH OP LOCK)
----------------------------------------------------------
for name,btn in pairs(tabButtons) do
	btn.MouseButton1Click:Connect(function()
		if name == "Overpowered" then
			if not isOwner then
				-- not owner: can't use
				opOut.Text = "Output:\nThis tab is owner-only."
				setTab("Local")
				return
			end
			if not opUnlocked then
				keyBox.Text = ""
				keyStatus.Text = "Owner-only. Enter key."
				keyFrame.Visible = true
				return
			end
		end
		setTab(name)
	end)
end

----------------------------------------------------------
-- LOCAL / UTILITY / OP COMMAND IMPLEMENTATION
----------------------------------------------------------
local flyOn = false
local noclipOn = false
local killauraOn = false

local function getHumanoid()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	return char:FindFirstChildOfClass("Humanoid")
end

local function getHRP()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	return char:WaitForChild("HumanoidRootPart")
end

-- Fly & Noclip loops
RunService.RenderStepped:Connect(function()
	if flyOn then
		local hrp = getHRP()
		local move = Vector3.zero
		local cf = Camera.CFrame

		if UIS:IsKeyDown(Enum.KeyCode.W) then move += cf.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cf.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cf.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then move += cf.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end

		hrp.CFrame = hrp.CFrame + move * 1.8
	end
end)

RunService.Stepped:Connect(function()
	if noclipOn then
		local char = LocalPlayer.Character
		if char then
			for _,p in ipairs(char:GetChildren()) do
				if p:IsA("BasePart") then
					p.CanCollide = false
				end
			end
		end
	end
end)

-- Kill aura
RunService.Heartbeat:Connect(function()
	if not killauraOn then return end

	local myChar = LocalPlayer.Character
	if not myChar then return end
	local myHRP = myChar:FindFirstChild("HumanoidRootPart")
	if not myHRP then return end

	for _,plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			local hum = plr.Character:FindFirstChildOfClass("Humanoid")
			local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
			if hum and hrp and hum.Health > 0 then
				if (myHRP.Position - hrp.Position).Magnitude < 8 then
					hum.Health = 0
				end
			end
		end
	end
end)

----------------------------------------------------------
-- COMMAND PARSERS
----------------------------------------------------------
local function runLocalCommand(text)
	localOut.Text = "Output:\n"
	local parts = string.split(text, " ")
	local cmd = string.lower(parts[1] or "")
	local arg = parts[2]

	local hum = getHumanoid()

	if cmd == "speed" then
		local n = tonumber(arg) or 60
		if hum then hum.WalkSpeed = n end
		localOut.Text = "Output:\nspeed set to "..n

	elseif cmd == "jump" then
		local n = tonumber(arg) or 120
		if hum then hum.JumpPower = n end
		localOut.Text = "Output:\njump power set to "..n

	elseif cmd == "fly" then
		flyOn = not flyOn
		if hum then hum.PlatformStand = flyOn end
		localOut.Text = "Output:\nfly "..(flyOn and "ENABLED" or "DISABLED")

	elseif cmd == "noclip" then
		noclipOn = not noclipOn
		localOut.Text = "Output:\nnoclip "..(noclipOn and "ENABLED" or "DISABLED")

	elseif cmd == "reset" then
		if hum then hum.Health = 0 end
		localOut.Text = "Output:\ncharacter reset"

	else
		localOut.Text = "Output:\nunknown local command"
	end
end

local function runUtilityCommand(text)
	utilOut.Text = "Output:\n"
	local cmd = string.lower((string.split(text," ")[1] or ""))

	if cmd == "esp" then
		for _,p in ipairs(Players:GetPlayers()) do
			if p.Character and not p.Character:FindFirstChild("EddieESP") then
				local h = Instance.new("Highlight")
				h.Name = "EddieESP"
				h.FillTransparency = 1
				h.OutlineColor = Color3.fromRGB(0,200,255)
				h.Parent = p.Character
			end
		end
		utilOut.Text = "Output:\nESP enabled"

	elseif cmd == "unesp" then
		for _,p in ipairs(Players:GetPlayers()) do
			if p.Character then
				local h = p.Character:FindFirstChild("EddieESP")
				if h then h:Destroy() end
			end
		end
		utilOut.Text = "Output:\nESP disabled"

	elseif cmd == "fullbright" then
		local L = game:GetService("Lighting")
		L.Ambient = Color3.new(1,1,1)
		L.Brightness = 4
		utilOut.Text = "Output:\nFullbright enabled"

	elseif cmd == "xray" then
		for _,v in ipairs(workspace:GetDescendants()) do
			if v:IsA("BasePart") and v.Transparency < 0.5 then
				v.Transparency = 0.8
			end
		end
		utilOut.Text = "Output:\nX-ray enabled"

	else
		utilOut.Text = "Output:\nunknown utility command"
	end
end

local function runOverpoweredCommand(text)
	opOut.Text = "Output:\n"

	if not isOwner then
		opOut.Text = "Output:\nOwner only."
		return
	end

	if not opUnlocked then
		opOut.Text = "Output:\nYou must verify the key first."
		return
	end

	local parts = string.split(text," ")
	local cmd = string.lower(parts[1] or "")
	local hum = getHumanoid()

	if cmd == "god" then
		if hum then
			hum.MaxHealth = math.huge
			hum.Health = hum.MaxHealth
		end
		opOut.Text = "Output:\nGOD mode enabled"

	elseif cmd == "ungod" then
		if hum then
			hum.MaxHealth = 100
			hum.Health = 100
		end
		opOut.Text = "Output:\nGOD mode disabled"

	elseif cmd == "killaura" then
		killauraOn = true
		opOut.Text = "Output:\nKill aura enabled"

	elseif cmd == "stopkillaura" then
		killauraOn = false
		opOut.Text = "Output:\nKill aura disabled"

	elseif cmd == "fling" then
		local hrp = getHRP()
		if hrp then
			hrp.Velocity = Vector3.new(9999,9999,9999)
		end
		opOut.Text = "Output:\nFLING executed"

	else
		opOut.Text = "Output:\nunknown overpowered command"
	end
end

----------------------------------------------------------
-- HOOK EXEC BUTTONS
----------------------------------------------------------
localExec.MouseButton1Click:Connect(function()
	if localBox.Text ~= "" then
		runLocalCommand(localBox.Text)
	end
end)

utilExec.MouseButton1Click:Connect(function()
	if utilBox.Text ~= "" then
		runUtilityCommand(utilBox.Text)
	end
end)

opExec.MouseButton1Click:Connect(function()
	if opBox.Text ~= "" then
		runOverpoweredCommand(opBox.Text)
	end
end)

----------------------------------------------------------
-- OPEN / CLOSE MAIN GUI
----------------------------------------------------------
openBtn.MouseButton1Click:Connect(function()
	mainGui.Enabled = not mainGui.Enabled
end)

closeMain.MouseButton1Click:Connect(function()
	mainGui.Enabled = false
end)

local library = loadstring(game:HttpGet("https://pastebin.com/raw/Dx75GE1z"))()
local METH = library.new("Mega Epic Treasure Hunter [METH]", 5013109572)
METH:Notify("Made by Cunning & BlackHeroin", "Heey! I hope you like the script and good luck on farming! :)")
local player = game.Players.LocalPlayer
local char = player.Character
local human = char:WaitForChild("HumanoidRootPart")
local BankGui = player.PlayerGui.MainGui:WaitForChild("Bank")
local hum = char:WaitForChild("Humanoid")
local ts = game:GetService("TweenService")      
local uis = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Plate = game.Workspace.Baseplate
local CPlate = Plate.CFrame
local Road = game:GetService("Workspace").Items.Roadwork
local Ramen = game.Workspace.Items:FindFirstChild("Ramen")
local GloveShop = game:GetService("Workspace").Items.Gloves
local Hunger = BankGui.Parent["Hunger"]["Clipping"]
Plate.CFrame = CFrame.new(CPlate.X, CPlate.Y - 1.26, CPlate.Z)

local Speed = 50
local Autohop = false

local Amount = 5000

local Money = false
local Autobank = false
local Cashcap = 5000

local Bag = false

local Roadwork = false

local Datas = {Speed, Autohop, Amount, Money, Autobank, Cashcap, Roadwork}
if syn and syn_io_isfile("METHDATA.lua") then
    local Data = syn_io_read("METHDATA.lua"):split("|")
    for i, vt in pairs(Data) do
        local v = vt
        if not type(v):find("string") then
            Data[i] = Datas[i]
        elseif v:find("false") then
            Data[i] = false
        elseif v:find("true") then
            Data[i] = true
        elseif tonumber(v) then
            Data[i] = tonumber(v)
        else
            Data[i] = Datas[i]
        end
    end
    Speed = Data[1]
    Autohop = Data[2]
    Amount = Data[3]
    Money = Data[4]
    Autobank = Data[5]
    Cashcap = Data[6]
    Bag = Data[7]
    Roadwork = Data[8]
end

function Save()
    if syn then
        syn_io_write("METHDATA.lua", tostring(Speed).."|"..tostring(Autohop).."|"..tostring(Amount).."|"..tostring(Money).."|"..tostring(Autobank).."|"..tostring(Cashcap).."|"..tostring(Bag).."|"..tostring(Roadwork))
    end
end

game.Players.PlayerRemoving:Connect(function(p)
    Save()
end)

local Admins = {
    "MikamiKambe",
    "TheNotDave",
    "Buakeu",
    "SheriffKami",
    "ZHasAmnesia",
    "0taaa",
    "Rhateus",
    "Iuvmin",
    "IchigoDP",
    "xGonca",
    "ceyhun321",
    "SojuSam",
    "Withered_Foxy777"
}

local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),  
    TextColor = Color3.fromRGB(255, 255, 255)
}

local Main = METH:addPage("Main", 1782521178)

local General = Main:addSection("General")

General:addTextbox("Speed", Speed, function(Value, FL)
    if FL then
        if tonumber(Value) then
            Speed = tonumber(Value)
        end
    end
end)

General:addToggle("Autohop", Autohop, function(Value)
    Autohop = Value
end)

if not pebc_execute then
    local Bank = Main:addSection("Banking")

    Bank:addTextbox("Amount", tostring(Amount), function(Value, FL)
        if FL then
            if tonumber(Value) then
                Amount = tonumber(Value)
            end
        end
    end)

    Bank:addButton("Withdraw", function()
        BankGui["Amount"].Text = Amount
        pcall(function()
            if syn_io_write then
                getconnections(BankGui["Deposit"].MouseButton1Click)[1]:Fire()
            else
                firesignal(BankGui["Deposit"].MouseButton1Click):Fire()
            end
        end)
    end)

    Bank:addButton("Deposit", function()
        BankGui["Amount"].Text = Amount
        pcall(function()
            if syn_io_write then
                getconnections(BankGui["Withdraw"].MouseButton1Click)[1]:Fire()
            else
                firesignal(BankGui["Withdraw"].MouseButton1Click):Fire()
            end
        end)
    end)
end

local Moneys = Main:addSection("Money")

Moneys:addToggle("Autofarm", Money, function(Value)
    Money = Value
end)

if not pebc_execute then
    Moneys:addToggle("Autobank", Autobank, function(Value)
        Autobank = Value
    end)

    Moneys:addTextbox("Cashcap", tostring(Cashcap), function(Value, FL)
        if FL then
            if tonumber(Value) then
                Cashcap = tonumber(Value)
            end
        end
    end)
end

local Bager = Main:addSection("Punching Bags")

Bager:addToggle("Autofarm", Bag, function(Value)
    Bag = Value
end)

local Roadworks = Main:addSection("Roadwork")

Roadworks:addToggle("Autofarm", Roadwork, function(Value)
    Roadwork = Value
end)

local Settings = METH:addPage("Settings")

local Hotkeys = Settings:addSection("Keybinds")

Hotkeys:addKeybind("Toggle Gui", Enum.KeyCode.G, function()
    METH:toggle()
end)

function GetQuest()
    Getting = true
    while Getting do 
        Key = os.time()
        Num = Key * 2
        game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer()
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(Num, tostring(Num * 3), {[1] = "Quest"})
        if char:FindFirstChild("Quest") then
            local Quest = char.Quest.PlayerQuest
            Passed = true
            if Quest.Value:find("Poster") or Quest.Value:find("Delivery") then
                if Quest.Value:find("Poster") then
                    Quest.Parent.Objective.Value = Quest.Parent.Req.Value
                    Passed = false
                elseif Quest.Parent.Location.Value == 1 then
                    Quest.Parent.Objective.Value = true
                    Passed = false
                end
            end
            if Passed then
                Getting = false
            else
                Quest.Parent:remove()
            end
        end
    end
    return game.Workspace.Quests.QuestLocations[char.Quest.PlayerQuest.Value][char.Quest.Location.Value]
end


local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

local function Tween(Human, Player, CF, Time)
    ti = TweenInfo.new(
        Player:DistanceFromCharacter(CF.Position)/Speed, 
        Enum.EasingStyle.Linear,Enum.EasingDirection.Out)

    tween = ts:Create(
        Human, 
        ti, 
        {CFrame = CF}
    ):Play()

    wait(Player:DistanceFromCharacter(CF.Position)/Speed + Time)
end

spawn(function()
    while wait() do
        local Quest = game.Players.LocalPlayer.Character:FindFirstChild("Quest")
        if Quest then
            if Quest.Objective.Value then
                Quest:remove()
            end
        end
        if game.Players.LocalPlayer.Character:FindFirstChild("QuestCD") then
            game.Players.LocalPlayer.Character:FindFirstChild("QuestCD"):remove()
        end
    end
end)

function DepositAll()
    BankGui["Amount"].Text = tonumber(BankGui.Parent.Cash.Text:split("$")[1])
    pcall(function()
        if syn_io_write then
            getconnections(BankGui["Withdraw"].MouseButton1Click)[1]:Fire()
        else
            firesignal(BankGui["Withdraw"].MouseButton1Click):Fire()
        end
    end)
end


local Parts = {"Map", "Test Items", "Others", "Items", "Quests", "Trainers"}

function NoCollide(_, Part)
    if Part:IsA("Part") or Part:IsA("MeshPart") or Part:IsA("UnionOperation") or Part:IsA("WedgePart") then
        Part.CanCollide = false    
    end
end

for _, Name in pairs(Parts) do
    table.foreach(game:GetService("Workspace")[Name]:GetDescendants(), NoCollide) 
end

function CheckPlayer(_, Player)
    if table.find(Admins, Player.Name) then
        local FindServers = game:HttpGetAsync('https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100')
        local Data = HttpService:JSONDecode(FindServers)["data"]
        local IDTable = {};
        for _,Server in next, Data do
            if Server["playing"] ~= nil then
                if Server["playing"] < Server["maxPlayers"] and game["JobId"] ~= Server["id"] then
                    table.insert(IDTable,Server["id"])
                end
            end
        end
        wait(.8)
        local newserver = IDTable[Random.new():NextInteger(1,#IDTable)];
        TeleportService:TeleportToPlaceInstance(game.PlaceId, newserver, player);
    end
end

function GetGlove()
    for _,v in pairs(game.Workspace:GetChildren()) do
        if v.Name == "RightGloves" then
            if v:WaitForChild("WeldConstraint").Part0 == char:WaitForChild("Right Arm") then
                return v
            end
        end
    end
    return false
end

local Planked = false
function Plank()
    Body_Axis_Rotation = 100
    _=wait
    AnimationId="181525546"
    A=Instance.new("Animation")
    A.AnimationId="rbxassetid://"..AnimationId
    k=game:GetService("Workspace")[game:GetService("Players").LocalPlayer.Name]:FindFirstChild("Humanoid"):LoadAnimation(A)
    k:Play()
    k:AdjustSpeed(1.5)
    _(Body_Axis_Rotation*.010625)
    k:AdjustSpeed(0)
    pcall(function()
        for i,v in pairs(player.Character:GetDescendants()) do
            if v.ClassName == "Accessory" or v.Name == "Shirt" or v.Name == "Pants" or v:IsA("SpecialMesh") or v:IsA("Texture") or v:IsA("WeldConstraint") then
                v:Destroy()
            end
        end
    end)
    Planked = true
end

METH:SelectPage(Main, true)


while wait() do
    if Autohop then
        for _, Player in pairs(game.Players:GetChildren()) do
            CheckPlayer(nil, Player)
        end
    end

    if not Planked then
        for i = 1, 2 do
            Plank()
        end
    end

    if hum:FindFirstChild("Animator") then
        hum:WaitForChild("Animator"):remove()
        char:WaitForChild("Animate").Disabled = true
    end

    if Money then
        local Target = GetQuest()
        Plate.CFrame = CFrame.new(CPlate.X, CPlate.Y - 1.26, CPlate.Z)
        while char:FindFirstChild("Quest") do
            Tween(human, player, CFrame.new(Target.CFrame.X, Target.CFrame.Y - 2.8, Target.CFrame.Z), 0)
            wait()
            if not pebc_execute then
                firetouchinterest(human, Target, 0)
                firetouchinterest(human, Target, 1)
            end
            if Autobank then
                if tonumber(BankGui.Parent.Cash.Text:split("$")[1]) >= Cashcap then
                    DepositAll()
                end
            end
        end
    end

    if Bag then
        Glove = GetGlove()
        hum:UnequipTools()
        Plate.CFrame = CFrame.new(CPlate.X, CPlate.Y - 0.25, CPlate.Z)
        if Glove then
            Combat = player.Backpack:FindFirstChild("Combat")
            game:GetService("Workspace").Items.Gloves.ClickDetector.MaxActivationDistance = 25
            bag = game:GetService("Workspace")["Punching Bags"]:GetChildren()[math.random(1,4)]["HumanoidRootPart"]
            if Hunger.AbsoluteSize.X < 25 then
                Tween(human, player, CFrame.new(bag.CFrame.X, bag.CFrame.Y - 5.5, bag.CFrame.Z), 0)
                while Hunger.AbsoluteSize.X < 200 do
                    Tween(human, player, CFrame.new(Ramen.CFrame.X, bag.CFrame.Y - 5.5, Ramen.CFrame.Z), 0)
                    while not player.Backpack:FindFirstChild("Ramen") do wait()
                        BankGui["Amount"].Text = 35
                        pcall(function()
                            if syn_io_write then
                                getconnections(BankGui["Deposit"].MouseButton1Click)[1]:Fire()
                            else
                                firesignal(BankGui["Deposit"].MouseButton1Click):Fire()
                            end
                        end)
                        if syn_io_write then
                            fireclickdetector(Ramen.ClickDetector)
                        else
                            click_detector(Ramen.ClickDetector, 8)
                        end
                    end
                    while player.Backpack:FindFirstChild("Ramen") do wait()
                        hum:EquipTool(player.Backpack:FindFirstChild("Ramen"))
                    end
                    while char:FindFirstChild("Ramen") do wait()
                        if char:FindFirstChild("Ramen") then 
                            char:FindFirstChild("Ramen"):Activate()
                        end
                    end
                end
            end 
            if Glove.Parent then
                while Glove.Parent do
                    if (hum.Health/(hum.MaxHealth/100)) <= 25 then
                        while (hum.Health/(hum.MaxHealth/100)) <= 25 do
                            Tween(human, player, CFrame.new(bag.CFrame.X + 25, bag.CFrame.Y - 3, bag.CFrame.Z + 20), 0.1)
                        end
                    else
                        Tween(human, player, CFrame.new(bag.CFrame.X, bag.CFrame.Y - 3, bag.CFrame.Z + 0.25), 0.1)
                    end
                    if Combat.Parent ~= char then
                        hum:EquipTool(Combat)
                    end
                    Combat:Activate()
                end
            end
        else
            while not GetGlove() do
                Tween(human, player, CFrame.new(GloveShop.CFrame.X, GloveShop.CFrame.Y - 1, GloveShop.CFrame.Z), 0)
                while not player.Backpack:FindFirstChild("Gloves") do wait()
                    BankGui["Amount"].Text = 150
                    pcall(function()
                        if syn_io_write then
                            getconnections(BankGui["Deposit"].MouseButton1Click)[1]:Fire()
                        else
                            firesignal(BankGui["Deposit"].MouseButton1Click):Fire()
                        end
                    end)
                    if syn_io_write then
                        fireclickdetector(GloveShop.ClickDetector)
                    else
                        click_detector(GloveShop.ClickDetector, 8)
                    end
                end
                while player.Backpack:FindFirstChild("Gloves") do wait()
                    hum:EquipTool(player.Backpack:FindFirstChild("Gloves"))
                end
                while not GetGlove() do wait()
                    char:FindFirstChild("Gloves"):Activate()
                end
            end
        end
    end

    if Roadwork then
        Plate.CFrame = CFrame.new(CPlate.X, CPlate.Y - 1.26, CPlate.Z)
        if player.Backpack:FindFirstChild("Roadwork") then
            pcall(function()
                hum:EquipTool(player.Backpack:FindFirstChild("Roadwork"))
            end)
        elseif char:FindFirstChild("Roadwork") then
            pcall(function()
                char:FindFirstChild("Roadwork"):Activate()
            end)
        else
            while player:DistanceFromCharacter(Road.Position) >= 4.5 do
                Tween(human, player, CFrame.new(Road.CFrame.X, Road.CFrame.Y - 1, Road.CFrame.Z), 0)
            end
            wait(0.5)
            BankGui["Amount"].Text = 300
            pcall(function()
                if syn_io_write then
                    getconnections(BankGui["Deposit"].MouseButton1Click)[1]:Fire()
                else
                    firesignal(BankGui["Deposit"].MouseButton1Click):Fire()
                end
            end)
            wait(0.5)
            while player.Backpack:FindFirstChild("Roadwork") == nil do
                wait()
                if syn_io_write then
                    fireclickdetector(Road.ClickDetector)
                else
                    click_detector(Road.ClickDetector, 8)
                end
            end
            for _, v in pairs(game:GetService("Workspace").Roadwork:GetChildren()) do
                if v:FindFirstChild("BillboardGui").Enabled == true then
                    Tween(human, player, CFrame.new(v.CFrame.X, v.CFrame.Y - 3, v.CFrame.Z), .8)
                    if not pebc_execute then    
                        firetouchinterest(human, v, 0)
                        firetouchinterest(human, v, 1)
                    end
                end
            end
        end
    end
end

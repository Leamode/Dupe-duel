
--// Cloud Script's | v2 Full Soft
--// LocalScript > StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

--// SETTINGS
local S = {
	ESP = {
		Enabled = true, Rainbow = true,
		Color = Color3.fromRGB(255,60,120),
		RainbowSpeed = 2, Box = true, Name = true,
		Distance = true, Health = true,
		MaxDist = 800, Tracers = true,
		TracerFrom = "Bottom", TracerColor = Color3.fromRGB(255,255,255),
		TracerThick = 2,
	},
	Hitbox = { Enabled = false, Show = false, Size = 12, Trans = 0.6, Color = Color3.fromRGB(255,255,255) },
	Aim = {
		Enabled = false, Silent = false, ShowFov = true,
		Fov = 120, Speed = 12, Part = "Head",
		TeamCheck = true, WallCheck = true,
		Holding = false, MobileLock = false
	},
	Mods = {
		SpeedOn = false, SpeedVal = 32,
		JumpVal = 50, InfJump = false,
		Fly = false, FlySpeed = 60,
		Noclip = false, Fullbright = false
	}
}

local function tw(o,i,p) return TweenService:Create(o,i,p) end
local function cnr(o,r) local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r) c.Parent=o return c end
local function str(o,c,t,tr) local s=Instance.new("UIStroke") s.Color=c s.Thickness=t s.Transparency=tr or 0 s.Parent=o return s end

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "CloudScripts" gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true gui.DisplayOrder = 999 gui.Parent = PlayerGui

local overlay = Instance.new("ScreenGui")
overlay.Name = "CloudOverlay" overlay.ResetOnSpawn = false
overlay.IgnoreGuiInset = true overlay.DisplayOrder = 998 overlay.Parent = PlayerGui

--// LOADER
local loader = Instance.new("Frame")
loader.Size = UDim2.new(1,0,1,0)
loader.BackgroundColor3 = Color3.fromRGB(11,13,21)
loader.BorderSizePixel = 0 loader.Parent = gui

local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0,Color3.fromRGB(11,13,21)),
	ColorSequenceKeypoint.new(.5,Color3.fromRGB(19,24,42)),
	ColorSequenceKeypoint.new(1,Color3.fromRGB(10,11,19))
}
grad.Rotation = 35 grad.Parent = loader

local card = Instance.new("Frame")
card.AnchorPoint = Vector2.new(.5,.5) card.Position = UDim2.new(.5,0,.5,0)
card.Size = UDim2.new(0,0,0,0) card.BackgroundColor3 = Color3.fromRGB(20,23,36)
card.BackgroundTransparency = .12 card.BorderSizePixel = 0 card.Parent = loader
cnr(card,24) str(card,Color3.fromRGB(255,255,255),1,.85)

local cloudH = Instance.new("Frame")
cloudH.AnchorPoint = Vector2.new(.5,.5) cloudH.Position = UDim2.new(.5,0,.36,0)
cloudH.Size = UDim2.new(0,0,0,0) cloudH.BackgroundTransparency = 1 cloudH.Parent = card

local function puff(x,y,sx,sy)
	local f = Instance.new("Frame")
	f.AnchorPoint = Vector2.new(.5,.5) f.Position = UDim2.new(.5,x,.5,y)
	f.Size = UDim2.new(0,sx,0,sy) f.BackgroundColor3 = Color3.fromRGB(255,255,255)
	f.BorderSizePixel = 0 f.Parent = cloudH cnr(f,100)
	local g = Instance.new("UIGradient")
	g.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(205,220,255))}
	g.Rotation = 90 g.Parent = f return f
end
puff(-45,15,90,70) puff(0,-5,110,90) puff(45,15,95,75) puff(0,28,160,45)

local glow = Instance.new("ImageLabel")
glow.AnchorPoint = Vector2.new(.5,.5) glow.Position = UDim2.new(.5,0,.5,10)
glow.Size = UDim2.new(0,240,0,150) glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://6014261993" glow.ImageColor3 = Color3.fromRGB(130,170,255)
glow.ImageTransparency = .75 glow.Parent = cloudH

local title = Instance.new("TextLabel")
title.AnchorPoint = Vector2.new(.5,0) title.Position = UDim2.new(.5,0,.62,0)
title.Size = UDim2.new(1,0,0,30) title.BackgroundTransparency = 1
title.Text = "Cloud Script's" title.Font = Enum.Font.GothamBold title.TextSize = 22
title.TextColor3 = Color3.new(1,1,1) title.TextTransparency = 1 title.Parent = card

local sub = Instance.new("TextLabel")
sub.AnchorPoint = Vector2.new(.5,0) sub.Position = UDim2.new(.5,0,.62,30)
sub.Size = UDim2.new(1,0,0,16) sub.BackgroundTransparency = 1
sub.Text = "coolest softest best experience" sub.Font = Enum.Font.Gotham
sub.TextSize = 11 sub.TextColor3 = Color3.fromRGB(140,150,180) sub.TextTransparency = 1 sub.Parent = card

local barBg = Instance.new("Frame")
barBg.AnchorPoint = Vector2.new(.5,0) barBg.Position = UDim2.new(.5,0,.83,0)
barBg.Size = UDim2.new(.8,0,0,6) barBg.BackgroundColor3 = Color3.new(1,1,1)
barBg.BackgroundTransparency = .9 barBg.BorderSizePixel = 0 barBg.Parent = card cnr(barBg,100)
local bar = Instance.new("Frame") bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.new(1,1,1) bar.BorderSizePixel = 0 bar.Parent = barBg cnr(bar,100)
local bg = Instance.new("UIGradient")
bg.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(120,170,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(210,225,255))}
bg.Parent = bar
local perc = Instance.new("TextLabel")
perc.AnchorPoint = Vector2.new(.5,0) perc.Position = UDim2.new(.5,0,.83,12)
perc.Size = UDim2.new(1,0,0,16) perc.BackgroundTransparency = 1 perc.Text = "%0"
perc.Font = Enum.Font.GothamMedium perc.TextSize = 11 perc.TextColor3 = Color3.fromRGB(180,190,210) perc.Parent = card

tw(card,TweenInfo.new(.7,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,320,0,300)}):Play() task.wait(.35)
tw(cloudH,TweenInfo.new(.8,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,180,0,110)}):Play()
tw(title,TweenInfo.new(.5),{TextTransparency=0}):Play() tw(sub,TweenInfo.new(.5),{TextTransparency=0}):Play()

task.spawn(function()
	while loader.Parent do
		tw(cloudH,TweenInfo.new(1.3,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Position=UDim2.new(.5,0,.36,-6)}):Play() task.wait(1.3)
		if not loader.Parent then break end
		tw(cloudH,TweenInfo.new(1.3,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Position=UDim2.new(.5,0,.36,0)}):Play() task.wait(1.3)
	end
end)

for i=0,100 do bar.Size=UDim2.new(i/100,0,1,0) perc.Text="%"..i task.wait(.016) end task.wait(.25)

-- seçim
tw(title,TweenInfo.new(.3),{Position=UDim2.new(.5,0,.48,0)}):Play()
tw(sub,TweenInfo.new(.3),{TextTransparency=1}):Play() tw(barBg,TweenInfo.new(.3),{BackgroundTransparency=1}):Play()
tw(bar,TweenInfo.new(.3),{BackgroundTransparency=1}):Play() tw(perc,TweenInfo.new(.3),{TextTransparency=1}):Play()
task.wait(.3) barBg.Visible=false perc.Visible=false sub.Visible=false

local function choice(y,txt,white)
	local b=Instance.new("TextButton") b.AnchorPoint=Vector2.new(.5,0) b.Position=UDim2.new(.5,0,y,0)
	b.Size=UDim2.new(.8,0,0,0) b.BackgroundColor3=white and Color3.new(1,1,1) or Color3.fromRGB(30,34,52)
	b.Text=txt b.Font=Enum.Font.GothamBold b.TextSize=13
	b.TextColor3=white and Color3.fromRGB(15,18,28) or Color3.new(1,1,1)
	b.AutoButtonColor=false b.Parent=card cnr(b,14)
	if not white then str(b,Color3.new(1,1,1),1,.85) end
	tw(b,TweenInfo.new(.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(.8,0,0,42)}):Play()
	b.MouseEnter:Connect(function() tw(b,TweenInfo.new(.2),{Size=UDim2.new(.83,0,0,46)}):Play() end)
	b.MouseLeave:Connect(function() tw(b,TweenInfo.new(.2),{Size=UDim2.new(.8,0,0,42)}):Play() end)
	return b
end
local bMenu = choice(.62,"  ●  MENULU DEVAM ET",true)
local bNoMenu = choice(.79,"  ○  MENUSUZ DEVAM ET",false)

--// FOV
local fov = Instance.new("Frame") fov.AnchorPoint=Vector2.new(.5,.5)
fov.BackgroundTransparency=1 fov.Visible=false fov.Parent=gui cnr(fov,1000)
local fovS = str(fov,Color3.new(1,1,1),1.5,0)
local function updFov()
	fov.Position=UDim2.new(.5,0,.5,0) fov.Size=UDim2.new(0,S.Aim.Fov*2,0,S.Aim.Fov*2)
	fov.Visible=S.Aim.ShowFov and S.Aim.Enabled
end

--// ANA MENU
local menu = Instance.new("Frame")
menu.AnchorPoint=Vector2.new(.5,.5) menu.Position=UDim2.new(.5,0,.5,0)
menu.Size=UDim2.new(0,360,0,480) menu.BackgroundColor3=Color3.fromRGB(18,20,32)
menu.BackgroundTransparency=.06 menu.BorderSizePixel=0 menu.Visible=false menu.Parent=gui
cnr(menu,20) str(menu,Color3.new(1,1,1),1,.8)
local ml=Instance.new("UISizeConstraint") ml.MaxSize=Vector2.new(380,520) ml.MinSize=Vector2.new(300,380) ml.Parent=menu

local top=Instance.new("Frame") top.Size=UDim2.new(1,0,0,56)
top.BackgroundColor3=Color3.new(1,1,1) top.BackgroundTransparency=.94 top.BorderSizePixel=0 top.Parent=menu cnr(top,20)
local fix=Instance.new("Frame") fix.AnchorPoint=Vector2.new(.5,1) fix.Position=UDim2.new(.5,0,1,0)
fix.Size=UDim2.new(1,0,0,20) fix.BackgroundColor3=top.BackgroundColor3 fix.BackgroundTransparency=top.BackgroundTransparency fix.BorderSizePixel=0 fix.Parent=top
local mt=Instance.new("TextLabel") mt.Position=UDim2.new(0,14,0,8) mt.Size=UDim2.new(1,-100,0,20)
mt.BackgroundTransparency=1 mt.Text="☁  Cloud Script's" mt.Font=Enum.Font.GothamBold mt.TextSize=15 mt.TextXAlignment=0 mt.TextColor3=Color3.new(1,1,1) mt.Parent=top
local ms=Instance.new("TextLabel") ms.Position=UDim2.new(0,14,0,28) ms.Size=UDim2.new(1,-100,0,16)
ms.BackgroundTransparency=1 ms.Text="esp • hitbox • aim • mods" ms.Font=Enum.Font.Gotham ms.TextSize=11 ms.TextXAlignment=0 ms.TextColor3=Color3.fromRGB(130,200,255) ms.Parent=top

local function topBtn(x,t,c)
	local b=Instance.new("TextButton") b.AnchorPoint=Vector2.new(1,.5) b.Position=UDim2.new(1,x,.5,0)
	b.Size=UDim2.new(0,30,0,30) b.BackgroundColor3=c b.Text=t b.Font=Enum.Font.GothamBold b.TextSize=14
	b.TextColor3=Color3.new(1,1,1) b.AutoButtonColor=false b.Parent=top cnr(b,10) return b
end
local closeB=topBtn(-10,"—",Color3.fromRGB(55,60,85)) local xB=topBtn(-46,"×",Color3.fromRGB(255,95,95))

local tabBar=Instance.new("Frame") tabBar.Position=UDim2.new(0,10,0,66) tabBar.Size=UDim2.new(1,-20,0,34) tabBar.BackgroundTransparency=1 tabBar.Parent=menu
local tl=Instance.new("UIListLayout") tl.FillDirection=Enum.FillDirection.Horizontal tl.Padding=UDim.new(0,6) tl.Parent=tabBar
local pages=Instance.new("Frame") pages.Position=UDim2.new(0,10,0,106) pages.Size=UDim2.new(1,-20,1,-116) pages.BackgroundTransparency=1 pages.Parent=menu

local function makePage()
	local s=Instance.new("ScrollingFrame") s.Size=UDim2.new(1,0,1,0) s.BackgroundTransparency=1
	s.ScrollBarThickness=3 s.ScrollBarImageColor3=Color3.fromRGB(120,170,255)
	s.AutomaticCanvasSize=Enum.AutomaticSize.Y s.CanvasSize=UDim2.new(0,0,0,0) s.Visible=false s.Parent=pages
	local l=Instance.new("UIListLayout") l.Padding=UDim.new(0,8) l.SortOrder=Enum.SortOrder.LayoutOrder l.Parent=s return s
end
local pESP=makePage() local pHit=makePage() local pAim=makePage() local pMods=makePage() pESP.Visible=true

local function tabBtn(txt,page)
	local b=Instance.new("TextButton") b.Size=UDim2.new(.25,-5,1,0) b.BackgroundColor3=Color3.fromRGB(28,32,48)
	b.Text=txt b.Font=Enum.Font.GothamBold b.TextSize=11 b.TextColor3=Color3.fromRGB(180,190,210) b.AutoButtonColor=false b.Parent=tabBar cnr(b,11)
	b.MouseButton1Click:Connect(function()
		for _,v in pairs(tabBar:GetChildren()) do if v:IsA("TextButton") then tw(v,TweenInfo.new(.2),{BackgroundColor3=Color3.fromRGB(28,32,48),TextColor3=Color3.fromRGB(180,190,210)}):Play() end end
		tw(b,TweenInfo.new(.2),{BackgroundColor3=Color3.new(1,1,1),TextColor3=Color3.fromRGB(15,18,28)}):Play()
		for _,p in pairs(pages:GetChildren()) do p.Visible=false end page.Visible=true
	end) return b
end
local tb1=tabBtn("ESP",pESP) local tb2=tabBtn("HITBOX",pHit) local tb3=tabBtn("AIM",pAim) local tb4=tabBtn("MODS",pMods)
tb1.BackgroundColor3=Color3.new(1,1,1) tb1.TextColor3=Color3.fromRGB(15,18,28)

local function sect(p,t) local l=Instance.new("TextLabel") l.Size=UDim2.new(1,0,0,18) l.BackgroundTransparency=1 l.Text=t l.Font=Enum.Font.GothamBold l.TextSize=11 l.TextXAlignment=0 l.TextColor3=Color3.fromRGB(130,170,255) l.Parent=p return l end
local function tog(p,txt,val,cb)
	local b=Instance.new("TextButton") b.Size=UDim2.new(1,0,0,44) b.BackgroundColor3=Color3.fromRGB(28,32,48) b.Text="" b.AutoButtonColor=false b.Parent=p cnr(b,12) str(b,Color3.new(1,1,1),1,.88)
	local t=Instance.new("TextLabel") t.Position=UDim2.new(0,10,0,0) t.Size=UDim2.new(1,-60,1,0) t.BackgroundTransparency=1 t.Text=txt t.Font=Enum.Font.GothamBold t.TextSize=12 t.TextXAlignment=0 t.TextColor3=Color3.new(1,1,1) t.Parent=b
	local dot=Instance.new("Frame") dot.AnchorPoint=Vector2.new(1,.5) dot.Position=UDim2.new(1,-10,.5,0) dot.Size=UDim2.new(0,36,0,20) dot.BackgroundColor3=val and Color3.fromRGB(90,200,120) or Color3.fromRGB(55,60,80) dot.BorderSizePixel=0 dot.Parent=b cnr(dot,100)
	local c=Instance.new("Frame") c.AnchorPoint=Vector2.new(.5,.5) c.Position=UDim2.new(val and .75 or .25,.5,.5,0) c.Size=UDim2.new(0,14,0,14) c.BackgroundColor3=Color3.new(1,1,1) c.BorderSizePixel=0 c.Parent=dot cnr(c,100)
	local on=val b.MouseButton1Click:Connect(function() on=not on
		tw(dot,TweenInfo.new(.25),{BackgroundColor3=on and Color3.fromRGB(90,200,120) or Color3.fromRGB(55,60,80)}):Play()
		tw(c,TweenInfo.new(.25,Enum.EasingStyle.Back),{Position=UDim2.new(on and .75 or .25,.5,.5,0)}):Play() cb(on) end) return b
end
local function sld(p,txt,min,max,val,cb)
	local f=Instance.new("Frame") f.Size=UDim2.new(1,0,0,52) f.BackgroundColor3=Color3.fromRGB(28,32,48) f.BorderSizePixel=0 f.Parent=p cnr(f,12) str(f,Color3.new(1,1,1),1,.88)
	local t=Instance.new("TextLabel") t.Position=UDim2.new(0,10,0,6) t.Size=UDim2.new(1,-20,0,16) t.BackgroundTransparency=1 t.Text=txt.." : "..val t.Font=Enum.Font.GothamBold t.TextSize=11 t.TextXAlignment=0 t.TextColor3=Color3.new(1,1,1) t.Parent=f
	local bg2=Instance.new("TextButton") bg2.AnchorPoint=Vector2.new(.5,0) bg2.Position=UDim2.new(.5,0,0,30) bg2.Size=UDim2.new(1,-20,0,12) bg2.BackgroundColor3=Color3.fromRGB(15,18,28) bg2.Text="" bg2.AutoButtonColor=false bg2.Parent=f cnr(bg2,100)
	local fill=Instance.new("Frame") fill.Size=UDim2.new((val-min)/(max-min),0,1,0) fill.BackgroundColor3=Color3.fromRGB(130,170,255) fill.BorderSizePixel=0 fill.Parent=bg2 cnr(fill,100)
	local function set(v) v=math.clamp(math.floor(v),min,max) fill.Size=UDim2.new((v-min)/(max-min),0,1,0) t.Text=txt.." : "..v cb(v) end
	bg2.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
		local function upd(pp) local r=bg2.AbsolutePosition.X local s=bg2.AbsoluteSize.X set(min+(max-min)*math.clamp((pp.X-r)/s,0,1)) end upd(i.Position)
		local m m=UserInputService.InputChanged:Connect(function(ii) if ii.UserInputType==Enum.UserInputType.MouseMovement or ii.UserInputType==Enum.UserInputType.Touch then upd(ii.Position) end end)
		UserInputService.InputEnded:Wait() if m then m:Disconnect() end end end) return f
end
local function cols(p,txt,list,cb)
	sect(p,txt) local h=Instance.new("Frame") h.Size=UDim2.new(1,0,0,36) h.BackgroundTransparency=1 h.Parent=p
	local l=Instance.new("UIListLayout") l.FillDirection=Enum.FillDirection.Horizontal l.Padding=UDim.new(0,6) l.Parent=h
	for _,c in pairs(list) do
		local b=Instance.new("TextButton") b.Size=UDim2.new(0,32,0,32)
		if c=="Rainbow" then b.BackgroundColor3=Color3.new(1,1,1) b.Text="🌈" else b.BackgroundColor3=c b.Text="" end
		b.Font=Enum.Font.GothamBold b.TextSize=14 b.AutoButtonColor=false b.Parent=h cnr(b,10) str(b,Color3.new(1,1,1),1,.7)
		b.MouseButton1Click:Connect(function() cb(c) tw(b,TweenInfo.new(.15,Enum.EasingStyle.Back),{Size=UDim2.new(0,37,0,37)}):Play() task.wait(.15) tw(b,TweenInfo.new(.15),{Size=UDim2.new(0,32,0,32)}):Play() end)
	end
end
local function cyc(p,txt,opts,cur,cb)
	local f=Instance.new("Frame") f.Size=UDim2.new(1,0,0,44) f.BackgroundColor3=Color3.fromRGB(28,32,48) f.Parent=p cnr(f,12) str(f,Color3.new(1,1,1),1,.88)
	local t=Instance.new("TextLabel") t.Position=UDim2.new(0,10,0,0) t.Size=UDim2.new(1,-20,0,20) t.BackgroundTransparency=1 t.Text=txt.." : "..cur t.Font=Enum.Font.GothamBold t.TextSize=11 t.TextXAlignment=0 t.TextColor3=Color3.new(1,1,1) t.Parent=f
	local b=Instance.new("TextButton") b.Position=UDim2.new(0,10,0,22) b.Size=UDim2.new(1,-20,0,16) b.BackgroundTransparency=1 b.Text="değiştir >" b.Font=Enum.Font.Gotham b.TextSize=11 b.TextColor3=Color3.fromRGB(130,200,255) b.Parent=f
	local i=table.find(opts,cur) or 1 b.MouseButton1Click:Connect(function() i=i%#opts+1 t.Text=txt.." : "..opts[i] cb(opts[i]) end)
end

-- ESP UI
sect(pESP,"ana") tog(pESP,"esp açık",true,function(v) S.ESP.Enabled=v end) tog(pESP,"rainbow",true,function(v) S.ESP.Rainbow=v end)
cols(pESP,"esp rengi",{"Rainbow",Color3.fromRGB(255,60,120),Color3.new(1,1,1),Color3.fromRGB(80,150,255),Color3.fromRGB(90,255,140),Color3.fromRGB(180,120,255),Color3.fromRGB(255,180,60)},function(c) if c=="Rainbow" then S.ESP.Rainbow=true else S.ESP.Rainbow=false S.ESP.Color=c end end)
sect(pESP,"parçalar") tog(pESP,"box highlight",true,function(v) S.ESP.Box=v end) tog(pESP,"isim",true,function(v) S.ESP.Name=v end)
tog(pESP,"mesafe",true,function(v) S.ESP.Distance=v end) tog(pESP,"can barı",true,function(v) S.ESP.Health=v end)
sect(pESP,"tracer") tog(pESP,"tracers açık",true,function(v) S.ESP.Tracers=v end)
cols(pESP,"tracer rengi",{Color3.new(1,1,1),Color3.fromRGB(255,60,120),Color3.fromRGB(80,150,255),Color3.fromRGB(90,255,140)},function(c) if c~="Rainbow" then S.ESP.TracerColor=c end end)
cyc(pESP,"çıkış",{"Bottom","Center","Top","Mouse"},"Bottom",function(v) S.ESP.TracerFrom=v end)
sld(pESP,"max mesafe",100,3000,800,function(v) S.ESP.MaxDist=v end)
sld(pESP,"rainbow hızı",1,10,2,function(v) S.ESP.RainbowSpeed=v end)
sld(pESP,"tracer kalınlık",1,5,2,function(v) S.ESP.TracerThick=v end)

-- HITBOX UI
sect(pHit,"hitbox") tog(pHit,"hitbox açık",false,function(v) S.Hitbox.Enabled=v end)
tog(pHit,"hitbox göster",false,function(v) S.Hitbox.Show=v end)
cols(pHit,"hitbox rengi",{Color3.new(1,1,1),Color3.fromRGB(255,60,120),Color3.fromRGB(80,150,255),Color3.fromRGB(90,255,140)},function(c) if c~="Rainbow" then S.Hitbox.Color=c end end)
sld(pHit,"büyüklük",2,30,12,function(v) S.Hitbox.Size=v end)
sld(pHit,"şeffaflık x10",0,9,6,function(v) S.Hitbox.Trans=v/10 end)

-- AIM UI
sect(pAim,"aimbot") tog(pAim,"aimbot açık",false,function(v) S.Aim.Enabled=v updFov() end)
tog(pAim,"silent aim",false,function(v) S.Aim.Silent=v end) tog(pAim,"fov göster",true,function(v) S.Aim.ShowFov=v updFov() end)
tog(pAim,"takım kontrol",true,function(v) S.Aim.TeamCheck=v end) tog(pAim,"duvar kontrol",true,function(v) S.Aim.WallCheck=v end)
sld(pAim,"fov",40,400,120,function(v) S.Aim.Fov=v updFov() end) sld(pAim,"speed",1,30,12,function(v) S.Aim.Speed=v end)
cyc(pAim,"hedef",{"Head","Torso","Random"},"Head",function(v) S.Aim.Part=v end)
sect(pAim,"mobil") tog(pAim,"mobil lock (dokunmatik)",false,function(v) S.Aim.MobileLock=v end)

-- MODS UI
sect(pMods,"hareket") tog(pMods,"speed açık",false,function(v) S.Mods.SpeedOn=v end)
sld(pMods,"speed",16,200,32,function(v) S.Mods.SpeedVal=v end)
sld(pMods,"jump power",50,200,50,function(v) S.Mods.JumpVal=v if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then player.Character:FindFirstChildOfClass("Humanoid").JumpPower=v end end)
tog(pMods,"inf jump",false,function(v) S.Mods.InfJump=v end)
tog(pMods,"fly",false,function(v) S.Mods.Fly=v end) sld(pMods,"fly hızı",20,150,60,function(v) S.Mods.FlySpeed=v end)
sect(pMods,"dünya") tog(pMods,"noclip",false,function(v) S.Mods.Noclip=v end) tog(pMods,"fullbright",false,function(v) S.Mods.Fullbright=v
	if v then game.Lighting.Brightness=2 game.Lighting.ClockTime=14 game.Lighting.FogEnd=100000 else game.Lighting.Brightness=1 game.Lighting.FogEnd=1000 end end)

do local dr,ds,sp top.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true ds=i.Position sp=menu.Position i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dr=false end end) end end)
UserInputService.InputChanged:Connect(function(i) if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then local d=i.Position-ds menu.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y) end end) end

--// MENUSUZ + MINI
local side=Instance.new("Frame") side.AnchorPoint=Vector2.new(1,.5) side.Position=UDim2.new(1,-12,.5,0)
side.Size=UDim2.new(0,58,0,124) side.BackgroundTransparency=1 side.Visible=false side.Parent=gui
local sl=Instance.new("UIListLayout") sl.Padding=UDim.new(0,8) sl.Parent=side
local function sideBtn(txt,on)
	local b=Instance.new("TextButton") b.Size=UDim2.new(0,58,0,58) b.BackgroundColor3=on and Color3.fromRGB(90,200,120) or Color3.fromRGB(20,23,36)
	b.BackgroundTransparency=.08 b.Text=txt b.Font=Enum.Font.GothamBold b.TextSize=16 b.TextColor3=Color3.new(1,1,1) b.AutoButtonColor=false b.Parent=side cnr(b,18) str(b,Color3.new(1,1,1),1,.8) return b
end
local espB=sideBtn("ESP",true) local hbB=sideBtn("HIT",false)
local espOn=true local hbOn=false
espB.MouseButton1Click:Connect(function() espOn=not espOn S.ESP.Enabled=espOn tw(espB,TweenInfo.new(.2),{BackgroundColor3=espOn and Color3.fromRGB(90,200,120) or Color3.fromRGB(20,23,36)}):Play() end)
hbB.MouseButton1Click:Connect(function() hbOn=not hbOn S.Hitbox.Enabled=hbOn tw(hbB,TweenInfo.new(.2),{BackgroundColor3=hbOn and Color3.fromRGB(90,200,120) or Color3.fromRGB(20,23,36)}):Play() end)

local mini=Instance.new("TextButton") mini.AnchorPoint=Vector2.new(1,.5) mini.Position=UDim2.new(1,-12,.5,0)
mini.Size=UDim2.new(0,52,0,52) mini.BackgroundColor3=Color3.fromRGB(20,23,36) mini.BackgroundTransparency=.08
mini.Text="☁" mini.Font=Enum.Font.GothamBold mini.TextSize=22 mini.TextColor3=Color3.new(1,1,1) mini.Visible=false mini.AutoButtonColor=false mini.Parent=gui cnr(mini,18) str(mini,Color3.new(1,1,1),1,.8)

local open=false
local function openM() menu.Visible=true open=true mini.Visible=false menu.Position=UDim2.new(.5,0,.6,0) menu.Size=UDim2.new(0,0,0,0)
	tw(menu,TweenInfo.new(.55,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,360,0,480),Position=UDim2.new(.5,0,.5,0)}):Play() end
local function closeM() tw(menu,TweenInfo.new(.3,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Size=UDim2.new(0,0,0,0),Position=UDim2.new(.5,0,.6,0)}):Play()
	task.wait(.3) menu.Visible=false open=false mini.Visible=true end
closeB.MouseButton1Click:Connect(closeM) xB.MouseButton1Click:Connect(closeM) mini.MouseButton1Click:Connect(openM)
local function kill() tw(loader,TweenInfo.new(.5),{BackgroundTransparency=1}):Play() tw(card,TweenInfo.new(.5,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Size=UDim2.new(0,0,0,0)}):Play() task.wait(.5) loader:Destroy() end
bMenu.MouseButton1Click:Connect(function() kill() openM() end)
bNoMenu.MouseButton1Click:Connect(function() kill() side.Visible=true side.Position=UDim2.new(1,80,.5,0) tw(side,TweenInfo.new(.6,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.new(1,-12,.5,0)}):Play() end)
UserInputService.InputBegan:Connect(function(i,g) if g then return end if i.KeyCode==Enum.KeyCode.RightShift and not loader.Parent then if open then closeM() elseif mini.Visible then openM() end end
	if i.UserInputType==Enum.UserInputType.MouseButton2 then S.Aim.Holding=true end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton2 then S.Aim.Holding=false end end)
UserInputService.JumpRequest:Connect(function() if S.Mods.InfJump and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping) end end)

--// ESP MOTORU
local store={} local function col() if S.ESP.Rainbow then return Color3.fromHSV(tick()*S.ESP.RainbowSpeed/10%1,.7,1) else return S.ESP.Color end end
local function mk(plr)
	if plr==player then return end
	local h=Instance.new("Highlight") h.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop h.FillTransparency=.6 h.OutlineTransparency=0 h.Parent=overlay
	local bb=Instance.new("BillboardGui") bb.Size=UDim2.new(0,120,0,60) bb.StudsOffset=Vector3.new(0,3,0) bb.AlwaysOnTop=true bb.Parent=overlay
	local nm=Instance.new("TextLabel") nm.Size=UDim2.new(1,0,0,16) nm.BackgroundTransparency=1 nm.Font=Enum.Font.GothamBold nm.TextSize=12 nm.TextStrokeTransparency=.4 nm.TextColor3=Color3.new(1,1,1) nm.Parent=bb
	local ds=Instance.new("TextLabel") ds.Position=UDim2.new(0,0,0,16) ds.Size=UDim2.new(1,0,0,14) ds.BackgroundTransparency=1 ds.Font=Enum.Font.Gotham ds.TextSize=11 ds.TextStrokeTransparency=.4 ds.TextColor3=Color3.fromRGB(200,210,230) ds.Parent=bb
	local hb=Instance.new("Frame") hb.Position=UDim2.new(.1,0,0,34) hb.Size=UDim2.new(.8,0,0,6) hb.BackgroundColor3=Color3.fromRGB(0,0,0) hb.BackgroundTransparency=.4 hb.BorderSizePixel=0 hb.Parent=bb cnr(hb,100)
	local hp=Instance.new("Frame") hp.Size=UDim2.new(1,0,1,0) hp.BackgroundColor3=Color3.fromRGB(90,255,140) hp.BorderSizePixel=0 hp.Parent=hb cnr(hp,100)
	local tr=Instance.new("Frame") tr.AnchorPoint=Vector2.new(.5,.5) tr.BackgroundColor3=Color3.new(1,1,1) tr.BorderSizePixel=0 tr.Visible=false tr.Parent=overlay cnr(tr,100)
	store[plr]={h=h,bb=bb,nm=nm,ds=ds,hb=hb,hp=hp,tr=tr}
end
for _,p in pairs(Players:GetPlayers()) do mk(p) end
Players.PlayerAdded:Connect(mk) Players.PlayerRemoving:Connect(function(p) if store[p] then store[p].h:Destroy() store[p].bb:Destroy() store[p].tr:Destroy() store[p]=nil end end)

RunService.RenderStepped:Connect(function()
	local c=col() updFov()
	for plr,d in pairs(store) do
		local ch=plr.Character local hrp=ch and ch:FindFirstChild("HumanoidRootPart") local hum=ch and ch:FindFirstChildOfClass("Humanoid")
		local show=S.ESP.Enabled and hrp and hum and hum.Health>0
		if show and (hrp.Position-Camera.CFrame.Position).Magnitude>S.ESP.MaxDist then show=false end
		if not show then d.h.Enabled=false d.bb.Enabled=false d.tr.Visible=false
		else
			d.h.Adornee=ch d.h.Enabled=S.ESP.Box d.h.FillColor=c d.h.OutlineColor=c
			d.bb.Adornee=hrp d.bb.Enabled=true d.nm.Visible=S.ESP.Name d.nm.Text=plr.Name d.nm.TextColor3=c
			local dist=(hrp.Position-Camera.CFrame.Position).Magnitude
			d.ds.Visible=S.ESP.Distance d.ds.Text="["..math.floor(dist).."m]"
			d.hb.Visible=S.ESP.Health
			if hum then local r=math.clamp(hum.Health/hum.MaxHealth,0,1) d.hp.Size=UDim2.new(r,0,1,0) d.hp.BackgroundColor3=Color3.fromHSV(r*.33,.8,1) end
			if S.ESP.Tracers then
				local v,on=Camera:WorldToViewportPoint(hrp.Position)
				if on then
					local vs=Camera.ViewportSize local ox,oy
					if S.ESP.TracerFrom=="Bottom" then ox,oy=vs.X/2,vs.Y-40
					elseif S.ESP.TracerFrom=="Top" then ox,oy=vs.X/2,40
					elseif S.ESP.TracerFrom=="Center" then ox,oy=vs.X/2,vs.Y/2
					else local m=UserInputService:GetMouseLocation() ox,oy=m.X,m.Y end
					local dx,dy=v.X-ox,v.Y-oy local len=math.sqrt(dx*dx+dy*dy)
					d.tr.Visible=true d.tr.BackgroundColor3=S.ESP.TracerColor
					d.tr.Size=UDim2.new(0,len,0,S.ESP.TracerThick)
					d.tr.Position=UDim2.new(0,(ox+v.X)/2,0,(oy+v.Y)/2) d.tr.Rotation=math.deg(math.atan2(dy,dx))
				else d.tr.Visible=false end
			else d.tr.Visible=false end
		end
		if hrp then
			if S.Hitbox.Enabled then
				local want=Vector3.new(S.Hitbox.Size,S.Hitbox.Size,S.Hitbox.Size)
				if hrp.Size~=want then
					-- soft büyüme hissi için lerp
					hrp.Size=hrp.Size:Lerp(want,.25)
					if (hrp.Size-want).Magnitude<.5 then hrp.Size=want end
				end
				hrp.Transparency=S.Hitbox.Show and S.Hitbox.Trans or 1
				hrp.Color=S.Hitbox.Color hrp.Material=Enum.Material.SmoothPlastic hrp.CanCollide=false
			else if hrp.Size~=Vector3.new(2,2,1) then hrp.Size=Vector3.new(2,2,1) hrp.Transparency=1 end end
		end
	end
	-- mods loop
	if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
		local h=player.Character:FindFirstChildOfClass("Humanoid")
		h.WalkSpeed=S.Mods.SpeedOn and S.Mods.SpeedVal or 16
		if S.Mods.Noclip and player.Character then for _,v in pairs(player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide=false end end end
	end
	-- fly
	if S.Mods.Fly and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local hrp=player.Character.HumanoidRootPart local mv=player.Character:FindFirstChildOfClass("Humanoid").MoveDirection
		hrp.Velocity=Vector3.new(mv.X*S.Mods.FlySpeed,0,mv.Z*S.Mods.FlySpeed)
		hrp.AssemblyLinearVelocity=Vector3.new(mv.X*S.Mods.FlySpeed,5,mv.Z*S.Mods.FlySpeed)
	end
	-- aimbot
	if S.Aim.Enabled and (S.Aim.Holding or S.Aim.MobileLock) then
		local best,cd=nil,S.Aim.Fov local mp=UserInputService:GetMouseLocation()
		for _,plr in pairs(Players:GetPlayers()) do
			if plr~=player and plr.Character then
				local pn=S.Aim.Part=="Random" and (math.random(2)==1 and "Head" or "HumanoidRootPart") or (S.Aim.Part=="Head" and "Head" or "HumanoidRootPart")
				local pt=plr.Character:FindFirstChild(pn) local hm=plr.Character:FindFirstChildOfClass("Humanoid")
				if pt and hm and hm.Health>0 then
					if S.Aim.TeamCheck and plr.Team==player.Team and player.Team~=nil then continue end
					local v,on=Camera:WorldToViewportPoint(pt.Position)
					if on then
						local d=math.sqrt((v.X-mp.X)^2+(v.Y-mp.Y)^2)
						if d<cd then
							if S.Aim.WallCheck then
								local pr=RaycastParams.new() pr.FilterType=Enum.RaycastFilterType.Exclude pr.FilterDescendantsInstances={player.Character,Camera}
								local r=workspace:Raycast(Camera.CFrame.Position,pt.Position-Camera.CFrame.Position,pr)
								if r and r.Instance and not r.Instance:IsDescendantOf(plr.Character) then continue end
							end
							cd=d best=pt
						end
					end
				end
			end
		end
		if best then
			if S.Aim.Silent then fovS.Color=Color3.fromRGB(255,60,120)
				Camera.CFrame=Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position,best.Position),math.clamp(S.Aim.Speed/100,.05,.5))
			else fovS.Color=Color3.new(1,1,1)
				Camera.CFrame=Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position,best.Position),math.clamp(S.Aim.Speed/50,.05,.8))
			end
		else fovS.Color=Color3.new(1,1,1) end
	end
end)

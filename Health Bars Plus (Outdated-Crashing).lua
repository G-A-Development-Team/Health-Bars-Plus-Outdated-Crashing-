local name = "Alice Health Bars"
local version = "1.0"

local screenH = draw.GetScreenSize("height");
local screenW = draw.GetScreenSize("width");
local locationX, locationY
local bars
local addi
local arbar
local araddi
local armextra

local playercount = 0

local locationX2, locationY2
local bars2
local addi2
local arbar2
local araddi2
local armextra2

local locationX3, locationY3
local bars3
local addi3
local arbar3
local araddi3
local armextra3

local showteam
local showenemyteam

local showteamxpos
local showteamypos

local showEnemyxpos
local showEnemyypos

local showhealthhudxpos
local showhealthhudypos

local showlocalplayer

local miscRef = gui.Reference("MISC");
local stgsRef = gui.Reference("Settings");

local configTabhud = gui.Tab(miscRef,"misc.gui_healthbarshud","Health Bars HUD");

local configTabstatshud = gui.Tab(miscRef,"misc.gui_statshud","Health Bars Stats HUD");
local statshudtogglesbox = gui.Groupbox(configTabstatshud, "Options", 10, 10, 300, 500)

local enablestatshud = gui.Checkbox(statshudtogglesbox,"misc.enablestatshud","Enable Stats HUD", false);

local boxstatshudpos = gui.Groupbox(configTabstatshud, "Stats HUD Positions", 320, 10, 300, 200)
local sliderstatshudxpos = gui.Slider(boxstatshudpos, "misc.sliderstatshudxpos","Stats HUD [XPos]",570,-screenW,screenW);
local sliderstatshudypos = gui.Slider(boxstatshudpos,"misc.sliderstatshudypos","Stats HUD [YPos]",-28,-screenH,screenH);

local statshudcolorsbox = gui.Groupbox(configTabstatshud, "Colors", 10, 103, 300, 500)
local backgroundcolorstatshud = gui.ColorPicker(statshudcolorsbox,"misc.backgroundcolorstatshud", "Background Color", 24,24,24,220);
local outlinecolorstatshud = gui.ColorPicker(statshudcolorsbox,"misc.outlinecolorstatshud", "Outline Color", 0,0,0,225);
local textcolorstatshud = gui.ColorPicker(statshudcolorsbox,"misc.textcolorstatshud", "Text Color", 255,255,0,225);


local boxstatshudsizes = gui.Groupbox(configTabstatshud, "Stats HUD Sizes", 320, 162, 300, 200)

local sliderstatshudsizeheight = gui.Slider(boxstatshudsizes, "misc.sliderstatshudsizeheight","Stats HUD [Height]",26,-screenH,348);
local sliderstatshudsizewidth = gui.Slider(boxstatshudsizes,"misc.sliderstatshudyposwidth","Stats HUD [Width]",546,357,screenW);
local sliderstatshudtextspacing = gui.Slider(boxstatshudsizes,"misc.sliderstatshudtextspacing","Text Spacing",0,0,100);

local settingstab = gui.Tab(stgsRef,"settings.gui_healthbarshud","Health Bars Settings");

local settingstaboptionsbox = gui.Groupbox(settingstab, "Font Update Checking (while menu is open)", 10, 10, 620, 500)
local enableconstantfontcheck = gui.Checkbox(settingstaboptionsbox,"misc.enableconstantfontcheck","Enable Font Loop Update Checking (Occurs while the Aimware menu is open)", false);
enableconstantfontcheck:SetDescription("When disabled, when you load configs with changed font size values you will have to manually apply the font from the button.")

local settingsplayercountstat = gui.Groupbox(settingstab, "Stats HUD Enable Player Count Check Loop", 10, 120, 620, 500)
local enableplayercountstats = gui.Checkbox(settingsplayercountstat,"misc.enableplayercountstats","Enable Loop to check for online players in an server.", false);
enableplayercountstats:SetDescription("When enabled, player count will always be 0 and save fps.")

local hudtogglesbox = gui.Groupbox(configTabhud, "Options", 10, 10, 300, 500)

local haharmorhealthhudpos = gui.Groupbox(configTabhud, "Health/Armor HUD Positions", 320, 10, 300, 200)


local slidershowhealthhudxpos = gui.Slider(haharmorhealthhudpos, "misc.hahshowhealthhudxpos","Health/Armor HUD [XPos]",132,0,screenW);
local slidershowhealthhudypos = gui.Slider(haharmorhealthhudpos,"misc.hahshowhealthhudypos","Health/Armor HUD [YPos]",779,0,screenH);



local hahsliderposcbox = gui.Groupbox(configTabhud, "Health/Armor HUD Counter Positions", 10, 283, 300, 200)
local hahsliderHealthCounterX = gui.Slider(hahsliderposcbox,"misc.hahhealthcounterx","Health Counter [XPos]",0,-screenW,screenW);
local hahsliderHealthCounter = gui.Slider(hahsliderposcbox,"misc.hahhealthcounter","Health Counter [YPos]",0,-screenH,screenH);
local hahsliderArmorCounterX = gui.Slider(hahsliderposcbox,"misc.haharmorcounterx","Armor Counter [XPos]",0,-screenW,screenW);
local hahsliderArmorCounter = gui.Slider(hahsliderposcbox,"misc.haharmorcounter","Armor Counter [YPos]",0,-screenH,screenH);

local hahsliderDefuseX = gui.Slider(hahsliderposcbox,"misc.hahdefusex","Defuse Indicator [XPos]",0,-screenW,screenW);
local hahsliderDefuse = gui.Slider(hahsliderposcbox,"misc.hahdefuse","Defuse Indicator [YPos]",0,-screenH,screenH);

local enablehealtharmorhud = gui.Checkbox(hudtogglesbox,"misc.hahenablehealtharmorhud","Enable Health/Armor HUD", false);

local hahenableoutlines = gui.Checkbox(hudtogglesbox,"misc.hahenableoutlines","Show Health/Armor HUD Outlines", true);
local shahenableoutlines = gui.Checkbox(hudtogglesbox,"misc.tshahenableoutlines","Show Health/Armor HUD Text Shadows", true);
local shahenablecounters = gui.Checkbox(hudtogglesbox,"misc.tshahenablecounters","Show Health/Armor HUD Counters", true);
local shahenabledefuseicon = gui.Checkbox(hudtogglesbox,"misc.tshahenabledefuseicon","Show Health/Armor HUD Defuse Indicator", true);

local hahslidertextsizebox = gui.Groupbox(configTabhud, "Health/Armor HUD Bar Sizes", 10, 628, 300, 200)
local hahsliderhealthbarsize = gui.Slider(hahslidertextsizebox,"misc.hahhealthbarsize","Health Bar Size [Height]",1,-25,10);

local hahsliderhealthbarsizeW = gui.Slider(hahslidertextsizebox,"misc.hahhealthbarsizeW","Health Bar Size [Width]",100,1,200);
local hahsliderarmorbarsize = gui.Slider(hahslidertextsizebox,"misc.haharmorbarsize","Armor Bar Size [Height]",1,-25,10);

local hahsliderarmorbarsizeW = gui.Slider(hahslidertextsizebox,"misc.haharmorbarsizeW","Armor Bar Size [Width]",100,1,200);


local hahslidertextsizebox = gui.Groupbox(configTabhud, "Health/Armor HUD Text Size", 10, 878, 300, 200)
local hahsliderhealthtextsize = gui.Slider(hahslidertextsizebox,"misc.hahsliderhealthtextsize","Health Counter",15,1,50);
local hahsliderarmortextsize = gui.Slider(hahslidertextsizebox,"misc.hahsliderarmortextsize","Armor Counter",15,1,50);
local hahsliderdefuseiconsize = gui.Slider(hahslidertextsizebox,"misc.hahsliderdefuseiconsize","Defuse Icon",15,1,50);


local haharmorcounterfont = draw.CreateFont("Bahnschrift", hahsliderarmortextsize:GetValue())
local hahhealthcounterfont = draw.CreateFont("Bahnschrift", hahsliderhealthtextsize:GetValue())
local hahdefuseiconfont = draw.CreateFont("Bahnschrift", hahsliderdefuseiconsize:GetValue())

local hahbuttonapplytextsize = gui.Button(hahslidertextsizebox, "Apply Size", function()
    haharmorcounterfont = draw.CreateFont("Bahnschrift", hahsliderarmortextsize:GetValue())
    hahhealthcounterfont = draw.CreateFont("Bahnschrift", hahsliderhealthtextsize:GetValue())
    hahdefuseiconfont = draw.CreateFont("Bahnschrift", hahsliderdefuseiconsize:GetValue())
end)


local configTab = gui.Tab(miscRef,"misc.gui_healthbars","Health Bars");
local sliderposbox = gui.Groupbox(configTab, "Bar Positions", 10, 10, 300, 200)

local healtharmorlocalhudpos = gui.Groupbox(configTabhud, "Health/Armor HUD Local Bar Positions", 320, 165, 300, 500)

local hahhudcolors = gui.Groupbox(configTabhud, "Health/Armor HUD Colors", 320, 415, 300, 500)


local hahhealthcolor = gui.ColorPicker(hahhudcolors,"misc.hahbar_healthcolor", "[Health Color]", 232, 70, 19, 255);
local haharmorcolor = gui.ColorPicker(hahhudcolors,"misc.hahbar_armorcolor", "[Armor Color]", 0, 167, 255, 255);

local hahhealthbarcolorplace = gui.ColorPicker(hahhudcolors,"misc.hahbar_healthplace", "Health Bar Placeholder", 33, 33, 33, 200);
local haharmorbarcolorplace = gui.ColorPicker(hahhudcolors,"misc.hahbar_armorplace", "Armor Bar Placeholder", 33, 33, 33, 200);

local hahcounterhealthbarcolorplace = gui.ColorPicker(hahhudcolors,"misc.hahcounterbar_healthplace", "Health Counter [Text Color]", 16, 232, 18, 255);
local hahcounterarmorbarcolorplace = gui.ColorPicker(hahhudcolors,"misc.hahcounterbar_armorplace", "Armor Counter [Text Color]", 0, 167, 255, 255);
local hahdefusecolor = gui.ColorPicker(hahhudcolors,"misc.hahdefusecolor", "Defuse Indicator [Color]", 0, 167, 255, 255);

local haharmorboxoutlinecolor = gui.ColorPicker(hahhudcolors,"misc.haharmorboxoutlinecolor", "Armor Box Outline Color", 0,0,0,255);
local hahhealthboxoutlinecolor = gui.ColorPicker(hahhudcolors,"misc.hahhealthboxoutlinecolor", "Health Box Outline Color", 0,0,0,255);



local hahsliderlochealthposx = gui.Slider(healtharmorlocalhudpos,"misc.hahhealthlocalposx","Local Health Bar [XPos]",0,-screenW,screenW);
local hahsliderlochealthpos = gui.Slider(healtharmorlocalhudpos,"misc.hahhealthlocalpos","Local Health Bar [YPos]",0,-screenW,screenW);

local hahsliderlocarmorposx = gui.Slider(healtharmorlocalhudpos,"misc.haharmorlocalposx","Local Armor Bar [XPos]",0,-screenW,screenW);
local hahsliderlocarmorpos = gui.Slider(healtharmorlocalhudpos,"misc.haharmorlocalpos","Local Armor Bar [YPos]",0,-screenW,screenW);

local sliderhealthsizebox = gui.Groupbox(configTab, "Health Bar Sizes", 320, 10, 300, 200)

local togglesbox = gui.Groupbox(configTab, "Options", 320, 165, 300, 400)

local sliderarmorcounterbox = gui.Groupbox(configTab, "Armor Counter Positions", 320, 477, 300, 400)

local sliderteamxpos = gui.Slider(sliderposbox,"misc.healthbarlocationx","My team [XPos]",230,0,screenW);
local sliderteamypos = gui.Slider(sliderposbox,"misc.healthbarlocationy","My team [YPos]",400,0,screenH);

local sliderEnemyxpos = gui.Slider(sliderposbox,"misc.healthbarlocationex","Enemy team [XPos]",25,0,screenW);
local sliderEnemyypos = gui.Slider(sliderposbox,"misc.healthbarlocationey","Enemy team [YPos]",400,0,screenH);


local sliderhealthbarsize = gui.Slider(sliderhealthsizebox,"misc.healthbarsize","Health Bar Size [Height]",1,-25,10);

local sliderhealthbarsizeW = gui.Slider(sliderhealthsizebox,"misc.healthbarsizeW","Health Bar Size [Width]",100,1,200);

local sliderarmorposbox = gui.Groupbox(configTab, "Armor Bar Sizes", 10, 260, 300, 200)

local slidercharlimitbox = gui.Groupbox(configTab, "Limits", 10, 415, 300, 200)

local sliderhealthcountersbox = gui.Groupbox(configTab, "Health Counter Positions", 10, 523, 300, 200)

local sliderdefusebox = gui.Groupbox(configTab, "Defuse Indicator Positions", 10, 775, 300, 200)

local slidernamebox = gui.Groupbox(configTab, "Name Positions", 10, 1027, 300, 200)
local sliderlocbarposbox = gui.Groupbox(configTab, "Local Bar Positions", 10, 1280, 300, 200)

local slidertextsizebox = gui.Groupbox(configTab, "Text Size", 10, 1722, 300, 500)
local slidernametextsize = gui.Slider(slidertextsizebox,"misc.nametextsize","Nametags",20,1,50);
local sliderhealthtextsize = gui.Slider(slidertextsizebox,"misc.sliderhealthtextsize","Health Counter",15,1,50);
local sliderarmortextsize = gui.Slider(slidertextsizebox,"misc.sliderarmortextsize","Armor Counter",15,1,50);
local sliderdefuseiconsize = gui.Slider(slidertextsizebox,"misc.sliderdefuseiconsize","Defuse Icon",15,1,50);


local nametagfont = draw.CreateFont("Bahnschrift", slidernametextsize:GetValue())
local armorcounterfont = draw.CreateFont("Bahnschrift", sliderarmortextsize:GetValue())
local healthcounterfont = draw.CreateFont("Bahnschrift", sliderhealthtextsize:GetValue())
local defuseiconfont = draw.CreateFont("Bahnschrift", sliderdefuseiconsize:GetValue())

local buttonapplytextsize = gui.Button(slidertextsizebox, "Apply Size", function()
    nametagfont = draw.CreateFont("Bahnschrift", slidernametextsize:GetValue())
    armorcounterfont = draw.CreateFont("Bahnschrift", sliderarmortextsize:GetValue())
    healthcounterfont = draw.CreateFont("Bahnschrift", sliderhealthtextsize:GetValue())
    defuseiconfont = draw.CreateFont("Bahnschrift", sliderdefuseiconsize:GetValue())
end)

local sliderlochealthposx = gui.Slider(sliderlocbarposbox,"misc.healthlocalposx","Local Health Bar [XPos]",0,-screenW,screenW);
local sliderlochealthpos = gui.Slider(sliderlocbarposbox,"misc.healthlocalpos","Local Health Bar [YPos]",0,-screenW,screenW);

local sliderlocarmorposx = gui.Slider(sliderlocbarposbox,"misc.armorlocalposx","Local Armor Bar [XPos]",0,-screenW,screenW);
local sliderlocarmorpos = gui.Slider(sliderlocbarposbox,"misc.armorlocalpos","Local Armor Bar [YPos]",0,-screenW,screenW);

local esliderlochealthposx = gui.Slider(sliderlocbarposbox,"misc.ehealthlocalposx","Enemy Local Health Bar [XPos]",0,-screenW,screenW);
local esliderlochealthpos = gui.Slider(sliderlocbarposbox,"misc.ehealthlocalpos","Enemy Local Health Bar [YPos]",0,-screenW,screenW);

local esliderlocarmorposx = gui.Slider(sliderlocbarposbox,"misc.earmorlocalposx","Enemy Local Armor Bar [XPos]",0,-screenW,screenW);
local esliderlocarmorpos = gui.Slider(sliderlocbarposbox,"misc.earmorlocalpos","Enemy Local Armor Bar [YPos]",0,-screenW,screenW);

local slidernameposx = gui.Slider(slidernamebox,"misc.nameposx","Team Name [XPos]",0,-screenW,screenW);
local slidernamepos = gui.Slider(slidernamebox,"misc.namepos","Team Name [YPos]",0,-screenH,screenH);

local eslidernameposx = gui.Slider(slidernamebox,"misc.enameposx","Enemy Name [XPos]",0,-screenW,screenW);
local eslidernamepos = gui.Slider(slidernamebox,"misc.enamepos","Enemy Name [YPos]",0,-screenH,screenH);

local sliderarmorbarsize = gui.Slider(sliderarmorposbox,"misc.armorbarsize","Armor Bar Size [Height]",1,-25,10);

local sliderarmorbarsizeW = gui.Slider(sliderarmorposbox,"misc.armorbarsizeW","Armor Bar Size [Width]",100,1,200);

local slidercharlength = gui.Slider(slidercharlimitbox,"misc.charlength","Max Name Char Limit [No Unicode Support]",10,1,35);

local chkShowEnemyTeam = gui.Checkbox( togglesbox, "misc.chk_enemyteam", "Show Enemy Team", true );
local chkShowMyTeam = gui.Checkbox( togglesbox, "misc.chk_myteam", "Show My Team", true );
local chkShowLocalPlayer = gui.Checkbox( togglesbox, "misc.chk_localplayer", "Show Local Player", false );
local chkShowDefuse= gui.Checkbox( togglesbox, "misc.chk_showdefuser", "Show Defuse Indicator", true );

local chkShowCounters = gui.Checkbox( togglesbox, "misc.chk_counters", "Show Healh/Armor Counters", true );

local sliderHealthCounterX = gui.Slider(sliderhealthcountersbox,"misc.healthcounterx","Health Counter [XPos]",0,-screenW,screenW);
local sliderHealthCounter = gui.Slider(sliderhealthcountersbox,"misc.healthcounter","Health Counter [YPos]",0,-screenH,screenH);

local esliderHealthCounterX = gui.Slider(sliderhealthcountersbox,"misc.ehealthcounterx","Enemy Health Counter [XPos]",0,-screenW,screenW);
local esliderHealthCounter = gui.Slider(sliderhealthcountersbox,"misc.ehealthcounter","Enemy Health Counter [YPos]",0,-screenH,screenH);


local sliderArmorCounterX = gui.Slider(sliderarmorcounterbox,"misc.armorcounterx","Armor Counter [XPos]",0,-screenW,screenW);
local sliderArmorCounter = gui.Slider(sliderarmorcounterbox,"misc.armorcounter","Armor Counter [YPos]",0,-screenH,screenH);

local sliderDefuseX = gui.Slider(sliderdefusebox,"misc.defusex","Defuse Indicator [XPos]",0,-screenW,screenW);
local sliderDefuse = gui.Slider(sliderdefusebox,"misc.defuse","Defuse Indicator [YPos]",0,-screenH,screenH);

local esliderArmorCounterX = gui.Slider(sliderarmorcounterbox,"misc.earmorcounterx","Enemy Armor Counter [XPos]",0,-screenW,screenW);
local esliderArmorCounter = gui.Slider(sliderarmorcounterbox,"misc.earmorcounter","Enemy Armor Counter [YPos]",0,-screenH,screenH);

local esliderDefuseX = gui.Slider(sliderdefusebox,"misc.edefusex","Enemy Defuse Indicator [XPos]",0,-screenW,screenW);
local esliderDefuse = gui.Slider(sliderdefusebox,"misc.edefuse","Enemy Defuse Indicator [YPos]",0,-screenH,screenH);

local chkShowOutlines = gui.Checkbox( togglesbox, "misc.chk_outlines", "Show Box Outlines", true );
local chkShowTextShadows = gui.Checkbox( togglesbox, "misc.chk_textshadow", "Show Text Shadows", true );


local myteamtextcolor = gui.ColorPicker(configTab,"misc.bar_myteamtextcolor", "My Team [Text Color]", 236, 229, 3, 255);
local myteamhealthcolor = gui.ColorPicker(configTab,"misc.bar_myteamhealthcolor", "My Team [Health Color]", 16, 232, 18, 255);
local myteamarmorcolor = gui.ColorPicker(configTab,"misc.bar_myteamarmorcolor", "My Team [Armor Color]", 0, 167, 255, 255);

local enemytextcolor = gui.ColorPicker(configTab,"misc.bar_enemytextcolor", "Enemy Team [Text Color]", 236, 229, 3, 255);
local enemyhealthcolor = gui.ColorPicker(configTab,"misc.bar_enemyhealthcolor", "Enemy Team [Health Color]", 232, 70, 19, 255);
local enemyarmorcolor = gui.ColorPicker(configTab,"misc.bar_enemyarmorcolor", "Enemy Team [Armor Color]", 0, 167, 255, 255);

local healthbarcolorplace = gui.ColorPicker(configTab,"misc.bar_healthplace", "Health Bar Placeholder", 33, 33, 33, 200);
local armorbarcolorplace = gui.ColorPicker(configTab,"misc.bar_armorplace", "Armor Bar Placeholder", 33, 33, 33, 200);

local counterhealthbarcolorplace = gui.ColorPicker(configTab,"misc.counterbar_healthplace", "Health Counter [Text Color]", 16, 232, 18, 255);
local counterarmorbarcolorplace = gui.ColorPicker(configTab,"misc.counterbar_armorplace", "Armor Counter [Text Color]", 0, 167, 255, 255);
local defusecolor = gui.ColorPicker(configTab,"misc.defusecolor", "Defuse Indicator [Color]", 0, 167, 255, 255);

local armorboxoutlinecolor = gui.ColorPicker(configTab,"misc.armorboxoutlinecolor", "Armor Box Outline Color", 0,0,0,255);
local healthboxoutlinecolor = gui.ColorPicker(configTab,"misc.healthboxoutlinecolor", "Health Box Outline Color", 0,0,0,255);

local healthbarknockoff
local healthbarknockoff2
local otherhealthbarknockoff
local otherhealthbarknockoff2
local armorbarknockoff
local armorbarknockoff2

local multiplyhealthbarwidth
local multiplyhealthbarwidth2
local multiplyarmorbarwidth
local multiplyarmorbarwidth2

function healtharmorhud()
    local player = entities.GetLocalPlayer();
    local armor = 0
    local incSize = multiplyhealthbarwidth2/player:GetMaxHealth()
    local incSizeArmor = multiplyarmorbarwidth2/100
    armor = player:GetProp("m_ArmorValue");

    --Armor Placeholder
    draw.Color(haharmorbarcolorplace:GetValue());
    draw.FilledRect( showhealthhudxpos + hahsliderlocarmorposx:GetValue(), bars3 + 18 + armextra3 + armorbarknockoff2+ hahsliderlocarmorpos:GetValue(), 100*incSizeArmor + showhealthhudxpos+ hahsliderlocarmorposx:GetValue(), arbar3 + 30 + armextra3+ hahsliderlocarmorpos:GetValue())

    --Health Placeholder
    draw.Color(hahhealthbarcolorplace:GetValue());
    draw.FilledRect( showhealthhudxpos + hahsliderlochealthposx:GetValue(), bars3 + 18 + armextra3 + 35 + otherhealthbarknockoff2 + hahsliderlochealthpos:GetValue(), player:GetMaxHealth()*incSize +showhealthhudxpos + hahsliderlochealthposx:GetValue(), arbar3 + 30 + armextra3 + healthbarknockoff2  + hahsliderlochealthpos:GetValue())

    --Armor Status
    draw.Color(haharmorcolor:GetValue());
    draw.FilledRect( showhealthhudxpos+ hahsliderlocarmorposx:GetValue(), bars3 + 18 + armextra3 + armorbarknockoff2+ hahsliderlocarmorpos:GetValue(), armor*incSizeArmor +showhealthhudxpos+ hahsliderlocarmorposx:GetValue(), arbar3 + 30 + armextra3+ hahsliderlocarmorpos:GetValue())

    --Health Status
    draw.Color(hahhealthcolor:GetValue());
    draw.FilledRect( showhealthhudxpos + hahsliderlochealthposx:GetValue(), bars3 + 18 + armextra3 + 35 + otherhealthbarknockoff2  + hahsliderlochealthpos:GetValue(), player:GetHealth()*incSize + showhealthhudxpos + hahsliderlochealthposx:GetValue(), arbar3 + 30 + armextra3 + healthbarknockoff2  + hahsliderlochealthpos:GetValue())

    --Check if HUD outlines enabled
    if hahenableoutlines:GetValue() == true then
        --Health Placeholder
        draw.Color(hahhealthboxoutlinecolor:GetValue());
        draw.OutlinedRect(showhealthhudxpos + hahsliderlochealthposx:GetValue(), bars3 + 18 + armextra3 + 35 + otherhealthbarknockoff2 + hahsliderlochealthpos:GetValue(), player:GetMaxHealth()*incSize +showhealthhudxpos + hahsliderlochealthposx:GetValue(), arbar3 + 30 + armextra3 + healthbarknockoff2  + hahsliderlochealthpos:GetValue())
        
        --Health Status
        --Check if armor is 0 to draw outline or not
        if player:GetHealth() == 0 then
        else
            draw.Color(hahhealthboxoutlinecolor:GetValue());
            draw.OutlinedRect( showhealthhudxpos + hahsliderlochealthposx:GetValue(), bars3 + 18 + armextra3 + 35 + otherhealthbarknockoff2  + hahsliderlochealthpos:GetValue(), player:GetHealth()*incSize + showhealthhudxpos + hahsliderlochealthposx:GetValue(), arbar3 + 30 + armextra3 + healthbarknockoff2  + hahsliderlochealthpos:GetValue())
        end
        
        --Armor Placeholder
        draw.Color(haharmorboxoutlinecolor:GetValue());
        draw.OutlinedRect( showhealthhudxpos + hahsliderlocarmorposx:GetValue(), bars3 + 18 + armextra3 + armorbarknockoff2+ hahsliderlocarmorpos:GetValue(), 100*incSizeArmor + showhealthhudxpos+ hahsliderlocarmorposx:GetValue(), arbar3 + 30 + armextra3+ hahsliderlocarmorpos:GetValue())
        
        --Armor Status
        --Check if armor is 0 to draw outline or not
        if armor == 0 then
        else
            draw.Color(haharmorboxoutlinecolor:GetValue());
            draw.OutlinedRect( showhealthhudxpos+ hahsliderlocarmorposx:GetValue(), bars3 + 18 + armextra3 + armorbarknockoff2+ hahsliderlocarmorpos:GetValue(), armor*incSizeArmor +showhealthhudxpos+ hahsliderlocarmorposx:GetValue(), arbar3 + 30 + armextra3+ hahsliderlocarmorpos:GetValue())
        end
    end

    --Check if HUD counters enabled
    if shahenablecounters:GetValue() == true then
        draw.SetFont(hahhealthcounterfont);
        draw.Color(hahcounterhealthbarcolorplace:GetValue());
        if shahenableoutlines:GetValue() == true then
            draw.TextShadow( showhealthhudxpos + player:GetMaxHealth()*incSize + hahsliderHealthCounterX:GetValue(), bars3 + armextra3 + 8+ hahsliderHealthCounter:GetValue(), player:GetHealth());
        else
            draw.Text( showhealthhudxpos + player:GetMaxHealth()*incSize + hahsliderHealthCounterX:GetValue(), bars3 + armextra3 + 8 + hahsliderHealthCounter:GetValue(), player:GetHealth());
        end
        draw.SetFont(haharmorcounterfont)
        draw.Color(hahcounterarmorbarcolorplace:GetValue());
        if shahenableoutlines:GetValue() == true then
            draw.TextShadow( showhealthhudxpos + 100*incSizeArmor  + hahsliderArmorCounterX:GetValue(), bars3 + armextra3 - 3  + hahsliderArmorCounter:GetValue(), armor);
        else
            draw.Text( showhealthhudxpos + 100*incSizeArmor  + hahsliderArmorCounterX:GetValue(), bars3 + armextra3 - 3  + hahsliderArmorCounter:GetValue(), armor);
        end
        
    end
    --Setup defuse icon font
    draw.SetFont( hahdefuseiconfont )
    draw.Color(hahdefusecolor:GetValue());

    --Check if HUD defuse icon enabled
    if shahenabledefuseicon:GetValue() == true then
        if player:GetPropBool("m_bHasDefuser") == true then
            if shahenableoutlines:GetValue() == true then
                draw.TextShadow( showhealthhudxpos + 100*incSizeArmor + hahsliderDefuseX:GetValue() + 20, bars3 + armextra3 - 3 + hahsliderDefuse:GetValue(), "✔");
            else
                draw.Text( showhealthhudxpos + 100*incSizeArmor + hahsliderDefuseX:GetValue() + 20, bars3 + armextra3 - 3 + hahsliderDefuse:GetValue(), "✔");
            end
        end
    end

    locationY3 = locationY3 + 50;
    addi3 = addi3 + 50
    araddi3 = araddi3 + 50;
    armextra3 = armextra3 + 60;
end

function showHUD()
    healtharmorhud();
    --Set hud to invisible
    client.SetConVar("hidehud", 8, true)
end

function showStatsHUD()
    draw.SetFont( draw.CreateFont("Bahnschrift", 15));
    draw.Color(backgroundcolorstatshud:GetValue());
    draw.FilledRect( 500 + sliderstatshudxpos:GetValue(), 500 + sliderstatshudypos:GetValue(), 150 + sliderstatshudxpos:GetValue() + sliderstatshudsizewidth:GetValue(), 150 + sliderstatshudypos:GetValue() + sliderstatshudsizeheight:GetValue());
    draw.Color(outlinecolorstatshud:GetValue());
    draw.OutlinedRect( 500 + sliderstatshudxpos:GetValue(), 500 + sliderstatshudypos:GetValue(), 150 + sliderstatshudxpos:GetValue() + sliderstatshudsizewidth:GetValue(), 150 + sliderstatshudypos:GetValue() + sliderstatshudsizeheight:GetValue());
    
    local server = engine.GetServerIP();
    if server == "loopback" then
        server = "localhost";
    end
    draw.Color(textcolorstatshud:GetValue());
    draw.TextShadow( 505 + sliderstatshudxpos:GetValue(), 155 + sliderstatshudypos:GetValue() + sliderstatshudsizeheight:GetValue(), "IP: " .. server);
    draw.TextShadow( 505 + sliderstatshudxpos:GetValue(), 167 + sliderstatshudypos:GetValue() + sliderstatshudsizeheight:GetValue(), "Map: " .. engine.GetMapName());
    draw.TextShadow( 505 + sliderstatshudxpos:GetValue(), 179 + sliderstatshudypos:GetValue() + sliderstatshudsizeheight:GetValue(), "MaxPlayers: " .. globals.MaxClients());
    draw.TextShadow( 505 + sliderstatshudxpos:GetValue(), 191 + sliderstatshudypos:GetValue() + sliderstatshudsizeheight:GetValue(), "PlayerCount: " .. playercount);
    draw.TextShadow( 505 + sliderstatshudxpos:GetValue(), 203 + sliderstatshudypos:GetValue() + sliderstatshudsizeheight:GetValue(), "ClientTick: " .. globals.TickCount());

    --Rect( sliderstatshudxpos, sliderstatshudypos, sliderstatshudxpos, sliderstatshudypos );
end

function EnemyTeamDrawUser(player)
    local armor = 0
    local incSize = multiplyhealthbarwidth/player:GetMaxHealth()
    local incSizeArmor = multiplyarmorbarwidth/100
    armor = player:GetProp("m_ArmorValue");

    --draw.SetFont(font1);

    draw.Color(13, 13, 13, 1);

    draw.OutlinedRect( showEnemyxpos, bars2, 300, bars2 + addi2 );

    --Armor bar
    draw.Color(armorbarcolorplace:GetValue());
    draw.FilledRect( showEnemyxpos + esliderlocarmorposx:GetValue(), bars2 + 18 + armextra2 + armorbarknockoff+ esliderlocarmorpos:GetValue(), 100*incSizeArmor + showEnemyxpos+ esliderlocarmorposx:GetValue(), arbar2 + 30 + armextra2+ esliderlocarmorpos:GetValue())

    --Health bar
    draw.Color(healthbarcolorplace:GetValue());
    draw.FilledRect( showEnemyxpos + esliderlochealthposx:GetValue(), bars2 + 18 + armextra2 + 35 + otherhealthbarknockoff + esliderlochealthpos:GetValue(), player:GetMaxHealth()*incSize +showEnemyxpos + esliderlochealthposx:GetValue(), arbar2 + 30 + armextra2 + healthbarknockoff  + esliderlochealthpos:GetValue())

    --Full armor
    draw.Color(enemyarmorcolor:GetValue());
    draw.FilledRect( showEnemyxpos+ esliderlocarmorposx:GetValue(), bars2 + 18 + armextra2 + armorbarknockoff+ esliderlocarmorpos:GetValue(), armor*incSizeArmor +showEnemyxpos+ esliderlocarmorposx:GetValue(), arbar2 + 30 + armextra2+ esliderlocarmorpos:GetValue())

    --Full health
    draw.Color(enemyhealthcolor:GetValue());
    draw.FilledRect( showEnemyxpos + esliderlochealthposx:GetValue(), bars2 + 18 + armextra2 + 35 + otherhealthbarknockoff  + esliderlochealthpos:GetValue(), player:GetHealth()*incSize + showEnemyxpos + esliderlochealthposx:GetValue(), arbar2 + 30 + armextra2 + healthbarknockoff  + esliderlochealthpos:GetValue())


    if chkShowOutlines:GetValue() == true then
        --Health Placeholder
        draw.Color(healthboxoutlinecolor:GetValue());
        draw.OutlinedRect(showEnemyxpos + esliderlochealthposx:GetValue(), bars2 + 18 + armextra2 + 35 + otherhealthbarknockoff  + esliderlochealthpos:GetValue(), player:GetMaxHealth()*incSize +showEnemyxpos+ esliderlochealthposx:GetValue(), arbar2 + 30 + armextra2 + healthbarknockoff  + esliderlochealthpos:GetValue())
        --Health Status
        --Check if health is 0 to draw outline or not
        if player:GetHealth() == 0 then
        else
            draw.Color(healthboxoutlinecolor:GetValue());
            draw.OutlinedRect( showEnemyxpos + esliderlochealthposx:GetValue(), bars2 + 18 + armextra2 + 35 + otherhealthbarknockoff  + esliderlochealthpos:GetValue(), player:GetHealth()*incSize + showEnemyxpos+ esliderlochealthposx:GetValue(), arbar2 + 30 + armextra2 + healthbarknockoff  + esliderlochealthpos:GetValue())
        end
        
        --Armor Placeholder
        draw.Color(armorboxoutlinecolor:GetValue());
        draw.OutlinedRect( showEnemyxpos+ esliderlocarmorposx:GetValue(), bars2 + 18 + armextra2 + armorbarknockoff+ esliderlocarmorpos:GetValue(), 100*incSizeArmor + showEnemyxpos+ esliderlocarmorposx:GetValue(), arbar2 + 30 + armextra2+ esliderlocarmorpos:GetValue())
        --Armor Status
        --Check if armor is 0 to draw outline or not
        if armor == 0 then
        else
            draw.Color(armorboxoutlinecolor:GetValue());
            draw.OutlinedRect( showEnemyxpos+ esliderlocarmorposx:GetValue(), bars2 + 18 + armextra2 + armorbarknockoff+ esliderlocarmorpos:GetValue(), armor*incSizeArmor +showEnemyxpos+ esliderlocarmorposx:GetValue(), arbar2 + 30 + armextra2+ esliderlocarmorpos:GetValue())
        end
    end

    draw.SetFont(nametagfont);
    draw.Color(enemytextcolor:GetValue());
    local name = string.sub(player:GetName(), 1, slidercharlength:GetValue())
    if chkShowTextShadows:GetValue() == true then
        draw.TextShadow( showEnemyxpos + eslidernameposx:GetValue(), bars2 + armextra2 + eslidernamepos:GetValue(), name);
    else
        draw.Text( showEnemyxpos + eslidernameposx:GetValue(), bars2 + armextra2 + eslidernamepos:GetValue(), name);
    end

    if chkShowCounters:GetValue() == true then
        draw.SetFont(healthcounterfont);
        draw.Color(counterhealthbarcolorplace:GetValue());
        if chkShowTextShadows:GetValue() == true then
            draw.TextShadow( showEnemyxpos + player:GetMaxHealth()*incSize + esliderHealthCounterX:GetValue(), bars2 + armextra2 + 8+ esliderHealthCounter:GetValue(), player:GetHealth());
        else
            draw.Text( showEnemyxpos + player:GetMaxHealth()*incSize + esliderHealthCounterX:GetValue(), bars2 + armextra2 + 8 + esliderHealthCounter:GetValue(), player:GetHealth());
        end
        draw.SetFont(armorcounterfont)
        draw.Color(counterarmorbarcolorplace:GetValue());
        if chkShowTextShadows:GetValue() == true then
            draw.TextShadow( showEnemyxpos + 100*incSizeArmor  + esliderArmorCounterX:GetValue(), bars2 + armextra2 - 3  + esliderArmorCounter:GetValue(), armor);
        else
            draw.Text( showEnemyxpos + 100*incSizeArmor  + esliderArmorCounterX:GetValue(), bars2 + armextra2 - 3  + esliderArmorCounter:GetValue(), armor);
        end
        
    end
    draw.SetFont( defuseiconfont )
    draw.Color(defusecolor:GetValue());
    if chkShowDefuse:GetValue() == true then
        if player:GetPropBool("m_bHasDefuser") == true then
            if chkShowTextShadows:GetValue() == true then
                draw.TextShadow( showEnemyxpos + 100*incSizeArmor + esliderDefuseX:GetValue() + 20, bars2 + armextra2 - 3 + esliderDefuse:GetValue(), "✔");
            else
                draw.Text( showEnemyxpos + 100*incSizeArmor + esliderDefuseX:GetValue() + 20, bars2 + armextra2 - 3 + esliderDefuse:GetValue(), "✔");
            end
        end
    end

    locationY2 = locationY2 + 50;
    addi2 = addi2 + 50
    araddi2 = araddi2 + 50;
    armextra2 = armextra2 + 60;
end

function MyTeamDrawUser(player)
    local armor = 0
    local incSize = multiplyhealthbarwidth/player:GetMaxHealth()
    local incSizeArmor = multiplyarmorbarwidth/100

    armor = player:GetProp("m_ArmorValue");

    --draw.SetFont(font1);
    draw.Color(13, 13, 13, 1);

    draw.OutlinedRect( showteamxpos, bars, 300, bars + addi );

    --Armor bar
    draw.Color(armorbarcolorplace:GetValue());
    draw.FilledRect( showteamxpos + sliderlocarmorposx:GetValue(), bars + 18 + armextra + armorbarknockoff+ sliderlocarmorpos:GetValue(), 100*incSizeArmor + showteamxpos + sliderlocarmorposx:GetValue(), arbar + 30 + armextra + sliderlocarmorpos:GetValue())

    --Health bar
    draw.Color(healthbarcolorplace:GetValue());
    draw.FilledRect( showteamxpos + sliderlochealthposx:GetValue(), bars + 18 + armextra + 35 + otherhealthbarknockoff + sliderlochealthpos:GetValue(), player:GetMaxHealth()*incSize +showteamxpos + sliderlochealthposx:GetValue(), arbar + 30 + armextra + healthbarknockoff+ sliderlochealthpos:GetValue())

    --Full armor
    draw.Color(myteamarmorcolor:GetValue());
    draw.FilledRect( showteamxpos+ sliderlocarmorposx:GetValue(), bars + 18 + armextra + armorbarknockoff+ sliderlocarmorpos:GetValue(), armor*incSizeArmor +showteamxpos+ sliderlocarmorposx:GetValue(), arbar + 30 + armextra+ sliderlocarmorpos:GetValue())

    --Full health
    draw.Color(myteamhealthcolor:GetValue());
    draw.FilledRect( showteamxpos + sliderlochealthposx:GetValue(), bars + 18 + armextra + 35 + otherhealthbarknockoff + sliderlochealthpos:GetValue(), player:GetHealth()*incSize + showteamxpos + sliderlochealthposx:GetValue(), arbar + 30 + armextra + healthbarknockoff + sliderlochealthpos:GetValue())

    if chkShowOutlines:GetValue() == true then
        --health
        draw.Color(healthboxoutlinecolor:GetValue());
        draw.OutlinedRect( showteamxpos + sliderlochealthposx:GetValue(), bars + 18 + armextra + 35 + otherhealthbarknockoff + sliderlochealthpos:GetValue(), player:GetMaxHealth()*incSize +showteamxpos + sliderlochealthposx:GetValue(), arbar + 30 + armextra + healthbarknockoff + sliderlochealthpos:GetValue())
        --health status
        draw.Color(healthboxoutlinecolor:GetValue());
        draw.OutlinedRect( showteamxpos + sliderlochealthposx:GetValue(), bars + 18 + armextra + 35 + otherhealthbarknockoff + sliderlochealthpos:GetValue(), player:GetHealth()*incSize + showteamxpos + sliderlochealthposx:GetValue(), arbar + 30 + armextra + healthbarknockoff + sliderlochealthpos:GetValue())
        --armor
        draw.Color(armorboxoutlinecolor:GetValue());
        draw.OutlinedRect( showteamxpos+ sliderlocarmorposx:GetValue(), bars + 18 + armextra + armorbarknockoff+ sliderlocarmorpos:GetValue(), 100*incSizeArmor + showteamxpos+ sliderlocarmorposx:GetValue(), arbar + 30 + armextra+ sliderlocarmorpos:GetValue())
        --armor status
        if armor == 0 then
        else
            draw.Color(armorboxoutlinecolor:GetValue());
            draw.OutlinedRect( showteamxpos+ sliderlocarmorposx:GetValue(), bars + 18 + armextra + armorbarknockoff+ sliderlocarmorpos:GetValue(), armor*incSizeArmor +showteamxpos+ sliderlocarmorposx:GetValue(), arbar + 30 + armextra+ sliderlocarmorpos:GetValue())
        end
    end

    draw.SetFont(nametagfont);
    draw.Color(myteamtextcolor:GetValue());
    local name = string.sub(player:GetName(), 1, slidercharlength:GetValue())
    if chkShowTextShadows:GetValue() == true then
        draw.TextShadow( showteamxpos + slidernameposx:GetValue(), bars + armextra + slidernamepos:GetValue(), name);
    else
        draw.Text( showteamxpos + slidernameposx:GetValue(), bars + armextra + slidernamepos:GetValue(), name);
    end

    if chkShowCounters:GetValue() == true then
        draw.SetFont(healthcounterfont);
        draw.Color(counterhealthbarcolorplace:GetValue());
        if chkShowTextShadows:GetValue() == true then
            draw.TextShadow( showteamxpos + player:GetMaxHealth()*incSize + sliderHealthCounterX:GetValue(), bars + armextra + 8 + sliderHealthCounter:GetValue(), player:GetHealth());
        else
            draw.Text( showteamxpos + player:GetMaxHealth()*incSize + sliderHealthCounterX:GetValue(), bars + armextra + 8 + sliderHealthCounter:GetValue(), player:GetHealth());
        end
        draw.SetFont(armorcounterfont);
        draw.Color(counterarmorbarcolorplace:GetValue());
        if chkShowTextShadows:GetValue() == true then
            draw.TextShadow( showteamxpos + 100*incSizeArmor + sliderArmorCounterX:GetValue(), bars + armextra - 3 + sliderArmorCounter:GetValue(), armor);
        else
            draw.Text( showteamxpos + 100*incSizeArmor + sliderArmorCounterX:GetValue(), bars + armextra - 3 + sliderArmorCounter:GetValue(), armor);
        end
    
    end
    draw.SetFont( defuseiconfont )
    draw.Color(defusecolor:GetValue());
    if chkShowDefuse:GetValue() == true then
        if player:GetPropBool("m_bHasDefuser") == true then
            if chkShowTextShadows:GetValue() == true then
                draw.TextShadow( showteamxpos + 100*incSizeArmor + sliderDefuseX:GetValue() + 20, bars + armextra - 3 + sliderDefuse:GetValue(), "✔");
            else
                draw.Text( showteamxpos + 100*incSizeArmor + sliderDefuseX:GetValue() + 20, bars + armextra - 3 + sliderDefuse:GetValue(), "✔");
            end
        end
    end

    locationY = locationY + 50;
    --bars = bars + 60;
    addi = addi + 50
    araddi = araddi + 50;
    armextra = armextra + 60;
end

local chatdata = {}
local chatnumber = 1
local appliedstartupfonts = false


local function DrawingHook()
    --Default location
    
    showteam = chkShowMyTeam:GetValue();
    showenemyteam = chkShowEnemyTeam:GetValue();
    locationX = 25;
    locationY = 420;
    bars = 420;
    arbar = 420;
    addi = 50;
    araddi = 18;
    armextra = 0;

    locationX2 = 25;
    locationY2 = 420;
    bars2 = 420;
    arbar2 = 420;
    addi2 = 50;
    araddi2 = 18;
    armextra2 = 0;

    locationX3 = 25;
    locationY3 = 420;
    bars3 = 420;
    arbar3 = 420;
    addi3 = 50;
    araddi3 = 18;
    armextra3 = 0;

    showhealthhudxpos = slidershowhealthhudxpos:GetValue();
    showhealthhudypos = slidershowhealthhudypos:GetValue();

    showteamxpos = sliderteamxpos:GetValue();
    showteamypos = sliderteamypos:GetValue();

    showEnemyxpos = sliderEnemyxpos:GetValue();
    showEnemyypos = sliderEnemyypos:GetValue();

    bars = showteamypos;
    arbar = showteamypos;

    bars2 = showEnemyypos;
    arbar2 = showEnemyypos;

    bars3 = showhealthhudypos;
    arbar3 = showhealthhudypos;

    local screenW, screenH = draw.GetScreenSize();
    local screenCenterX = draw.GetScreenSize();
    screenCenterX = screenCenterX * 0.5;

    healthbarknockoff = 0;
    healthbarknockoff2 = 0;
    armorbarknockoff = sliderarmorbarsize:GetValue();
    otherhealthbarknockoff = sliderhealthbarsize:GetValue(); --min -25 max 10

    multiplyhealthbarwidth = sliderhealthbarsizeW:GetValue();
    multiplyarmorbarwidth = sliderarmorbarsizeW:GetValue();




    otherhealthbarknockoff2 = hahsliderhealthbarsize:GetValue(); --min -25 max 10
    multiplyhealthbarwidth2 = hahsliderhealthbarsizeW:GetValue();
    

    armorbarknockoff2 = hahsliderarmorbarsize:GetValue();
    multiplyarmorbarwidth2 = hahsliderarmorbarsizeW:GetValue();




    showlocalplayer = chkShowLocalPlayer:GetValue();

    --If font checking enabled recheck and create fonts
    if enableconstantfontcheck:GetValue() == true then
        if gui.Reference("MENU"):IsActive() then
            if haharmorcounterfont == draw.CreateFont("Bahnschrift", hahsliderarmortextsize:GetValue()) then
            else
                haharmorcounterfont = draw.CreateFont("Bahnschrift", hahsliderarmortextsize:GetValue())
            end
        
            if hahhealthcounterfont  == draw.CreateFont("Bahnschrift", hahsliderhealthtextsize:GetValue()) then
            else
                hahhealthcounterfont = draw.CreateFont("Bahnschrift", hahsliderhealthtextsize:GetValue())
            end
        
            if hahdefuseiconfont == draw.CreateFont("Bahnschrift", hahsliderdefuseiconsize:GetValue()) then
            else
                hahdefuseiconfont = draw.CreateFont("Bahnschrift", hahsliderdefuseiconsize:GetValue())
            end
    
            if nametagfont == draw.CreateFont("Bahnschrift", slidernametextsize:GetValue()) then
            else
                nametagfont = draw.CreateFont("Bahnschrift", slidernametextsize:GetValue())
            end
    
            if armorcounterfont == draw.CreateFont("Bahnschrift", sliderarmortextsize:GetValue()) then
            else
                armorcounterfont = draw.CreateFont("Bahnschrift", sliderarmortextsize:GetValue())
            end
    
            if healthcounterfont == draw.CreateFont("Bahnschrift", sliderhealthtextsize:GetValue()) then
            else
                healthcounterfont = draw.CreateFont("Bahnschrift", sliderhealthtextsize:GetValue())
            end
    
            if defuseiconfont == draw.CreateFont("Bahnschrift", sliderdefuseiconsize:GetValue()) then
            else
                defuseiconfont = draw.CreateFont("Bahnschrift", sliderdefuseiconsize:GetValue())
            end
        end
    end

    --Count players for statshud
    local players = entities.FindByClass( "CCSPlayer" );
    local lp = entities.GetLocalPlayer();

    if enableplayercountstats:GetValue() == true then
        for i = 1, #players do
            playercount = playercount + 1;
        end
    end

    --If health/armor hud is enabled
    if enablehealtharmorhud:GetValue() == true then
        showHUD();
    else
        --Set default HUD to show
        client.SetConVar("hidehud", 0, true)
    end

    --If stats hud is enabled
    if enablestatshud:GetValue() == true then
        showStatsHUD();
    end

    --Reset stats player count to 0
    playercount = 0;

    --Main player loop
    for i = 1, #players do
        local player = players[ i ];
        if player:IsAlive() then
            --Find out what team the player is on and the opposite to that team
            local currentteam = 0
            local otherteam = 0
            currentteam = lp:GetTeamNumber();
            if currentteam == 2 then
                otherteam = 3;

            else
                otherteam = 2;
            end
            --If show enemy team is on
            if showenemyteam == true then
                if player:GetTeamNumber() == otherteam then
                    EnemyTeamDrawUser(player);
                end
            end
            --If show my team is on
            if showteam == true then
                if player:GetTeamNumber() == lp:GetTeamNumber() then
                    if showlocalplayer == true then
                        MyTeamDrawUser(player);
                    else
                        if player:GetIndex() == lp:GetIndex() then
                        else
                            MyTeamDrawUser(player);
                        end
                    end
                end
            end
        end
    end
end
callbacks.Register( "Draw", "DrawingHook", DrawingHook );

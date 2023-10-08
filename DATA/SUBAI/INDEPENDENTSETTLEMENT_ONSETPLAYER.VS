// void, Obj this, int player

Query qHouses;
ObjList ol;
str group_name;
int i;
Obj u;


// Change player for the surrounding guards
group_name = "independent_at_" + .pos.x + "_" + .pos.y;
Group(group_name).SetPlayer(.player);

// Change player for the surrounding houses
qHouses = ObjsInRange(this, "BaseIndependentHouse", GetConst("BuildDistance"), true);
qHouses.SetPlayer(.player);
.time_to_notify = GetTime() + 45000 + rand(30) * 1000;

// Change glory points carried by each unit
{
        int count;
        int glory_given, glory_total;
        
        .independent_unit_1_glory = .independent_unit_1_glory * .glory_already_captured / (.glory_capture * .glory_already_captured_div);
        .independent_unit_2_glory = .independent_unit_2_glory * .glory_already_captured / (.glory_capture * .glory_already_captured_div);
        glory_total = .glory_already_captured * ResGloryFactor / .glory_already_captured_div;
        ol = Group(group_name).GetObjList();
        count = ol.count();
        glory_given = 0;
        for(i = 0; i < count; i += 1)
        {
                if(ol[i].class == .independent_unit_1)
                {
                        ol[i].independent_glory = .independent_unit_1_glory;
                        glory_given += .independent_unit_1_glory;
                }
                else
                {
                        ol[i].independent_glory = .independent_unit_2_glory;
                        glory_given += .independent_unit_2_glory;
                }
        }
        if(count > 0 && glory_total - glory_given > 0)
        {
                // give the additional glory to some random unit to fill it to the max
                ol[rand(count)].independent_glory += glory_total - glory_given;
        }
}

if (player==15) // Was independent
        {
                // Add some gold to all other independents 
                ol = ClassPlayerObjs("Independent_Settlement", 15, true).GetObjList;
                ol = ol.FilterClosest(.pos, .global_increase_count);
                for(i = 0; i < .global_increase_count; i+=1)
                        if (i<ol.count)
                                if (.DistTo(ol[i])<.global_increase_distance)
                                        ol[i].army_value_to_spawn += MapDifficulty * .global_army_value_increase_perc / 100 * ol[i].army_increase_percent / 100;

                // Nomad Bazaar
                if(EnvReadInt(.player, "Nomads_Bazar") > 0)
                        IncRes(.player, ResGlory, EnvReadInt(.player, "Nomads_Bazar") * ResGloryFactor*2);
        }

if ( .GetSkillNumber == 0 ) .SetDefaultTab(11); // prevent showing develop commands when skill is already developed (by DevelopSkill)
else {
        str skill;
        skill = .SkillName(4);
        if ( skill != "" ) {
                .CreateShortcutIcon(skill, GetFromStr(GetCmdParam("Develop_"+skill), "NoReplaceSelection")!="1");
        }
}

.ind_fake_queuer.SetPlayer(.player);

EnvWriteInt(.player, .race_str, EnvReadInt(.player, .race_str) + 1);
EnvWriteInt( player, .race_str, EnvReadInt( player, .race_str) - 1);
EnvWriteInt(.player, "colonyCount", EnvReadInt(.player, "colonyCount") + 1);

ol = ClassPlayerObjs("Building", .player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsBuilding();
		
		
        if ( u.IsAlive() && EnvReadInt(.player, "colonyCount") == 1 ) {
        if (u.race_str=="Race_Dragons" || u.race_str=="Race_Trolls" || u.race_str=="Race_Shades" || u.race_str=="Race_Nomads" || u.race_str=="Race_Elves") continue;
        if (u.class=="Human_Townhall" || u.class=="Darkling_Townhall" || u.class=="Forester_Townhall") u.armor+=u.first_armor_extra; }
		
		if ( u.IsAlive() && EnvReadInt(.player, "colonyCount") == 2 ) {
        if (u.race_str=="Race_Dragons" || u.race_str=="Race_Trolls" || u.race_str=="Race_Shades" || u.race_str=="Race_Nomads" || u.race_str=="Race_Elves") continue;
        if (u.class=="Human_Townhall" || u.class=="Darkling_Townhall" || u.class=="Forester_Townhall") u.armor+=u.second_armor_extra; }
		
		if ( u.IsAlive() && EnvReadInt(.player, "colonyCount") == 3 ) {
        if (u.race_str=="Race_Dragons" || u.race_str=="Race_Trolls" || u.race_str=="Race_Shades" || u.race_str=="Race_Nomads" || u.race_str=="Race_Elves") continue;
        if (u.class=="Human_Townhall" || u.class=="Darkling_Townhall" || u.class=="Forester_Townhall") u.armor+=u.third_armor_extra; }
		
		if ( u.IsAlive() ) {
        if (u.race_str=="Race_Dragons" || u.race_str=="Race_Trolls" || u.race_str=="Race_Shades" || u.race_str=="Race_Nomads" || u.race_str=="Race_Elves") continue;
        if (u.class=="Human_Townhall" || u.class=="Darkling_Townhall" || u.class=="Forester_Townhall") u.armor+=u.armor_bonus; 
                else if (u.class=="Darkling_Tower" || u.class=="Forester_Tower" || u.class=="Human_Tower") u.SetMaxHealth(u.GetMaxHealth()+25); else u.armor+=5;
        }
}

//Independent Upgrades Health Boosts:

if(IsUpgradeAvailable(.player, "upgrade_Elven_Unity") && .class == "Elves_Settlement")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg1);}

if(IsUpgradeAvailable(.player, "upgrade_Elven_Encouragement") && .class == "Elves_Settlement")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg2);}

if(IsUpgradeAvailable(.player, "upgrade_Horse_Hunters") && .class == "Nomad_Townhall")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg1);}

if(IsUpgradeAvailable(.player, "upgrade_Plundering") && .class == "Nomad_Townhall")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg2);}

if(IsUpgradeAvailable(.player, "upgrade_Shades_champpoison") && .class == "Shades_Settlement")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg1);}

if(IsUpgradeAvailable(.player, "upgrade_bottle_o_fog") && .class == "Shades_Settlement")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg2);}

if(IsUpgradeAvailable(.player, "upgrade_Weakening_Acid") && .class == "Dragons_Townhall")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg1);}

if(IsUpgradeAvailable(.player, "upgrade_Burning_Wings") && .class == "Dragons_Townhall")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg2);}

if(IsUpgradeAvailable(.player, "upgrade_Smash_Roll") && .class == "Trolls_Settlement")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg1);}

if(IsUpgradeAvailable(.player, "upgrade_Raze") && .class == "Trolls_Settlement")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg2);}



if(IsUpgradeAvailable(.player, "upgrade_Elven_Unity") && IsUpgradeAvailable(.player, "upgrade_Elven_Encouragement") && .class == "Elves_Settlement")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg1 + .health_bonus_upg2);}

if(IsUpgradeAvailable(.player, "upgrade_Horse_Hunters") && IsUpgradeAvailable(.player, "upgrade_Plundering") && .class == "Nomad_Townhall")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg1 + .health_bonus_upg2);}

if(IsUpgradeAvailable(.player, "upgrade_Shades_champpoison") && IsUpgradeAvailable(.player, "upgrade_bottle_o_fog") && .class == "Shades_Settlement")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg1 + .health_bonus_upg2);}

if(IsUpgradeAvailable(.player, "upgrade_Weakening_Acid") && IsUpgradeAvailable(.player, "upgrade_Burning_Wings") && .class == "Dragons_Townhall")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg1 + .health_bonus_upg2);}

if(IsUpgradeAvailable(.player, "upgrade_Smash_Roll") && IsUpgradeAvailable(.player, "upgrade_Raze") && .class == "Trolls_Settlement")
{.AsBuilding().SetMaxHealth(.maxhealth + .health_bonus_upg1 + .health_bonus_upg2);}
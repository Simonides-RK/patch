//void, int nPlayer, Obj oBase

int base_level, choice;
Gaika gaika;
str suggest, build_list;
int time_for_the_next_upgrade, priority;
StrArray build_lists, history;
int history_top, history_size, max_history_size;
int support_limit, max_level;
int race, i;
int const_forester_race, const_human_race, const_darkling_race;
str rangers_buildlist;
bool force_newbuildlist;

const_forester_race = 0;
const_human_race = 1;
const_darkling_race = 2;

history_top = -1;
history_size = 0;

suggest = "";
max_history_size = AIGetConst(nPlayer, "MaxHistorySize");
if(oBase.class == "Darkling_Townhall")
{
	if(IsUpgradeAvailable(nPlayer, "upgrade_DarklingLevel3"))
		base_level = 3;
	else
	if(IsUpgradeAvailable(nPlayer, "upgrade_DarklingLevel2"))
		base_level = 2;
	else
	if(IsUpgradeAvailable(nPlayer, "upgrade_DarklingLevel1"))
		base_level = 1;
	else
		base_level = 0;
	max_level = 4;
		
	build_lists[0] =  "darkling.train.lev.1.disciple.bl,							level:0, priority:1";

	build_lists[1] =  "darkling.train.lev.2.apostleofdeath.bl,						level:1, priority:3";
	build_lists[2] =  "darkling.train.lev.2.disciple.strength.bl,					level:1, priority:2";
	
	build_lists[3] =  "darkling.train.lev.3.apostleofdeath.afterlife.bl,			level:2, priority:6";
	build_lists[4] =  "darkling.train.lev.3.darkmage.raisespirtis.bl,				level:2, priority:2";
	build_lists[5] = "darkling.train.lev.3.disciple.thunder.bl,						level:2, priority:2";

	build_lists[6] = "darkling.train.lev.4.darkrider.bl,							level:3, priority:6";
	build_lists[6] = "darkling.train.lev.4.darkrider.bl,							level:3, priority:6";
	build_lists[7] = "darkling.train.lev.3.disciple.thunder.bl,						level:3, priority:1";
	build_lists[8] = "darkling.train.lev.3.darkmage.raisespirtis.bl,				level:3, priority:3";
	build_lists[9] = "darkling.train.lev.3.apostleofdeath.afterlife.bl,				level:3, priority:2";
	build_lists[10] = "darkling.train.lev.4.cannon.bl,								level:3, priority:6";

	build_lists[11] = "darkling.train.lev.5.shapeshaper.bl,							level:4, priority:6";
	build_lists[12] = "darkling.train.lev.5.apostleofdeath.aetherblade.bl,			level:4, priority:2";
	build_lists[13] = "darkling.train.lev.5.darkrider.fearstrike.bl,				level:4, priority:5";
	build_lists[14] = "darkling.train.lev.5.fanatic.bl,								level:4, priority:4";
	build_lists[15] = "darkling.train.lev.3.disciple.thunder.bl,					level:4, priority:1";
	build_lists[16] = "darkling.train.lev.3.darkmage.raisespirtis.bl,				level:4, priority:2";
	build_lists[17] = "darkling.train.lev.4.cannon.bl,								level:4, priority:6";
	
	rangers_buildlist = "darkling.train.lev.1.disciple.bl";
	race = const_darkling_race;
} else
if(oBase.class == "Forester_Townhall")
{
	if(IsUpgradeAvailable(nPlayer, "upgrade_ForesterLevel3"))
		base_level = 3;
	else
	if(IsUpgradeAvailable(nPlayer, "upgrade_ForesterLevel2"))
		base_level = 2;
	else
	if(IsUpgradeAvailable(nPlayer, "upgrade_ForesterLevel1"))
		base_level = 1;
	else
		base_level = 0;
	max_level = 4;
		
	build_lists[0] =  "forester.train.lev.1.rangers.bl,						level:0, priority:2"; //lvl 0
	build_lists[1] =  "forester.train.lev.1.wolfmasters.bl,					level:0, priority:1";

	build_lists[2] =  "forester.train.lev.2.rangers.weakpoints.bl,			level:1, priority:2"; //lvl 1
	build_lists[3] =  "forester.train.lev.2.wolfmasters.knifethrowing.bl,	level:1, priority:2";
	build_lists[4] =  "forester.train.lev.3.clodhoppers.bl,					level:1, priority:1";

	build_lists[5] =  "forester.train.lev.5.spirit.bl,						level:2, priority:1";
	build_lists[6] =  "forester.train.lev.5.shamans.fatigue.bl,				level:2, priority:2";
	build_lists[7] =  "forester.train.lev.4.clodhoppers.stun.bl,			level:2, priority:3";
	build_lists[8] =  "forester.train.lev.4.wolfmasters.antihorse.bl,		level:2, priority:2";
	build_lists[9] =  "forester.train.lev.5.rangers.strength.bl,			level:2, priority:2"; //lvl 2

	build_lists[10] = "forester.train.lev.6.hunter.bl,						level:3, priority:6";
	build_lists[11] = "forester.train.lev.6.spirit.shock.bl,				level:3, priority:1";
	build_lists[12] = "forester.train.lev.6.clodhoppers.armor.bl,			level:3, priority:2";
	build_lists[13] = "forester.train.lev.6.shaman.revitalize.bl,			level:3, priority:2";
	build_lists[14] = "forester.train.lev.6.wolfmasters.summon.bl,			level:3, priority:2";
	build_lists[15] = "forester.train.lev.6.rangers.archery.bl,			    level:3, priority:2"; //lvl 3

	build_lists[16] = "forester.train.lev.7.werewolf.vamp.bl,				level:4, priority:6";
	build_lists[17] = "forester.train.lev.7.hunter.moonblade.bl,			level:4, priority:5";
	build_lists[18] = "forester.train.lev.7.spirit.invisible.bl,			level:4, priority:2";
	build_lists[19] = "forester.train.lev.6.clodhoppers.armor.bl,			level:4, priority:1";
	build_lists[20] = "forester.train.lev.6.shaman.revitalize.bl,			level:4, priority:3";
	build_lists[21] = "forester.train.lev.6.wolfmasters.summon.bl,			level:4, priority:1"; 
	build_lists[22] = "forester.train.lev.6.rangers.archery.bl,			    level:4, priority:2"; //lvl 4
	rangers_buildlist = "forester.train.lev.1.rangers.bl";
	race = const_forester_race;
} else
if(oBase.class == "Human_Townhall")
{
	if(IsUpgradeAvailable(nPlayer, "upgrade_HumanLevel3"))
		base_level = 3;
	else
	if(IsUpgradeAvailable(nPlayer, "upgrade_HumanLevel2"))
		base_level = 2;
	else 
	if(IsUpgradeAvailable(nPlayer, "upgrade_HumanLevel1"))
		base_level = 1;
	else
		base_level = 0;
	max_level = 4;

	build_lists[0] =  "human.train.lev.1.monk.bl,							level:0, priority:1";
	build_lists[1] =  "human.train.lev.1.pikeman.bl,						level:0, priority:3";

	build_lists[2] =  "human.train.lev.2.swordsman.bl,						level:1, priority:4";
	build_lists[3] =  "human.train.lev.2.cavalry.bl,						level:1, priority:1";
	build_lists[4] =  "human.train.lev.2.longbowman.bl,						level:1, priority:5";
	build_lists[5] =  "human.train.lev.2.oracle.exorcism.bl,				level:1, priority:1";
	build_lists[6] =  "human.train.lev.2.pikeman.militia.bl,				level:1, priority:1";
	build_lists[7] =  "human.train.lev.1.monk.bl,							level:1, priority:1";
	
	build_lists[8] =  "human.train.lev.3.pikeman.goldshield.bl,				level:2, priority:1";
	build_lists[9] =  "human.train.lev.3.paladin.bl,						level:2, priority:6";
	build_lists[10] = "human.train.lev.3.oracle.holyshield.bl,				level:2, priority:4";
	build_lists[11] = "human.train.lev.3.monk.lifesteal.bl,					level:2, priority:1";
	build_lists[12] = "human.train.lev.3.longbowman.precision.bl,			level:2, priority:5";
	build_lists[13] = "human.train.lev.2.swordsman.bl,						level:2, priority:3";
	build_lists[14] = "human.train.lev.2.cavalry.bl,						level:2, priority:1";

	build_lists[15] = "human.train.lev.4.pikeman.reinforced.bl,				level:3, priority:1";
	build_lists[16] = "human.train.lev.4.paladin.deathblow.bl,				level:3, priority:6";
	build_lists[17] = "human.train.lev.3.oracle.holyshield.bl,				level:3, priority:4";
	build_lists[18] = "human.train.lev.3.monk.lifesteal.bl,					level:3, priority:2";
	build_lists[19] = "human.train.lev.4.longbow.range.bl,					level:3, priority:5";
	build_lists[20] = "human.train.lev.4.swordsman.stamina.bl,				level:3, priority:3";
	build_lists[21] = "human.train.lev.4.cavalry.bl,						level:3, priority:1";

	build_lists[22] = "human.train.lev.4.pikeman.reinforced.bl,				level:4, priority:1";
	build_lists[23] = "human.train.lev.5.paladin.leadership.bl,				level:4, priority:6";
	build_lists[24] = "human.train.lev.3.oracle.holyshield.bl,				level:4, priority:4";
	build_lists[25] = "human.train.lev.3.monk.lifesteal.bl,					level:4, priority:1";
	build_lists[26] = "human.train.lev.4.longbow.range.bl,					level:4, priority:5";
	build_lists[27] = "human.train.lev.4.swordsman.stamina.bl,				level:4, priority:3";
	build_lists[28] = "human.train.lev.4.cavalry.bl,						level:4, priority:1";
	build_lists[29] = "human.train.lev.5.heavycavalry.bl,					level:4, priority:5";
	build_lists[30] = "human.train.lev.5.shadowmistress.bl,					level:4, priority:4";
	build_lists[31] = "human.train.lev.5.witch.bl,							level:4, priority:4";
	rangers_buildlist = "human.train.lev.2.longbowman.bl";
	race = const_human_race;
}
if(base_level < max_level)
	support_limit = AIGetConst(nPlayer, "Level"+(base_level+1)+"Support");
time_for_the_next_upgrade = -1;
while (1) 
{
	Sleep(AIGetConst(nPlayer, "DevelopDelay"));
	force_newbuildlist = false;
	suggest = "";
	ailog("support limit : " + support_limit + " level : " + base_level, nPlayer);
	ailog("time : " + time_for_the_next_upgrade + '/' + GetTime(), nPlayer);

	if(race == const_darkling_race)
	{
		if(base_level > 1)
		{
			AIStartBuildlist("darkling.temple.upgrade.2.bl", oBase, AIPriorityArmy);
		}
		if(base_level > 0)
		{
			AIStartBuildlist("darkling.temple.upgrade.bl", oBase, AIPriorityArmy);
		} 
	}
	priority = AIPriorityArmy;
	if(EnvReadInt(nPlayer, "StrategyRequestGoldGhost") > 0)
	{
		ailog("<green>request gold spirits registered", nPlayer);
		if (base_level > 0)	
		{
			suggest = "darkling.goldspirits.lifebond.bl";
		}
		else 
		{
			suggest = "darkling.goldspirits.bl";
		}
		priority = AIPriorityArmyForced;
		EnvWriteInt(nPlayer, "StrategyRequestGoldGhost", 0);
	} else
	if(EnvReadInt(nPlayer, "StrategyRequestReinforce") > 0)
	{
		ailog("<yellow>history status : <white>" + history_size + " : " + history_top, nPlayer);
		EnvWriteInt(nPlayer, "StrategyRequestReinforce", 0);
		if(GetRes(nPlayer, ResSupport) >= 6)
		{
			ailog("<green>request reinforcement accepted", nPlayer);
			if(history_size > 1)
			{
				int i;
				for(i = 0; i < 10; i += 1)
				{
					int r;
					r = rand(history_size);
					
					if(r != history_top)
					{
						suggest = history[r];
						if(AIIsBuildlistRunning(suggest, oBase))
						{
							ailog("<red>" + i + "." + suggest, nPlayer);
							suggest = "";
							continue;
						}

						if ((suggest != "human.train.lev.2.oracle.bl") &&
							(suggest != "human.train.lev.2.oracle.exorcism.bl") &&
							(suggest != "human.train.lev.3.oracle.holyshield.bl") &&
							(suggest != "darkling.goldspirits.bl") &&
							(suggest != "darkling.train.lev.1.darkmage.bl") &&
							(suggest != "darkling.train.lev.3.darkmage.raisespirtis.bl") &&
							(suggest != "forester.train.lev.6.shaman.revitalize.bl") &&
							(suggest != "forester.train.lev.5.shamans.fatigue.bl") &&
							(suggest != "forester.train.lev.5.spirit.bl") &&
							(suggest != "forester.train.lev.6.spirit.shock.bl"))
						{
							ailog("<green>" + i + "." + suggest + " ok!", nPlayer);
							break;
						} else
						{
							ailog("<green>!!" + i + "." + suggest, nPlayer);
							suggest = "";
						}
					}
				}
			}
		 
			if(suggest == "")
			{
				ailog("<green>increase random buildlist priority", nPlayer);
			}
			priority = AIPriorityArmyReinforcement;
		} else
			ailog("<red>request reinforcement rejected", nPlayer);
	} else
	if(EnvReadInt(nPlayer, "StrategyRequestRangers") > 0)
	{
		suggest = rangers_buildlist;
		ailog("<green>rangers request registered", nPlayer);
		EnvWriteInt(nPlayer, "StrategyRequestRangers", 0);
		priority = AIPriorityArmyForced;
	} else
	if(EnvReadInt(nPlayer, "StrategyRequestMonks") > 0)
	{
		suggest = "human.train.lev.1.monk.bl";
		ailog("<green>monk request registered", nPlayer);
		EnvWriteInt(nPlayer, "StrategyRequestMonks", 0);
		priority = AIPriorityArmyHumanHeal;
	} else
	if(EnvReadInt(nPlayer, "StrategyDarkMageRequest") > 0)
	{
		suggest = "darkling.train.lev.1.darkmage.bl";
		ailog("<green>dark mage request registered", nPlayer);
		EnvWriteInt(nPlayer, "StrategyDarkMageRequest", 0);
		priority = AIPriorityArmyForced;
	} else
	if(GetRes(nPlayer, ResGold) > 2000 && GetRes(nPlayer, ResGems) < 20) // we have loads of gems and just a few gems
	{ 
		ailog("<green>too much gold registered", nPlayer);
		if(race == const_forester_race)
		{
			choice = WRand(2, 1);
			if(choice == 0)
				suggest = "forester.train.lev.1.rangers.bl";
			else if(choice == 1)
				suggest = "forester.train.lev.1.wolfmasters.bl";	
		} else
		if(race == const_human_race)
		{
			suggest = "human.train.lev.2.swordsman.bl";	
		} else
		if(race == const_darkling_race)
		{
			suggest = "darkling.goldspirits.bl";
		}
		priority = AIPriorityArmyForced;
	} else
	if(EnvReadInt(nPlayer, "StrategyRequestReveal") > 0)
	{
		if(race == const_forester_race)
		{
			if(base_level == 0)
			{
				base_level = 1;
				time_for_the_next_upgrade = GetTime() + 180000;
				ailog("<green>base level 1 requested<white>", nPlayer);
				force_newbuildlist = true;
			}
		} else
		if(race == const_human_race)
		{
			suggest = "human.train.lev.2.oracle.bl";
			priority = AIPriorityArmyForced;
			if(base_level == 0)
			{
				base_level = 1;
			}
			ailog("<green>oracles request registered", nPlayer);
		}
		EnvWriteInt(nPlayer, "StrategyRequestReveal", 0);
	} else
	if(race == const_forester_race && GetRes(nPlayer, ResGold) < 500 && GetRes(nPlayer, ResGems) > 80 && base_level == 2) // we have loads of gems and just a few gold
	{ 
		suggest = "forester.train.lev.5.spirit.bl";  
		priority = AIPriorityArmyForced;
	} else
	{
		if(base_level < max_level)
		if(time_for_the_next_upgrade < GetTime())
		if(GetResLimit(nPlayer, ResSupport) - GetRes(nPlayer, ResSupport) > support_limit || GetRes(nPlayer, ResSupport) < 3)
		{
			base_level = base_level+1;
			time_for_the_next_upgrade = GetTime() + 180000;
			if(base_level < max_level)
				support_limit = AIGetConst(nPlayer, "Level"+(base_level+1)+"Support");
			ailog("<yellow>Time to upgrade to "+base_level, nPlayer);
			if(GetRes(nPlayer, ResSupport) < 3)
			if(GetRes(nPlayer, ResGold) > 600) 
			if(GetRes(nPlayer, ResGems) > 30)
				priority = AIPriorityArmyForced;
			force_newbuildlist = true;
		}
	}
	build_list = "";
	if(suggest == "")
		for(i = 0; i < history_size; i += 1)
		{
			build_list = history[i];
			if(AIIsBuildlistRunning(build_list, oBase))
			{
				break;
			}
		}
	if(force_newbuildlist || build_list == "" || i == history_size)
	{
		build_list = ChooseBuildlist(nPlayer, build_lists, base_level, suggest);	
		ailog("<yellow>" + build_list + ", new, prt : " + priority, nPlayer);
	} else
	{
		ailog("<yellow>" + build_list + ", old, prt : " + priority, nPlayer);
	}
		
	if(build_list != "")
	{
		if(history_size < max_history_size)
		{
			history_top += 1;
			history[history_top] = build_list;
			history_size += 1;
		} else
		{
			history_top += 1;
			if(history_top >= history_size)
				history_top = 0;
			history[history_top] = build_list;
		}	
		AIStartBuildlist(build_list, oBase, priority);
		
		while(AIIsBuildlistRunning(build_list, oBase))
		{
			Sleep(5000);
			if(race == const_forester_race)
			if(base_level >= 2)
			if(GetRes(nPlayer, ResSupport) < 3)
				AIStartBuildlist("forester.huntingparties.bl", oBase, AIPriorityHouseBuild);

			if(GetRes(nPlayer, ResSupport) < 3)
			if(GetRes(nPlayer, ResGold) > 600) // this fixes the case with no available pop limit
			if(GetRes(nPlayer, ResGems) > 30)
			{
				ailog("high resources. low pop. new buildlist", nPlayer);
				break;
			}
			
			if(EnvReadInt(nPlayer, "StrategyRequestReinforce") > 0)
			if(GetRes(nPlayer, ResSupport) >= 6)
				break;
			if(EnvReadInt(nPlayer, "StrategyRequestRangers") > 0)
				break;
			if(EnvReadInt(nPlayer, "StrategyRequestMonks") > 0)
				break;
			if(EnvReadInt(nPlayer, "StrategyRequestReveal") > 0)
				break;
			if(EnvReadInt(nPlayer, "StrategyRequestGoldGhost") > 0)
				break;
		}
	} else
		Sleep(30000);
}

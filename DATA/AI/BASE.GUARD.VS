// void, int nPlayer, Obj oColony
Building this;
Gaika gaika;
Obj obj_to_defend;
int value;
Unit builder;
int const_build_distance;
bool refresh_attack_dir;
int next_builder_send_time;
int builder_send_interval;
StrArray aTowersBuildlist, aIndTowersBuildlist;
str worker_class, townhall_upgrade;
if(oColony.class == "Darkling_Townhall")
{
	aTowersBuildlist[0] = "darkling.1.tower.bl";
	aTowersBuildlist[1] = "darkling.2.tower.bl";
	aTowersBuildlist[2] = "darkling.3.tower.bl";
	aTowersBuildlist[3] = "darkling.4.tower.bl";
	aTowersBuildlist[4] = "darkling.5.tower.bl";
	aTowersBuildlist[5] = "darkling.6.tower.bl";
	aTowersBuildlist[6] = "darkling.7.tower.bl";
	aTowersBuildlist[7] = "darkling.8.tower.bl";
	aTowersBuildlist[8] = "darkling.9.tower.bl";
	aTowersBuildlist[9] = "darkling.10.tower.bl";
	aTowersBuildlist[10] = "darkling.11.tower.bl";
	aTowersBuildlist[11] = "darkling.12.tower.bl";
	aTowersBuildlist[12] = "darkling.13.tower.bl";
	aTowersBuildlist[13] = "darkling.14.tower.bl";
	aTowersBuildlist[14] = "darkling.15.tower.bl";
	
	aIndTowersBuildlist[0] = "darkling.1.ind_tower.bl";
	aIndTowersBuildlist[1] = "darkling.2.ind_tower.bl";
	aIndTowersBuildlist[2] = "darkling.3.ind_tower.bl";
	aIndTowersBuildlist[3] = "darkling.4.ind_tower.bl";
	worker_class = "Darkling_DarkMage";
	townhall_upgrade = "upgrade_DarklingLevel2";
} else
if(oColony.class == "Forester_Townhall")
{
	aTowersBuildlist[0] = "forester.1.tower.bl";
	aTowersBuildlist[1] = "forester.2.tower.bl";
	aTowersBuildlist[2] = "forester.3.tower.bl";
	aTowersBuildlist[3] = "forester.4.tower.bl";
	aTowersBuildlist[4] = "forester.5.tower.bl";
	aTowersBuildlist[5] = "forester.6.tower.bl";
	aTowersBuildlist[6] = "forester.7.tower.bl";
	aTowersBuildlist[7] = "forester.8.tower.bl";
	aTowersBuildlist[8] = "forester.9.tower.bl";
	aTowersBuildlist[9] = "forester.10.tower.bl";
	aTowersBuildlist[10] = "forester.11.tower.bl";
	aTowersBuildlist[11] = "forester.12.tower.bl";
	aTowersBuildlist[12] = "forester.13.tower.bl";
	aTowersBuildlist[13] = "forester.14.tower.bl";
	aTowersBuildlist[14] = "forester.15.tower.bl";
	
	aIndTowersBuildlist[0] = "forester.1.ind_tower.bl";
	aIndTowersBuildlist[1] = "forester.2.ind_tower.bl";
	aIndTowersBuildlist[2] = "forester.3.ind_tower.bl";
	aIndTowersBuildlist[3] = "forester.4.ind_tower.bl";
	worker_class = "Forester_Worker";
	townhall_upgrade = "upgrade_ForesterLevel2";
} else
if(oColony.class == "Human_Townhall")
{
	aTowersBuildlist[0] = "human.1.tower.bl";
	aTowersBuildlist[1] = "human.2.tower.bl";
	aTowersBuildlist[2] = "human.3.tower.bl";
	aTowersBuildlist[3] = "human.4.tower.bl";
	aTowersBuildlist[4] = "human.5.tower.bl";
	aTowersBuildlist[5] = "human.6.tower.bl";
	aTowersBuildlist[6] = "human.7.tower.bl";
	aTowersBuildlist[7] = "human.8.tower.bl";
	aTowersBuildlist[8] = "human.9.tower.bl";
	aTowersBuildlist[9] = "human.10.tower.bl";
	aTowersBuildlist[10] = "human.11.tower.bl";
	aTowersBuildlist[11] = "human.12.tower.bl";
	aTowersBuildlist[12] = "human.13.tower.bl";
	aTowersBuildlist[13] = "human.14.tower.bl";
	aTowersBuildlist[14] = "human.15.tower.bl";
	
	aIndTowersBuildlist[0] = "human.1.ind_tower.bl";
	aIndTowersBuildlist[1] = "human.2.ind_tower.bl";
	aIndTowersBuildlist[2] = "human.3.ind_tower.bl";
	aIndTowersBuildlist[3] = "human.4.ind_tower.bl";
	worker_class = "Human_Worker";
	townhall_upgrade = "upgrade_HumanLevel2";
}


this = oColony.AsBuilding;
gaika = GetGaika(oColony.pos);

refresh_attack_dir = true;
const_build_distance = GetConst("BuildDistance");

.ai_guard_is_running = 1;

EnvWriteObj(nPlayer, "lastcaptured", oColony);
EnvWriteInt(nPlayer, "lastcapturedtime", GetTime);

next_builder_send_time = AIGetConst(.player, "OneIndTowerTime");
builder_send_interval = AIGetConst(.player, "BuilderSendInterval");

while(.IsAlive)
{
// defender bahavior
	value = gaika.GetNearEnemiesValue(nPlayer, 1);
	if(value > 0)
	{
		int player;
		for(player = 1; player <= 8; player += 1)
		{
			if(DiplGetCeaseFire(player, nPlayer))
				if(value > EnvReadInt(player, "endangeredvalue") || EnvReadInt(player, "endangeredtime") + 6000 < GetTime)
				{
					ObjList enemies_in_gaika;
					EnvWriteObj(player, "endangered", oColony);
					EnvWriteInt(player, "endangeredtime", GetTime);
					if(player == nPlayer)
						EnvWriteInt(player, "endangeredvalue", value);
					else
						EnvWriteInt(player, "endangeredvalue", value/3);   // go defend on allies only if there are large armies
					ailog("<red>danger at " + oColony.class + ", # enemies : <white>" + value, player);
					
					enemies_in_gaika = gaika.GetEnemyUnits(player);
					if(enemies_in_gaika.count > 0)
					if(refresh_attack_dir)
					{
						.AIRememberLastAttackDir(enemies_in_gaika.FilterClosest(.pos, 1)[0].pos - .pos);
						refresh_attack_dir = false;
					}
				}
		}
	} else
	{
		refresh_attack_dir = true;
		if(oColony.IsHeirOf("BaseTownhall"))
		{
	// tower building & management code
			if((AIGetConst(.player, "FifteenTowersTime")  < GetTime) && (IsUpgradeAvailable(nPlayer, townhall_upgrade)))
				AIStartBuildlist(aTowersBuildlist[14], oColony, AIPriorityDefence);
			else
			if((AIGetConst(.player, "FourteenTowersTime")  < GetTime) && (IsUpgradeAvailable(nPlayer, townhall_upgrade)))
				AIStartBuildlist(aTowersBuildlist[13], oColony, AIPriorityDefence);
			else
			if((AIGetConst(.player, "ThirteenTowersTime")  < GetTime) && (IsUpgradeAvailable(nPlayer, townhall_upgrade)))
				AIStartBuildlist(aTowersBuildlist[12], oColony, AIPriorityDefence);
			else
			if((AIGetConst(.player, "TwelveTowersTime")  < GetTime) && (IsUpgradeAvailable(nPlayer, townhall_upgrade)))
				AIStartBuildlist(aTowersBuildlist[11], oColony, AIPriorityDefence);
			else
			if((AIGetConst(.player, "ElevenTowersTime")  < GetTime) && (IsUpgradeAvailable(nPlayer, townhall_upgrade)))
				AIStartBuildlist(aTowersBuildlist[10], oColony, AIPriorityDefence);	
			else
			if((AIGetConst(.player, "TenTowersTime")  < GetTime) && (IsUpgradeAvailable(nPlayer, townhall_upgrade)))
				AIStartBuildlist(aTowersBuildlist[9], oColony, AIPriorityDefence);	
			else
			if((AIGetConst(.player, "NineTowersTime")  < GetTime) && (IsUpgradeAvailable(nPlayer, townhall_upgrade)))
				AIStartBuildlist(aTowersBuildlist[8], oColony, AIPriorityDefence);
			else
			if((AIGetConst(.player, "EightTowersTime")  < GetTime) && (IsUpgradeAvailable(nPlayer, townhall_upgrade)))
				AIStartBuildlist(aTowersBuildlist[7], oColony, AIPriorityDefence);	
			else
			if((AIGetConst(.player, "SevenTowersTime")  < GetTime) && (IsUpgradeAvailable(nPlayer, townhall_upgrade)))
				AIStartBuildlist(aTowersBuildlist[6], oColony, AIPriorityDefence);
			else
			if((AIGetConst(.player, "SixTowersTime") < GetTime) && (IsUpgradeAvailable(nPlayer, townhall_upgrade)))
				AIStartBuildlist(aTowersBuildlist[5], oColony, AIPriorityDefence);	
			else
			if(AIGetConst(.player, "FiveTowersTime") < GetTime)
				AIStartBuildlist(aTowersBuildlist[4], oColony, AIPriorityDefence);
			else
			if(AIGetConst(.player, "FourTowersTime") < GetTime)
				AIStartBuildlist(aTowersBuildlist[3], oColony, AIPriorityDefence);
			else
			if(AIGetConst(.player, "ThreeTowersTime") < GetTime)
				AIStartBuildlist(aTowersBuildlist[2], oColony, AIPriorityDefence);
			else
			if(AIGetConst(.player, "TwoTowersTime") < GetTime)
				AIStartBuildlist(aTowersBuildlist[1], oColony, AIPriorityDefence);
			else
			if(AIGetConst(.player, "OneTowerTime") < GetTime)
				AIStartBuildlist(aTowersBuildlist[0], oColony, AIPriorityDefence);
			
			if(next_builder_send_time < GetTime)
			{
				bool captured;
				// if we have captured colony sooner than it has been endangered or the colony is still endangered we defend the lastcaptured
				if(EnvReadInt(nPlayer, "lastcapturedtime") > EnvReadInt(nPlayer, "endangeredtime")+6000 || EnvReadInt(nPlayer, "endangeredtime") + 10000 > GetTime)
				{
					obj_to_defend = EnvReadObj(nPlayer, "lastcaptured");
					captured = true;
				}
				else
				{
					obj_to_defend = EnvReadObj(nPlayer, "endangered");
					captured = true;
				}
			
			
				if(obj_to_defend.IsAlive)
				{
					ailog("<yellow>building towers near : " + obj_to_defend.class, nPlayer);
					if(builder.IsDead)
					{
						if(oColony.class == "Darkling_Townhall")
						{
							ObjList olWorkers; 
							olWorkers = ClassPlayerObjs("Darkling_DarkMage", nPlayer, true).GetObjList.FilterCommand("idle,move_cmd,follow").FilterAIEnabled;
							if(olWorkers.count > 0)
							{
								Unit u;
								Army army;
								ailog("found guard towers builder...", nPlayer);
								builder = olWorkers.FilterClosest(obj_to_defend.pos, 1)[0];
								u = builder.AsUnit;
								u.AISetNoAIFlag;
								army = GetArmy(u);
								if(army.IsValid)
									army.Remove(u);
							} else
							EnvWriteInt(.player, "StrategyDarkMageRequest", 1);
							next_builder_send_time = GetTime + builder_send_interval;
						} else
						{
							Query qWorkers;
							ObjList ol;
							qWorkers = Intersect(
									ObjsInCircle(oColony.pos, oColony.radius + const_build_distance, worker_class, true) ,
									ClassPlayerObjs(worker_class, nPlayer, true)
								);
							ol = qWorkers.GetObjList;
							if(ol.count > 0)
							{
								builder = ol[rand(ol.count)].AsUnit;
								next_builder_send_time = GetTime + builder_send_interval;
							}
						}
					}
					if(builder.IsAlive)
					{
						Gaika target_gaika;
						target_gaika = GetGaika(oColony.pos);			
						if(builder.DistTo(obj_to_defend) < 800)
						{
							ailog("<yellow>builder reached : " + obj_to_defend.class, nPlayer);

							// build more than 1 tower only if the settlement has been attacked already
							if(AIGetConst(.player, "FourIndTowersTime") < GetTime && !captured)
								AIStartBuildlist(aIndTowersBuildlist[3], obj_to_defend, AIPriorityDefence, builder);
							else
							if(AIGetConst(.player, "ThreeIndTowersTime") < GetTime && !captured)
								AIStartBuildlist(aIndTowersBuildlist[2], obj_to_defend, AIPriorityDefence, builder);
							else
							if(AIGetConst(.player, "TwoIndTowersTime") < GetTime && !captured)
								AIStartBuildlist(aIndTowersBuildlist[1], obj_to_defend, AIPriorityDefence, builder);
							else
							if(AIGetConst(.player, "OneIndTowerTime") < GetTime)
								AIStartBuildlist(aIndTowersBuildlist[0], obj_to_defend, AIPriorityDefence, builder);
						} else
						{
							if(builder.GetEnemyCount > 3)
								builder.ExecCmd("move", builder.pos, true);
							ailog("<yellow>builder on the way : " + obj_to_defend.class, nPlayer);
							builder.ExecCmd("move", obj_to_defend.pos, true);
						}
					}
				} else
				if(builder.IsAlive) // make builder stop
					builder.ExecCmd("move", .pos, true);
			}
		}
	}
	Sleep(3000);
}

.ai_guard_is_running = 0;
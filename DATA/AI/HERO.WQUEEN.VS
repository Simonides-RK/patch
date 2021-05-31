//void, int nPlayer, Obj This


Hero this;
ObjList enemies;
int enemies_first_seen_time;

enemies_first_seen_time = -1;
this = This.AsHero;
if(!this.IsValid)
{
	_pr("hero is invalid");
	return;
}
Sleep(1000);
while(1)
{
	Sleep(AIGetConst(nPlayer, "HeroResponseTime"));
	if(!.IsValid)
		return;
	if(.IsGhost)
	{
		if(.ressurection_began == -1)
		{
			Sleep(3000);
			while(!WaitForResources(nPlayer, AIPriorityHeal, 300, 0, 5000));
			.ExecCmd("Ressurect_Hero", true);
		}
		Sleep(5000);
		continue;
	}
	if(.ai_specials_enabled != 0)
	if(.command == "follow" || .command == "idle" || .command == "engage" || .command == "attack")
	if(.ai_micro_action <= 0)
	{
		Army hero_army;
		hero_army = GetArmy(this);
		
		if(hero_army.IsValid)
			enemies = hero_army.GetEnemies;
		else
			enemies = .GetEnemiesInSquadSight;
		
		if(enemies.count > 0)
		{
			if(enemies_first_seen_time == -1)
				enemies_first_seen_time = GetTime;
			if(.IsSkillReady("Consternating_Touch"))
			{
				ObjList under_25_perc;
				
				under_25_perc = enemies.FilterClass("Unit").FilterUnderHealthPerc(GetClassInt("Human_WitchQueen", "consternating_touch_health"));	
				if(under_25_perc.count > 0)
				{
					int old_action;
					old_action = .ai_micro_action;
					.ai_micro_action = const_micro_off;
					.ExecCmd("attack", under_25_perc[0], true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					.ai_micro_action = old_action;
				}
			}
			if(enemies_first_seen_time + 3000 < GetTime)
			if(.IsSkillReady("HauntBuilding"))
			{
				ObjList buildings;
				buildings = enemies.FilterClass("Tower");
				if(buildings.count == 0)
					buildings = enemies.FilterClass("Building");
				if(buildings.count > 0)
				{
					Obj target;
					target = buildings.FilterClosest(.pos, 1)[0];
					.ExecCmd("HauntBuilding", target, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				}
			}
			if(enemies_first_seen_time + 3000 < GetTime)
			if(.IsSkillReady("Consume"))
			{
				Obj target;
				target = invalid_obj;
				if(.health < 250)	// feed ourselves		
				{
					target = .AIBestTarget("Trolls_BoulderThrower,Shades_AExecutioner,Hero,Elves_SpiritOfCreation",
											"Forester_Hunter",			
											"", 
											AIBestTargetPreferAbout300Health+AIBestTargetNoStandartEval); 				
				} else
				{
					enemies.FilterAIValue(3, true).FilterMoving.FilterUnderHealth(300);
					if(enemies.count > 0)
						target = enemies[rand(enemies.count)];
				}
				if(target.IsValid)
				{
					.ExecCmd("Consume", target, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				}
			}		
			if(enemies_first_seen_time + 6000 < GetTime)
			{
				if(.IsSkillReady("Polymorph"))
				{
					ObjList cursed;
					cursed = enemies.FilterEffect("curse");
					if(cursed.count > 6 || cursed.count > enemies.count*2/3)
					{
						.ExecCmd("Polymorph", true);
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					} else
					if(enemies_first_seen_time + 10000 < GetTime)
					if(cursed.count > 2)
					{
						.ExecCmd("Polymorph", true);
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					}
				}
			}
/// ypsilon: POWERSTONES			
			if(.IsSkillReady("Hero_Heal"))
			{
				Query nearby;
				nearby = Intersect(ObjsInSight(this, "Hero,Trolls_Boulder,Shades_AExecutioner,Elves_SpiritOfCreation", false), FriendlyObjs(.player, "Unit", false));
				if(!nearby.IsEmpty)
				{
					ObjList heroes_list; 
					int count, i;
					heroes_list = nearby.GetObjList.FilterUnderHealthPerc(98);
					count = heroes_list.count;
					for(i = 0; i < count; i += 1)
					{
						Unit u;
						u = heroes_list[i].AsUnit;
						.ExecCmd("Hero_Heal", u, true);
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
						continue;
					}
				}
			}
			if(.IsSkillReady("Hero_Shock"))
			{
				Obj target;
				target = .GetEnemiesInSquadSight.FindHighestValue(false, false);  // true = exclude heroes; false include legends
				if(target.IsValid)
				{
					.ExecCmd("Hero_Shock", target, true); 
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			}
			if(.IsSkillReady("Hero_Illusion"))
			{
				Obj target;
				target = FriendlyObjsInSight(this, "Unit", false).GetObjList.FindHighestValue(true,true); // true = no heores, true = no legends
				if(target.IsValid)
				if(target.ai_value > 2)
				{
					.ExecCmd("Hero_Illusion", target, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			}
			if(.IsSkillReady("Hero_Invisibility"))
			{
				.ExecCmd("Hero_Invisibility", true);
				Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				continue;
			}
			if(.IsSkillReady("Hero_SecondSight"))
			{
				int i;
				ObjList targets;
				targets = .GetEnemiesInSquadSight();
				for ( i = 0; i < targets.count; i += 1 ) {				
					if(targets[i].IsValid)
					if(!targets[i].IsRevealed(nPlayer))
					{
						.ExecCmd("Hero_SecondSight", targets[i].pos, true); 
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
						continue;
					}
				}
			}
			if(.IsSkillReady("Hero_Resurrect"))
			{
				ObjList ol;
				ol = GetCorpses(.pos, 200);
				if ( ol.count != 0 ) 
				{
					.ExecCmd("Hero_Resurrect", ol[rand(ol.count)].pos, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}					
			}			
		} else
		{
			enemies_first_seen_time = -1;
		}
	}

}
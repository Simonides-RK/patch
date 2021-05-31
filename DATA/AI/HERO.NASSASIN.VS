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
			enemies = hero_army.GetEnemyUnits;
		else
			enemies = .GetEnemiesInSquadSight;
		
		if(enemies.count > 0)
		{
			if(enemies_first_seen_time == -1)
				enemies_first_seen_time = GetTime;
				
			if(.IsSkillReady("AngelOfDeath"))
			{
				Obj target;
				target = .AIBestTarget("Trolls_BoulderThrower,Shades_AExecutioner,Hero",
							"Forester_Hunter",			
							"", 
							AIBestTargetPreferHealth); ;
				if(target.IsAlive)
				{
					.ExecCmd("AngelOfDeath", target.pos, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				}
				
			}
			if(.IsSkillReady("Confuse") && enemies.count > 5)
			{
				ObjList empty;
				Obj o;
				if(enemies_first_seen_time + 8000 < GetTime)
					o = AIGetBestSplashTargetFriend(empty, enemies, GetClassInt("Darkling_Axemaster", "leap_attack_dmg_range"), 20);
				else
					o = AIGetBestSplashTargetFriend(empty, enemies, GetClassInt("Darkling_Axemaster", "leap_attack_dmg_range"), 12);
				if(o.IsValid)
				{
					.ExecCmd("Confuse", o.pos, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
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
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
			if(.IsSkillReady("Aimed_Shot"))
			{
				Obj target;
				target = enemies.FindHighestValue(false, false);  // true = exclude heroes; false include legends
				if(target.IsValid)
				if(target.ai_value > 4 || enemies_first_seen_time + 6000 < GetTime) // cast aimed shot 6 seconds after we have seen the first enemy
				{
					.ExecCmd("Aimed_Shot", target, true); 
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			}
			if(.IsSkillReady("Entangling_Shot")&& enemies.count > 3)
			{
				Obj target;
				target = invalid_obj;
				enemies.FilterAIValue(3, true).FilterMoving;
				if(enemies.count > 0)
					target = enemies[rand(enemies.count)];
				if(target.IsValid)
				{
					.ExecCmd("Entangling_Shot", target, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				}
			}
			if(.IsSkillReady("Corrosive_Gas_Shot")&& enemies.count > 5)
			{
				Obj target;
				target = invalid_obj;
				enemies.FilterAIValue(3, true).FilterMoving;
				if(enemies.count > 0)
					target = enemies[rand(enemies.count)];
				if(target.IsValid)
				{
					.ExecCmd("Corrosive_Gas_Shot", target, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				}
			}			
			if(.IsSkillReady("Ambush"))
			{
				
				enemies = Intersect(ObjsInCircle(.pos, 800, "Forester_Hunter,Forester_Ranger", false), FriendlyObjs(.player, "Unit", false)).GetObjList;
				if(enemies.count > 0)
				{
					.ExecCmd("Ambush", this, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			}			
			if(.IsSkillReady("Fog_Strike") && enemies.count > 5)
			{
				ObjList empty;
				Obj o;
				if(enemies_first_seen_time + 8000 < GetTime)
					o = AIGetBestSplashTargetFriend(empty, enemies, GetClassInt("Forester_Sharpshooter_Fog", "sight"), 20);
				else
					o = AIGetBestSplashTargetFriend(empty, enemies, GetClassInt("Forester_Sharpshooter_Fog", "sight"), 12);
				if(o.IsValid)
				{
					.ExecCmd("Fog_Strike", o.pos, true);
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
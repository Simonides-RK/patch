//void, int nPlayer, Obj This

//ailog("<white> Hello world");
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
			if(.IsSkillReady("DivineJourney"))
			{
				if(this.GetMaxHealth()/2 > this.health()) 
				{
					.ExecCmd("DivineJourney", this, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				} else
				{
					Query nearby_heroes;
					nearby_heroes = Intersect(ObjsInSight(this, "Hero,Trolls_Boulder,Shades_AExecutioner,Elves_SpiritOfCreation", false), FriendlyObjs(.player, "Unit", false));
					if(!nearby_heroes.IsEmpty)
					{
						ObjList heroes_list; 
						int count, i;
						//bool casted;
						heroes_list = nearby_heroes.GetObjList.FilterUnderHealthPerc(98);
						count = heroes_list.count;
						//casted = false;
						for(i = 0; i < count; i += 1)
						{
							Unit u;
							u = heroes_list[i].AsUnit;
								.ExecCmd("DivineJourney", u, true);
								Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
								//casted = true;
								//break;	
								continue;
						}
						//if(casted)
							//continue;
					}
				}
			}	
			if(.IsSkillReady("Resurrect_Skill"))
			{
				ObjList ol;
				Obj o;
				ol = GetCorpses(.pos, GetClassInt("Darkling_Empath", "resurrect_range"));
				if ( ol.count != 0 ) 
				{
					.ExecCmd("Resurrect_Skill", ol[rand(ol.count)].pos, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}					
			}
			
			if(.IsSkillReady("RealityRipple")) // level2 skill2
			{
				Obj target;
				if(enemies_first_seen_time + 6000 > GetTime)
					target = AIGetBestSplashTargetRR(enemies, GetClassInt("Darkling_Empath", "realityripple_range"), 20);
				else
					target = AIGetBestSplashTargetRR(enemies, GetClassInt("Darkling_Empath", "realityripple_range"), 12);
				if(target.IsValid)
				{
					.ExecCmd("RealityRipple", target, true); 
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			}
			if(.IsSkillReady("MindBlaze")) // level1 skill2
			{
				Obj target;
				target = enemies.FindHighestValue(false, false);  // true = exclude heroes; false include legends
				if(target.IsValid)
				if(target.ai_value > 4 || enemies_first_seen_time + 6000 < GetTime) // cast mind blaze 6 seconds after we have seen the first enemy
				{
					.ExecCmd("MindBlaze", target, true); 
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			}
			if(.IsSkillReady("Possession")) // level1 skill3
			{
				ObjList targets;
				targets = Intersect(ObjsInSight(this, "Darkling_Disciple,Darkling_GoldSpirit,Darkling_Spirit,Darkling_Cannoneer,Darkling_Fanatic,Darkling_ApostleOfDeath,Darkling_DarkRider", false), FriendlyObjs(.player, "Unit", false)).GetObjList;
				if(targets.count > 0)
				{
					Obj o;
					o = targets[rand(targets.count)];
					if(o.IsAlive)
					{
						.ExecCmd("Possession", o, true);
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
						continue;
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
			if(.IsSkillReady("Dichotomize")) // level3 skill1
			{
				ObjList targets;
				targets = Intersect(ObjsInSight(this, "Darkling_DarkRider,Dragons_RedDragon,Nomad_Cavalry,Shades_Warrior,Trolls_MountainTroll", false), FriendlyObjs(.player, "Unit", false)).GetObjList;
				//targets = Intersect(ObjsInSight(this, "Darkling_AngelOfDeath,Darkling_Cannoneer,Darkling_StoneShaper,Darkling_DarkRider,", false), FriendlyObjs(.player, "Unit", false)).GetObjList;
				if(targets.count > 0)
				{
					Obj o;
					o = targets[rand(targets.count)];
					if(o.IsAlive && o.health() > 180)
					{
						.ExecCmd("Dichotomize", o, true);
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
						continue;
					}
						
				
			}
			}
			if(.IsSkillReady("DivineJourney")) 
			{
				.ExecCmd("DivineJourney", this, true);
				Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				continue;
			}
		}
	}

}
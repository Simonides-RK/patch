// void, int nPlayer, Obj queen_of_the_wolves

Hero this;
str filter;
Obj target;

this = queen_of_the_wolves.AsHero;
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
		if(.BestTargetInSquadSight.IsValid)
		{
			if(.IsSkillReady("Revive_Wolves"))
			{
				if (this.GetMaxHealth()/2 > this.health() && .queen_state == 2 ) 
				{
					.ExecCmd("Revive_Wolves", this, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;					
				}
				else if ((this.GetMaxHealth()/2 > this.health()) && .IsSkillReady("Werewolf_Form") && .queen_state != 2 ) 
				{
					.ExecCmd("Werewolf_Form", true);
					.ExecCmd("Revive_Wolves", this, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;					
				}				
				else	
				{
					target = SearchCorpse(.pos, 700, .player, "Forester_WolfMaster,Forester_Werewolf");
					if(target.IsValid)
					{
						.ExecCmd("Revive_Wolves", target.pos, true);
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
						continue;
					} 
				}
			} 
			if(.IsSkillReady("Werewolf_Form") && .queen_state != 2)
			{
				.ExecCmd("Werewolf_Form", true);
				Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				continue;
			} 
			if(.IsSkillReady("Assassin_Wolves"))
			{
					target = .AIBestTarget("Trolls_BoulderThrower,Shades_AExecutioner,Hero",
											"Forester_Hunter",			
											"", 
											AIBestTargetPreferHealth); 
				if(target.IsAlive)
				{
					.ExecCmd("Assassin_Wolves", target, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			}
			if(.IsSkillReady("Air_Shield"))
			{
				.ExecCmd("Air_Shield", true);
				Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				continue;
			}			
			if(.IsSkillReady("Gaze_Of_Fear") && .queen_state != 2)
			{
				if(.GetAnim != 0)
					Sleep(.TimeToAnimFinish);
				if(!.airshield_obj.IsValid)
					target = .AIBestTarget("Trolls_BoulderThrower,Shades_AExecutioner",
											"Dragons_RedDragon,Forester_Hunter",			
											"Hero,Trolls_SmallTroll", 
											AIBestTargetPreferHealth); 
				else
					target = .AIBestTarget("Shades_AExecutioner",	
											"Hero",
											"Trolls_SmallTroll", 
											AIBestTargetPreferHealth); 
				if(target.IsAlive)
				{
					.ExecCmd("attack", target, true);
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
		}
	}
}
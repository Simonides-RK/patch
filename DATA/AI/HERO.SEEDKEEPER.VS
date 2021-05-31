//void, int nPlayer, Obj This

Hero this;
ObjList ol;
point dir;

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
		ol = .GetEnemiesInSquadSight;
		if(ol.count > 0)
		{
			if(.IsSkillReady("Plant_Beast"))
			{
				dir = .pos - ol.FilterClosest(.pos, 1)[0].pos;
				dir.SetLen(250);
				.ExecCmd("Plant_Beast", .pos - dir, true);
				Sleep(5000);
				if(.command == "Plant_Beast") // break if not casted after 5 sec
					.ExecCmd("attack", .pos, true);
				continue;
				
			} 
			if(.IsSkillReady("Burrow"))
			{
				if(.burrowed == 0)
				{
					.ExecCmd("Burrow", true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			} 
			if(.IsSkillReady("Thorns") && ol.count > 3)
			{
				Obj target;
				target = .AIGetThornsTarget; 
				if(target.IsValid)
				{
					.ExecCmd("Thorns", target, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			} 
			if(.IsSkillReady("Cactus_Trap") && ol.count > 4)
			{
				point pt;
				pt = GetCastPoint(.pos, 500, ol);
				if(pt.x != -1 && pt.y != -1)
					.ExecCmd("Cactus_Trap", pt, true);
				Sleep(5000);
				if(.command == "Cactus_Trap") // break if not casted after 5 sec
					.ExecCmd("attack", .pos, true);
				continue;
			} 
			if(.IsSkillReady("Forester_Overlord"))
			{
				dir = .pos - ol.FilterClosest(.pos, 1)[0].pos;
				dir.SetLen(50);
				.ExecCmd("Forester_Overlord", .pos + dir, true);
				Sleep(5000);
				if(.command == "Forester_Overlord") // break if not casted after 5 sec
					.ExecCmd("attack", .pos, true);

				continue;
			}
			if(.IsSkillReady("Venom"))
			{
				Obj target;
				if(.GetAnim != 0)
					Sleep(.TimeToAnimFinish);				
				target = .AIGetVenomTarget; 
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
		} else
		{
			if(.burrowed != 0)
				.ExecCmd("Unburrow", true);
			if(.IsSkillMaxCharged("Plant_Beast"))
			{
				dir = .GetDir;
				dir.SetLen(250);
				.ExecCmd("Plant_Beast", .pos - dir, true);
			} else
			if(.IsSkillMaxCharged("Forester_Overlord"))
			{
				dir = .GetDir;
				dir.SetLen(250);
				.ExecCmd("Forester_Overlord", .pos + dir, true);
				Sleep(5000);
				if(.command == "Forester_Overlord") // break if not casted after 5 sec
					.ExecCmd("attack", .pos, true);
			} else
			if(.IsSkillMaxCharged("Cactus_Trap"))
			{
				dir = .GetDir;
				dir.SetLen(250);
				.ExecCmd("Cactus_Trap", .pos + dir, true);
				Sleep(5000);
				if(.command == "Cactus_Trap") // break if not casted after 5 sec
					.ExecCmd("attack", .pos, true);
			} 
		}
		
	}
}
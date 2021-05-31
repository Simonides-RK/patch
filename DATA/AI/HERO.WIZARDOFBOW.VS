//void, int nPlayer, Obj This


Hero this;
ObjList ol;
point dir;
int skill_cast_time;

this = This.AsHero;
skill_cast_time = -1;
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
			while(!WaitForResources(nPlayer, AIPriorityHeal, 300, 0, 300000));
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
		int enemy_count, attackers_count;
		hero_army = GetArmy(this);
		
		if(hero_army.IsValid)
			ol = hero_army.GetEnemyUnits;
		else
			ol = .GetEnemiesInSquadSight;
			
		attackers_count = ol.FilterAttacking.count;
		enemy_count = ol.count;
		if(hero_army.IsValid)
			hero_army.logu(this, "<Micro>WoB : "+attackers_count+"/<yellow>"+enemy_count);		
		else
			ailog("<Micro>WoB : "+attackers_count+"/<yellow>"+enemy_count, .player);

		if(enemy_count > 0)
		{
			if(skill_cast_time == -1)
				skill_cast_time = GetTime + 4000;
				
			if(enemy_count > 4)
			if(attackers_count > enemy_count/3 || skill_cast_time > GetTime)
			{
				if(.IsSkillReady("Flare"))
				{
					Obj o;
					o = AIGetBestSplashTarget(this, GetClassInt("Human_WizardOfTheBow_Flame", "sight"));
					if(o.IsValid)
					{
						.ExecCmd("Flare", o.pos, true);
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
						continue;
					}
				}
				if(.IsSkillReady("Crystal_Tower"))
				if(.on_crystal_tower != 1)
				{
					.ExecCmd("Crystal_Tower", .pos, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			}
			if(.IsSkillReady("ElectrostaticCocoon"))
			{
				.ExecCmd("ElectrostaticCocoon", true);
				Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				continue;
			}
			if(.IsSkillReady("StarStorm"))
			{
				Query friendly;
				Obj target; 
				int t;
				friendly = FriendlyObjsInSight(this, "Unit", false);
				
				target = AIGetBestSplashTargetFriend(friendly.GetObjList, ol, GetClassInt("Human_WizardOfTheBow_StarStorm", "sight"), 12);
				if(target.IsValid)
				{
					int star_storm_time;
					Obj star_storm_obj;
					Query star_storm_q;
					int old_action;
					.ExecCmd("StarStorm", target.pos, true);
					old_action = .ai_micro_action;
					.ai_micro_action = const_micro_off;
					Sleep(2000);
					star_storm_q = ObjsInCircle(target.pos, 50, "Human_WizardOfTheBow_StarStorm", false);
					if(!star_storm_q.IsEmpty)					
					{
						star_storm_obj = star_storm_q.GetObjList[0];
						while(star_storm_obj.IsValid)
						{
							Sleep(1000);
							if(.IsGhost)
								break;
							if(star_storm_obj.enemy_objs_damaged < 2 || star_storm_obj.enemy_objs_damaged < star_storm_obj.friendly_objs_damaged) 
								break;
							
						}
					}
					if(.IsGhost)
						continue;
					.ai_micro_action = old_action;
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				}
				continue;
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
			skill_cast_time = -1;
			
		if(.on_crystal_tower == 1)
		if(enemy_count == 0 || .TimeWithoutAttack > 5000)
		{
			.ExecCmd("Leave_Crystal_Tower", true);
			Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
			continue;
		}		
	}

}
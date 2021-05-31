//void, int nPlayer, Obj This


Hero this;
ObjList ol;
point dir;
int special_attack_force_activation;

this = This.AsHero;
special_attack_force_activation = -1;
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
		int enemy_count, attackers_count;
		hero_army = GetArmy(this);
		
		if(hero_army.IsValid)
			ol = hero_army.GetEnemyUnits;
		else
			ol = .GetEnemiesInSquadSight;
		
		if(ol.count > 0)
		{
			if(special_attack_force_activation == -1)
				special_attack_force_activation = GetTime + 6000;
			if(.IsSkillReady("Leap_Attack") && ol.count > 5)
			{
				Obj o;
				ObjList empty;
				if(special_attack_force_activation < GetTime)
					o = AIGetBestSplashTargetFriend(empty, ol, GetClassInt("Darkling_Axemaster", "leap_attack_dmg_range"), 20);
				else
					o = AIGetBestSplashTargetFriend(empty, ol, GetClassInt("Darkling_Axemaster", "leap_attack_dmg_range"), 12);
				if(o.IsValid)
				{
					.ExecCmd("Leap_Attack", o.pos, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			} 
			if(.IsSkillReady("Invincibility") && .health < .GetMaxHealth/4 && !.ExistEffect("invincibility"))
			{
				.ExecCmd("Invincibility", true);
				Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				continue;
			}
			if(.activated_bash == -1)
			if(.activated_death_blow == -1)
			{
				if(.IsSkillReady("Bash"))
				{
					Obj target;
					target = ol.FilterClosest(.pos, 4).FindHighestValue(false, false);
					if(target.IsValid)
					if(target.ai_value > 4 || special_attack_force_activation < GetTime)
					{
						.ExecCmd("Bash", true);
						.ExecCmd("attack", target, false);
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
						continue;
					}
				} else
				if(.IsSkillReady("Death_Blow"))
				{
					.ExecCmd("Death_Blow", true);
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
		}
	}

}
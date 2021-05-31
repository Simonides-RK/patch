//void, int nPlayer, Obj This


Hero this;
ObjList ol;
point dir;
int altar_of_healing_time;

this = This.AsHero;

if(!this.IsValid)
{
	_pr("hero is invalid");
	return;
}
altar_of_healing_time = -1;
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
			if(altar_of_healing_time == -1)
				altar_of_healing_time = GetTime + 10000;
			if(ol.count > 3)
			if(.IsSkillReady("Salvation"))
			{
				point pt;
				pt = AIGetRetreatPoint(this, ol, Point(-1, -1));
				if(pt.InRect(GetMapRect))
				{
					pt = GetSummonPt("Human_AltarOfSalvation", pt, 300, .player);
					if(pt.InRect(GetMapRect))
					{
						.ExecCmd("Salvation", pt, true);
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
						continue;
					}
				}
			}
			if(.IsSkillReady("AltarOfHealing"))
			if(altar_of_healing_time < GetTime)
			{
				ObjList ol;
				Obj target;
				ol = Intersect(ObjsInCircle(.pos, 800, "Unit", false), FriendlyObjs(.player, "Unit", false)).GetObjList;
				target = AIGetMassHealTarget(ol, GetClassInt("Human_AltarOfHealing", "sight"), 15);
				if(target.IsValid)
				{
					point pt;
					pt = GetSummonPt("Human_AltarOfHealing", target.pos, 300, .player);
					if(pt.InRect(GetMapRect))
					{
						.ExecCmd("AltarOfHealing", pt, true);
						Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
						continue;
					}
				}
				
			}
			if(.IsSkillReady("MagicSwords"))
			{
				ol = Intersect(ObjsInCircle(.pos, 800, "Human_Paladin,Human_Swordsman", false), FriendlyObjs(.player, "Unit", false)).GetObjList;
				if(ol.count > 0)
				{
					.ExecCmd("MagicSwords", this, true);
					Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
					continue;
				}
			}
			if(.IsSkillReady("LightningShield"))
			{
				if(!.ExistEffect("lightningshield"))
				{
					.ExecCmd("LightningShield", this, true);
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
						bool casted;
						heroes_list = nearby_heroes.GetObjList;
						count = heroes_list.count;
						casted = false;
						for(i = 0; i < count; i += 1)
						{
							Unit u;
							u = heroes_list[i].AsUnit;
							if(!u.ExistEffect("lightningshield"))
							{
								.ExecCmd("LightningShield", u, true);
								Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
								casted = true;
								break;	
							}
						}
						if(casted)
							continue;
					}
				}
			}
			if(.IsSkillReady("GuardianSpirit"))
			if(!.ExistEffect("guardianspirit"))
			{
				.ExecCmd("GuardianSpirit", this, true);
				Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
				continue;
			} else
			{
				Query nearby_heroes;
				ObjList heroes_list;
				bool casted;
				nearby_heroes = Intersect(ObjsInSight(this, "Hero,Trolls_Boulder,Shades_AExecutioner,Elves_SpiritOfCreation", false), FriendlyObjs(.player, "Hero", false));
				if(!nearby_heroes.IsEmpty)
				{
					ObjList heroes;
					int count, i;
					bool casted;
					heroes_list = nearby_heroes.GetObjList;
					count = heroes_list.count;
					casted = false;
					for(i = 0; i < count; i += 1)
					{
						Unit u;
						u = heroes_list[i].AsUnit;
						if(!u.ExistEffect("guardianspirit"))
						{
							.ExecCmd("GuardianSpirit", u, true);
							Sleep(AIGetConst(nPlayer, "HeroSleepAftetSkillUse"));
							casted = true;
							break;
						}
					}
					if(casted)
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
			altar_of_healing_time = -1;
	}

}
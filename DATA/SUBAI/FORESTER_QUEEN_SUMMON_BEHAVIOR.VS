// void, Obj This

Hero this;
bool are_there_dead_wolves;

this = This.AsHero();
if(.number_wolves == -1)	// initialize 
	.number_wolves = 0;
while(1)
{
	Sleep(500);	

	if (!.IsGhost)
	{
		if (.in_shelter.IsValid()) continue; //dont summon while in a shelter
		if (.ExistEffect("divine_journey")) continue;		// done summon while in divine journey
		
		if (.number_wolves < .max_number_wolves)
			{
				Sleep(.white_wolf_summon_time);				
				if(!.IsGhost && .number_wolves < .max_number_wolves)
					{
						Obj wolf;
						point pt;

						if (.in_shelter.IsValid()) continue;				//dont summon while in a shelter
						if (.ExistEffect("divine_journey")) continue;		// done summon while in divine journey
						
						if ((.GetAnim()==0 || .GetAnim()==AnimIdle1) && .queen_state == 1)
							{
								.StartAnim(AnimSpecial6);
								Sleep(500);								
							}
						if (!.IsGhost && !.ExistEffect("divine_journey") && .in_shelter.IsDead() && .number_wolves < .max_number_wolves)
							{
								pt = GetSummonPt("Forester_WhiteWolf", .last_passable_pos, 200, .player);
								if (pt.x >= 0 && pt.y >= 0)
								{
									PlaySound(pt, "assets/sounds/HeroSkills/Forester Queen/Forester_Queen_summoning_wolf.wav");
									CreateFeedback("Data/Particles/summon.part.xml", pt, 1000);
									Sleep(700);									

									if(.number_wolves < .max_number_wolves)
									{
										wolf = Place("Forester_WhiteWolf", pt, .player);
										wolf.SetMaxHealth(wolf.maxhealth + .GetEffectParam("item_moon_bonus", 1));
										wolf.queen_of_the_wolves = this;
										wolf.AsUnit().SetUncontrollableFlag(true);
										if (.IsSkillAvailable("Assassin_Wolves"))
											{
											wolf.SetMaxHealth(wolf.maxhealth + .GetEffectParam("item_moon_bonus", 1) + .assassin_wolves_health_bonus);
											}
										if(.IsSkillAvailable("Ghost_Wolves"))
										{
											wolf.SetVisible(false);
											wolf.SetMaxHealth(wolf.maxhealth + .GetEffectParam("item_moon_bonus", 1)+.ghost_wolves_health_bonus);
											if (.IsSkillAvailable("Assassin_Wolves"))
											{
											wolf.SetMaxHealth(wolf.maxhealth + .GetEffectParam("item_moon_bonus", 1)+.ghost_wolves_health_bonus + .assassin_wolves_health_bonus);
											}
										}
										.number_wolves += 1;
									}
								}
							}
					}
			}
	}
}

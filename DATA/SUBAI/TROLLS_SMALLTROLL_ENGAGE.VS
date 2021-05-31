// void, Obj me

Unit this;
Obj u;
point ptDir;
int delay;

this = me.AsUnit();
//_pr("smalltroll::engage - searching for new enemy");
u = .BestTargetInSquadSight();
if(u.IsAlive())	
{
	//_pr("smalltroll::engage - target found!");
	while(u.IsAlive()) 
	{
		if(.DistTo(u) > .attack_dist)
		{
			.rolling = 2;
			while(.DistTo(u) > .attack_dist && !.Goto(u, 50, 500, false, -1))
			{
				u = .BestTargetInSquadSight();
				if(!u.IsAlive())
				{
					return;
				}
			}
		}
		// roll to the enemy
		if(.rolling == 2 && u.IsAlive())
		{
			.rolling = 1;
			SetFlag(.user_flags1, .cant_be_stunned, true);
			.Face(u);
			ptDir = .GetDir();
			ptDir.SetLen(.GetAnimWalkDist(AnimSpecial1));
			.SetSpeedFactor(.factor * .speed_factor);
			.SetDeadAnim(AnimSpecial4);
			.PlayAnim(AnimSpecial1, .pos + ptDir);
			.SetWalkAnim(AnimWalk2);
			
		}
		delay = 2000;
		if (.rolling==1)
			delay = 0; // Don't stop while rolling
		while(!.GotoAttack(u, 1000, false, delay)) 
		{
			//_pr("smalltroll::engage - approaching target!");
			if(.rolling != 1)
			{
				u = .BestTargetInSquadSight();
			}
			if(!u.IsAlive())
			{
				break;
			}
		}
		if(.rolling == 1)
		{
			.rolling = 0;
			SetFlag(.user_flags1, .cant_be_stunned, false);
			.PlayAnim(AnimSpecial2);
			.SetWalkAnim(AnimWalk1);
			.SetDeadAnim(AnimDie);
			.SetSpeedFactor(.speed_factor / .factor);
		}
		//_pr("smalltroll::engage - attacking target!");
		if(u.IsAlive())
		{
			while(.Attack(u, false))
				if (u.AsBuilding())
					u = .BestTargetInSquadSight();
		}
		u = .BestTargetInSquadSight();
	}
} 

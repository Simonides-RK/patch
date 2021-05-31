// void, Obj me, Obj u

Unit this;
IntArray aPtX, aPtY;
point pt, temp;
int dir, i, attack_time;
rect rc;
rc = GetMapRect();

this = me.AsUnit();

//.pr("unit::attack: attacking particular enemy");

if (u.AsBuilding.IsValid && .constantly_idle_played == 0 && .IsRanged)
	Sleep(rand(600));

if (u.IsAlive() || u.AsBuilding.IsValid)
{
	if (!.InRange(u)) //don't move if we're in range! (for units with ranges longer than their sight)
		if (.DistTo(u)>500  && .ShouldGotoForm(u.pos))
			while (!.GotoForm(u,150,1000,false))
				if (!u.IsAlive() && !u.AsBuilding().IsValid())
					break;
				else if (.InRange(u))
					break;

	while(.IsValidTarget(u))
	{
		if(.GotoAttack(u, 1000, true, 2000))
		{
			// this whole piece of code which follow is the while(.Attack(u)); line
			// so if it needs change it must reflect in attack, engage, engage_unit_type and stand_position too
			
			pt = .pos - u.pos;
			// the formula is radius = x / (2 * sin(angle/8)) where angle=48 is radius of rotation of the attack
			pt.SetLen(.GetAnimWalkDist(AnimAttack1) * 478 / 100);	// (1 / (2 * sin(6)) is about 4.78
			temp = pt;
			pt.Rot((-1) * .attack_angle / 2);
			for(i = 0; i <= .attack_angle_parts; i += 1)
			{
				aPtX[i] = pt.x;
				aPtY[i] = pt.y;
				pt.Rot(.attack_angle / .attack_angle_parts);				
			}
			pt = .pos - temp;
			for(i = 0; i <= .attack_angle_parts; i += 1)
			{
				temp = pt + Point(aPtX[i], aPtY[i]);
				temp.IntoRect(rc);
				aPtX[i] = temp.x;
				aPtY[i] = temp.y;
			}			
			i = .attack_angle_parts / 2;	// in the middle at the beginning
			pt = Point(aPtX[i], aPtY[i]);
			dir = -1;
			while(1)
			{
				if(dir == -1)
				{
					if(i == 0)
					{
						i = 1;
						dir = 1;
					}
					else
					{
						i -= 1;
					}
				}
				else
				{
					if(i == .attack_angle_parts)
					{
						i = .attack_angle_parts - 1;
						dir = -1;
					}
					else
					{
						i += 1;
					}
				}
				pt = Point(aPtX[i], aPtY[i]);
				attack_time = .attack_time;
				if (.ExistEffect("BurningWings"))
					{
					attack_time = .attack_time - .attack_time * .burning_wings_atkspeed/100;
					}
				if(GetTime() > .attack_last_time + attack_time)
				{
					.StartAnim(AnimAttack1, pt, u.pos);
					if(.GetAnim())
					{
						Sleep(.TimeToActionMoment());
					}
					if(!.IsValidTarget(u) || !.InRange(u))
					{
						break;
					}
					.attack_last_time = GetTime();
					if(dir == -1)
					{
						.CreateProjectile(u, .projectile_class, .projectile_dist, 5 * .projectile_angle / 2);
					}
					else
					{
						.CreateProjectile(u, .projectile_class, .projectile_dist, .projectile_angle / 2);
					}
					if(.GetAnim())
					{
						Sleep(.TimeToAnimFinish());
					}
				}
				else
				{
					.PlayAnim(AnimWalk1, pt, u.pos);					
				}
				if(!.IsValidTarget(u) || !.InRange(u))
				{
					break;
				}
			}
	
			// end of while(.Attack(u)); piece of code
			
			if (.InRange(u))
				break;
		}
	}
}

if (.CmdCount()==1)
	.AddCommand(true, "engage");

//void, Obj This, point pt

Unit this, u;
point ptDir;
int delay, i;
ObjList ol;

this=This.AsUnit();
pt = PassablePointNear(pt, 40, 10, true);

while ( !.Goto(pt, .smash_roll_range, 500, false, 500) );

			.SetEnergy(.energy - .smash_roll_energy);
			.rolling = 1;
			SetFlag(.user_flags1, .cant_be_stunned, true);
			.Face(pt);
			ptDir = .GetDir();
			ptDir.SetLen(.GetAnimWalkDist(AnimSpecial1));
			.SetSpeedFactor(.factor * .speed_factor);
			.SetDeadAnim(AnimSpecial4);
			.PlayAnim(AnimSpecial1, .pos + ptDir);
			.SetWalkAnim(AnimWalk2);
			.GotoStraight(pt,false);
			
		
		delay = 2000;
		if (.rolling==1)
			delay = 0; // Don't stop while rolling
		while(!.Goto(pt, 60, 1000, false, delay));
		if(.rolling == 1)
		{
			.rolling = 0;
			SetFlag(.user_flags1, .cant_be_stunned, false);
			.PlayAnim(AnimSpecial2);
			.SetWalkAnim(AnimWalk1);
			.SetDeadAnim(AnimDie);
			.SetSpeedFactor(.speed_factor / .factor);
			ol = Intersect( ObjsInCircle(.pos, .smash_roll_radius, "Unit", false), EnemyObjs(.player, "Unit", false) ).GetObjList;
			for (i=0; i < ol.count; i+=1)
				{
				u= ol[i].AsUnit();
				
				if(u.IsValid())
					{
					u.Damage(this, CalculateDamage(this, u, .smash_roll_damage, u.armor), true);
					if((u.user_flags1 & u.cant_be_stunned) == 0)
						{
						if(u.command != "stun")
							{
							u.InsertCommand("stun");
							}
						}
					}
				}
		}
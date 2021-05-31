// void, Obj This

Building this;
ObjList ol, ol2;
Unit u, x;
str group_name;
int i, j, value, last_player_found, time, dist;
point pt;
Query units_around, units_around3, units_around2, qHouses;
ObjList olFound;
Obj obj, target;
int number_attacked, retreat_timeout, n, unit_per_iteration;
int independent_unit_1_value, independent_unit_2_value;
str temp;
bool bMilitaryFound;
int last_tick_health;

this = This.AsBuilding;
independent_unit_1_value = GetIndependentClassValue(.independent_unit_1);
independent_unit_2_value = GetIndependentClassValue(.independent_unit_2);


// capture behavior
group_name = "independent_at_" + .pos.x + "_" + .pos.y;

if(.player != 15 && .GetSkillNumber == 0)
	.SetDefaultTab(11);

retreat_timeout = 2;
last_tick_health = .health;
Sleep(1500 + rand(3000));

while(1)
{
	ol = Group(group_name).GetObjList;	
	ol.ClearDead;
	if(.player == 15)
	{
		value = 0;
		for(i = 0; i < ol.count; i +=1)
		{
			if(ol[i].class == .independent_unit_1)
				value += independent_unit_1_value;
			else
				value += independent_unit_2_value;
		}
		// ok we surrender
		if(value < .surrender_army_value)
		{  // look who's gonna take control
			units_around3 = Substract(ObjsInSight(this, "Unit", true), ObjsInSight(this, "Darkling_SoulWatcher", true));
			units_around2 = Substract(units_around3, ObjsInSight(this, "Forester_GrayWolf", true));
			units_around = Substract(units_around2, ObjsInSight(this, "Forester_SparklingSpy", true));
			last_player_found = -1;
			for(i = 1; i < 14; i+=1)
			{
				olFound = Intersect(units_around, ClassPlayerObjs("Unit", i, true)).GetObjList();
				if ( olFound.count > 0 ) {
					if ( last_player_found == -1 ) {
						last_player_found = i;
						bMilitaryFound = false;
						for ( j = 0; j < olFound.count; j += 1 ) {
							if ( olFound[j].IsHeirOf("Military") && !olFound[j].AsUnit().IsIndependentGuardian()) {
								
								bMilitaryFound = true;
								break;
							
							}
						}
						if ( bMilitaryFound ) {
							CreateFeedbackPlayerColor("data/particles/ColonyCaptureTiny.part.xml", .pos-Point(70, 240), 5000, i);
						}
					} else {
						for ( j = 0; j < olFound.count; j += 1 ) {
							if ( olFound[j].IsHeirOf("Military")&& !olFound[j].AsUnit().IsIndependentGuardian()) {
							
								if ( bMilitaryFound ) {
									last_player_found = -2;
							} else {
									last_player_found = i;
									bMilitaryFound = true;
								}
								CreateFeedbackPlayerColor("data/particles/ColonyCaptureTiny.part.xml", .pos-Point(70, 240), 5000, i);
								break;
							}
						
						}
						if ( j == olFound.count ) { // only peaceful units
							if ( !bMilitaryFound ) { // other player also does not have military units around
								last_player_found = -2; // can't decide side
							} 
						}
					}
				}
			}
			// The 'onsetplayer' script manages all details on the capturing, including:
			//  - guards and houses player change; 
			//  - notification to other players;
			//  - nomad Bazaar implementation;
			//  - decrease amount of glory on the guards;
			//  - set default interface tab
			if(last_player_found > 0) {
				.SetPlayer(last_player_found);
				CreateFeedbackPlayerColor("data/particles/ColonyCapture.part.xml", .pos-Point(70, 240), 6000, last_player_found);
			}
		}		
	} else
	if(.time_to_notify < GetTime() && .time_to_notify != -1)
	{
		.time_to_notify = -1;
		for(i = 1; i <= 8; i+=1)
		{
			if(i != .player && !DiplGetCeaseFire(.player, i) && !DiplGetShareView(.player, i))
			{
				UserNotification("enemy has taken ind", "", Point(-1, -1), i );
			}
		}
	}

	{
		if(ol.count == 0)
		{
			Sleep(1000); // This is how often we check for capturing when the defenders are dead
			continue;
		}

		target = invalid_obj;
		for(i = 0; i < ol.count(); i += 1)
		{
			u = ol[rand(ol.count)].AsUnit;
			if(u.SquadAttackBefore < 5500)
				{ target = u.SquadAttackBy; break; }
		}	
			
		if(!target.IsAlive)
		if(last_tick_health != .health)  // if someone attacked the base building go hunt him
		{
			ObjList enemies;
			last_tick_health = .health;
			
			enemies = Intersect(ObjsInCircle(.pos, 1200, "BaseGameObject", true), EnemyObjs(.player, "BaseGameObject", true)).GetObjList;
			if(enemies.count > 0)
			{
				target = enemies.FilterClosest(.pos, 1)[0];
			}
		} 



		if(u.EnemyBuildingsInSquad)
		{
			retreat_timeout = 1;
			target = invalid_obj;
		}
		
		if(target.IsAlive)
		{
			for (i=0; i<ol.count/6+1; i+=1)
				{
					obj = ol[rand(ol.count)];
					if(obj.player != .player) // could happen if mind controlled by fairy
						continue;

					if (obj.command != "engage")
					if (obj.command != "advance")
					if (obj.command != "move")
					if (obj.command != "follow")
					if (obj.command != "attack") // Ivko: This makes the Fairy Rage of Impulse work
					{
						obj.ExecCmd("attack", target.pos, true);
					}
				}

			retreat_timeout = 3;	// reset retreat counter - means we will retreat after 3 ticks
		} else
		{
			retreat_timeout -= 1; // decrease retreat counter when reaches zero retreat
			// heal somebody
			u = SearchForHealing(.pos, .guard_range2, ol);
			if(u.IsAlive)
			{
				CreateFeedback("data/particles/Heal_Unit_Feedback.part.xml", u, 400, true);
				u.Heal(.heal_amount, "Heal_Sound_");
			}
			if(u.IsAlive)
			{
				pt = (.pos-u.pos);
				pt.SetLen(.guard_range1 - 100);
				pt.Rot(90);
				u.ExecCmd("attack", .pos+pt, true);
			}
		} 
		if(retreat_timeout == 0)
		{
			retreat_timeout = 3;
			for(i = 0; i < ol.count(); i += 1)
			{
				obj = ol[i];
				if(obj.player != .player)		// could happen if mind controlled by fairy
					continue;

				if(obj.DistTo(this) > .guard_range1)
				{
					obj.ExecCmd("follow", this, true);
				} 
			}
		}
		Sleep(2500); // Ivko: Change with caution - retreat time and possibly other behavior depends on it!
	}
	
}

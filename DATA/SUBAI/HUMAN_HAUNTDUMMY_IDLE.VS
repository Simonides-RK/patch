//void, Obj this

int timeFinish;
Building b;
Obj upgd;
Unit uTarget, u;
ObjList ol, olTargets;
ObjList olTgtUnits;
ParticleSystem ps;
point pt;
IntArray arrHeights, arrStates;
int i, j, count, height, maxheight, time, dist, tries, d;
int haunts, haunt;
bool bInside, bInsideUpgd;
int maxtries;
int last_damage_time, times_to_damage;

maxtries = 20;

//_pr("haunt idle");
timeFinish = GetTime() + GetClassInt("Human_WitchQueen", "haunt_duration");

b = .target_building.AsBuilding();

upgd = b.building_upgrade;

if ( !b.IsValid() ) {
	_pr("haunt_idle: invalid target");
	this.Erase();
	return;
}

//b.SetVisible(false);
b.is_haunted = 1;
b.ClearCommands();


if ( b.IsHeirOf("Tower") ) {
	b.disabled = 1;
}

maxheight = b.GetHeight();
if ( upgd.IsValid() ) {
	maxheight += upgd.GetHeight();
}

count = GetClassInt("Human_WitchQueen", "haunt_particlecount");

for ( i = 0; i < count; i += 1 ) {
	ps = CreateParticleSystem("HauntParticleSystem");
	arrStates[i] = 2; // uninitialized state
	ol.Add(ps);
	olTgtUnits.Add(ps); // put the ps here, so later the list could be used as an array
}

time = 1200;
haunt = 0;
last_damage_time = GetTime();
while ( GetTime() < timeFinish ) {
	
	if(GetTime() - last_damage_time >= 1000)
	{
		// damage the building during the cursed period
		times_to_damage = (GetTime() - last_damage_time) / 1000;
		last_damage_time = GetTime();
			.target_building.Damage(.reserved_obj0, .reserved_obj0.haunt_building_damage_per_sec * times_to_damage, false);
	}
	
	// check for a nearby enemy unit
	uTarget.Clear();
	olTargets = EnemyObjsInSight(this, "Unit", false).GetObjList();
	for ( i = 0; i < olTargets.count; i += 1 ) {
		u = olTargets[i].AsUnit();
		if ( u.IsAlive() ) {
			if ( !u.ExistEffect("curse") ) {
				bInside = false;
				for ( j = 0; j < olTgtUnits.count; j += 1 ) {
					if ( olTgtUnits[j] == u ) {
						bInside = true;
						break;
					}		
				}
				if ( !bInside ) {
					uTarget = u;
					break;
				}
			}
		}
	}
	
	// if any, direct one of the ps-s towards it (only if there is a ps in idle state)
	if ( uTarget.IsAlive() ) {
		haunts = 0;
		for ( i = 0; i < ol.count; i += 1 ) {
			if ( arrStates[i] == 0 ) {
				haunts += 1;
				if ( haunts > count / 2 ) {
					arrStates[i] = 1; // chasing an enemy unit
					olTgtUnits.Set(i, uTarget);
				}
			}
		}
	}

	for ( i = 0; i < count; i += 1 ) {
		ps = ol[i].AsParticleSystem();
		if ( !ps.IsValid() ) continue;
		if ( arrStates[i] == 0 || arrStates[i] == 2 ) {
			if ( i != haunt ) continue;
			bInside = false;
			bInsideUpgd = false;
			while ( tries < maxtries ) {
				if ( arrStates[i] == 0 ) {
					height = -(arrHeights[i] + rand(50) - 25);
					pt = RandomPoint(ps.pos, 50, 8);
				} else {
					pt = RandomPoint(b.pos, b.radius, 8);
					height = -rand(maxheight);
				}
				if ( upgd.IsValid() ) {
					bInsideUpgd = upgd.IsPointInside(pt - b.pos - Point(0, height));
				} 
				bInside = b.IsPointInside(pt - b.pos - Point(0, height));
				if ( bInside || bInsideUpgd ) break;
				
				tries += 1;
			}
			if ( tries >= maxtries ) {
				pt = RandomPoint(b.pos, b.radius, 8);
				height = -rand(maxheight);
			}
			if ( arrStates[i] == 0 ) {	// normal state, go to new location
				ps.Goto(pt, time, height); 
			} else {					// not initialized, set position/height and state
				ps.Goto(pt, 0, height);
				arrStates[i] = 0;
			}
			arrHeights[i] = height;
		} else if ( arrStates[i] == 1 ) { // going towards unit
			// go towards target with const velocity
			u = olTgtUnits[i].AsUnit();
			if ( u.IsAlive() ) {
				if ( ps.pos.Dist(u.pos) < u.radius ) {
					if ( !u.ExistEffect("curse") ) {
						u.curse_owner = this;
						u.AddEffectTimeout("curse", GetClassInt("Human_WitchQueen", "haunt_curse_damage"), 1000, GetClassInt("Human_WitchQueen", "haunt_curse_duration"));
					}
					arrStates[i] = 2; 
					pt = RandomPoint(b.pos, b.radius, 8);
					height = -rand(maxheight);
					ps.Goto(pt, 0, height);
				} else {
					// track unit movement
					dist = u.pos.Dist(ps.pos); // dist in xy
//					dist = Int(sqrt(dist * dist + (arrHeights[i] - 50) * (arrHeights[i] - 50)));
					ps.Goto(u.pos, 1000 * dist / 150, 0); // t[ms] = 1000 * s[px] / v[px/s]
				}
			} else {
				arrStates[i] = 2;
			}
			if ( arrStates[i] != 1 ) {
				olTgtUnits.Set(i, ps);
			}

			// after a directed ps reaches the unit, curse it (if unit is still alive), then 
			// reset the ps to normal state (idle) and position within the building contour
		}
	}
	Sleep(time / count);
	haunt += 1;
	if ( haunt >= count ) haunt = 0;
}
if(GetTime() - last_damage_time >= 1000)
{
	// damage the building during the cursed period
	times_to_damage = (GetTime() - last_damage_time) / 1000;
	last_damage_time = GetTime();
	.target_building.Damage(.reserved_obj0, .reserved_obj0.haunt_building_damage_per_sec * times_to_damage, false);
}

for ( i = 0; i < count; i += 1 ) {
	ps = ol[i].AsParticleSystem();
	if ( ps.IsValid() ) {
		ps.StopEmitters();
	}
}

b.SetVisible(true);
if ( b.IsHeirOf("Tower") ) {
	b.disabled = 0;
}

Sleep(3000);
for ( i = 0; i < count; i += 1 ) {
	ps = ol[i].AsParticleSystem();
	if ( ps.IsValid() ) {
		ps.Erase();
	}
}


b.is_haunted = 0;
this.Erase();
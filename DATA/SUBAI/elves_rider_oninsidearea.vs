// void, Obj me, ObjList ol

int i, elfcnt, atkspeed;
Unit u, this;

this = me.AsUnit();
if ( IsUpgradeAvailable( .player, "upgrade_Elven_Encouragement" ) && !this.IsIndependentGuardian() )	{
	elfcnt = 0;
	for ( i = 0; i < ol.count; i += 1 ) {
		u = ol[i].AsUnit();
		if (u.IsAlive()) 
			if ( ( u != this ) && !u.IsIndependentGuardian() )	{
				elfcnt += 1;
			}
	}
	atkspeed = .encouragement_bonus * elfcnt;
	if (atkspeed > .encouragement_max)
		{
		atkspeed = .encouragement_max;
		}
	.SetAttackSpeedFactor( .attack_speed_factor - .last_damagebonus + atkspeed );	
	.SetSpeedFactor( .speed_factor - .last_damagebonus + atkspeed );	
	.last_damagebonus = atkspeed;
}
// void, Obj me, ObjList ol

int i, elfcnt, dmg;
Unit u, this;

this = me.AsUnit();
if ( IsUpgradeAvailable( .player, "upgrade_Elven_Unity" ) && !this.IsIndependentGuardian() )	{
	elfcnt = 0;
	for ( i = 0; i < ol.count; i += 1 ) {
		u = ol[i].AsUnit();
		if (u.IsAlive()) 
			if ( ( u != this ) && !u.IsIndependentGuardian() )	{
				elfcnt += 1;
			}
	}
	
	dmg = .unity_bonus * elfcnt;
	
	if (dmg>.unity_max)
		{
		dmg = .unity_max;
		}
	.damage = .damage - .last_damagebonus + dmg;
	.last_damagebonus = dmg;
}
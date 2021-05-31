// void, Obj This, point pt

Unit this, wolf;

this = This.AsUnit();

pt = PassablePointNear(pt, 40, 10, true);
if( !pt.InRect(GetMapRect()) )
{
	// FIX: Send the unit to the general location anyway!
	return;
}

if ( .wm_wolf1.IsValid() ) {
	if ( .wm_wolf1.IsAlive() ) {
		wolf = .wm_wolf1.AsUnit();
		.wm_wolf1.Clear();
	}
} else if ( .wm_wolf2.IsValid() ) {
	if ( .wm_wolf2.IsAlive() ) {
		wolf = .wm_wolf2.AsUnit();
		.wm_wolf2.Clear();
	}
} else if ( .wm_wolf3.IsValid() ) {
	if ( .wm_wolf3.IsAlive() ) {
		wolf = .wm_wolf3.AsUnit();
		.wm_wolf3.Clear();
	}
} else if ( .wm_wolf4.IsValid() ) {
	if ( .wm_wolf4.IsAlive() ) {
		wolf = .wm_wolf4.AsUnit();
		.wm_wolf4.Clear();
	}
}

if ( wolf.IsValid() ) {
	if ( wolf.IsAlive() ) {
		wolf.ExecCmd("move", pt, true);
		wolf.SetVisible(false);
		wolf.SetSight(wolf.sight+100);
		wolf.wolf_master.Clear();
		wolf.wolf_master_scout = this;
		wolf.wolf_state = wolf.wolfstate_sentry;
		.scout_charges = .scout_charges - 1;
		.SetEnergy(.energy - .scout_wolf_energy_cost);
	}	
}
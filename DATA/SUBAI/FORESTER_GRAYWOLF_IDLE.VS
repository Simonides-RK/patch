// void, Obj This

Unit this, uMaster, u;
int nDist;
point ptVector, ptDest;
int nSleep;

this = This.AsUnit();
uMaster = .wolf_master;

if (uMaster.IsAlive() && .wolf_state>=0) {
	if (uMaster.HasPath()) {
		ptVector = uMaster.dest - uMaster.pos;
		ptVector.SetLen(.sight/2 + rand(.sight/2));
		ptVector.Rot(45-rand(90));

		.ClearCommands();
		.AddCommand(true, "advance", uMaster.dest + ptVector);
		.wolf_state=0;
		return;
	} else {
		if (uMaster.command == "idle") {
			nSleep = 3000 + rand(5000);
			while (nSleep>0) {
				if(rand(100)<.idle_anim_percent)
					.PlayAnim(AnimIdle);
				else
					Sleep(1000);
				nSleep -= 1000;
				if (uMaster.command != "idle")
					return; //run script anew so the other case would kick in
			}
		} else {
			if (uMaster.lasttarget.IsAlive()) {
				.ClearCommands();
				.AddCommand(true, "advance", uMaster.lasttarget.pos);
				.wolf_state=0;
				return;
			} else {
				if(rand(100)<.idle_anim_percent)
					.PlayAnim(AnimIdle);
				else
					Sleep(1000);
			}
		}
	}

} else { //wolfmaster is dead or we are sentry
	if ( .wolf_state == -1 ) {
		.PlayAnimRandomly(AnimIdle, 2000 + rand(2000), 5);
		ptVector = .GetDir();
		ptVector.SetLen(.sight/2 + rand(.sight/2));
		ptVector.Rot(90-rand(180));

		.ClearCommands();
		.AddCommand(true, "move", .pos + ptVector);
		return;
	}
	
	if ( .wolf_state == .wolfstate_sentry ) { 
		while ( 1 ) {
			if ( .GetVisible() ) {
				.SetVisible(false);	// if someone made us visible for some reason (altough there appears to be no).
			}
			if ( rand(100 )< .idle_anim_percent )
				.PlayAnim(AnimIdle);
			else
				Sleep(1000);
		}
	}
	
	//if the handle is later reused, avoid following a completely different unit :)
	.wolf_master.Clear();

	// This case makes the wolf fight until there are no enemies
	u = .BestTargetInSquadSight();
	if (u.IsAlive())
		{
			.ClearCommands();
			.AddCommand(true, "engage");
			return;
		}

	// When there are no enemies, we go wild and independent
	.SetEnemyCannotTargetFlag(true);
	.SetPlayer(15);
	.wolf_state = -1;
	Sleep(6000);
	.SetHidden(true);
	.Erase();
	return;
}

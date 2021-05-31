// void, Obj This, Obj attacker

Unit this;
Unit wolfmaster;
this = This.AsUnit();
wolfmaster = .wolf_master_scout;

if (.wolf_state == .wolfstate_sentry)
{
	wolfmaster.scout_charges = wolfmaster.scout_charges + 1;
}
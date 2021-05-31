// void, Obj me, Obj target

Unit this, tgt;

this = me.AsUnit();

if ( .energy < .holyshield_energy_cost ) {
	_pr("warrning: holy armor started with insufficient energy!");
	return;
}

tgt = target.AsUnit();
if ( !tgt.IsAlive() ) return;
if ( tgt.ExistEffect("holy_armor") ) {
	return;
}

.PlayAnim(AnimAttack1);
if(tgt.IsAlive())
{
	tgt.AddEffectTimeout("holy_armor", .holyshield_damagemax, 0, .holyshileld_duration);
}
.SetEnergy(.energy - .holyshield_energy_cost);
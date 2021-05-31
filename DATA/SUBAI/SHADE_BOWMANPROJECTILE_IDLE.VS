// void, Obj this

int dmg;
Unit u;

if ( .proj_owner.IsDead ) {
	.Erase();
	return;
}

u = .proj_owner.AsUnit();

if ( .proj_target.IsAlive() ) {
	dmg = CalculateDamage(.proj_owner, .proj_target, .proj_owner.damage, .proj_target.armor);
	Sleep(.proj_time);
	if ( .proj_target.IsAlive ) {
		if ( IsUpgradeAvailable(.player, "upgrade_Shades_champpoison") && .proj_target.AsUnit().IsValid() && .proj_target.AsUnit().IsHeirOf("Hero") ) {
			.proj_target.AsUnit().AddEffectTimeoutObjParam("open_wounds_ranger", 0, 0, .proj_owner, u.champpoison_duration);
			.proj_target.AsUnit().AddEffectTimeoutObjParam("poison", u.champpoison_damage, 1000, .proj_owner, u.champpoison_duration);
			
		}
		.proj_target.Damage(.proj_owner, dmg, true);
	}
} else {
	Sleep(.proj_time);
}

.Erase();

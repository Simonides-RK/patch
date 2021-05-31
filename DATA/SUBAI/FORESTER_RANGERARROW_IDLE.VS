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
		if ( IsUpgradeAvailable(.player, "upgrade_WeakPoints") && .proj_target.AsUnit().IsValid() ) {
			.proj_target.AsUnit().AddEffectTimeoutObjParam("open_wounds_ranger", u.open_wound_damage, u.open_wound_interval, .proj_owner, u.open_wound_duration);
			dmg += u.open_wound_damage;
		}
				if ( IsUpgradeAvailable(u.player, "upgrade_SkilfulArchery") && (rand(100) < GetClassInt("Forester_Ranger", "archery_critical_chance")) && .proj_target.AsUnit().IsValid() ) {
				dmg += CalculateDamage(.proj_owner, .proj_target, .proj_owner.damage, .proj_target.armor);
				FloatingText(Translate("[[]]-[[]]") + dmg, .proj_target.pos + Point(0, -25), GetConst("CriticalDamageColor"), 0);
					} 

		
		.proj_target.Damage(.proj_owner, dmg, true);
	}
} else {
	Sleep(.proj_time);
}

.Erase();

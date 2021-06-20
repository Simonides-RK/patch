// void, Obj this, ObjList ol

int i;
Unit u;

//_pr("wizardofthebow::oninside");
.enemy_objs_damaged = 0;
.friendly_objs_damaged = 0;
for(i = 0; i < ol.count(); i += 1)
{
	if(ol[i].IsAlive() && .starstorm_owner.IsAlive() && .starstorm_owner.IsEnemy(ol[i]))
	{
		Obj o;
		int damage;
		o = ol[i];

		damage = CalculateDirectDamage(.starstorm_owner, o, .starstorm_owner.starstorm_dmg_per_sec + .starstorm_owner.AsUnit.GetEffectParam("item_starstorm_bonus", 1));
		o.Damage(.starstorm_owner, damage, false);
		u = o.AsUnit;
		if(u.IsAlive)
			u.AddEffectTimeout("frozen", .starstorm_owner.starstorm_slowdown_percent, 0, 1100);
		// this code is added because of ai star strom stats tracking
		if(.IsEnemy(o))
			.enemy_objs_damaged += 1;
		else
			.friendly_objs_damaged += 1;
	}
}

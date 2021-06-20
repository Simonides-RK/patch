// void, Obj this, ObjList ol

int i;

//_pr("sharpshootercorrosivegas::oninside");
if(.target_unit.IsValid() && .target_unit.IsAlive() && .target_unit.IsAlive())
{
	this.AsParticleSystem().Goto(.target_unit.pos, 1000);
}
for(i = 0; i < ol.count; i += 1)
{
	Obj o;
	o = ol[i];
	if(o.AsUnit().IsValid() && .owner.IsEnemy(o))
	{
		int damage;

		damage = CalculateDirectDamage(.owner, o, .owner.gas_dmg_unit+.owner.AsUnit.GetEffectParam("item_corrosivegas_bonus", 1));
		o.Damage(.owner, damage, false);
	}
	else if(o.AsBuilding().IsValid())
	{
		o.Damage(.owner, .owner.gas_dmg_building, false);
	}
}

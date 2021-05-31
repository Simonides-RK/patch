// void, Unit this, Obj src, int damage, int param1, int param2

ObjList ol;
int count, i, old_damage;
Unit u;
Hero h;

//_pr("effect_magicswords::ondealtdamage");

ol=ClassPlayerObjs("Human_BattleAngel", .player, true).GetObjList;

for (i=0; i<ol.count; i+=1)
	{
	h=ol[i].AsHero();
	}

u = src.AsUnit();
if ( u.IsAlive() ) {
	if ( !u.IsRanged() ) {
		if (h.IsSkillDeveloped("MagicExposure"))
		{
			.RemoveEffect("magicsword", h.GetEffectParam("item_magicsword_bonus", 1), 50);
		} else {	
			.RemoveEffect("magicsword", h.GetEffectParam("item_magicsword_bonus", 1), 0);
			}
	}
}
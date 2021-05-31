// void, Obj This

Hero this;
ObjList ol;
int i;

this = This.AsHero;

ol = ClassPlayerObjs("Forester_WhiteWolf", .player, true).GetObjList;
for(i = 0; i < ol.count; i += 1)
{
	if(ol[i].queen_of_the_wolves == this)
	{
		Obj o;
		o = ol[i];
		o.SetVisible(false);
		o.SetMaxHealth(o.maxhealth + .GetEffectParam("item_moon_bonus", 1) + .assassin_wolves_health_bonus);
		if (.IsSkillAvailable("Ghost_Wolves"))
		{
		o.SetMaxHealth(o.maxhealth + .GetEffectParam("item_moon_bonus", 1) + .assassin_wolves_health_bonus + .ghost_wolves_health_bonus);
		}
	}	
}

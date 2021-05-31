// void, Obj This, Obj target

Unit this;
Building b;
int add_health;
ObjList ol;
int i, index, min_life, count, gold_repair, gold_cost;
ParticleSystem ps;

this = This.AsUnit();
b = target.AsBuilding();
//_pr("darkmage::repair");

while(b.IsAlive())
{
	// Goto building
	while(!.Goto(b, .build_repair_distance, 1500, false, -1));
	.Face(b.pos);	// handle case when the unit is already close to the building

	gold_cost = GetCost(b.cost, ResGold) + GetCost(b.cost, ResGems) * GetConst("GoldForOneGem");
	add_health = .health_repair + .health_fract_repair * b.GetMaxHealth() / 1000;
	gold_repair = (gold_cost * add_health * .gold_repair_percent) / (100 * b.GetMaxHealth());
	if(gold_repair < .min_gold_per_repair)
	{
		gold_repair = .min_gold_per_repair;
	}
	while(GetRes(.player, ResGold) >= gold_repair && b.health < b.GetMaxHealth())
	{		
		PlaySound(.pos, .repair_building_sound);
		.PlayAnim(AnimSpecial1);
		if(GetRes(.player, ResGold) >= gold_repair)
		{
			DecRes(.player, ResGold, gold_repair);
			FloatingText(Translate("[[]]-[[]]") + gold_repair, .pos - Point(0, 10), GetConst("GoldResColor"), .player);
		}
		else
		{
			break;
		}
		if(!b.IsAlive())
		{
			break;
		}
		b.Heal(add_health);
	}
	if(GetRes(.player, ResGold) < gold_repair)
	{
		break;
	}

	ol = Intersect(ObjsInSight(this, "Building", true), FriendlyObjs(.player, "Building", true)).GetObjList();
	count = ol.count;
	index = -1;
	for(i = 0; i < count; i += 1)
	{
		b = ol[i].AsBuilding();
		if(!b.IsBuilt() || b.health > b.GetMaxHealth() / 2 || b.race != Race_Darklings)
		{
			continue;
		}
		if(index == -1 || b.health < min_life)
		{
			min_life = b.health;
			index = i;
		}
	}
	if(index != -1)
	{
		if(ol[index].health < ol[index].GetMaxHealth() / 2)
		{
			b = ol[index].AsBuilding();
		}
		else
		{
			break;
		}
	}
	else
	{
		break;
	}
}

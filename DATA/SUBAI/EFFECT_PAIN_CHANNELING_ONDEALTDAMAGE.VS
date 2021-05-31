// void, Unit this, Obj src, int &damage, bool bDirectDamage, int param1, int param2, Obj oParam

ObjList ol;
int count, i, old_damage;
Unit u;

//_pr("effect_pain_channeling::ondealtdamage");

ol = Intersect(ObjsInRange(this, "Unit", .pain_channeling_radius, false), FriendlyObjs(.player, "Unit", false)).GetObjList();
count = ol.count();

u = invalid_obj;
// param1 - percents of dealt damage
old_damage = damage;
.pain_channel_damage = damage * param1 / 100;


// 1st) search for mind controlled units
for(i = 0; i < count; i += 1)
{
	u = ol[i].AsUnit();
	if(u.ExistEffect("mind_control"))
	{
		//_pr("effect_pain_channeling::ondealtdamage - mind controlled unit found");
		break;
	}
}

if(!u.IsValid)
{
	// 2nd) search for illusion units
	for(i = 0; i < count; i += 1)
	{
		u = ol[i].AsUnit();
		if(u.ExistEffect("illusion"))
		{
			//_pr("effect_pain_channeling::ondealtdamage - illusion unit found");
			break;
		}
	}
}

if(!u.IsValid)
{
	// 3rd) search for units taken control by mind blend
	for(i = 0; i < count; i += 1)
	{
		u = ol[i].AsUnit();
		if(u.ExistEffect("possessed") || u.summoned_unit > 0)
		{
			//_pr("effect_pain_channeling::ondealtdamage - unit taken control by mind blend found");
			break;
		}
	}
}

if(!u.IsValid)
{
	Unit best_unit;
	int best_health;
	best_health = 0;
	// 4th) any other unit
	for(i = 0; i < count; i += 1)
	{
		u = ol[i].AsUnit();
		if(u.IsAlive())
		if(u != this)
		if(u.health > best_health) // do not kill the units   
		{
			best_health = u.health;
			best_unit = u;			
			break;
		}
	}
	if(best_health+50 < .pain_channel_damage)
		u = invalid_obj; // couldnot find object
	else
		u = best_unit;
}

if(u.IsValid)
{
	damage = old_damage - .pain_channel_damage;
	if(GetTime - .last_pain_channel_feedback > .pain_channel_fdbk_pause)
	{
		.last_pain_channel_feedback = GetTime();
		CreateFeedback("data/particles/PainChannelingFairy.part.xml", this, .pain_channeling_time, true);
		.CreateProjectile(u, .pain_channeling_projectile);
	}
}
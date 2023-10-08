// void, Obj me

ParticleSystem this;
ObjList ol;
int count, i, splash_radius, dist, damage, damage_orig;
Obj o;
point pt;
bool bDoSplash;

this = me.AsParticleSystem();
if(.proj_owner.IsDead())
{
	.Erase();
	return;
}

splash_radius = .proj_owner.splash_radius;
damage_orig = .proj_owner.damage;
Sleep(.proj_time);	

pt = .exact_pos;
ol = ObjsInCircle(pt, splash_radius+250, "BaseGameObject", false).GetObjList();
count = ol.count();
for(i = 0; i < count; i += 1)
{
	o = ol[i];
	if ( !o.IsEnemy(.proj_owner) ) continue;
	if (o.IsAlive()) {
		dist = o.DistTo(pt);
		if (o != .proj_owner && dist < splash_radius)
		{
			damage = CalculateSplash(damage_orig, dist, splash_radius);
			o.Damage(.proj_owner, CalculateDamage(DamageExplosive, o, damage, o.armor), true);
			CreateFeedback("data/particles/HitFeedback_Fire.part.xml", o, 3000, true);
		}
	}
}

.StopEmitters();
Sleep(2000);
.Erase();

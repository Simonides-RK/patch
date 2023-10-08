// void, Unit this, int param1, int param2, Obj oParam

Hero h;
ObjList targets;
Unit u;
int i, n;

//_pr("lightning storm: behavior");

h = oParam.AsHero();

// find possible targets
targets = Intersect(ObjsInCircle(.pos, h.lightningstorm_range, "BaseGameObject", false), EnemyObjs(.player, "BaseGameObject", false)).GetObjList();

// Random damage targets
for (i = 0; i < h.lightningstorm_numtargets; i+=1)
	if (targets.count>0)
		{
			n = rand(targets.count);
			.CreateProjectile(targets[n], h.lightningstorm_projectile, 20, 0);
			targets.Remove(targets[n]);
		}
if (!.IsHeirOf("Hero")) {
.Damage(h, h.lightningstorm_damage_initial, false);
}

Sleep(100); // let unit die, if damaged enough

if ( .IsAlive() ) {
	.RemoveEffect("lightningstorm", 0, 0, h);
}

// void, Obj this

Query enemy;
ObjList ol;
Obj attacker;
int i, dmg, basedmg;
bool bUseVenom;

if(.cactus_owner.IsValid())
{
	if(!.cactus_owner.AsHero().IsValid())
	{
		bUseVenom = .cactus_owner.stalker_venom == 1;
	}
}
else
{
	bUseVenom = false;
}
.SetHidden(true);
Sleep(200); // Planting delay for visual purposes
.SetHidden(false);
.PlayAnim(AnimSpecial2);
enemy = Intersect(ObjsInRange(this, "Unit", .range, false), EnemyObjs(.player, "Unit", false));
WaitNonEmptyQuery(enemy, -1);

.PlayAnim(AnimSpecial3);
Sleep(.trap_delay);

.StartAnim(AnimSpecial1);
Sleep(.TimeToActionMoment);

if(.cactus_owner.IsValid()) {
	attacker = .cactus_owner;
} else {
	attacker = this;
}

ol = ObjsInCircle(.pos, .range, "Unit", false).GetObjList();
for ( i = 0; i < ol.count; i += 1 ) {
	if ( !ol[i].IsAlive() ) continue;
	if ( !ol[i].IsEnemy(this) ) continue;
	if ( .DistTo(ol[i]) > .range / 2 ) {
		basedmg = .trap_basedamage / 2;
	} else {
		basedmg = .trap_basedamage;
	}
	
	dmg = CalculateDirectDamage(this, ol[i], basedmg);
	ol[i].Damage(attacker, dmg, false);
}

if(.cactus_owner.AsHero().IsValid())
{
	//_pr("cactus_trap::idle - owner is Stalker hero");
	if(.cactus_owner.IsSkillDeveloped("Venom"))
	{
		//_pr("cactust_trap::idle - placing Forester_Cactus_Particle");
		Place("Forester_Cactus_Particle", .pos, .player);
	}
}
else
{
	//_pr("cactus_trap::idle - owner is Forest Overlord");
	if(bUseVenom)
	{
		//_pr("cactust_trap::idle - placing Forester_Cactus_Particle");
		Place("Forester_Cactus_Particle", .pos, .player);
	}
}
Sleep(.TimeToAnimFinish);

.Erase;

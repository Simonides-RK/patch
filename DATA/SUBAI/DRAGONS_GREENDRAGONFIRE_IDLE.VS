// void, Obj me

ParticleSystem this;
int damage; 

this = me.AsParticleSystem();
if(.proj_owner.IsDead())
{
	.Erase();
	return;
}
if(.proj_target.class == "Dragons_RedDragon")
{
	.Goto(.pos, 0, 350);
	.Goto(.proj_target.pos, .proj_time, 350);
} else
if(.proj_target.class == "Dragons_GreenDragon")
{
	.Goto(.pos, 0, 350);
	.Goto(.proj_target.pos, .proj_time, 280);
}

if (.proj_target.IsAlive())
	damage = CalculateDamage(.proj_owner, .proj_target, .proj_owner.damage, .proj_target.armor);
Sleep(.proj_time);

if (.proj_target.IsAlive())
{
	.proj_target.Damage(.proj_owner, damage, true);
	if(.proj_target.AsUnit().IsAlive())
		.proj_target.AsUnit().AddEffectTimeout("cantattack", 0, 0, 1100);
	if (IsUpgradeAvailable(.proj_owner.player, "upgrade_Weakening_Acid"))
		{
		.proj_target.AsUnit().AddEffectTimeout("weakening_acid", .proj_owner.acid_vulnerabilty_increase, 0, .proj_owner.acid_duration);
		}

}

.StopEmitters();
Sleep(.life_time);
.Erase();

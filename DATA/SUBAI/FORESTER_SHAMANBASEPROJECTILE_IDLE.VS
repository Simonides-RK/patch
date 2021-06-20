// void, Obj me

ParticleSystem this;
Unit u;
int damage;

this = me.AsParticleSystem();

if(.proj_owner.IsAlive())
if(.proj_target.IsAlive())
{
	// calc it here because channeling shamans may change 
	// when target is reached
	damage = (.proj_owner.initial_damage + .proj_owner.channel_bonus) * (.proj_owner.shamans_channeled) * (.proj_owner.shamans_channeled + 9) / 10;
	damage = CalculateDamage(.proj_owner, .proj_target, damage, .proj_target.armor);

	if(.proj_target.AsHero.IsValid && damage > .proj_owner.hero_cap_damage)
		damage = .proj_owner.hero_cap_damage;
}

Sleep(.proj_time);
.StopEmitters();

if(.proj_target.IsAlive())
{		
	//_pr("shamanbaseprojectile::idle - damaging x" + damage_multiplier + "...");
	.proj_target.Damage(.proj_owner, damage, true);
}

Sleep(.time_fadeout);
.Erase();

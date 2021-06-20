// void, Obj this

int dmg;
bool bUseVenom;

if (.proj_owner.IsDead)
	{
		.Erase();
		return;
	}
if(.proj_owner.class == "Forester_Overlord")
{
	bUseVenom = .proj_owner.stalker_venom == 1;
}
else
{
	bUseVenom = false;
}
if (.proj_target.IsAlive() && .proj_owner.IsEnemy(.proj_target))
	{
		dmg = CalculateDirectDamage(.proj_owner, .proj_target, GetClassInt('Forester_Cactus_Trap', 'trap_numprojectile_damage'));
		Sleep(.proj_time);
		if(.proj_target.IsAlive)
		{
			if(.proj_owner.class == "Forester_Stalker")
			{
				//_pr("cactus_projectile::idle - owner is Stalker hero");
				if(.proj_owner.IsSkillDeveloped("Venom"))
				{
					.proj_target.AsUnit.AddEffectTimeout("poison",
											.proj_owner.cactus_venom_damage,
											.proj_owner.cactus_venom_sleep,
											.proj_owner.cactus_venom_effect_time);
				}
			}
			else if(.proj_owner.class == "Forester_Overlord")
			{
				//_pr("cactus_projectile::idle - owner is Forest Overlord");
				if(bUseVenom)
				{
					.proj_target.AsUnit.AddEffectTimeout("poison",
											.proj_owner.cactus_venom_damage,
											.proj_owner.cactus_venom_sleep,
											.proj_owner.cactus_venom_effect_time);
				}
			}
			.proj_target.Damage(.proj_owner, dmg, false);
		}
	}
else
	Sleep(.proj_time);


.Erase();

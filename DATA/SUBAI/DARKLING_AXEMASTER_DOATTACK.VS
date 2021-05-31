// void, Obj This, Obj enemy

Hero this;
int dmg;
bool bSpecialUsed;

this = This.AsHero();

dmg = CalculateDamage(this, enemy, .damage, enemy.armor);

if(dmg == 0) // we missed  on invisible
	return;
	
bSpecialUsed = false;

if(.activated_bash != -1)
{
	bSpecialUsed = true;
	.activated_bash = -1;
	if(.ExistEffect("bloodlust"))
	{
		.clr_end = GetConst("BloodLustDamageColor");
	}
	else
	{
		.activated_glow = 0;
	}
	dmg = dmg * .bash_multiplyer;
	dmg = CalculateDirectDamage(this, enemy, dmg);
	FloatingText(Translate("[[]]-[[]]") + dmg, enemy.pos, GetConst("CriticalDamageColor"), 0);
	.ClearCustomAttackAnim();
	if(enemy.command != "stun")
	if((enemy.user_flags1 & enemy.cant_be_stunned) == 0)
	if(enemy.AsUnit.IsAlive)
	{
		enemy.InsertCommand("stun");
	}
}

if(.activated_death_blow != -1)
{
	bSpecialUsed = true;
	.activated_death_blow = -1;	
	if(.ExistEffect("bloodlust"))
	{
		.clr_end = GetConst("BloodLustDamageColor");
	}
	else
	{
		.activated_glow = 0;
	}
	dmg = dmg * .death_blow_multiplyer;
	dmg = CalculateDirectDamage(this, enemy, dmg);
	FloatingText(Translate("[[]]-[[]]") + dmg, enemy.pos, GetConst("CriticalDamageColor"), 0);
	.ClearCustomAttackAnim();
}


enemy.Damage(this, dmg, true);

if (dmg >= enemy.health && !enemy.IsAlive()) // We've killed him! We need both to make sure it actually died and was killed by HIM.
{
	if(.IsSkillDeveloped("Ferocity"))
	{
		.Heal(.GetMaxHealth() * .ferocity_heal_percent / 100, "Heal_Sound_");
			CreateFeedback("data/particles/Heal_Unit_Feedback.part.xml", this, 400, true);
			
		if (.ExistEffect("bloodlust"))
			bSpecialUsed = true;
		if(bSpecialUsed)
		{
			.Heal(.GetMaxHealth() * .ferocity_heal_percent_extra / 100, "Heal_Sound_");
		}
	}

	if(.IsSkillDeveloped("Blood_Lust"))
	{
		.AddEffectTimeout("bloodlust", .blood_lust_bonus_damage, -1, .blood_lust_timeout);
		CreateFeedback("data/particles/Bloodlust.part.xml", this, 400, true);
		PlaySound(.pos, "assets/sounds/HeroSkills/Darkling Axemaster/Axemaster_BloodLust.wav");
		.activated_glow = 1;
		.clr_end = GetConst("BloodLustDamageColor");
	}
}

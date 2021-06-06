// void, Obj This

Unit this;
this = This.AsUnit();


while(1)
{

	while (.modal_button == 4)
	{
		if (.health < .GetMaxHealth() && IsUpgradeAvailable(.player, "upgrade_Burning_Wings"))
			{
			.Heal (.burning_wings_regen);
			}
		Sleep(1000);
	}

if (IsUpgradeAvailable(.player, "upgrade_Burning_Wings") && .modal_button == 5)
	{
		
		if (!.ExistEffect("BurningWings"))
		{
			.AddEffect("BurningWings",0,0); 
		}
	}

	while (.modal_button == 5)
	{
		.Damage(this, .burning_wings_damage, false); 
		Sleep(1000);
	}

 
		if (.modal_button == 4 ) // ypsilon: check for disappearing effect
	{
		if (.ExistEffect("BurningWings"))
		{
			.RemoveEffect("BurningWings",0,0); 
		}
	}
}
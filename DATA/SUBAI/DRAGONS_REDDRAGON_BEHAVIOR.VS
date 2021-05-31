// void, Obj This

Unit this;
this = This.AsUnit();


while(1)
{

	while (.modal_button == 4)
	{
		Sleep(100);
	}

if (IsUpgradeAvailable(.player, "upgrade_Burning_Wings") && .modal_button == 5) // ypsilon: check for effect
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
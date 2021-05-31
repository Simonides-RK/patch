// void, Obj This

Unit this;
this = This.AsUnit();


while(1)
{
	while (.modal_button == 4)
	{
		.SetEnergy(.energy - .inquisitor_energy/20);
		Sleep(100);
	}
	
	while (.modal_button == 5)
	{
		.SetEnergy(.energy + .inquisitor_energy/20);
		Sleep(1000);
	}
	
	if ( IsUpgradeAvailable(.player, "upgrade_PaladinArmor") && .modal_button == 6 && .energy > .inquisitor_energy ) // ypsilon: check for effect
	{
		.SetEnergy(.energy - .inquisitor_energy/2); 
		if (!.ExistEffect("PaladinArmor"))
		{
			.AddEffect("PaladinArmor",0,0); 
		}
	}

	while (.ExistEffect("PaladinArmor") && .energy > .inquisitor_energy && .modal_button == 6)
	{
		.SetEnergy(.energy - .inquisitor_energy/2); 
		Sleep(1000);
	}
	if (.energy < .inquisitor_energy && .modal_button == 6)
	{
		.SetModalButton(.mb_manaup);
		Sleep(1000);
	}
 
		if (.modal_button == 4 || .modal_button == 5 || .energy < .inquisitor_energy) // ypsilon: check for disappearing effect
	{
		if (.ExistEffect("PaladinArmor"))
		{
			.RemoveEffect("PaladinArmor",0,0); 
		}
	}
}




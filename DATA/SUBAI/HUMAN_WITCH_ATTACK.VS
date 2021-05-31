// void, Obj me, Obj u

Unit this;
bool friendly;

this = me.AsUnit();

if(u.IsAlive())
{
	friendly = !me.IsEnemy(u) || !u.GetVisible;	
	if(.DistTo(u) > 500  && !.EnemiesInSquad)
	{
		while(!.GotoForm(u,150,1000,false))
		{
			if(!u.IsAlive())
			{
				break;
			}
			else if (.InRange(u))
			{
				break;
			}
		}
	}

	while(.IsValidTarget(u))
	{

		if(.energy < .attack_energy)
		{
			Sleep(.attack_energy_sleep);
		}
		if(.GotoAttack(u, 1000, true, 2000))
		{
			while(.energy >= .attack_energy)
			{
				.SetEnergy(.energy - .attack_energy);
				if(!.Attack(u, friendly))
				{
					break;
				}
			}
			if (u.IsAlive)
			if (.InRange(u) || u.AsBuilding.IsValid) // This means that 'Attack' has returned 'false' not because of range, so we give up
				break;
		}
	}
}

if (.CmdCount()==1)
	.AddCommand(true, "engage");

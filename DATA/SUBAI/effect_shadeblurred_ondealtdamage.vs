//void, Unit this, int *damage

if(damage == 0) {return;} 

if (.GetAnim != 0)
	{if (.GetAnim != AnimIdle1)
		{if (.GetAnim != AnimIdle2)
			{if(.GetAnim != AnimAttack1)
				{ if(damage > .moving_reduction)
					{damage = damage - .moving_reduction;}
						else damage = 1; }
				}
			}
		}


	if (IsUpgradeAvailable(.player, "upgrade_bottle_o_fog") && .class == "Shades_Warrior"){
	
		if (.GetAnim == 0 || .GetAnim == AnimIdle1 || .GetAnim == AnimIdle2 || .GetAnim == AnimAttack1)
		{
		
			if(damage > .bottle_o_fog_reduction)
			{	
				damage = damage - .bottle_o_fog_reduction;
			}
	
			else
			{
				damage = 1;
			}
		}			
	}
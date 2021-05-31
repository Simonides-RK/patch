// void, Obj me, Obj enemy

// unit demolish building attack
if(enemy.IsHeirOf("Tower"))
	enemy.Damage(me, CalculateDamage(me, enemy, me.damage, enemy.armor)+rand(me.extra_tower_damage)+me.extra_tower_damage, true);
else
	if (enemy.IsHeirOf("Building") && IsUpgradeAvailable(me.player, "upgrade_Raze") && !enemy.IsHeirOf("Tower"))
		{
		enemy.Damage(me, CalculateDamage(me, enemy, me.damage, enemy.armor)+me.extra_raze_damage, true);
		} else
			{
			enemy.Damage(me, CalculateDamage(me, enemy, me.damage, enemy.armor), true);	
			}
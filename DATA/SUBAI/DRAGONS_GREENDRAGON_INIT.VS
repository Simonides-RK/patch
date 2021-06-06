//void, Obj This

Unit this;

this=This.AsUnit;

if (IsUpgradeAvailable(.player, "upgrade_Weakening_Acid"))
	{
	.SetMaxHealth(.GetMaxHealth() + .weakening_bonus_health);
	.armor += GetClassInt("Dragons_GreenDragon", "weakening_bonus_armor");
	}
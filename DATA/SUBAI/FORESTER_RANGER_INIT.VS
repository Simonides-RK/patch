//void, Obj this

if (IsUpgradeAvailable(.player, "upgrade_Ranger_Strength_Training"))
{
	.SetMaxHealth(.GetMaxHealth + .strength_upgrade_hp_bonus);
}
if ( IsUpgradeAvailable(.player, "upgrade_SkilfulArchery"))
{
	.damage += GetClassInt("Forester_Ranger", "archery_bonus_atack");
}
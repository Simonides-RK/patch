// void, Obj This

Unit this;

this = This.AsUnit();


if(!IsUpgradeAvailable(.player, "upgrade_LifeBond"))
{
	.AddEffectTimeout("spirit", -1, -1, .spirit_lifetime);
}
else
{
	.AddEffectTimeout("spirit", -1, -1, .spirit_bond_lifetime);
}
.AddEffect("ethereal", .ethereal_miss_percent, -1);
// void, Obj This

Unit this;

this = This.AsUnit();

.time_borned = GetTime();
if(!IsUpgradeAvailable(.player, "upgrade_LifeBond"))
{
	.AddEffectTimeout("spirit", -1, -1, .spirit_lifetime);
}
else
{
	.AddEffectTimeout("spirit", -1, -1, .spirit_bond_lifetime);
}
.AddEffect("ethereal", .ethereal_miss_percent, -1);

if(.class == "Darkling_Spirit")
{
	.SetSpiritFX(true);
}
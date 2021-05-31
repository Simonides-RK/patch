//void, int player

int regen;

regen = GetClassInt("Darkling_TempleOfNightfall", "meditation_regenrate");

// set regen rate for each unit class. add call here when adding new units!
SetRegenerationRate("Darkling_ApostleOfDeath", player, regen, 0);
SetRegenerationRate("Darkling_Fanatic", player, regen, 0);
SetRegenerationRate("Darkling_Disciple", player, regen, 0);
SetRegenerationRate("Darkling_Cannoneer", player, regen, 0);
SetRegenerationRate("Darkling_DarkMage", player, regen, 0);
SetRegenerationRate("Darkling_GoldSpirit", player, regen, 0);
SetRegenerationRate("Darkling_SoulWatcher", player, regen, 0);
SetRegenerationRate("Darkling_StoneShaper", player, regen, 0);
/* no additional regeneration for heroes
SetRegenerationRate("Darkling_Axemaster", player, regen, 0);
SetRegenerationRate("Darkling_NightAssassin", player, regen, 0);
SetRegenerationRate("Darkling_Soulmonger", player, regen, 0);
SetRegenerationRate("Darkling_Empath", player, regen, 0);
*/
if(IsUpgradeAvailable(player, "upgrade_Nightweb"))
{
	int dark_rider_nigthweb_regen;
	dark_rider_nigthweb_regen = GetClassInt("Darkling_DarkRider", "nightweb_regenrate");
	SetRegenerationRate("Darkling_DarkRider", player, regen, dark_rider_nigthweb_regen);
}
else
	SetRegenerationRate("Darkling_DarkRider", player, regen, 0);

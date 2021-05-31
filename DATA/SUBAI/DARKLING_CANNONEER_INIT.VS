//void, Obj this

Unit u;

u = this.AsUnit();

if (IsUpgradeAvailable(.player, "upgrade_UnholyStrength")) u.armor += GetClassInt("Darkling_Cannoneer", "unholy_armor_bonus");
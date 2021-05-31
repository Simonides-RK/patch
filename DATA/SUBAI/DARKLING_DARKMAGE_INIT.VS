//void, Obj this

Unit u;

u = this.AsUnit();


.SetModalButton(.mb_mind_twist);
.gold_deposit = this;

if (IsUpgradeAvailable(.player, "upgrade_UnholyStrength")) 
{
		u.armor += GetClassInt("Darkling_DarkMage", "unholy_armor_bonus");
}
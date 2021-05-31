//void, Obj this

Unit u;
u = this.AsUnit();

u.SetDisableRangedAttack(true);
.SetRange(GetClassInt("Unit", "range"));
.last_damagebonus = 0;

if ( IsUpgradeAvailable(.player, "upgrade_PaladinArmor"))
{
	u.SetModalButton(.mb_manaup);
}
else
{
	u.SetModalButton(.mb_warrior);
}
	
if (IsUpgradeAvailable(.player, "upgrade_SpiritualBlessing")) u.AddEffect("spiritual_blessing_effect", 0, 0);
if (IsUpgradeAvailable(.player, "upgrade_GoldenShield")) u.AddEffect("goldenshield_swordsmans", 0, 0);
//void, Obj this

Unit u;
u = .AsUnit();


if (IsUpgradeAvailable(.player, "upgrade_Cavalry_AdvArmor"))
{
        u.SetSpeedFactor(u.speed_factor + .adv_armor_speed_bonus);
        u.SetMaxHealth(u.GetMaxHealth() + .adv_armor_health_bonus);
}
if (IsUpgradeAvailable(.player, "upgrade_GoldenShield")) u.AddEffect("goldenshield_swordsmans", 0, 0);
if (IsUpgradeAvailable(.player, "upgrade_SpiritualBlessing")) u.AddEffect("spiritual_blessing_effect", 0, 0);
//void, Obj this

// check for pikemen upgrades and apply, if available
.nearby_buildings = 0;
.militia_applied = 0;
.militia_glow_trans = 0;
.SetLayerTrans(2, 0);

if (IsUpgradeAvailable(.player, "upgrade_GoldenShieldPikeman")) .AsUnit().AddEffect("goldenshield", 0, 0);
if (IsUpgradeAvailable(.player, "upgrade_ReinforcedSpears")) .AsUnit().AddEffect("reinfspears", 0, 0);
if (IsUpgradeAvailable(.player, "upgrade_SpiritualBlessing")) .AsUnit().AddEffect("spiritual_blessing_effect", 0, 0);

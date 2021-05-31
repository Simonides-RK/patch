//void, Obj this

if ( IsUpgradeAvailable(.player, "upgrade_ReinforcedArrows") ) {
        .damage += GetClassInt("Human_Longbowman", "reinfarrows_bonus");
}

if ( !IsUpgradeAvailable(.player, "upgrade_ExplosiveArrows") ) {
        .SetProjectileClass(GetClassStr("Human_Longbowman", "projectile_class"));
}

if ( IsUpgradeAvailable(.player, "upgrade_CompositeLongbows") ) {
        .SetRange(.range * 2);
}

if ( IsUpgradeAvailable(.player, "upgrade_SpiritualBlessing") ) {
		.AsUnit().AddEffect("spiritual_blessing_effect", 0, 0);
}
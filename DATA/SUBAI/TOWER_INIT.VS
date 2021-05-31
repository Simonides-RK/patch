// void, Obj this

.disabled = 0;

if ( IsUpgradeAvailable(.player, "upgrade_ReinforcedArrows") ) {
        .damage += GetClassInt("Human_Longbowman", "reinfarrows_bonus");
}

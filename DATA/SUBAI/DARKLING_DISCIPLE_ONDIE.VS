// void, Obj this, Obj attacker

if ( IsUpgradeAvailable(.player, "upgrade_SacredWar") ) {
	IncRes(.player, ResGold, GetCost(.cost, ResGold) / 2);
	FloatingText(Translate("[[]]+[[]]") + GetCost(.cost, ResGold) / 2, .pos - Point(0, 10), GetConst("GoldResColor"), .player);
}

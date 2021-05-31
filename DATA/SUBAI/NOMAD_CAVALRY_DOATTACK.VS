// void, Obj me, Obj enemy

Unit this, u;
int damage;
ObjList ol;
int i, count;
int nGold;

this = me.AsUnit();

if ( IsUpgradeAvailable(.player, "upgrade_Plundering")) {
	
	damage = CalculateDamage(me, enemy, me.damage, enemy.armor);
	enemy.Damage(me, damage, true);
	if ( enemy.AsBuilding.IsValid() && enemy.IsAlive() ) {
		nGold = .plunder_attack;
			IncRes(.player, ResGold, nGold);
			FloatingText(Translate("[[]]+[[]]") + nGold, enemy.pos + Point(10,10), GetConst("GoldResColor"), .player);
		if ( enemy.AsBuilding.IsValid() && !enemy.IsAlive() ) {
		nGold = .plunder_destroy;
			IncRes(.player, ResGems, nGold);
			FloatingText(Translate("[[]]+[[]]") + nGold, enemy.pos + Point(10,10), GetConst("GoldResColor"), .player);
		}		
	}
} else {
	damage = CalculateDamage(me, enemy, me.damage, enemy.armor);
	enemy.Damage(me, damage, true);
}
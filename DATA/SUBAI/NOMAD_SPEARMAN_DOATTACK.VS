// void, Obj me, Obj enemy

Unit this;
int damage;


this = me.AsUnit();

if ( IsUpgradeAvailable(.player, "upgrade_Horse_Hunters") && enemy.defence_type == "mounted") {
	
	damage = CalculateDamage(me, enemy, me.damage + enemy.armor, enemy.armor);
	enemy.Damage(me, damage, true);
	
} else {
	damage = CalculateDamage(me, enemy, me.damage, enemy.armor);
	enemy.Damage(me, damage, true);
}
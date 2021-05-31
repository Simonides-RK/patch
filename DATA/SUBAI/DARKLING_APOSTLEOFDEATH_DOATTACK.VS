// void, Obj this, Obj enemy

Unit u;
int dmg;

dmg = CalculateDamage(this, enemy, .damage, enemy.armor);
if(enemy.energy >= .aether_blade_min_energy && IsUpgradeAvailable(.player, "upgrade_AetherBlade") && enemy.class!="Human_Shelter")
{
        dmg = .aether_blade_damage;
        enemy.SetEnergy(enemy.energy-.aether_blade_min_energy);
        enemy.Damage(this, dmg, true);
        FloatingText(Translate("[[]]-[[]]") + dmg, enemy.pos, GetConst('CriticalDamageColor'), 0);
}
else
{
        enemy.Damage(this, dmg, true);
}


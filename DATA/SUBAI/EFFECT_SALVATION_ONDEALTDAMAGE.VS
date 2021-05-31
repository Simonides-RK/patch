// void, Unit this, Obj src, int *damage, bool bDirectDamage, int param1, int param2, Obj oParam

if ( !oParam.IsAlive() ) return; // altar no longer exists, so we die

if ( (.health <= damage) && (.pos.Dist(oParam.pos) > 150) && (!.ExistEffect("dichotimize"))) {
    damage = 0;
	.SetHealth(.GetMaxHealth());
    .DamageWithNoAttacker(damage);
	.SetInvulnerable(true);
	.SetCommand("angelwings_save");
	.SetBlockCommand(true); 
}
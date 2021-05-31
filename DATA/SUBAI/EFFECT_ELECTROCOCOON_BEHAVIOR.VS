// void, Unit this, int param1, int param2, Obj oParam

Hero h;
ObjList ol, targets;
Unit u;
int i;

//_pr("cocoon: behavior");

h = .AsHero();

while ( 1 ) {
        // find target
        ol = Intersect(ObjsInCircle(h.pos, h.electrostatic_range, "Unit", false), EnemyObjs(.player, "Unit", false)).GetObjList();

        targets.Clear();
        for ( i = 0; i < ol.count; i += 1 ) {
                u = ol[0].AsUnit();
                                
                if ( u.IsAlive() && !u.ExistEffect("invincibility") && u.command != "stun" && !u.GetVisible() && u.class!="Trolls_SmallTrollFlying") {
                        targets.Add(u);
                } 
        }

if ( !targets.count > 0 )
{
        for ( i = 0; i < ol.count; i += 1 ) {
                u = ol[0].AsUnit();
                                
                if ( u.IsAlive() && !u.ExistEffect("invincibility") && u.command != "stun" && u.AsHero().IsValid()) {
                        targets.Add(u);
                } 
        }

}        

if ( !targets.count > 0 )
{
        for ( i = 0; i < ol.count; i += 1 ) {
                u = ol[0].AsUnit();
                                
                if ( u.IsAlive() && !u.ExistEffect("invincibility") && u.command != "stun" && u.class!="Trolls_SmallTrollFlying") {
                        targets.Add(u);
                } 
        }

}        

        if ( targets.count > 0 ) {
                // attack target
                u = targets.FilterClosest(.pos, 1)[0];
                .CreateProjectile(u, h.electro_projectile);
                        
                Sleep(h.electrostatic_delay*(100-.GetEffectParam("item_electricity_bonus", 1))/100);
        }
        
        // Stop effect if stunned
        if (.command=="stun") {
                .RemoveEffect("electro_cocoon", 0, 0);
                break;
        }
        Sleep(383);
}
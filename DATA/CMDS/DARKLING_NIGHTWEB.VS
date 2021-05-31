//void, int player
int regen;
int dark_rider_nigthweb_regen;
ObjList ol;
int i;
Unit u;

dark_rider_nigthweb_regen = GetClassInt("Darkling_DarkRider", "nightweb_regenrate");

if(IsUpgradeAvailable(player, "upgrade_Meditation"))
        regen = GetClassInt("Darkling_TempleOfNightfall", "meditation_regenrate");
else
        regen = GetClassInt("Darkling_DarkRider", "regenerate_promille");

SetRegenerationRate("Darkling_DarkRider", player, regen, dark_rider_nigthweb_regen); 


ol = ClassPlayerObjs("Darkling_DarkRider", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() )  u.SetMaxHealth(u.GetMaxHealth() + u.nightweb_health_bonus);	
}

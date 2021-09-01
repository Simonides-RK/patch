// void, Obj this, Obj oAttacker

Obj svo;
ObjList ol;
int i;
Obj u;

svo = .special_visual_obj;
if (svo.IsValid) if (svo.command == "idle")
{
        svo.SetCommand("die");
}

.ind_fake_queuer.Erase();
.special_visual_obj.Erase();
.special_visual_obj2.Erase();

if (.IsBuilt){
EnvWriteInt(.player, .race_str, EnvReadInt(.player, .race_str) - 1);
EnvWriteInt(.player, "colonyCount", EnvReadInt(.player, "colonyCount") - 1);

ol = ClassPlayerObjs("Building", .player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsBuilding();
		
        if ( u.IsAlive() && EnvReadInt(.player, "colonyCount") == 0 ) {
        if (u.race_str=="Race_Dragons" || u.race_str=="Race_Trolls" || u.race_str=="Race_Shades" || u.race_str=="Race_Nomads" || u.race_str=="Race_Elves") continue;
        if (u.class=="Human_Townhall" || u.class=="Darkling_Townhall" || u.class=="Forester_Townhall") u.armor-=u.first_armor_extra; }
		
		if ( u.IsAlive() && EnvReadInt(.player, "colonyCount") == 1 ) {
        if (u.race_str=="Race_Dragons" || u.race_str=="Race_Trolls" || u.race_str=="Race_Shades" || u.race_str=="Race_Nomads" || u.race_str=="Race_Elves") continue;
        if (u.class=="Human_Townhall" || u.class=="Darkling_Townhall" || u.class=="Forester_Townhall") u.armor-=u.second_armor_extra; }
		
		if ( u.IsAlive() && EnvReadInt(.player, "colonyCount") == 2 ) {
        if (u.race_str=="Race_Dragons" || u.race_str=="Race_Trolls" || u.race_str=="Race_Shades" || u.race_str=="Race_Nomads" || u.race_str=="Race_Elves") continue;
        if (u.class=="Human_Townhall" || u.class=="Darkling_Townhall" || u.class=="Forester_Townhall") u.armor-=u.third_armor_extra; }
		
		if ( u.IsAlive() ) {
        if (u.race_str=="Race_Dragons" || u.race_str=="Race_Trolls" || u.race_str=="Race_Shades" || u.race_str=="Race_Nomads" || u.race_str=="Race_Elves") continue;
        if (u.class=="Human_Townhall" || u.class=="Darkling_Townhall" || u.class=="Forester_Townhall") u.armor-=u.armor_bonus;
                else if (u.class=="Darkling_Tower" || u.class=="Forester_Tower" || u.class=="Human_Tower") u.SetMaxHealth(u.GetMaxHealth()-25); else u.armor-=5;
        }
}
}
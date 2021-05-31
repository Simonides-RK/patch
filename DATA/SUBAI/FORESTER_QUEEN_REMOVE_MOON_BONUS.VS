// void, Unit this, int param1, int param2

ObjList ol;
int i;
ol = ClassPlayerObjs("Forester_WhiteWolf", .player, true).GetObjList;
for(i = 0; i < ol.count; i += 1)
{
        if(ol[i].queen_of_the_wolves == this)
        {
//        if(.IsSkillAvailable("Ghost_Wolves"))
//                {ol[i].SetMaxHealth(ol[i].maxhealth + .AsUnit().GetEffectParam("item_moon_bonus", 1) + .ghost_wolves_health_bonus - param1);}
//            else
//                {ol[i].SetMaxHealth(ol[i].maxhealth + .AsUnit().GetEffectParam("item_moon_bonus", 1) - param1);}
ol[i].SetMaxHealth(ol[i].GetMaxHealth()-param1);
        }

               
}



// void, Unit this, int param1, int param2


ObjList ol;
int i;
ol = ClassPlayerObjs("Forester_WhiteWolf", .player, true).GetObjList;
for(i = 0; i < ol.count; i += 1)
{
        if(ol[i].queen_of_the_wolves == this)
        {ol[i].SetMaxHealth(ol[i].GetMaxHealth() + .AsUnit().GetEffectParam("item_moon_bonus", 1));
        if(.IsSkillAvailable("Ghost_Wolves")) ol[i].SetMaxHealth(ol[i].GetMaxHealth() + .ghost_wolves_health_bonus);
        }

               
}


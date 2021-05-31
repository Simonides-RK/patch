//void, int player

ObjList ol;
int i;
Unit u;

ol = ClassPlayerObjs("Forester_Werewolf", player, false).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        u = ol[i].AsUnit();
        if ( u.IsAlive() ) {
        //u.SetMaxHealth(u.GetMaxHealth() + 300);  ??? may not be necessary
        u.armor += GetClassInt("Forester_Werewolf", "ferocity_armor_bonus");

        }
}

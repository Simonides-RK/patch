//void, int player

ObjList ol;
int i;

ol = ClassPlayerObjs("Human_Longbowman", player, true).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        ol[i].damage += GetClassInt("Human_Longbowman", "reinfarrows_bonus");
}

ol = ClassPlayerObjs("Human_Tower", player, true).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
        ol[i].damage += GetClassInt("Human_Longbowman", "reinfarrows_bonus");
}

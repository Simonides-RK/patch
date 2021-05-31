//void, int player

ObjList ol;
int i;

ol = ClassPlayerObjs("Forester_Ranger", player, true).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
	ol[i].damage += GetClassInt("Forester_Ranger", "archery_bonus_atack");
}

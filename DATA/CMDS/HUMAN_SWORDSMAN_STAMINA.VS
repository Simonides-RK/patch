//void, int player

ObjList ol;
int i;
Unit u;

ol = ClassPlayerObjs("Human_Swordsman", player, true).GetObjList();

for (i = ol.count - 1; i >= 0; i -= 1)
{
	u = ol[i].AsUnit();
	u.SetSpeedFactor(u.speed_factor + GetClassInt("Human_Swordsman", "stamina_speed_bonus"));
	u.SetAttackSpeedFactor(u.attack_speed_factor + GetClassInt("Human_Swordsman", "stamina_attackspeed_bonus"));
}
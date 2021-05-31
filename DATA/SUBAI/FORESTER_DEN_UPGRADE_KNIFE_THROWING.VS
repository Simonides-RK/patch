// void, int player

ObjList ol;
int count, i;
Unit u;

//_pr("den_upgrade::knife_throwing");
ol = ClassPlayerObjs("Forester_WolfMaster", player, true).GetObjList();
count = ol.count();
for(i = 0; i < count; i += 1)
{
	u = ol[i].AsUnit();
	u.SetRange(u.range);
	u.SetDisableRangedAttack(false);	
	u.SetCustomAttackAnim(AnimAttack2);

}

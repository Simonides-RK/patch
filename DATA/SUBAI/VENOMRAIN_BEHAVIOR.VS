// void, Unit this, int param1, int param2, Obj oParam

while(1)
{
	if(oParam.IsAlive)
		.Damage(oParam, param1, false);
	else
		.DamageWithNoAttacker(param1);
	Sleep(param2);
}

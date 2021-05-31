// void, Obj This

Hero this;
bool cant_ressurect_effect;
int time_to_ressurect;

this = This.AsHero;
while(1)
{
	if(.class == "Darkling_Axemaster" && .IsSkillAvailable("Revenge"))
	{
		time_to_ressurect = .ressurect_time * .revenge_decrease_percent / 100;
	}
	else
	{
		time_to_ressurect = .ressurect_time;
	}
	if(.ressurection_began != -1)
	{
		if(.ressurection_began+time_to_ressurect < GetTime())
		{
			.ressurection_began = -2;
			cant_ressurect_effect = false;
			while(Intersect(ObjsInCircle(.pos, 810, "BaseTownhall,Forester_TradePost,Human_TradePost", true), EnemyObjs(.player, "Object", true)).count > 0) 
			{
				if(!cant_ressurect_effect)
				{
					cant_ressurect_effect = true;
					.AddEffect('ressurected', 0, 0);
				}
				Sleep(2000);
			}
			.Ressurect;
			.InsertCommand("onresurrect");
			if(cant_ressurect_effect)
			{
				.RemoveEffect("ressurected", 0, 0);
			}
			.ressurection_began = -1;
			
		} else
		{
			Sleep(.ressurection_began + time_to_ressurect + 100 - GetTime());
		}
	} else
		Sleep(time_to_ressurect/2);
}
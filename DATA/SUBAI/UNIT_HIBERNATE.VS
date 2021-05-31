// void, Obj me

Unit this, u;
point pt;
int i;
int start_time;
ObjList townhall;
ObjList ol;

this = me.AsUnit();
townhall=ClassPlayerObjs("BaseTownhall", .player, true).GetObjList;
for(i=0;i<townhall.count;i+=1)
{
pt = PassablePointNear(townhall[i].pos, 1500, 300, true);
}

.AddEffect("hibernated", -1, -1);
.Stop(1000);
start_time = GetTime();
while(1)
{
	if(GetTime() < start_time + GetClassInt("Darkling_StoneShaper", "evacuate_timeout")) 
		{
			break;
		}
	Sleep(1000);
}


.SetPos(pt);
.SetCommand("unhibernate");


// void, Obj This

Unit this;
int i, iMinDist, iDist;
ObjList ol;
Obj townhall;
point pt, ptPos;

this = This.AsUnit();

CreateFeedback("data/particles/SpiritualFire.part.xml", .pos, .explosion_timeout);
if(.evacuating.IsAlive() && .evacuating.class != "BasePlant" && .evacuating.summoned_unit != 1 && .evacuating.class != "Darkling_Meteor") //ypsilon: cannot evacuate: plants, illusions, spirits, ghosts, angels of death etc
{
	ol = FriendlyObjs(.evacuating.player, "BaseTownhall", true).GetObjList(); //
	iMinDist = -1;
	for(i = ol.count() - 1; i >= 0; i -= 1)
	{
		if(!ol[i].IsAlive())
		{
			continue;
		}
		iDist = ol[i].DistTo(.pos) < iMinDist;
		if(iMinDist == -1 || iDist < iMinDist)
		{
			pt = PassablePointNear(ol[i].pos, 1500, 100, true);
			if(pt.x != -1 && pt.y != -1)
			{
				iMinDist = iDist;
				ptPos = pt;
			}
		}
	}
	if(iMinDist != -1)
	{
		ol.Clear();
		ol.Add(.evacuating);	
		if(Teleport(ol, ptPos, .evacuate_townhall_radius).count() == 0)
		{
			iMinDist = -1;
		}
	}
	if(iMinDist == -1)
	{
		UserNotification("common", Translate("[[24997243]]Cannot teleport, not enough space[[]]"), Point(-1, -1), .player);
	}
} else
{.DropDead();}
// void, Obj This, point ptDest

Building this;
str group_name, cmdname;
ObjList ol, olFury;
int i, dragons_sent, new_mana, red_dragons;
Unit u;
point a, b, a2, b2, attack_dist_a, attack_dist_b;
rect rc;
point ptExit;

this = This.fake_queuer_townhall.AsBuilding();

cmdname = "Fury";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
	UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
	return;
}

.SetMana(cmdname, new_mana);

a = ptDest - .pos;
attack_dist_a = a;
a.SetLen(.fury_size1 / 2);
a2 = a;
a2.SetLen(.fury_size2 / 3);

b = ptDest - .pos;
b.Rot(90);
attack_dist_b = b;
b.SetLen(.fury_size1 / 2);
b2 = b;
b2.SetLen(.fury_size2 / 2);
rc = GetMapRect();

attack_dist_a.SetLen(GetClassInt("Dragons_RedDragon", "fly_range"));
attack_dist_b.SetLen(GetClassInt("Dragons_RedDragon", "fly_range"));

group_name = "independent_at_" + .pos.x + "_" + .pos.y;

ol = Group(group_name).GetObjList();
ol.ClearDead();
for(i = ol.count() - 1; i >= 0; i -= 1)
	if(ol[i].class == "Dragons_RedDragon")
		olFury.Add(ol[i]);

while(olFury.count() < .fury_dragons)
{		
	if(.rally_object.IsValid())
	{
		ptExit = .GetExitPoint(.rally_object.pos);
		u = Place("Dragons_RedDragon", ptExit, .player);
		if(.independent_unit_1 == "Dragons_RedDragon")
		{
			u.independent_glory = .independent_unit_1_glory;
		}
		else
		{
			u.independent_glory = .independent_unit_2_glory;
		}
		IncResNoLimit(.player, ResSupport, GetCost(u.cost, ResSupport));	// taken in init of the unit
		u.SetUncontrollableFlag(true);
		Sleep(10);			
		SetFlag(u.user_flags1, u.dont_return_population, true);
		u.SetIndependentGuardian(true);
		olFury.Add(u);
		u.ExecDefaultCmd(.rally_object.pos, .rally_object.GetRallyTargetObj(), true);
		Sleep(500);
	}
	else
	{
		_pr("dragons_fury: This building ("+.class+") doesn't have a valid rally_object");
		return;
	}
}

// send some red dragons for a Fury
for(i = olFury.count() - 1; i >= 0; i -= 1)
{
	u = olFury[i].AsUnit();
	if(u.IsAlive() && u.class == "Dragons_RedDragon")
	{		
		u.RemoveFromGroup(group_name);
		u.ClearCommands();
		if(dragons_sent == 0)
		{
			u.SetCommand("move", ptDest - a - b2 - attack_dist_a);
			u.AddCommand(false, "fury", ptDest - b2);
			u.AddCommand(false, "rotate", ptDest);
			u.AddCommand(false, "fury", ptDest-a2);
			u.AddCommand(false, "rotate", ptDest); 
			u.AddCommand(false, "fury", ptDest+b2);
			u.AddCommand(false, "group_rejoin", .pos);
		}
		else if(dragons_sent == 1)
		{
			u.SetCommand("move", ptDest - a + b2 - attack_dist_a);
			u.AddCommand(false, "fury", ptDest + b2);
			u.AddCommand(false, "rotate", ptDest);
			u.AddCommand(false, "fury", ptDest+a2);
			u.AddCommand(false, "rotate", ptDest);
			u.AddCommand(false, "fury", ptDest-b2);
			u.AddCommand(false, "group_rejoin", .pos);
		}
		else if(dragons_sent == 2)
		{
			u.SetCommand("move", ptDest - a2 + b + attack_dist_b);
			u.AddCommand(false, "fury", ptDest - a2);
			u.AddCommand(false, "rotate", ptDest); 
			u.AddCommand(false, "fury", ptDest+b2);
			u.AddCommand(false, "rotate", ptDest); 
			u.AddCommand(false, "fury", ptDest-a2);
			u.AddCommand(false, "group_rejoin", .pos);
		}
		dragons_sent += 1;
		if(dragons_sent >= .fury_dragons)
		{		
			break;
		}
		Sleep(300);
	}
}
if(dragons_sent == 0)
{
	.SetMana(cmdname, .GetMana(cmdname) + .GetManaCost(cmdname));
}

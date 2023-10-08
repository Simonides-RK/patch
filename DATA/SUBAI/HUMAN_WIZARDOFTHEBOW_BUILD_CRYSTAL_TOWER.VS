// void, Obj This, point pt


Unit this;
int i, j;
Building bdNew;
int nRadius;
Query q;
ObjList ol;
bool bOnce;
str cmdname;
int new_mana;

this = This.AsUnit;

if(.on_crystal_tower == 1)
{
	UserNotification("on crystal tower", "", Point(-1, -1), .player);
	.KillCommand(); //so the onaddremove script would return the resources
	return;
}

nRadius = GetRadius(cmdparam) + 15;

//1. approach at a distance and get ready to ward the obstructing units away

//while going, see if this is impossible
while (!.Goto(pt, nRadius + 300, 1020, false, -1)) {
	if (.TimeWithoutWalking() > 2000) {
		UserNotification("cant build there", "", Point(-1, -1), .player);
		.KillCommand(); //so the onaddremove script would return the resources
		return;
	}
}

//2. Start approaching and checking if someone obstructs us
bOnce = true; //run the body at least once
while(!.Goto(pt, 0, 300, false, -1) || bOnce)
{
	bOnce = false;
	if(.TimeWithoutWalking() > 2000)
	{
		UserNotification("cant build there", "", Point(-1, -1), .player);
		.KillCommand(); //so the onaddremove script would return the resources
		return;
	}

	//move the obstructing units away
	q = Intersect(FriendlyObjs(.player, "Unit", true), ObjsInCircle(pt, nRadius + 80, "Unit", true));
	ol = q.GetObjList();
	for(i=0; i<ol.count; i+=1)
	{
		Obj o;
		point ptVector;
		int nLen;

		o = ol[i];
		if(o == this)
		{
			continue;
		}
		if(!IsInterruptableCommand(o))
			continue;

		ptVector = o.pos - pt;
		//snap to 90 degrees
		nLen = ptVector.Len();

		if (abs(ptVector.x) > abs(ptVector.y))
			ptVector = Point(ptVector.x, 0);
		else
			ptVector = Point(0, ptVector.y);

		for (j=40; j<240; j+=10) {
			ptVector.SetLen(j + nRadius*2);
			if (IsPassable(pt + ptVector)) break;
		}
		o.InsertCommand("move", pt + ptVector);
	}
}


//get mana here!
cmdname = "Crystal_Tower";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana >= 0)
{
	.SetMana(cmdname, new_mana);
} 
else
{
	UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
	return;
}
.SetBlockCommand(true);

PlaySound(pt, "assets/sounds/HeroSkills/Human WizardOfTheBow/WizardOfTheBow_CrystalTower.wav");
bdNew = Place(cmdparam, pt - Point(5, 5), .player);


if(bdNew.IsValid())
{
	SetFlag(.user_flags1, .cant_be_stunned, true);
	.SetEnemyCannotTargetFlag(true);
	.SetRange(.GetRange() + .crystal_tower_range_inc);
	.SetSight(.GetSight() + .crystal_tower_range_inc);
	.SetMinRange(.crystal_tower_min_range);
	.AsUnit().AddEffect("absorb_damage", 100, 0);
	.AsUnit().AddEffect("wizard_on_crystal_tower", 0, 0); //Władysław Ańtian: set stun
	//.SetCantAddEffect(true);
	.damage += .crystal_tower_dmg_inc;
	.on_crystal_tower = 1;

	.crystal_tower = bdNew;
	bdNew.SetMaxHealth(bdNew.maxhealth*(100+.GetEffectParam("item_crystal_bonus", 1))/100);
	bdNew.DamageWithNoAttacker(bdNew.GetMaxHealth*9/10);
	bdNew.SetBuilt(false);
	bdNew.the_hero = this;
	bdNew.SetCommand("being_built");
} else
{
	_pr("place failed");
}

// void, Obj This, point pt


Unit this;
point ptBegin;
bool bCanceling;
int a1, a2;
int n1, n2;
point ptNewBuildingPos;
Building bldTownhall;
Query q;
ObjList ol;
int i,j;
bool bPassabilityPlaced;

this = This.AsUnit;
ptBegin = .pos;
bCanceling = false;

q = Intersect( 
		FriendlyObjs(.player, "Unit", true) ,
		ObjsInCircle(pt, .new_building.radius + 80, "Unit", true)
	);

bPassabilityPlaced = false;

//while going, see if this is impossible and return 
while (true) {
	if (.IsHidden()) { //wait for the fake worker to jump down
		Sleep(300);
	} else 	{
		if (.Goto(.new_building, 35, 300, false, -1)) 
			break;
	}
	
	if (.TimeWithoutWalking() > 10000) {
		UserNotification("cant build there", "", Point(-1, -1), .player);
		bCanceling = true;
		if (.new_building.IsAlive())
			.new_building.ExecCmd("building_cancel_build", Point(-1,-1), this, false); //only the first param is real
		break;
	}
	if (.new_building.health == 0) {
		bCanceling = true;
		break;
	}
	
	//move the obstructing units
	
	//move the obstructing units away 
	ol = q.GetObjList();
	for (i=0; i<ol.count && !bPassabilityPlaced; i+=1) {
		Obj o;
		point ptVector;
		int nLen;
		
		o = ol[i];
		if (o==this) continue;
		if (!IsInterruptableCommand(o))
			continue;
		
		ptVector = o.pos - pt;
		//snap to 90 degrees
		nLen = ptVector.Len();
		
		if (abs(ptVector.x) > abs(ptVector.y))
			ptVector = Point(ptVector.x, 0);
		else
			ptVector = Point(0, ptVector.y);
		
		for (j=40; j<240; j+=10) {
			ptVector.SetLen(j + .new_building.radius * 2);
			if (IsPassable(pt + ptVector)) break;
		}
		o.InsertCommand("move", pt + ptVector);
	}	
	
	if (IsPassableToPlace(.new_building.class, .new_building.pos, this)) {
		.new_building.AsBuilding.PlacePassability();
		bPassabilityPlaced = true;
	}
	
}

if (!bPassabilityPlaced) {
	//if it's not passable, wait to see if it will be soon (some friendly units may still be moving)
	if (!IsPassableToPlace(.new_building.class, .new_building.pos, this)) {
		for (i=0; i<8; i+=1) {
			Sleep(500);
			if (!.new_building.IsAlive())
				break;
			if (IsPassableToPlace(.new_building.class, .new_building.pos, this)) 
				break;
		}
		if (.new_building.IsAlive())
			if (!IsPassableToPlace(.new_building.class, .new_building.pos, this)) {
				UserNotification("cant build there", "", Point(-1, -1), .player);
				.new_building.ExecCmd("building_cancel_build", Point(-1,-1), this, false); //only the first param is real
				bCanceling = true;
			}
	}

	if (.new_building.IsAlive())
		if (IsPassableToPlace(.new_building.class, .new_building.pos, this)) {
			.new_building.AsBuilding.PlacePassability();
			bPassabilityPlaced = true;
		}
}

if (.new_building.health == 0) {
	bCanceling = true;
} else {
	ptNewBuildingPos = .new_building.pos;
}

if (!bCanceling) {
	point ptEdge, ptVector;

	ptEdge = .pos;
	
	ptVector = ptNewBuildingPos - .pos;
	ptVector.SetLen(ptVector.Len()-15);

	.GotoStraight(.pos + ptVector, false);
	if(.new_building.IsAlive())
	{
		.PlayAnim(AnimSpecial1);
	}

	//start this straight away, else the unit may get killed when going back to the edge
	//and the .new_building will be destroyed
	if (.new_building.IsValid()) {
		.new_building.SetPlayer(.player);
		.new_building.SetCommand("being_built");
	}
	
	if(.new_building.IsAlive())
	{
		.GotoStraight(ptEdge, false);
		.Face(ptNewBuildingPos); //look at it :)
		.new_building.Clear();   //let the building be free :)
		Sleep(3000);
	}
}


//while (!.Goto(ptBegin, 0, 2000, false, -1));

while (!.Goto(ptBegin, 0, 2000, false, -1)) {
	if (.TimeWithoutWalking() > 15000) {
		if (.DistTo(ptBegin) < 50) {
			.GotoStraight(ptBegin, false);
			break;
		} else {
			.AddCommand(true, "wander", .pos);
			return;
		}
	}
}



if (!.workers_townhall.IsAlive) {
	.AddCommand(true, "wander", .pos);
	return;
} else {

	//choose a free slot for the animation, but don't play climbing and going down at the same time

	while (1) {
		Sleep(10); //give chance to the queued build commands to play the going down anim
		n1 = 0;
		n2 = 0;

		if (!.workers_townhall.IsAlive)
		{
			.AddCommand(true, "wander", .pos);
			return;
		}
		a1 = .workers_townhall.fake_unit1.GetAnim(); if (a1) n1 = .workers_townhall.fake_unit1.TimeToAnimFinish();
		a2 = .workers_townhall.fake_unit2.GetAnim(); if (a2) n2 = .workers_townhall.fake_unit2.TimeToAnimFinish();
		
		if (a1 == AnimSpecial3) { .PlayAnimRandomly(AnimIdle, n1, 10); continue; }
		if (a2 == AnimSpecial3) { .PlayAnimRandomly(AnimIdle, n2, 10); continue; }
		
		//avoid overlapping climbing animations
		//if (a1 == AnimSpecial1) { .Idle(400);  } 
		//if (a2 == AnimSpecial1) { .Idle(400);  }
		
		if (n1 <= n2) {
			if (n1) .PlayAnimRandomly(AnimIdle, n1, 10);
		} else {
			if (n2) .PlayAnimRandomly(AnimIdle, n2, 10);
		}
		
		if (n1 == 0 || n2 == 0) break;
	}

	bldTownhall = .workers_townhall.AsBuilding();
	if (bldTownhall.IsAlive)
	{
		.Erase();//will destroy unit on_script_finish
		//.SetHidden(true); //the onfinish script will kill it

		if (n1 == 0) {
			bldTownhall.SetCannotDie(true);
			bldTownhall.fake_unit1.PlayAnim(AnimSpecial1, bldTownhall.pos);
			Sleep(1);
			if (bldTownhall.IsAlive) if (bldTownhall.fake_unit1.GetAnim()==0 && bldTownhall.fake_unit2.GetAnim()==0)
				bldTownhall.SetCannotDie(false);
		} else {
			bldTownhall.SetCannotDie(true);
			bldTownhall.fake_unit2.PlayAnim(AnimSpecial1, bldTownhall.pos);
			Sleep(1);
			if (bldTownhall.IsAlive) if (bldTownhall.fake_unit1.GetAnim()==0 && bldTownhall.fake_unit2.GetAnim()==0)
				bldTownhall.SetCannotDie(false);
		}
	}
}
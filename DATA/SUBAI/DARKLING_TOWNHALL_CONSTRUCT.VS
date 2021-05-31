//void, Obj This, point pt

Query q;
Building this, bdNew;
int i,j;
bool bPassabilityPlaced;
ObjList ol;

this = This.fake_queuer_townhall;

//1. Find the building
q = ObjsInCircle(pt, 5, cmdparam, true);
if (q.IsEmpty) {
	_pr("darkling_townhall_construct: Could not find the building placed when the command was added");
	return;
} else {
	bdNew = q.GetObjList()[0].AsBuilding();
}


//2. Move the units away and place passability
q = Intersect( 
		FriendlyObjs(.player, "Unit", true) ,
		ObjsInCircle(pt, bdNew.radius + 80, "Unit", true)
	);

bPassabilityPlaced = false;

for (i=0; i<3; i+=1) {
	int i;
	//move the obstructing units away 
	ol = q.GetObjList();
	for (i=0; i<ol.count && !bPassabilityPlaced; i+=1) {
		Obj o;
		point ptVector;
		int nLen;
		
		o = ol[i];
		//if (o==this) continue; irrelevant
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
			ptVector.SetLen(j + bdNew.radius * 2);
			if (IsPassable(pt + ptVector)) break;
		}
		o.InsertCommand("move", pt + ptVector);
	}	
	
	if (This.is_haunted == 1) {
		UserNotification("common", Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]"), Point(-1, -1), .player);
		break;
		}
	
	if (IsPassableToPlace(bdNew.class, bdNew.pos, this)) {
		bdNew.AsBuilding.PlacePassability();
		bPassabilityPlaced = true;
		break;
	}
	
	Sleep(1000);
	if (!bdNew.IsAlive)
		break;

}


if (!bPassabilityPlaced) {
	if (bdNew.IsAlive) {
		UserNotification("cant build there", "", Point(-1, -1), .player);
		bdNew.ExecCmd("building_cancel_build", Point(-1,-1), this, false); //only the first param is real
	}
} else {
	bdNew.SetCommand("being_built");
}

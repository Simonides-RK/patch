//void, Obj This, point pt

Building this, bdNew;
Unit uWorker;	 
int a1, a2;
int n1, n2;
Query q;
IntArray aPtX, aPtY; //coordinates of each framework
StrArray aClasses;	 //class of each framework

//this = This.AsBuilding();
this = This.fake_queuer_townhall;	 //this command is in fact being issued to the fake_queuer object

if (This.is_haunted == 1) {
		UserNotification("common", Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]"), Point(-1, -1), .player);
		return;
		}

q = ObjsInCircle(pt, 5, cmdparam, true);
if (q.IsEmpty) {
	// Ivko: It is perfectly OK someone to destroy the building before this starts to run
	// _pr("forest_townhall_construct: Could not find the building placed when the command was added");
	return;
} else {
	bdNew = q.GetObjList()[0].AsBuilding();
	.constructing_building = bdNew;
	.constructing_unit_state = 0;
}

//If the townhall dies the unit will remain placed but hidden
//	the worker should check for this in it's construct method


uWorker = Place("Forester_Worker_Uncontrollable", .pos + Point(40,120), .player);
uWorker.SetUncontrollableFlag(true);
uWorker.workers_townhall = this;
uWorker.new_building = bdNew;
uWorker.SetCommand("construct", pt); //start moving the obstructing units away
uWorker.SetHidden(true);

//choose a free slot for the animation, but don't play climbing and going down at the same time
while (1) {
	n1 = 0;
	n2 = 0;

	a1 = .fake_unit1.GetAnim(); if (a1) n1 = .fake_unit1.TimeToAnimFinish();
	a2 = .fake_unit2.GetAnim(); if (a2) n2 = .fake_unit2.TimeToAnimFinish();

	if (a1 == AnimSpecial1) { Sleep(n1); continue; }
	if (a2 == AnimSpecial1) { Sleep(n2); continue; }

	if (n1 <= n2) {
		Sleep(n1);
		.SetCannotDie(true);
		.fake_unit1.PlayAnim(AnimSpecial3);
		Sleep(1);
		if (.fake_unit1.GetAnim()==0 && .fake_unit2.GetAnim()==0)
			.SetCannotDie(false);
		break;
	} else {
		Sleep(n2);
		.SetCannotDie(true);
		.fake_unit2.PlayAnim(AnimSpecial3);
		Sleep(1);
		if (.fake_unit1.GetAnim()==0 && .fake_unit2.GetAnim()==0)
			.SetCannotDie(false);
		break;
	}
}

uWorker.SetHidden(false);
.constructing_unit_state = 1;

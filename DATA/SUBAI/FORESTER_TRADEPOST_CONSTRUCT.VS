//void, Obj This, point pt

Query q;
Building this, bdNew;

ObjList olWorkers;
ObjList olFrameworks;
IntArray aPtX, aPtY; //coordinates of each framework
StrArray aClasses;	 //class of each framework
bool bPassabilityPlaced;
int i, nWorkers, nPoints1, nPoints2;	//for the two types of frameworks
bPassabilityPlaced = false;
this = This.fake_queuer_townhall;

if (This.is_haunted == 1) {
		UserNotification("common", Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]"), Point(-1, -1), .player);
		return;
		}

q = ObjsInCircle(pt, 5, cmdparam, true);
if (q.IsEmpty) {
	// Ivko: It is perfectly OK someone to destroy the building before this starts to run
	// _pr("human_townhall_construct: Could not find the building placed when the command was added");
	return;
} else {
	bdNew = q.GetObjList()[0].AsBuilding();
		bdNew.AsBuilding.PlacePassability();
		bPassabilityPlaced = true;
}

bdNew.SetPlayer(.player);
bdNew.SetCommand("being_built");

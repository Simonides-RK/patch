// bool, ObjList objs, int player, str cmdcost, str OUT disabled_reason_text

// Cancel build command verifier. This command is enabled if the selection
// consists only of buildings, and all of them are under construction.

int i;
Building bld;

disabled_reason_text = "";

for (i = objs.count - 1; i >= 0; i = i - 1) {
	bld = objs[i].AsBuilding();
	if (!bld.IsValid()) {
		return false;
	}
	if(bld.IsHeirOf("Independent_Settlement"))
		return false;
	if (bld.IsBuilt()) {
		return false;
	}
	if (bld.is_haunted == 1) {
		return false;
		disabled_reason_text = "Building is disabled while being haunted";
	}
}
return true;
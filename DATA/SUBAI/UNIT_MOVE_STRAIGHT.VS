// void, Obj This, point pt

Unit this;
this = This.AsUnit();



if (.in_shelter.IsValid())
	.GotoStraight(pt, true);
else
	.GotoStraight(pt, false);

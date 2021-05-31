// void, Obj This, point pt

Unit this;
point ptDir;
str group_name;

//_pr("reddragn::group_rejoin");
this = This.AsUnit();
while(!.GotoForm(pt, 0, 2000, true));
group_name = "independent_at_" + pt.x + "_" + pt.y;
.AddToGroup(group_name);
.is_fury = 0;
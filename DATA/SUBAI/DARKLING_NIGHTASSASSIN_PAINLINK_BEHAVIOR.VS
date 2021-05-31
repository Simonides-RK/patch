//void, Obj This

Hero this, h, linked;
ObjList ol;
int i, change_description_back_time;
ParticleSystem ps1;
rect map_rect;

this = This.AsHero();
ps1 = invalid_obj;
change_description_back_time = -1;
map_rect = GetMapRect;
while ( 1 ) {
	while(.IsGhost() || !.IsSkillAvailable("PainLink")) 
	{
		Sleep(1000);
	}
		
	if (!.ExistEffect("painlink"))
	{
		.AddEffect("painlink", 0, 0);
	}
	if(.pos.InRect(map_rect))
		ol = Intersect(ObjsInCircle(.pos, .sight, "Hero", false), EnemyObjs(.player, "Hero", false)).GetObjList();
	else
		ol.Clear;
	
	if ( ol.count > 0 ) 
	{
		h = ol.FilterClosest(.pos, 1)[0];
	} else
	{
		if(ps1.IsValid)
		{
			ps1.Erase;
			ps1 = invalid_obj;
			linked = invalid_obj;
		}
		h = invalid_obj;
	}
	
	if ( h.IsValid )
	if ( !h.IsGhost() && (h != linked) ) 
	{
		if(ps1.IsValid)
			ps1.Erase;
		linked = h;
		ps1 = CreateParticleSystem("data/particles/PainLinkOnDamage.part.xml");
		ps1.SetHeight(-40);
		ps1.Chain(this);
		change_description_back_time = GetTime + 100;
	}
	if(ps1.IsValid)
	{
		ps1.SetPos(linked.exact_pos);
		for(i = 0; i < 20; i += 1)
		{
			if(.painlink_damagetarget > 0 && linked.IsValid)
			{
				change_description_back_time = GetTime + 100;
				ps1.SetPartDesc("data/particles/PainLinkOnDamage.part.xml");
				linked.Damage(this, .painlink_damagetarget, false);
				.painlink_damagetarget = 0;
			} else
			if(change_description_back_time != -1 && GetTime > change_description_back_time)
			{
				ps1.SetPartDesc("data/particles/PainLink.part.xml");
				change_description_back_time = -1;
			}
			Sleep(50);
			if( .IsGhost() || linked.IsGhost() || !linked.pos.InRect(map_rect) || .DistTo(linked) > h.sight || !.IsSkillAvailable("PainLink") || linked.class == "Darkling_NightAssassin")
			{
				ps1.Erase;
				ps1 = invalid_obj;
				linked = invalid_obj;
				break;
			}
			ps1.SetPos(linked.exact_pos);		
		}
	} else
		Sleep(1000);
	.painlink_damagetarget = 0;
}
 
// void, Obj This, Obj other

Unit this, u;
str cmd;
bool bHero, bIdleAnim;
point pt;

this = This.AsUnit();
bHero = other.AsHero().IsValid();


while(!.Stop(1000));

while(1)
{
	if(!other.IsAlive())
	{
		pt.Set(.pos.x +150 -rand(65), .pos.y +150 -rand(65));
		.GotoStraight(pt, false);
		break;
	}
	cmd = other.command;
	bIdleAnim = false;
	if(cmd == "advance" || cmd == "follow" || cmd == "move" || cmd == "move_cmd" || cmd == "move_single" || .DistTo(other) > 200)
	{
		if(.Goto(other, 200, 5000, true, 15000))
		{
			bIdleAnim = true;
		}
	}
	else
	{
		if(.IsHeirOf("Peaceful"))
		{
			bIdleAnim = true;
		}
		else
		{
			u = .BestTargetInSquadSight();
			if(u.IsAlive())
			{
				.AddCommand(true, "follow", other);
				.AddCommand(true, "engage");
				return;
			}
			else
			{
				bIdleAnim = true;
			}
		}
	}
	if(bIdleAnim)
	{
		// Play idle animation
		if(.constantly_idle_played != 0)
		{
			if(.constantly_idle_played != AnimIdle && rand(100) < .idle_anim_percent && .HasAnim(AnimIdle))
				.PlayAnim(AnimIdle);
			else
				.PlayAnim(.constantly_idle_played);
		}
		else
		{
			if (rand(100)<.idle_anim_percent)
				.PlayAnim(AnimIdle);
			else
				Sleep(1400 + rand(100));
		}
	}
}

if(!bHero && other.IsValid())
{
	.AddCommand(true, "advance", other.die_pos);
}
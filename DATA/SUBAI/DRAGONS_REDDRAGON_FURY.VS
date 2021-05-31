// void, Obj me, point ptDest

Unit this;
Obj target;
int approach_dist;
int attack_dist, attack_len, len, fly_step;
point pt, ptDir, ptAttackDir, ptDirToDest, ptMyDir;
int count, i, cos;
rect rc;
bool IsFury;

//_pr("reddragon::fury - (" + ptDest.x + ", " + ptDest.y + ")");
this = me.AsUnit();

rc = GetMapRect();

attack_dist = .GetAnimWalkDist(AnimAttack1);
fly_step = attack_dist+50;
count = .fury_size1 * 2 / (attack_dist + fly_step);

approach_dist = (.fly_range + .fury_size1)/2;

ptDir = .GetDir;
ptDir.SetLen(attack_dist);
ptAttackDir = ptDir;
ptAttackDir.SetLen(.fly_range);
.is_fury = 1;
while(.DistTo(ptDest) > approach_dist)
		.Goto(ptDest, 50, 300, true, 1000);

pt = .pos;
for(i = 0; i < count; i += 1)
{
	pt = .pos;
	ptDir = .GetDir;
	ptAttackDir = ptDir;
	ptAttackDir.SetLen(.fly_range);
	if((i % 4) == 0)
	{
		point attack_point;
		ptDir.SetLen(attack_dist);
		target = .BestTargetInSquadSight();
		if(target.IsValid)
		if(.CanAttack(target))
		{
			ptDirToDest = target.pos - .pos;
			len = ptDirToDest.Len;
			cos = (ptDir.x * ptDirToDest.x + ptDir.y * ptDirToDest.y)*1000/(ptDir.Len*ptDirToDest.Len);
			if(cos > 850 && len > .fly_range)
			{
				ptDirToDest.SetLen(attack_dist);
				ptDir = ptDirToDest;
				.Attack(target, pt+ptDirToDest);
				continue;
			}
		} 
		attack_point = pt+ptAttackDir;
		if(attack_point.InRect(rc))
			.AttackMove(pt + ptDir, attack_point);
		else
			.Goto(pt + ptDir, 50, 2000, true, 1000);
	} else
	{
		ptDir.SetLen(fly_step);
		.Goto(pt + ptDir, 50, 2000, true, 1000);
	}
	pt = .pos;
}
//_pr("fly_away");



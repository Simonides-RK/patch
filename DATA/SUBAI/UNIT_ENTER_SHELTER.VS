// void, Obj me, Obj target

Unit this;
point pt;
int nStep, i, j, k;
bool bFound;

this = me.AsUnit;

if (.IsEnemy(target) || .CantMove() || .flying==1) return;

if (.DistTo(target) > target.radius + 20)
        while(!.Goto(target, 20, 1000, true, 0)) {
                if (!target.IsAlive)
                        return;
        }

nStep = 16;
bFound = false;

 for (k=0; k < 20; k+=1) {
         if (!target.IsAlive())
                 return;
         i = rand(target.pos.x - target.shelter_radius, target.pos.x + target.shelter_radius);
         j = rand(target.pos.y - target.shelter_radius, target.pos.y + target.shelter_radius);
         pt.Set(i,j);
         if (pt.Dist(target.pos) < target.shelter_radius) {
                 if (DestLockPossible(this, pt)) {
                         bFound = true;
                         break;
                 }
         }
 }

if (!bFound)
        for (i = target.pos.x - target.shelter_radius; i <= target.pos.x + target.shelter_radius; i += nStep) {
                for (j = target.pos.y - target.shelter_radius; j <= target.pos.y + target.shelter_radius; j += nStep) {
                        pt.Set(i,j);
                        if (!target.IsAlive())
                                return;
                        if (pt.Dist(target.pos) < target.shelter_radius) {
                                if (DestLockPossible(this, pt)) {
                                        bFound = true;
                                        break;
                                }
                        }
                }
                if (bFound) break;
        }

if (bFound) {
        .GotoStraight(pt, true);
                .SetCommand("engage"); //as if it's entangled
} else {
        //no place for us. Check if this is a just-placed shelter
        if (IsPassable(.pos)) {
                .SetCommand("idle");
        }
}

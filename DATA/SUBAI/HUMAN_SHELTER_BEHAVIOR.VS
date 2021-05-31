// void, Obj This

Query qEnemies, qSheltered;
ObjList olEnemies, olSheltered;
int i,j,x,y, nStep;
Unit uRanger;
Obj oEnemy;
point pt, ptBest;
bool bEnemyFound;
Obj this;

this = This;
nStep = 16;
qEnemies = EnemyObjsInRange(this, "Unit", .radius + 700, true);
qSheltered = FriendlyObjsInRange(this, "Unit", .radius, true); //will be filtered more later

while (1) {
        Sleep(990); // Ivko: Must be appx a second!

        //Make IsValid() mean IsAlive()
        if (.shelter_target.IsValid())
                if (.shelter_target.IsDead())
                        .shelter_target.Clear();

        // Heal units inside
        olSheltered = qSheltered.GetObjList();
        for (i=0; i < olSheltered.count; i+=1){
                if (olSheltered[i].flying!=1) {
                        olSheltered[i].Heal(.heal_per_second);
                        if (!olSheltered[i].AsUnit.ExistEffect("unit_in_shelter")){
                        olSheltered[i].in_shelter = this;
                        olSheltered[i].AsUnit.AddEffectTimeout("unit_in_shelter", 0, 0, .energy*1000); // Ivko: Now units can't be attacked in shelter. This is in case of splash damage
                        }
                }
        }
        // Decrease energy
        .SetEnergy(.energy - 1);
        if (.energy==0)
                .DropDead();

        //1. Watch for enemies


        olEnemies = qEnemies.GetObjList();
        //do we have an enemy or a ready target?
        if (olEnemies.count > 0 || .shelter_target.IsValid()) {
                //2. Check if we have a targetless ranged unit, who cannot reach an enemy
                olSheltered = qSheltered.GetObjList();
                for (i=0; i < olSheltered.count; i+=1) {
                        uRanger = olSheltered[i].AsUnit;

                        if (!uRanger.IsRanged()) continue;
                        if (uRanger.lasttarget.IsValid()) {
                                if (uRanger.lasttarget == .shelter_target)
                                        continue;
                        }
                        if (!uRanger.lasttarget.IsValid() || .shelter_target.IsValid()) {
                                //3. Choose him an enemy
                                bEnemyFound = false;
                                for (j=0; j < olEnemies.count || .shelter_target.IsValid(); j+=1) {
                                        if (.shelter_target.IsValid())
                                                oEnemy = .shelter_target;
                                        else
                                                oEnemy = olEnemies[j];
                                        //Is it in theoretical range?
                                        if (oEnemy.DistTo(this) + 30 > uRanger.range) {
                                                //If we have a target, the cycle should run only once
                                                if (.shelter_target.IsValid())
                                                        break;
                                                else
                                                        continue;
                                        }
                                        //Can we move somewhere within range?
                                        
                                        for (x = .pos.x - .shelter_radius; x < .pos.x + .shelter_radius; x+=nStep) {
                                                for (y = .pos.y - .shelter_radius; y < .pos.y + .shelter_radius; y+=nStep) {
                                                        pt.Set(x,y);
                                                        if (pt.Dist(.pos) > .shelter_radius) //is it in the shelter?
                                                                continue; 
                                                        if (!DestLockPossible(uRanger, pt))
                                                                continue;
                                                        if (oEnemy.DistTo(pt) < uRanger.range) { //is it in range?
                                                                if (bEnemyFound) {
                                                                        if (pt.Dist(oEnemy.pos) < ptBest.Dist(oEnemy.pos))
                                                                                ptBest = pt;
                                                                } else {
                                                                        bEnemyFound = true;
                                                                        ptBest = pt;
                                                                }
                                                        }
                                                }
                                                Sleep(1); 
                                        }
                                        //If we have a target, the cycle should run only once
                                        if (bEnemyFound || .shelter_target.IsValid()) break;
                                }
                                if (bEnemyFound) { //then ptBest says where we should go
                                        Sleep(11);
                                        //uRanger.SetCommand("move_straight", ptBest);
                                        if (.shelter_target.IsValid())
                                                uRanger.AddCommand(false, "attack", .shelter_target);
                                }
                        }
                }
        }
}
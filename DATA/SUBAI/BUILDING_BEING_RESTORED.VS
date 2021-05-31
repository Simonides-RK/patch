//void, Obj me

Building this, dying;
int nTime, nDuration, nPercent;
int nHealth, nOldHealth;

Unit worker;
bool NeedWorker;
point worker_pos;

ObjList ol;
int i;
Obj u;


NeedWorker=false;
this = me.AsBuilding();
worker=.being_restored_worker.AsUnit;
nDuration = GetClassInt("Nomad_Townhall", "restoration_period");
if (worker.IsAlive) {nDuration=nDuration*2; NeedWorker=true;}
dying = this;
if(.IsHeirOf("Independent_Settlement"))
{
        ObjList ol;
        
        ol = ObjsInCircle(.pos, 50, .dying_object_class, true).GetObjList();
        if(ol.count() == 1)
        {
                if(ol[0].IsAlive())
                {
                        dying = ol[0];
                }
        }
}

.SetBuilt(false);
if (NeedWorker) worker_pos=worker.pos;
while (nTime <= nDuration && ((worker.IsAlive && worker_pos==worker.pos ) || !NeedWorker)) {
        nPercent = nTime * 100 / nDuration;
        .SetTranslucency(nPercent);
        if(dying != this)
        {
                dying.SetTranslucency(100-nPercent);
        }

        nHealth = (.GetMaxHealth() * nTime) / nDuration;
        if (nHealth > nOldHealth) {
                .Heal(nHealth - nOldHealth);
                nOldHealth = nHealth;
        }

        Sleep(300);
        nTime += 300;
        if (NeedWorker) {
        worker.Face(.pos);
        if (worker.class=="Forester_Worker") worker.PlayAnim(AnimSpecial2);
        if (worker.class=="Human_Worker") worker.PlayAnim(AnimSpecial3);
        if (worker.class=="Darkling_DarkMage") {PlaySound(worker.pos, worker.repair_building_sound);worker.PlayAnim(AnimSpecial1);}
        }
}
if ((worker.IsAlive && NeedWorker && worker_pos==worker.pos) || !NeedWorker){
        .Heal(1);
        .SetTranslucency(100);
        if(dying != this)
        {
                dying.SetTranslucency(0);
                dying.Erase();
        }
        .SetCmdEnable(true);
        .CmdEnable("Learn_new_skill_ind");
        .SetBuilt(true);


if(.IsHeirOf("Independent_Settlement"))
{
  EnvWriteInt(.player, .race_str, EnvReadInt(.player, .race_str) + 1);
  EnvWriteInt(.player, "colonyCount", EnvReadInt(.player, "colonyCount") + 1);
  ol = ClassPlayerObjs("Building", .player, false).GetObjList();
  for (i = ol.count - 1; i >= 0; i -= 1)
  {
        u = ol[i].AsBuilding();
        if ( u.IsAlive() ) {
        if (u.race_str=="Race_Dragons" || u.race_str=="Race_Trolls" || u.race_str=="Race_Shades" || u.race_str=="Race_Nomads" || u.race_str=="Race_Elves") continue;
        if (u.class=="Human_Townhall" || u.class=="Darkling_Townhall" || u.class=="Forester_Townhall") u.armor+=10; 
                else if (u.class=="Darkling_Tower" || u.class=="Forester_Tower" || u.class=="Human_Tower") u.SetMaxHealth(u.GetMaxHealth()+25); else u.armor+=5;

        }
  }
}

} else {
        .DropDead;
}
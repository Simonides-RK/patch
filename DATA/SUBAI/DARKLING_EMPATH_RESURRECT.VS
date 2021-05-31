// void, Obj This, point pt

Hero this, h;
Unit u;
str cmdname;
int new_mana, i, new_health, j;
ObjList ol, olResurrected, olTemp;

this = This.AsHero();

cmdname = "Resurrect_Skill";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
} 

if ( .DistTo(pt) > .sight ) {
        while ( !.Goto(pt, .sight, 500, false, 500) );
}

.Face(pt);

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

ol = GetCorpses(pt, .resurrect_range);

              

PlaySound(pt, "assets/sounds/HeroSkills/Darkling Empath/Empath_Resurrection.wav");

for ( i = 0; i < ol.count; i += 1 ) {
        u = ol[i].AsUnit();
        h = ol[i].AsHero();
        
        if ( !h.IsValid() ) {
                olTemp = Summon(u.class, 1, u.pos, 50, .player, "data/particles/summon.part.xml", 1000, "Summon_Sound_");
                if ( olTemp.count > 0 ) {
                        olResurrected.Add(olTemp[0]);
                        new_health=olTemp[0].GetMaxHealth * .ressurected_health_perc / 100;
                        if (u.AsUnit.reserved_int9>0) {
                        if (u.AsUnit.reserved_int9==1) new_health=new_health/2;
                        else if (u.AsUnit.reserved_int9==2) new_health=new_health/4;
                        else if (u.AsUnit.reserved_int9==3) new_health=new_health/8;
                        else if (u.AsUnit.reserved_int9==4) new_health=new_health/16;
                        else if (u.AsUnit.reserved_int9==5) new_health=new_health/32;
                        else if (u.AsUnit.reserved_int9==6) new_health=new_health/64;
                        else if (u.AsUnit.reserved_int9==7) new_health=new_health/128;
                        else if (u.AsUnit.reserved_int9==8) new_health=new_health/256;
                        else if (u.AsUnit.reserved_int9==9) new_health=new_health/512;
                        else new_health=new_health/1024;
                         if (new_health<1) new_health=1;
                         olTemp[0].AsUnit.AddEffect("dichotimize", 0, 0);
                         olTemp[0].AsUnit.reserved_int9=u.AsUnit.reserved_int9;
                        }
                        olTemp[0].SetHealth(new_health);
//                if ( olTemp.count > 0 ) {
//                        olResurrected.Add(olTemp[0]);
//                        olTemp[0].SetHealth(olTemp[0].GetMaxHealth * .ressurected_health_perc / 100);
//                        olTemp[0].AsUnit.AddEffect("resurected", 0, 0);
//                        u.StartFadeAway();
//               }
                      

                        u.StartFadeAway();
                }
        }
}

if(.GetAnim())
{
        Sleep(.TimeToAnimFinish());
}

ol=olResurrected;
if ( ol.count > 0 ) {
FinishSummon(ol);
                                                                                              
.SetMana(cmdname, new_mana);}
// void, Unit this, Obj dest, int* damage, bool bDirectDamage, int param1, int param2, Obj oParam
Unit u;
bool bGuardian;
StrArray classes;
ObjList ol, objs;
int i, polymorph_duration;
int gold_value, glory_value;
Unit temporalymonk;
if (dest.AsHero().IsValid) return;

u=dest.AsUnit();
if (!u.IsValid()) return;
if (!u.IsAlive()) return;
if ( rand(100) > param1 ) return;
if (!.IsEnemy(u)) return;
if (u.class=="Rat") return;

EnvWriteString(u, "OldClass", u.class);

polymorph_duration = GetClassInt("Human_WitchQueen", "polymorph_duration") + .GetEffectParam("item_polymorph_bonus", 1)*1000;
polymorph_duration=polymorph_duration*3/2;
PlaySound(u.pos, "assets/sounds/HeroSkills/Human WitchQueen/WitchQueen_Polymorph.wav");
//                        if ( u.ExistEffect("curse") ) u.AsUnit.RemoveEffect("curse", 0, 0); 
                        u.AddEffectTimeout("polymorph1", polymorph_duration, 0, polymorph_duration);
                        bGuardian = false;
                        if ( u.IsIndependentGuardian) {
                                bGuardian = true;
                                // using the same code as in the unit_ondie script:
                                gold_value = (GetCost(u.cost, ResGold) + GetCost(u.cost, ResGems) * GetConst("GoldForOneGem")) * 20/100;
                                glory_value = u.independent_glory;
                        }

                        if ( bGuardian ) {
                                u.independent_glory = glory_value;
                                u.SetIndependentGuardian(true);
                                u.reserved_int2 = gold_value;
                        }

        temporalymonk=Place("Human_Monk", .pos, .player);
        IncRes(temporalymonk.player, ResSupport, GetCost(temporalymonk.cost, ResSupport));
        SetFlag(temporalymonk.user_flags1, temporalymonk.dont_return_population, true);
        EnvWriteString(temporalymonk, "NewClass", "Rat");
        temporalymonk.SetHidden(true);        
        temporalymonk.reserved_obj0=u;
        temporalymonk.reserved_int7=1;
        temporalymonk.reserved_int9=1;
        temporalymonk.SetCommand("promote_changeclass");


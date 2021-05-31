// void, Obj This

Hero this;
Unit u;
bool bGuardian;
StrArray classes;
ObjList ol, objs;
int i, try, polymorph_duration;
int gold_value, glory_value, rat_support;

this = This.AsHero();

while ( 1 ) {
        while ( (.polymorph_started == 0) || .IsGhost() || !.IsSkillAvailable("Polymorph") ) Sleep(97);

        polymorph_duration = .polymorph_duration + .GetEffectParam("item_polymorph_bonus", 1)*1000;
        ol = Intersect(ObjsInCircle(.pos, .sight, "Unit", false), EnemyObjs(.player, "Unit", false)).GetObjList();
        objs.Clear();   
        
        for ( try = 0; try < 2; try += 1 ) {

                for ( i = 0; i < ol.count; i += 1 ) {
                        u = ol[i].AsUnit();
                        if ( !u.IsAlive ) continue;
                        if ( u.AsHero.IsValid ) continue;   // do not polymorph heroes
                        if ( u.ExistEffect("curse") && !u.ExistEffect("polymorph") && (ol[i].class != "Rat") ) {
                                objs.Add(u);
                        }
                }
        
                for ( i = 0; i < objs.count; i += 1 ) {
                        u = objs[i].AsUnit();
                        if ( !u.IsAlive ) continue;
                        if ( u.ExistEffect("polymorph") ) continue;
                        
                        classes[i] = u.class;
                        u.AddEffectTimeout("polymorph", 0, 0, polymorph_duration);
                }
                Sleep(500);

                for ( i = 0; i < objs.count; i += 1 ) {
                        u = objs[i].AsUnit();
                        if ( !u.IsAlive() ) continue;
                        if ( u.class != classes[i] ) continue;
                        
                        if ( u.ExistEffect("curse") ) { // curse could have timed out meanwhile
                                u.AsUnit.RemoveEffect("curse", 0, 0); // the effect should be canceled, because of its behavior script
                        }
                        if ( u.IsIndependentGuardian ) {
                                bGuardian = true;
                                // using the same code as in the unit_ondie script:
                                gold_value = (GetCost(u.cost, ResGold) + GetCost(u.cost, ResGems) * GetConst("GoldForOneGem")) * 20/100;
                                glory_value = u.independent_glory;
								u.rat_support = 0;
                        } else {
                                bGuardian = false;
								rat_support = GetCost(u.cost, ResSupport);
								u.rat_support = rat_support;
                        }
                        u.SetNoselectFlag(true);
                        u.SetEnemyCannotTargetFlag(true);
                        Sleep(300);
                        u.AsUnit.ChangeScriptClass("Rat", true, false); // copy effects, don't alter health
                        Sleep(300);
                        u.SetNoselectFlag(false);
                        u.SetEnemyCannotTargetFlag(false);
                        if ( bGuardian ) {
                                u.independent_glory = glory_value;
                                u.SetIndependentGuardian(true);
                                u.reserved_int2 = gold_value;
								u.rat_support = 0;
                        } else
							{
							u.rat_support = rat_support;
							}
                }

                Sleep(1000);
        }
        
        Sleep(polymorph_duration - 2550);
        
        for ( i = 0; i < objs.count; i += 1 ) {
                u = objs[i].AsUnit();
                if ( u.IsValid() ) {
                        if ( u.IsAlive() ) {
                                if ( u.ExistEffect("curse") ) {
                                        u.RemoveEffect("curse", 0, 0); // same as above
                                }
                        u.SetNoselectFlag(true);
                        u.SetEnemyCannotTargetFlag(true);
                        Sleep(300);
                                u.ChangeScriptClass(classes[i], true, false);
								u.rat_support = 0;
                        Sleep(300);
                        u.SetEnemyCannotTargetFlag(false);
                        u.SetNoselectFlag(false);
                        }	
						 
                }
        }
        
        .polymorph_started = 0;
}

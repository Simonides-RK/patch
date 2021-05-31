// void, Obj me, Obj oWho

Unit this, u;
Hero fairy;
int i, dmg, nDist; //distance to circle from
point ptVector;
Query q;

this = me.AsUnit();
u = oWho.AsUnit();
nDist  = 10;

.state = 0;
if (!u.AsUnit().IsValid()) return;

if(.IsValidTarget(u))
{
                if ( u.ExistEffect("possessed") || (u.IsUncontrollable() && !u.IsIndependentGuardian()))
                        return;
                //1. Go near it
                while(!.Goto(u, nDist, 1000, false, 1000))
                {
                        if (!u.IsAlive()) return;
                        if (u.ExistEffect("possessed")) return;
                if (u.ExistEffect("invincibility")) return;         

                }
                if (!u.IsAlive()) return;
                if (u.ExistEffect("possessed")) return;
                if (u.ExistEffect("invincibility")) return;         
                
                if(.ExistEffect("illusion"))
                        return;
                
                .state = 1;
                .SetUncontrollableFlag(true); //non reference counted
                SetFlag(.user_flags1, .cant_be_stunned, true);
                
                //2. Rotate widdershins
                ptVector = .pos - u.pos;
                .SetSpeedFactor(.speed_factor*3);
                for (i=0; i<15; i+=1)
                {
                        ptVector.Rot(30);
                        .GotoStraight(u.pos + ptVector, false);

                        if (!u.IsAlive()) return;
                        if (u.ExistEffect("possessed")) return;
                if (u.ExistEffect("invincibility")) return;         

                        if (i>6)
                                {
                                        ptVector.SetLen(ptVector.Len()*7/8);
                                        .SetTranslucency(100-100*(i-6)/8);
                                }
                }
                
                if (!u.IsAlive()) return;
                if (u.ExistEffect("possessed")) return;         
                if (u.ExistEffect("invincibility")) return;         
                if ( IsUpgradeAvailable(.player, "upgrade_SpiritInvisibility") ) {
                        .SetVisible(true);
                        }
                .state = 2;
                .SetSightEx(90);
                .SetBlockCommand(true);
                .SetHidden(true);
                .SetTranslucency(0);
                .SetNoselectFlag(true);
                .SetEnemyCannotTargetFlag(true);
                .SetInvulnerable(true);
                .Deselect();
                .unit_possessed = u;
                u.reserved_obj6=this;
                u.AddEffect("possessed", 0, 0);
                
                if ( IsUpgradeAvailable(.player, "upgrade_MentalShock") ) {
                        // damage only if not mind blend
                        
                        if ( u.player != .player ) {
                                dmg = CalculateDirectDamage(this, u, this.energy);
                                u.Damage(this, dmg, true);
                                FloatingText(Translate("[[]]-[[]]") + dmg, u.pos, GetConst("CriticalDamageColor"), 0);
                                .SetEnergy(0);
                        }
                }
                
                u.SetCantBeHealed(true);
                while( u.IsAlive() ) // should be a valid target, if we reached this code anyways
                {
                        ObjList fairies;
                        if(.next_command == "wait_for_death")
                        {
                                break;
                        }
                        fairies = ClassPlayerObjs("Forester_Fairy", .player, false).GetObjList;
                        if ( fairies.count > 0 ) {
                                int count;
                                int i;
                                count = fairies.count;
                                for(i = 0; i < count; i += 1)
                                {
                                        fairy = fairies[i].AsHero();
                                        
                                        if(fairy.IsAlive)
                                        if(u.ExistEffect("mind_blend", fairy))
                                        if(u.health < u.GetMaxHealth*fairy.mindblend_at_health_perc/100) 
                                                u.SetPlayer(.player);
                                }
                        }
                        u.Damage(this, .damage, true);
                        .SetPos(u.pos);
                        Sleep(.attack_sleep);
                }


                //Play animation for going out of the body
                .SetTranslucency(100);
                .SetHidden(false);
                .PlayAnim(AnimSpecial1);
                .state = 3;

}

if (.CmdCount()==1)
        .AddCommand(true, "engage");

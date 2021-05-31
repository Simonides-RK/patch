// void, Obj This, Obj oAttacker

Unit this;
int r, gl;
str FigMas;
this = This.AsHero();


.killer = oAttacker;
if (oAttacker.IsValid()) oAttacker.kills += 1;

if (oAttacker.AsHero().IsValid() && oAttacker.IsEnemy(this))
        if (!oAttacker.AsHero().IsGhost()){


r=.GetSkillNumber()*20+10;
        oAttacker.SetMaxHealth(oAttacker.GetMaxHealth() + r);
        FloatingText(Translate("[[25601940]]Health +[[]]")+r, oAttacker.pos, 0xCC3366, 0);
        }

if (oAttacker.IsValid())
        if (oAttacker.IsEnemy(this))
                gl=EnvReadInt(oAttacker.player, "Race_Shades");
                if (gl > 0)
                        {
                                IncRes(oAttacker.player, ResGlory, GetConst("Glory_KillHero")/2*gl);
                                CreateFeedbackForPlayer("Coin", this, 1200, true, oAttacker.player);
                                CreateFeedbackForPlayer("CoinParticle", this, true, oAttacker.player);
                        }



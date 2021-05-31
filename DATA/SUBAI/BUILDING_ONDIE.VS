// void, Obj this, Obj oAttacker
int gl;
if (.rally_object.IsValid)
        .rally_object.Erase();

if (oAttacker.IsValid())
        if (oAttacker.IsEnemy(this))
        gl=EnvReadInt(oAttacker.player, "Race_Trolls");
                if (gl>0) {
                        IncRes(oAttacker.player, ResGlory, GetConst("Glory_RuinBuilding")/2*gl);

                        CreateFeedbackForPlayer("Coin", this, 1200, true, oAttacker.player);
                        CreateFeedbackForPlayer("CoinParticle", this, true, oAttacker.player);
                }
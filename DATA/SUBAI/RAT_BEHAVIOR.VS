// void, Obj This
str prev_class;
Unit this;
Unit temporalymonk;


this = This.AsUnit();
Sleep (1000);
while (1){
Sleep (100);
if (!.ExistEffect("polymorph1")){
if ( !.AsUnit.IsValid() ) break;
if ( !.IsAlive()) break;
if (.class!="Rat")  break;
        temporalymonk=Place("Human_Monk", .pos, .player);
        IncRes(temporalymonk.player, ResSupport, GetCost(temporalymonk.cost, ResSupport));
        SetFlag(temporalymonk.user_flags1, temporalymonk.dont_return_population, true);
        EnvWriteString(temporalymonk, "NewClass", EnvReadString(this, "OldClass"));
        temporalymonk.SetHidden(true);        
        temporalymonk.reserved_obj0=this;
        temporalymonk.reserved_int7=1;
        temporalymonk.reserved_int9=1;
        temporalymonk.SetCommand("promote_changeclass");

break;
}}
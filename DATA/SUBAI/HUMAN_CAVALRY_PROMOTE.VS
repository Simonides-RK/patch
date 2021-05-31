// void, Obj This

Unit this;
int support;
Unit temporalymonk;


//_pr("Promote");

this = This.AsUnit();

.SetBlockCommand(true);
CreateFeedback("data/particles/summon.part.xml", this, 1000, true);
Sleep(500);
.reserved_int5 = 1;
.SetBlockCommand(false);

//.ChangeScriptClass("Human_HeavyCavalry", true, true); // copy effects & update health

        temporalymonk=Place("Human_Monk", .pos, .player);
        IncRes(temporalymonk.player, ResSupport, GetCost(temporalymonk.cost, ResSupport));
        SetFlag(temporalymonk.user_flags1, temporalymonk.dont_return_population, true);
        EnvWriteString(temporalymonk, "NewClass", "Human_HeavyCavalry");
        temporalymonk.SetHidden(true);        
        temporalymonk.reserved_obj0=this;
        temporalymonk.reserved_int7=1;
        temporalymonk.reserved_int9=0;
        temporalymonk.SetCommand("promote_changeclass");


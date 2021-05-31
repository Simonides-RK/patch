// void, Obj This

Unit this;
Unit temporalymonk;
//_pr("Promote");

this = This.AsUnit();


.SetBlockCommand(true); 
SetFlag(.user_flags1, .cant_be_stunned, true);

.promotion_canceled = 0;
.AddEffectTimeout("promote", 0, 0, .promotion_time);

while ( .ExistEffect("promote") )
        .PlayAnim(AnimAttack1);

if ( .promotion_canceled == 0 ) {
        // create a particle effect with Summon
        temporalymonk=Place("Human_Monk", .pos, .player);
        IncRes(temporalymonk.player, ResSupport, GetCost(temporalymonk.cost, ResSupport));
        SetFlag(temporalymonk.user_flags1, temporalymonk.dont_return_population, true);
        EnvWriteString(temporalymonk, "NewClass", "Human_Oracle");
        temporalymonk.SetHidden(true);        
        temporalymonk.reserved_obj0=this;
        temporalymonk.reserved_int7=1;
        temporalymonk.reserved_int9=0;
        CreateFeedback("data/particles/summon.part.xml", this, .promotion_replace_time, true);
        Sleep(.promotion_replace_time / 2);
        temporalymonk.SetCommand("promote_changeclass");


}

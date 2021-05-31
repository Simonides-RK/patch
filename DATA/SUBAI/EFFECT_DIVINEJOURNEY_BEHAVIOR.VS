// void, Unit this, int param1, int param2, Obj oParam

point pt;
Hero h;
Item item;
int cost, slot, i;
int newmin, newrange, impmin, imprange;
str strSlotType;
if (!.IsAlive()) {.RemoveEffect("divine_journey",param1,param2);
return;
}
pt =.pos;
CreateFeedback("data/particles/summon.part.xml", .pos, 1000);
Sleep(700);
if (!.IsAlive()) {.RemoveEffect("divine_journey",param1,param2);
return;
}
.SetBlockCommand(true);
.SetCommand("idle");
.SetHidden(true);
//.AsUnit.SetPos(Point(-100, -100));
.AsUnit.SetCantAddEffect(true);
SetFlag(.user_flags1,.cant_be_stunned,true);
.SetEnemyCannotTargetFlag(true);
.AsUnit().AddEffect("absorb_damage",100,0);
.SetVisible(false);
.AddEffect("stunned",0,0);
Sleep(GetClassInt("Darkling_Empath", "journey_duration"));

newmin=GetClassInt("Darkling_Empath","divinejourney_newitem_min");
newrange=GetClassInt("Darkling_Empath","divinejourney_newitem_range");
impmin=GetClassInt("Darkling_Empath","divinejourney_impitem_min");
imprange=GetClassInt("Darkling_Empath","divinejourney_impitem_range");
h=.AsHero();
if(h.IsValid()){
        slot=rand(4);
        for(i=0;i<4;i+=1){
        item=.GetItem(slot);
        if(!item.IsValid())break;
        slot=(slot+1)%4;}
        if(item.IsValid()){
        for(i=4;i<8;i+=1){
        slot=i;item=.GetItem(slot);
        if(!item.IsValid()) break;
        }
        }
        strSlotType=.GetSlotType(slot);
        } else {slot=0;
       strSlotType="";
        item=.GetItem(slot);

}if ( item.IsValid() ) {
        slot = -1;

} else {
        cost = newmin + rand(newrange);
}cost=(100+param2)* cost / 100;


if ( slot >= 0 ){.CreateRandomItem(cost, slot, strSlotType, "", "");

}

CreateFeedback("data/particles/summon.part.xml", pt, 1000);

Sleep(700);

.SetBlockCommand(false);
 .SetNoselectFlag(false);
.UpdateItemEffects(true);
SetFlag(.user_flags1, .cant_be_stunned, false);
.SetEnemyCannotTargetFlag(false);
.RemoveEffect("stunned",0,0);
.RemoveEffect("absorb_damage", 100, 0);
.AsUnit.SetCantAddEffect(false);
.SetVisible(true);
//.AsUnit.SetPos(pt);
.SetHidden(false);
.RemoveEffect("divine_journey",param1,param2);

// void, Obj me, Obj target

Hero this;
Unit u;
str cmdname;
int new_mana, bonus;
bool bDichotomized;
ObjList ol;

this = me.AsHero();
u = target.AsUnit();

cmdname = "DivineJourney";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if ( new_mana < 0 ) {
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
} 

u = target.AsUnit();
if ( !u.IsAlive() || u.IsHidden()) {
        UserNotification("Invalid target", "", Point(-1, -1), .player);
        return; 
}

if ( .DistTo(target.pos) > .sight ) {
        while ( !.Goto(target, .sight, 500, false, 500) );
}
.Face(target);

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

if ( u.IsAlive() && !u.IsHidden()) {
u.reserved_int8=0;
        if(u.ExistEffect("possessed"))
        {
        u.reserved_obj6.DropDead();
        u.SetCantBeHealed(false);
        u.RemoveEffect("possessed",0,0);
        }
 if(u.ExistEffect("possession"))
        {
        u.reserved_obj6.DropDead();
        u.SetCantBeHealed(false);
        u.RemoveEffect("possession",0,0);
        }       
        // set it before RemoveAllEffects so if some effect uses .DropDead() or .SetCommand("selfdestruct")
        // it can check for these flag and to be able to not kill the unit
        SetFlag(u.user_flags1, u.to_be_divine_journeyd, true);
        bonus = .GetEffectParam("item_divine_journey_bonus", 1);        
        u.UpdateItemEffects(false); // remove all item effects
         // can't do it from the effect behavior script, as it would remove this effect as well
        PlaySound(u.pos, "assets/sounds/HeroSkills/Darkling Empath/Empath_DivineJourney.wav");
        .SetMana(cmdname, new_mana); // take mana before adding the effect, so it is taken if he's casting on himself
Sleep(150);
        //u.RemoveAllEffects();
        if (u.ExistEffect("open_wounds")) u.RemoveEffect("open_wounds",0,0);
        if (u.ExistEffect("curse")) u.RemoveEffect("curse",0,0);
        if (u.ExistEffect("confuse")) u.RemoveEffect("confuse",0,0);
        if (u.ExistEffect("fog_strike")) u.RemoveEffect("fog_strike",0,0);
        if (u.ExistEffect("corrosive_gas")) u.RemoveEffect("corrosive_gas",0,0);
        // Ivko: Timeout added for displaying an infolist progress bar; +3000 is larger than needed, but just in case...
        u.AddEffectTimeout("divine_journey", 0, bonus, GetClassInt("Darkling_Empath", "journey_duration")+3000);

}

if(.GetAnim())
{
        Sleep(.TimeToAnimFinish());
}
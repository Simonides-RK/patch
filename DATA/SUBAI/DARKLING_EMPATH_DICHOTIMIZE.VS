// void, Obj me, Obj target

Hero this;
Unit u, new;
str cmdname;
int new_mana, bonus, he, slot;
point pt;
str strGroup;

this = me.AsHero();
u = target.AsUnit();

cmdname = "Dichotomize";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if ( new_mana < 0 ) {
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
} 

if ( .DistTo(target.pos) > .sight ) {
        while ( !.Goto(target, .sight, 500, false, 500) );
}
.Face(target);

//                 es,      
if ( ((u.user_flags1 & u.cant_be_stunned) != 0) || !IsInterruptableCommand(u) ) {
        Sleep(1000);
}

//||u.ExistEffect("dichotimize")||u.ExistEffect("resurected")
if ( ((u.user_flags1 & u.cant_be_stunned) != 0) || !IsInterruptableCommand(u) ||u.legendary==1) {
        UserNotification("common", Translate("[[24982763]]Failed to dichotomize unit.[[]]"), Point(-1, -1), .player);
        return;
}
 if (u.health<2){ //u.AddEffectTimeoutObjParam("disintegration", 0, 0, this, 1);
                   //new.AddEffectTimeoutObjParam("disintegration", 0, 0, this, 1);
        UserNotification("common", Translate("[[24982763]]Failed to dichotomize unit.[[]]"), Point(-1, -1), .player);
        return;}
					 
SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

if(u.IsAlive())
{
        PlaySound(u.pos, "assets/sounds/HeroSkills/Darkling Empath/Empath_Dichotomize.wav");
        new = CopyUnit(u);

        IncRes(u.player, ResSupport, GetCost(u.cost, ResSupport));
        SetFlag(new.user_flags1, new.dont_return_population, true);
        he=u.health;
        u.SetHealth((u.health+1) / 2);
        new.SetHealth(u.health);
        u.AddEffect("dichotimize", 0, 0);
        new.AddEffect("dichotimize", 0, 0);
        u.reserved_int9+=1;
        new.reserved_int9=u.reserved_int9;
        strGroup = u.GetIndependentGroupName();
        if ( strGroup != "" ) {
                new.AddToGroup(strGroup);
        }

        pt = u.GetDir();

        Sleep(1); // Give some time to the new unit to start any scripts inserted from the 'init' script
        new.Face(new.pos - pt);
        if (u.IsAlive())
                u.InsertCommand("dichotimize_split", new);
        new.InsertCommand("dichotimize_split", u);
		//Władysław Ańtian: remove new's item
		slot = rand(1);
if(new.GetItem(slot).IsValid() ==1)
{
	new.RemoveItem(slot);
}
        }
        .SetMana(cmdname, new_mana);


 
if(.GetAnim())
{
        Sleep(.TimeToAnimFinish());
}


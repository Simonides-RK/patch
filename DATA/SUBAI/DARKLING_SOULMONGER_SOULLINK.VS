// void, Obj me, Obj target

Hero this;
Unit u;
str cmdname;
int new_mana;

this = me.AsHero();
u = target.AsUnit();

cmdname = "SoulLink";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
} 
if(u.ExistEffect("soullink", this))
{
        UserNotification("Invalid target", "", Point(-1, -1), .player);
        return;
}
if ( .DistTo(target) > .sight ) {
        while ( !.Goto(target, .range, 500, false, 500) );
}
.Face(target);

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

if (u.IsAlive() && !target.IsHidden())
        {
                u.AddEffectObjParam("soullink", .soullink_rate, 0, this);
                .SetMana(cmdname, new_mana);
                .AddEffectObjParam("soullink_hero", .soullink_rate, 0, u);
        }
.SetBlockCommand(false);
if(.GetAnim())
{
        Sleep(.TimeToAnimFinish());
}
// void, Obj me, Obj target

Hero this;
Unit u;
str cmdname;
int new_mana;
ObjList ol;
ParticleSystem ps;
point pt;
int i;

this = me.AsHero();
u = target.AsUnit();
pt = u.pos;

cmdname = "SoulBurn";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
} 

if ( .DistTo(target.pos) > .sight ) {
        while ( !.Goto(target, .sight, 500, false, 500) );
}
if ( target.IsAlive() && !target.IsHidden()) {
 .Face(target);

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

//play the sound here because the die sound will override it
PlaySound(pt, "assets/sounds/HeroSkills/Darkling Soulmonger/Soulmonger_SoulBurn.wav");

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

ol = Intersect(ObjsInCircle(pt, .soulburn_range, "Unit", false), EnemyObjs(.player, "Unit", false)).GetObjList();

if(ol.count != 0)
{       
        if ( target.IsAlive() && !target.IsHidden())
		{ target.DropDead();
        CreateFeedback("data/particles/SoulBurn.part.xml", pt, 1600);

        for ( i = 0; i < ol.count; i += 1 ) 
			{
					ol[i].Damage(this, .soulburn_damage, false);
					CreateFeedback("data/particles/HitFeedback_Fire.part.xml", ol[i], 600, true);
			}
        .SetMana(cmdname, new_mana);
		}       
}
else
{
        UserNotification("No units in sight", "", Point(-1, -1), .player);
        return; 
}
.SetBlockCommand(false);
if(.GetAnim())
{
        Sleep(.TimeToAnimFinish());
}
}
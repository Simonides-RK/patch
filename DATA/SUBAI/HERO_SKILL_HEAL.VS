// void, Obj me, Obj target

Hero this;
Unit u;
Item item;
str cmdname;
int new_mana, i, slot;
point ptdir;

this = me.AsHero();
u = target.AsUnit();

if ( !u.IsValid() ) {
	_pr("heal: selectverify selected invalid target!");
	return;
}

cmdname = "Hero_Heal";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
	UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
	return;
} 

if ( .DistTo(u) > .sight ) {
	while ( !.Goto(u, .sight, 500, false, 500) );
}
.Face(target);

if ( !u.IsAlive() ) return;

u.Heal(.skill_heal_amount, "Heal_Sound_");
CreateFeedback("data/particles/Heal_Unit_Feedback.part.xml", u.pos, 1000);

.SetMana(cmdname, new_mana);

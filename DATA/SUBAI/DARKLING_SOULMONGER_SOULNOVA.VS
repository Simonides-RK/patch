// void, Obj me, Obj target

Hero this;
Unit u;
str cmdname;
int new_mana;

this = me.AsHero();
u = target.AsUnit();

if ( .health < .soulnova_healthcost+50 ) {
        UserNotification("common", Translate("[[25004925]]Not enough health for casting Soul Nova[[]]"), Point(-1, -1), .player);
        return;
}

cmdname = "SoulNova";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(!u.IsAlive)
        return;
if(new_mana < 0)
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
} 

if ( .DistTo(u) > .sight ) {
        while ( !.Goto(u, .sight, 500, false, 500) );
}
.Face(target);

SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

if(rand(100) > .GetEffectParam("item_soulnova_bonus", 1))
        .DamageWithNoAttacker(.soulnova_healthcost);
.CreateProjectile(u, "Darkling_Soulmonger_ProjectileNova");
PlaySound(.pos, "assets/sounds/HeroSkills/Darkling Soulmonger/Soulmonger_SoulNova.wav");

if(.GetAnim())
{
        Sleep(.TimeToAnimFinish());
}

// finally:
.SetMana(cmdname, new_mana);
.SetBlockCommand(false);
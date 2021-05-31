// void, Obj This, Obj target

Hero this;
str cmdname;
int new_mana;
Unit u;
ObjList ol;
int count, i;
bool bSucceeded;

this = This.AsHero();



while(!.GotoAttack(target, 500, false, 300));
.Face(target);

cmdname = "Rage_Impulse";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
}
.SetBlockCommand(true);
SetFlag(.user_flags1, .cant_be_stunned, true);

ol = Intersect(ObjsInRange(target, "Unit", .rage_impulse_radius, true), EnemyObjs(.player, "Unit", true)).GetObjList();
count = ol.count();
bSucceeded = false;
for(i = 0; i < count; i += 1)
{
        u = ol[i].AsUnit();
        if(u.IsValid() && u.IsValidTarget(target) && !u.GetEnemyCannotTargetFlag()&& u.class!="Darkling_Meteor")
        {
                bSucceeded = true;
                u.SetCommand("attack", target);
                if (u.AsHero.IsValid) u.AddEffectTimeout("rage_impulse", 0, 0, .rage_time_effect/2); else u.AddEffectTimeout("rage_impulse", 0, 0, .rage_time_effect);
                //CreateFeedback("Data/Particles/RageImpulseEnemy.part.xml", u, .rage_time_effect, true);
        }
}
if(bSucceeded)
{
        PlaySound(target.pos, "assets/sounds/HeroSkills/Forester Fairy/Fairy_rage_impulse.wav");
        CreateFeedback("Data/Particles/RageImpulseFriendly.part.xml", target.AsUnit(), .rage_time_effect, true);
        .SetMana(cmdname, new_mana);
}
else
{       
        UserNotification("Rage Impulse Impossible", "", Point(-1, -1), .player);
        return;
} 

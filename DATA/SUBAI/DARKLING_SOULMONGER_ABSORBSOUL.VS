// void, Obj me, Obj target

Hero this;
Unit u;
str cmdname;
int new_mana;
ObjList ol;
ObjList olParticles;
ParticleSystem ps;
int i;
bool bAlive, bHealed;
point pt;

this = me.AsHero();
u = target.AsUnit();
pt = u.pos;

cmdname = "AbsorbSoul";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
} 

if ( .DistTo(pt) > .sight ) {
        while ( !.Goto(target, .sight, 500, false, 500) );
}
if ( target.IsAlive() && !target.IsHidden()) {
.Face(target);
target.AsUnit.SetNoselectFlag(true);
target.AsUnit.SetEnemyCannotTargetFlag(true);
                         
SetFlag(.user_flags1, .cant_be_stunned, true);
.SetBlockCommand(true);

//play the sound here because the die sound will override it
PlaySound(pt, "assets/sounds/HeroSkills/Darkling Soulmonger/Soulmonger_AbsorbSoul.wav");

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

this.CreateProjectileFromPt(this, .healprojectile, pt);

if ( target.IsAlive() && !target.IsHidden() ) target.DropDead();

if(rand(100) > .GetEffectParam("item_absorbsoul_bonus", 1)){
        .SetMaxHealth(.GetMaxHealth() + .absorbsoul_bonus);
        FloatingText(Translate("[[25601940]]Health +[[]]")+.absorbsoul_bonus, .pos, 0xCC3366, 0);}
else
        {.SetMaxHealth(.GetMaxHealth() + .absorbsoul_bonus + 10);
        FloatingText(Translate("[[25601940]]Health +[[]]")+(.absorbsoul_bonus+10), .pos, 0xCC3366, 0);}

if(.GetAnim())
{
        Sleep(.TimeToAnimFinish());
}
target.AsUnit.SetNoselectFlag(false);
target.AsUnit.SetEnemyCannotTargetFlag(false);

// finally:
.SetMana(cmdname, new_mana);
}
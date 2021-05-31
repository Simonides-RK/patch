// void, Obj This

Hero this;
str cmdname;
int new_mana;
Unit u;
ObjList ol, olps;
int i;
Obj WatchEye;

this = This.AsHero();

//_pr("battleangel::magicswords");

cmdname = "LightningStorm";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0)
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
}

.SetBlockCommand(true);
SetFlag(.user_flags1, .cant_be_stunned, true);

.StartAnim(AnimSpecial1);
if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

WatchEye = Place("WatchEyeLightningStorm", .pos, .player);      // it will selfdestroy itself
PlaySound(.pos, "assets/sounds/HeroSkills/Human BattleAngel/BattleAngel_LightningStorm.wav");

ol = Intersect(ObjsInSight(this, "Unit", false), FriendlyObjs(.player, "Unit", true)).GetObjList();

ol.Add(this);

for(i = 0; i < ol.count; i += 1)
{
        ParticleSystem ps;
        u = ol[i].AsUnit();
        if(u.IsValid() && !u.ExistEffect("unit_in_shelter"))
        {
                ps = CreateParticleSystem("Data/Particles/Lightning02.part.xml");
                ps.SetPos(u.pos);
                ps.SetHeight(-400);
                ps.Goto(u.pos, 600, 0);
                olps.Add(ps);
        }else{ol.Remove(ol[i]);}
}

Sleep(600);

for(i = 0; i < ol.count; i += 1)
{
        u = ol[i].AsUnit();
        olps[i].SetCommand("selfdestruct", Point(1, 700));
        if(u.IsAlive())
          u.AddEffectObjParam("lightningstorm", 0, 0, this);
}

if(.GetAnim())
{
        Sleep(.TimeToAnimFinish());
}
.AddEffectTimeout("invisible", 0, 0, 15000);
// finally:
.SetMana(cmdname, new_mana);
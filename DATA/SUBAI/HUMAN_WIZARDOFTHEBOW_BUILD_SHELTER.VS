// void, Obj This, point pt


Unit this;
point ptBegin;
int a1, a2;
int n1, n2, i,j;
point ptNewBuildingPos;
Building bdNew;
point ptEdge;
int nRadius;
str sCmdCost;
Query q;
ObjList ol;
bool bOnce, bUnitsMoved;
str cmdname;
int new_mana;
bool bMustWeMove;

bMustWeMove = false;

this = This.AsUnit;

ptBegin = .pos;

nRadius = GetRadius(cmdparam) + 15;


//1. approach at a distance and get ready to ward the obstructing units away

//while going, see if this is impossible
if(.on_crystal_tower != 1)
{
        while (!.Goto(pt, nRadius + .shelter_range , 1020, false, -1)) {
                if (.TimeWithoutWalking() > 2000) {
                        UserNotification("cant build there", "", Point(-1, -1), .player);
                        .KillCommand(); //so the onaddremove script would return the resources
                        return;
                }
        }
}

//2. Start approaching and checking if someone obstructs us
bOnce = true; //run the body at least once
while(.on_crystal_tower != 1 || bOnce)
{
        if(.on_crystal_tower != 1)
        {
                if(.Goto(pt, nRadius + .shelter_radius, 300, false, -1));
                if (.TimeWithoutWalking() > 2000) {
                        UserNotification("cant build there", "", Point(-1, -1), .player);
                        .KillCommand(); //so the onaddremove script would return the resources
                        return;
                }
        }
        bOnce = false;

        //move the obstructing units away

        if(.on_crystal_tower != 1)
        {
                if(.Goto(pt, nRadius + .shelter_radius, 300, false, -1))
                {
                        break;
                }
        }
}


//get mana here!
cmdname = "Shelter";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana >= 0)
{
        .SetMana(cmdname, new_mana);
}
else
{
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
}


if(.on_crystal_tower != 1)
{
        .SetBlockCommand(true);
}


PlaySound(pt, "assets/sounds/HeroSkills/Human WizardOfTheBow/WizardOfTheBow_Shelter.wav");
bdNew = Place(cmdparam, pt, .player);
bdNew.SetMaxHealth(bdNew.GetMaxHealth*(100+.GetEffectParam("item_crystal_bonus", 1))/100);
bdNew.DamageWithNoAttacker(bdNew.GetMaxHealth*9/10);
bdNew.SetBuilt(false);
if (bdNew.IsValid())
        bdNew.SetCommand("being_built");

if(.on_crystal_tower != 1)
{
        .SetBlockCommand(false);
}

q = Intersect(
                FriendlyObjs(.player, "Unit", true) ,
                ObjsInCircle(pt, nRadius , "Unit", true)
        );
        ol = q.GetObjList();
        for (i=0; i<ol.count; i+=1) {
                Obj o;
                point ptVector;
                int nLen;
                o = ol[i];
                //don't touch ranged units (except for wolfmasters, which are ranged only sometimes)
                if (o.AsUnit.IsRanged()) continue;
                if (!IsInterruptableCommand(o)) continue;
                o.in_shelter=bdNew;
                o.InsertCommand("exit_shelter");
        }

q = Intersect(
                FriendlyObjs(.player, "Unit", true) ,
                ObjsInCircle(pt, nRadius+200 , "Unit", true)
        );
ol = q.GetObjList();
for (i=0; i<ol.count; i+=1) {
        Unit o;
        o = ol[i].AsUnit;
        if (o != this) {
        if (o.flying==1) continue;
        if (!o.AsUnit.IsRanged()) continue;
                if (!o.IsUncontrollable() || o.IsIndependentGuardian())
                        o.SetCommand("enter_shelter", bdNew);
        }
}


//if(.on_crystal_tower != 1 )
//{
//        .SetCommand("enter_shelter", bdNew);
//}

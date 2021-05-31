//void, ObjList objs, int player, str cmdcost, point pt, Obj This, bool bReplace

int i;
Unit u;

for (i = objs.count - 1; i >= 0; i -= 1)
{
        u = objs[i].AsUnit();
        if ( u.IsAlive() && u.class=="Human_Paladin") {
        if (u.ExistEffect("PaladinArmor")) u.RemoveEffect("PaladinArmor",0,0);
        u.AddEffectTimeout("PaladinArmor",0,0,15000);
        break;
													  }
}
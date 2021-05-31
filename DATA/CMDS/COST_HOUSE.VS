//str, ObjList objs, int player

Query q;
int glory_cost, built;
q = ClassPlayerObjs("Forester_Mage_Tower,Human_SupportBuilding", player, true);

built = EnvReadInt(player, "Houses_Built");

if(built > q.count)
        glory_cost = 0;
else
        glory_cost = (q.count + 1) * ResGloryFactor;
if (glory_cost/ResGloryFactor>7) glory_cost=7*ResGloryFactor;
if (q.count>9) glory_cost=10*ResGloryFactor;
return GetClassStr(cmdparam, "cost")+"/"+(glory_cost / ResGloryFactor);
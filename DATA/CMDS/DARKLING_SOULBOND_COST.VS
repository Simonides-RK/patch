//str, ObjList objs, int player

int glory_cost;

glory_cost = 1 + EnvReadInt(player, "Max_Soulwatchers");
if (glory_cost>7) glory_cost=7;
if (EnvReadInt(player, "Max_Soulwatchers")>9) glory_cost=10;
return "150/0/0" + "/" + glory_cost;
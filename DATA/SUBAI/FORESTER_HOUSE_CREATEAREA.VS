//void, ObjList objs, int player, str cmdcost, point pt, Obj obj, bool bReplace

Building this;
int i;

this = objs[0].AsBuilding();

if ( !.IsAlive() ) return;

.magic_area = Place(GetFromStr(cmdparam, "MagicAreaClass"), pt, .player);
.magic_area.magic_area_charge = Str2Int(GetFromStr(cmdparam, "MagicAreaCharge"));
.magic_area.mage_tower = this;

DecRes(.player, ResGold, GetCost(cmdcost, ResGold));
DecRes(.player, ResGems, GetCost(cmdcost, ResGems));

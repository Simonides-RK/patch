// void, Obj this

str sClass;
point ptRally;
Building bld;
rect rc;
point defpt;
ObjList ol;

bld = this.AsBuilding();

sClass = .rally_object_class;
if(sClass != "")
{
        // fixes the problem when the rally point is out of the map
        rc = GetMapRect();
        defpt = .GetDefRallyPoint();
        if(.pos.x + defpt.x <= rc.left || .pos.x + defpt.x >= rc.right)
        {
                // move the rally point symetricaly by X axis
                defpt = Point(-defpt.x, defpt.y);
        }
        if(.pos.y + defpt.y <= rc.top || .pos.y + defpt.y >= rc.bottom)
        {
                // move the rally point symetricaly by Y axis
                defpt = Point(defpt.x, -defpt.y);
        }
        ptRally = .pos + defpt;
        .rally_object = Place(sClass, ptRally, .player);
        .RallyPointCreated(.rally_object);
}

// Check if 'IsBuilt()' returns true - if it does
// this must be a building placed from the editor, and
// its 'onconstruct' script must be called (because there's
// no build process and it won't be called from there)
if (bld.IsBuilt())
{
        ol = ObjsInCircle(.pos, .radius, "BuildingUpgrade", true).GetObjList();
        if(ol.count() > 0)
        {
                if(!ol[0].IsHidden())
                {
                        //_pr("bulding::init: upgrade of the the building found nearby");
                        .building_upgrade = ol[0];
                        bld.RegSubObj(.building_upgrade);
                }
        }
        .SetCommand("onconstruct");
}

.promille_ready = 0;
.passability_placed     = 0;
.ai_guard_is_running = 0;

if (!(.race_str=="Race_Dragons" || .race_str=="Race_Trolls" || .race_str=="Race_Shades" || .race_str=="Race_Nomads" || .race_str=="Race_Elves" || .class=="Darkling_Tower" || .class=="Forester_Tower" || .class=="Human_Tower")) .armor+=EnvReadInt(.player, "colonyCount")*5;
if (.class=="Darkling_Tower" || .class=="Forester_Tower" || .class=="Human_Tower") .SetMaxHealth(.GetMaxHealth()+EnvReadInt(.player, "colonyCount")*25);



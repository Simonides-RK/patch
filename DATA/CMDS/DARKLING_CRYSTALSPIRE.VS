// void, Obj this

Building b;

b = .AsBuilding();
if ( !b.IsAlive() ) return;

b.building_upgrade = Place("Darkling_TowerUpgrade_Crystal", .pos, .player);
b.building_upgrade.building_owner = this;       
b.RegSubObj(.building_upgrade);
if(b.building_upgrade.HasCommand("appear"))
{
        b.building_upgrade.InsertCommand("appear");
}
.SetSight(.sight/2);
.SetRange(.range/2);
.damage=10;
.SetMaxHealth(.GetMaxHealth()+500);
.CmdDisable("upgrade_DarklingEmberTower");
.CmdDisable("upgrade_DarklingMagmaTower");
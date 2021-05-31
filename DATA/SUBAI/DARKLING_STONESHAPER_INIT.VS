//void, Obj this

Query q;
int iMeteors, iAngle;
point ptDir, ptPos;
Unit u;

u = this.AsUnit();

if (IsUpgradeAvailable(.player, "upgrade_Evacuation"))
{
        //.armor+=2;
        //.SetMaxHealth(.maxhealth + 350);
			u.armor += GetClassInt("Darkling_StoneShaper", "evacuate_armor_bonus");
			u.SetMaxHealth(u.GetMaxHealth() + .evacuate_health_bonus);		
}        
.unit_to_attack = this;

.SetModalButton(.mb_annihilate);

.InsertCommand("init_meteors");

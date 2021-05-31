// void, Obj me, ObjList ol

Unit u;
int i;
Unit uToHeal;

if(me.mage_tower.IsDead)
        return;
//if(me.mage_tower.magic_area_charge == 0 || me.mage_tower.magic_area != me)
if(me.magic_area_charge == 0)
        return;
        

// Look for a hero first        
for ( i = 0; i < ol.count; i += 1 ) {
        u = ol[i].AsHero();
        if (u.IsAlive()) {
                if ( u.health < u.GetMaxHealth() && !u.CantBeHealed() && !me.IsEnemy(u)) {
                        uToHeal = u;
                        break;
                }
        }
}

// Then look for an unit
if (!uToHeal.IsValid())
        for ( i = 0; i < ol.count; i += 1 ) {
                u = ol[i].AsUnit();
                if(u.IsAlive)
                {
                        if ( u.health < u.GetMaxHealth() && !u.CantBeHealed() ) {
                                if (!me.IsEnemy(u)) {
                                        uToHeal = u;
                                        break;
                                }
                                else if (u.class == "Darkling_DarkRider") {
                                        if (EnvReadString(u.player, "upgrade_upgrade_Nightweb") == "available") {
                                                uToHeal = u;
                                                break;
                                        }
                                }
                        }
                }
        }       

if (uToHeal.IsValid()) {
        u.Heal(100000);
        CreateFeedback("data/particles/Heal_Unit_Feedback.part.xml", u, 400, true);
        me.magic_area_charge -= 1;
        PlaySound(me.pos, "Heal_Sound_");
}

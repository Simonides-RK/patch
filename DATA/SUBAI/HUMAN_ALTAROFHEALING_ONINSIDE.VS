// void, Obj me, ObjList ol

Unit u;
int i;
bool bHealIt;
str strStatus;
bool bSomeHealingDone;

//_pr("Altar::oninside");

bSomeHealingDone = false;
for ( i = 0; i < ol.count; i += 1 ) {
	u = ol[i].AsUnit();
	if(u.IsAlive)
	{
		if ( u.health < u.GetMaxHealth() && !u.CantBeHealed() ) {
		
			bHealIt = true;
			if (me.IsEnemy(u)) {
				bHealIt = false;
				if (u.class == "Darkling_DarkRider") {
					strStatus = EnvReadString(u.player, "upgrade_upgrade_Nightweb");
					if (strStatus == "available")
						bHealIt = true;
				}
			}		
			if (bHealIt) {
				bSomeHealingDone = true;
				u.Heal(me.area_heal_rate);
				CreateFeedback("data/particles/Heal_Unit_Feedback.part.xml", u, 400, true);
			}
		}
	}
}
if(bSomeHealingDone)
{
	PlaySound(me.pos, "Heal_Sound_");
}
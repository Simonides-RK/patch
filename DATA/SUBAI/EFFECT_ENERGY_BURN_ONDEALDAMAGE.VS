// void, Unit this, Obj dest, int* damage, bool bDirectDamage, int param1, int param2, Obj oParam

Unit u;
int diff;
u = dest.AsUnit;  
if(damage == 0) // we missed on invisible
        return;
if (u.class=="Human_Shelter") return;
if ( u.IsAlive() && bDirectDamage ) 
{ 
        if(dest.energy > param1) 
                diff = param1; 
        else 
                diff = dest.energy; 
        if(diff > 1)
        {
                u.SetEnergy(dest.energy - diff); 
                damage = damage + diff;
                FloatingText(Translate("[[]]-[[]]") + diff, u.pos, GetConst("EnergyBurnDamageColor"), 0);
                CreateFeedback("data/particles/EnergyBurn.part.xml", u, 60, true);
        }
}
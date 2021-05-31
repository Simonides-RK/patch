// void, Unit this, Obj src, int *damage, bool bDirectDamage, int param1, int param2, Obj oParam

int nReducedDamage;

//_pr("effect_guardianspirit::ondealtdamage");


nReducedDamage = damage * (100-GetClassInt("Human_Pikeman", "goldenshield_damage_reduction")) / 100;

if ( bDirectDamage ) {

        if ( src.AsBuilding.IsValid ) {         
                damage = nReducedDamage;
        } else {
                if ( src.AsUnit().IsValid() ) {
                        if ( src.AsUnit().IsAlive() ) {
                                if ( src.AsUnit().IsRanged() )
                                        damage = nReducedDamage;
                        } else {
                                damage = nReducedDamage; // should be ranged, if is already dead
                        }
                }
        }
}
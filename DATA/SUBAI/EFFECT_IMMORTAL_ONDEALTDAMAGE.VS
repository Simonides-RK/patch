// void, Unit this, Obj src, int *damage, bool bDirectDamage, int param1, int param2, Obj oParam

if(damage >= .health)
{
.SetInvulnerable(true);
        // do all the stuff here before setting wait for death comamnd of the sprite    
        damage = 0; // Don't deal damage to the unit after 'reviving' it!
        .SetHealth(.GetMaxHealth()); // Feanor: Heal won't do, if unit can't be healed
                                // AND, SetCantBeHealed(false) also doesn't work, as the flag is ref-counted

        .RemoveEffect('immortal', 0, 0);
        .AddEffectTimeout('immortal', 0, 0,1000);
        if (.reserved_obj6.IsAlive()) {
        .reserved_obj6.SetCommand("wait_for_death", this);
        .SetCantBeHealed(false);
        .Heal(100000); 
        }
.SetInvulnerable(false);
}
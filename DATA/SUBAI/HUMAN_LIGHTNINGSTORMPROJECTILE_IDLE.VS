// void, Obj me

ParticleSystem this;

this = me.AsParticleSystem;

Sleep(.proj_time);

if (.proj_target.IsAlive() && !.proj_target.AsUnit.ExistEffect("unit_in_shelter"))

{
   if (!.proj_target.AsHero.IsValid){
       .proj_target.DamageWithNoAttacker(GetClassInt("Human_BattleAngel", "lightningstorm_damage"));
   }else{
      if (!.proj_target.class=="Human_WizardOfTheBow"){
         .proj_target.DamageWithNoAttacker(GetClassInt("Human_BattleAngel", "lightningstorm_damage")/3); 
       }else{
         if (.proj_target.on_crystal_tower != 1) .proj_target.DamageWithNoAttacker(GetClassInt("Human_BattleAngel", "lightningstorm_damage")/3); 
      }  
   }
}

.StopEmitters();
Sleep(600);
.Erase();

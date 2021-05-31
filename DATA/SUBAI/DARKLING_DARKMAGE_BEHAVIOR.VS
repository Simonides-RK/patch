// void, Obj This

Unit this;
this = This.AsUnit();
Sleep(1000);
while(1){
Sleep(1000);
        if(.modal_button == 7 && .energy > .mind_twist_energy) {
                if (!.ExistEffect("revealer")) {
                        .AddEffect("revealer",0,0); 
                        .PlayAnim(AnimSpecial1);
                }else{
                        .SetEnergy(.energy - .mind_twist_energy/4);
                }
        }else{
                 if (.ExistEffect("revealer")) .RemoveEffect("revealer",0,0); 
        }
}
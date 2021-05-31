// void, Obj This, point ptDest

Building this;
ObjList olRuined;
int i;
str cmdname;
int new_mana;

this = This.fake_queuer_townhall.AsBuilding();

cmdname = "Restoration";
new_mana = .GetMana(cmdname) - .GetManaCost(cmdname);
if(new_mana < 0) {
        UserNotification("Skill is not ready yet", "", Point(-1, -1), .player);
        return;
}

olRuined = ISRestoration(ptDest, .player);
if (olRuined.count > 0) {
        .SetMana(cmdname, new_mana); //get the mana only if work was done
        
        Sleep(1); //wait for the constructors to be called
        
        for (i=0; i < olRuined.count; i+=1) {
                olRuined[i].being_restored_worker=olRuined[i];
                olRuined[i].SetCommand("being_restored");
        }
        
} else {
        UserNotification("common", Translate("[[25167043]]Please select a point near a destroyed colony.[[]]"), Point(-1, -1), .player);
}

//bool, ObjList objs, int player, str cmdcost, str rollover, str OUT disabled_reason_text

Building this;
str strValue;
str strDisabled;
str strStatus;
int i;
bool NotBuilt;
NotBuilt=false;

this = objs[0].AsBuilding;
strDisabled = disabled_reason_text + "\n" + rollover;
strStatus = "upgrade_" + cmdid;



for (i=0; i<objs.count; i+=1){
 if (!objs[i].IsBuilt()) NotBuilt=true;
 if (cmdid=="train_Longbowman"){
  if (!IsUpgradeAvailable(objs[i].AsBuilding, "upgrade_Human_Barracks"))  NotBuilt=true;;
 }

 if (cmdid=="train_ApostleOfDeath"){
  if (!IsUpgradeAvailable(objs[i].AsBuilding, "upgrade_Battle_Shrine"))  NotBuilt=true;;
 }

 if (cmdid=="train_Hunter"){
  if (!IsUpgradeAvailable(objs[i].AsBuilding, "upgrade_Forester_Hut"))  NotBuilt=true;;
 }


}

if (NotBuilt) {
disabled_reason_text = strDisabled;
return false;
}





NotBuilt=false;
for (i=0; i<objs.count; i+=1){
if (!objs[i].IsAlive) NotBuilt=true;;
if (NotBuilt){
disabled_reason_text = strDisabled;// + "<color 255 255 64>\n\n" + Translate("[[10743998]]Queue not empty[[]]");
return false;
}
}

return true;

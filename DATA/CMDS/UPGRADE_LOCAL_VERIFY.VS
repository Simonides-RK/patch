//bool, ObjList objs, int player, str cmdcost, str rollover, str OUT disabled_reason_text

Building this;
str strValue;
str strDisabled;
str strStatus;


int i;
bool NotBuilt;
NotBuilt=false;
if (objs.count>1){
for (i=0; i<objs.count; i+=1){
if (!.IsBuilt()) NotBuilt=true;
if (NotBuilt) {disabled_reason_text = strDisabled; return false;}
}
}

this = objs[0].AsBuilding;

//strDisabled = disabled_reason_text + "\n" + Translate(rollover);
strDisabled = disabled_reason_text + "\n" + rollover;
strStatus = "upgrade_" + cmdid;

if (.IsAlive)
{
//if ((.CmdCount() < 2) && (.command == "idle"))
if (.IsBuilt())
{
strValue = EnvReadString( this, "upgrade_status" );
if (strValue == "in progress") {
//this could not happen, because the method we are executing is 'idle'
disabled_reason_text = strDisabled;// + "<color 255 255 64>\n\n" + Translate("[[10734537]]An upgrade is currently in progress.[[]]");
return false;
}
strValue = EnvReadString( this, strStatus );
if (strValue == "in progress") {
disabled_reason_text = strDisabled + "<color 255 255 64>\n\n" + Translate("[[10794045]]This upgrade is already in progress.[[]]");
return false;
}
if (strValue == "available") {
disabled_reason_text = strDisabled + "<color 255 255 64>\n\n" + Translate("[[10728005]]This upgrade is currently available.[[]]");
return false;
}
if (strValue == "disabled") {
disabled_reason_text = strDisabled;
return false;
}
if (.is_haunted == 1)  {
disabled_reason_text = Translate("[[hauntedbld]]Haunted Buildings can't produce.[[]]");
return false;
}
return true;
}
else
{
disabled_reason_text = strDisabled;// + "<color 255 255 64>\n\n" + Translate("[[10743998]]Queue not empty[[]]");
}
}
return false;

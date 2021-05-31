// void, Obj me, Obj other

Unit this;
Obj u;

//_pr("shaman::vitalize");
this = me.AsUnit();

u = other.AsUnit();
if(u.class == "Human_Shelter") return;
if(u.class == "Human_Paladin" && u.modal_button == 4) 
{	
	Sleep(1000);
	return;
}
if(u.class == "Forester_Shaman")
{
        _pr("shaman::vitalize - this SHOULD NOT happen!!!");
}
if(.energy < .energy_vitalize)
{
        return;
}

if(IsFlagSet(u.user_flags1, u.to_be_vitalized))
{
        Sleep(50);
        return;
}

.SetBlockCommand(true);
SetFlag(.user_flags1, .cant_be_stunned, true);
SetFlag(u.user_flags1, u.to_be_vitalized, true);

.unit_attacked = u;
.Face(u);
.StartAnim(27);

if(.GetAnim())
{
        Sleep(.TimeToActionMoment());
}

.SetEnergy(.energy - .energy_vitalize);
.CreateProjectile(u, .projectile_channel);
.shaman_last_attack_time = GetTime();
if(.GetAnim())
{
        Sleep(.TimeToAnimFinish());
}
Sleep(.vitalize_delay);

SetFlag(.user_flags1, .cant_be_stunned, false);
.SetBlockCommand(false);

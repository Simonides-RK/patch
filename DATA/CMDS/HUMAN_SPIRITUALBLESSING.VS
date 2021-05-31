//void, int player

ObjList ol;
int i;
Unit u;


// Longbowman
ol=ClassPlayerObjs("Human_Longbowman", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
// Worker
ol=ClassPlayerObjs("Human_Worker", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
// Pikeman
ol=ClassPlayerObjs("Human_Pikeman", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
// Swordsman
ol=ClassPlayerObjs("Human_Swordsman", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
// Paladin
ol=ClassPlayerObjs("Human_Paladin", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
// Heavy Cavalry (Knight)
ol=ClassPlayerObjs("Human_HeavyCavalry", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
// Cavalry
ol=ClassPlayerObjs("Human_Cavalry", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
// Monk
ol=ClassPlayerObjs("Human_Monk", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
// Oracle
ol=ClassPlayerObjs("Human_Oracle", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
//Witch
ol=ClassPlayerObjs("Human_Witch", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
//Prophet (Shadow Mistress)
ol=ClassPlayerObjs("Human_Prophet", player, false).GetObjList();
for (i = ol.count - 1; i >= 0; i -= 1)
{
u = ol[i].AsUnit();
 if ( u.IsAlive() )
 {
	u.AddEffect("spiritual_blessing_effect", 0, 0);
 }
}
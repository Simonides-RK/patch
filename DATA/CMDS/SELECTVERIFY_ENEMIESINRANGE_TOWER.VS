//bool, Obj this, point ptTarget, Obj objTarget, str OUT reason

int new_mana;
Unit u;

if( !objTarget.IsAlive )
{
	reason = "";
	return false;
}
if( !.CanAttack(objTarget))
{
	reason = GetNotificationText("Invalid target");
	return false;
}

if(!.IsEnemy(objTarget) && !objTarget.IsHeirOf("Tower")) 
{
	reason = GetNotificationText("enemy target only");
	return false;
}	

return true;
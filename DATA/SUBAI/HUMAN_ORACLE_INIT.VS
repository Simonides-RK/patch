//void, Obj this

Unit u;

//_pr("Oracle: init");

u = .AsUnit();

u.SetRevealer(true);
CreatePermanentFeedback("AllSeeingEye", u);

if ( IsUpgradeAvailable(.player, "upgrade_Exorcism") ) {
        u.SetModalButton(u.mb_exorcism);
}

// check for the Holy Shield upgrade as well, it will override the Exorcism
if ( IsUpgradeAvailable(.player, "upgrade_HolyShield") ) {
        u.SetModalButton(u.mb_holyshield);
}

if (IsUpgradeAvailable(.player, "upgrade_SpiritualBlessing")) u.AddEffect("spiritual_blessing_effect", 0, 0);
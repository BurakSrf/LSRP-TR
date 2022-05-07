StartSpectate(playerid, targetid) 
{
	TogglePlayerSpectating(playerid, 1);
    SetPlayerInterior(playerid, GetPlayerInterior(targetid));
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

	new vehicleid = GetPlayerVehicleID(targetid);
	if (vehicleid != 0) {
		PlayerSpectateVehicle(playerid, vehicleid, SPECTATE_MODE_NORMAL);
	}
	else {
	    PlayerSpectatePlayer(playerid, targetid, SPECTATE_MODE_NORMAL);
	}

   	SpectateID[playerid] = targetid;
    SpectateType[playerid] = (vehicleid != 0) ? SPECTATE_TYPE_VEHICLE : SPECTATE_TYPE_PLAYER;
    ShowSpectatorTextdraw(playerid, true);
	return 1;
}

StopSpectate(playerid) {
	TogglePlayerSpectating(playerid, 0);
	ShowSpectatorTextdraw(playerid, false);	
	//ReturnPlayerWeapons(playerid);
	return 1;
}

GetNextPlayer(current) {
	new next = -1;

	if (Iter_Count(SpectatePlayers) > 1) 
	{
		if (Iter_Contains(SpectatePlayers, current)) 
		{
			next = Iter_Next(SpectatePlayers, current);

			if (next == Iter_End(SpectatePlayers)) {
			    next = Iter_First(SpectatePlayers);
			}
		}
	}

	return next;
}

GetPreviousPlayer(current) {
	new prev = -1;

	if (Iter_Count(SpectatePlayers) > 1) 
	{
		if (Iter_Contains(SpectatePlayers, current)) {
			prev = Iter_Prev(SpectatePlayers, current);

			if (prev == Iter_Begin(SpectatePlayers)) {
			    prev = Iter_Last(SpectatePlayers);
			}
		}
	}

	return prev;
}
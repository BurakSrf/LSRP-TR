Drop_Nearest(playerid)
{
	foreach(new i : Drops) if(IsPlayerInRangeOfPoint(playerid, 1.5, DropData[i][DropLocation][0], DropData[i][DropLocation][1], DropData[i][DropLocation][2]))
 	{
		if (GetPlayerInterior(playerid) == DropData[i][DropInterior] && GetPlayerVirtualWorld(playerid) == DropData[i][DropWorld])
			return i;
	}
	return -1;
}
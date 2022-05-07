Server:Hud_Update(playerid, vehicleid)
{
	if(PlayerData[playerid][pHudStatus]) 
	{
		switch(PlayerData[playerid][pHudstyle])
		{
		    case 0:
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsABike(vehicleid) && vehicleid != g_aVehicleSpawned[playerid]) PlayerTextDrawSetString(playerid, Player_Hud[playerid][0], sprintf("KM/H: ~g~%i~n~~b~Yakit: ~g~%i~n~_~n~~b~Radyo Bilgi~n~Kanal: ~g~%i~n~~b~Slot: ~g~%i", floatround(GetVehicleSpeed(vehicleid)), floatround(CarData[vehicleid][carFuel]), PlayerData[playerid][pRadio][ PlayerData[playerid][pMainSlot] ], PlayerData[playerid][pMainSlot]));
		        else PlayerTextDrawSetString(playerid, Player_Hud[playerid][0], sprintf("Radyo Bilgi~n~Kanal: ~g~%i~n~~b~Slot: ~g~%i", PlayerData[playerid][pRadio][ PlayerData[playerid][pMainSlot] ], PlayerData[playerid][pMainSlot]));
		    }
		    case 1:
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsABike(vehicleid) && vehicleid != g_aVehicleSpawned[playerid]) PlayerTextDrawSetString(playerid, Player_Hud[playerid][1], sprintf("~g~%i__~r~%i__~w~%i", floatround(GetVehicleSpeed(vehicleid)), floatround(CarData[vehicleid][carFuel]), floatround(CarData[vehicleid][carMileage])));
				else PlayerTextDrawHide(playerid, Player_Hud[playerid][1]);
		    }
		    case 2:
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsABike(vehicleid) && vehicleid != g_aVehicleSpawned[playerid]) PlayerTextDrawSetString(playerid, Player_Hud[playerid][2], sprintf("%s_~r~%i_%i~y~KMH/~r~%i~y~MPH~n~~w~Kanal: ~y~%i~n~~w~Slot: ~y~%i", ReturnVehicleName(vehicleid), floatround(CarData[vehicleid][carFuel]), floatround(GetVehicleSpeed(vehicleid)), floatround(GetVehicleSpeed(vehicleid) * 0.6214), PlayerData[playerid][pRadio][ PlayerData[playerid][pMainSlot] ], PlayerData[playerid][pMainSlot]));
		        else PlayerTextDrawSetString(playerid, Player_Hud[playerid][2], sprintf("Kanal: ~y~%i~n~~w~Slot: ~y~%i", PlayerData[playerid][pRadio][ PlayerData[playerid][pMainSlot] ], PlayerData[playerid][pMainSlot]));
		    }
		    case 3:
		    {
		        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsABike(vehicleid) && vehicleid != g_aVehicleSpawned[playerid])
				{
					PlayerTextDrawShow(playerid, Player_Hud[playerid][3]); new Float: carhp; GetVehicleHealth(vehicleid, carhp);
			        PlayerTextDrawSetString(playerid,Player_Hud[playerid][3], sprintf("~l~%s~n~~w~%i   ~l~%i   ~w~%i   ~l~%i", ReturnVehicleName(vehicleid), floatround(CarData[vehicleid][carEngine]), floatround(CarData[vehicleid][carFuel]), floatround(carhp), floatround(GetVehicleSpeed(vehicleid))));
		        }
		        else PlayerTextDrawHide(playerid, Player_Hud[playerid][3]);
		    }
		    case 4:
		    {
		    	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && !IsABike(vehicleid) && vehicleid != g_aVehicleSpawned[playerid]) PlayerTextDrawSetString(playerid, Player_Hud[playerid][4], sprintf("KM/H: %i~n~Yakit: %i~n~_~n~Kanal: %i~n~Slot: %i", floatround(GetVehicleSpeed(vehicleid)), floatround(CarData[vehicleid][carFuel]), PlayerData[playerid][pRadio][ PlayerData[playerid][pMainSlot] ], PlayerData[playerid][pMainSlot]));
		        else PlayerTextDrawSetString(playerid, Player_Hud[playerid][4], sprintf("Kanal: %i~n~Slot: %i", PlayerData[playerid][pRadio][ PlayerData[playerid][pMainSlot] ], PlayerData[playerid][pMainSlot]));
		    }
		}
	}

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) CarData[vehicleid][carMileage] += (floatround(GetVehicleSpeed(vehicleid)) * 0.00009722222);
	return 1;
}

Street_Change(playerid)
{
	if(!PlayerData[playerid][pStreetStatus])
	{
		for(new i = 0; i < 7; i ++) PlayerTextDrawHide(playerid, Street_Hud[playerid][i]);
		return 1;
	}

	PlayerTextDrawShow(playerid, Street_Hud[playerid][PlayerData[playerid][pStreetstyle]]);
	return 1;
}

Street_Update(playerid, vehicleid)
{
	if(PlayerData[playerid][pStreetStatus]) 
	{
		if(IsPlayerInAnyVehicle(playerid)) 
		{
			new Float: rz, p_PreviousDirection[8];
			strcat((p_PreviousDirection[0] = EOS, p_PreviousDirection), PlayerDirection[playerid]);
			GetVehicleZAngle(vehicleid, rz);

			if(rz >= 348.75 || rz < 11.25) PlayerDirection[playerid] = "N";
			else if(rz >= 326.25 && rz < 348.75) PlayerDirection[playerid] = "NNE";
			else if(rz >= 303.75 && rz < 326.25) PlayerDirection[playerid] = "NE";
			else if(rz >= 281.25 && rz < 303.75) PlayerDirection[playerid] = "ENE";
			else if(rz >= 258.75 && rz < 281.25) PlayerDirection[playerid] = "E";
			else if(rz >= 236.25 && rz < 258.75) PlayerDirection[playerid] = "ESE";
			else if(rz >= 213.75 && rz < 236.25) PlayerDirection[playerid] = "SE";
			else if(rz >= 191.25 && rz < 213.75) PlayerDirection[playerid] = "SSE";
			else if(rz >= 168.75 && rz < 191.25) PlayerDirection[playerid] = "S";
			else if(rz >= 146.25 && rz < 168.75) PlayerDirection[playerid] = "SSW";
			else if(rz >= 123.25 && rz < 146.25) PlayerDirection[playerid] = "SW";
			else if(rz >= 101.25 && rz < 123.25) PlayerDirection[playerid] = "WSW";
			else if(rz >= 78.75 && rz < 101.25) PlayerDirection[playerid] = "W";
			else if(rz >= 56.25 && rz < 78.75) PlayerDirection[playerid] = "WNW";
			else if(rz >= 33.75 && rz < 56.25) PlayerDirection[playerid] = "NW";
			else if(rz >= 11.5 && rz < 33.75) PlayerDirection[playerid] = "NNW";
			// Credits to Pottus for the above.

			if(strcmp(p_PreviousDirection, PlayerDirection[playerid]))
				return 1;

			switch(PlayerData[playerid][pStreetstyle])
			{
				case 0, 2: PlayerTextDrawSetString(playerid, Street_Hud[playerid][PlayerData[playerid][pStreetstyle]], sprintf("~l~%s %s", PlayerDirection[playerid], GetPlayerStreet(playerid)));
				default: PlayerTextDrawSetString(playerid, Street_Hud[playerid][PlayerData[playerid][pStreetstyle]], sprintf("%s %s", PlayerDirection[playerid], GetPlayerStreet(playerid)));
			}
			PlayerTextDrawShow(playerid, Street_Hud[playerid][PlayerData[playerid][pStreetstyle]]);
		} 
		else PlayerTextDrawHide(playerid, Street_Hud[playerid][PlayerData[playerid][pStreetstyle]]);
	}
	return 1;
}

UI_Huds(playerid)
{
	Player_Hud[playerid][0] = CreatePlayerTextDraw(playerid, 547.000000, 114.000000, "_");
	PlayerTextDrawFont(playerid, Player_Hud[playerid][0], 3);
	PlayerTextDrawLetterSize(playerid, Player_Hud[playerid][0], 0.395833, 1.500000);
	PlayerTextDrawTextSize(playerid, Player_Hud[playerid][0], 376.000000, 99.000000);
	PlayerTextDrawSetOutline(playerid, Player_Hud[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, Player_Hud[playerid][0], 1);
	PlayerTextDrawAlignment(playerid, Player_Hud[playerid][0], 2);
	PlayerTextDrawColor(playerid, Player_Hud[playerid][0], 758542591);
	PlayerTextDrawBackgroundColor(playerid, Player_Hud[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, Player_Hud[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, Player_Hud[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, Player_Hud[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Hud[playerid][0], 0);

	Player_Hud[playerid][1] = CreatePlayerTextDraw(playerid, 497.000000, 101.000000, "_");
	PlayerTextDrawFont(playerid, Player_Hud[playerid][1], 3);
	PlayerTextDrawLetterSize(playerid, Player_Hud[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, Player_Hud[playerid][1], 633.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Player_Hud[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Player_Hud[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, Player_Hud[playerid][1], 1);
	PlayerTextDrawColor(playerid, Player_Hud[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, Player_Hud[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, Player_Hud[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, Player_Hud[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, Player_Hud[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Hud[playerid][1], 0);

	Player_Hud[playerid][2] = CreatePlayerTextDraw(playerid, 13.000000, 166.000000, "_");
	PlayerTextDrawFont(playerid, Player_Hud[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, Player_Hud[playerid][2], 0.341666, 1.750000);
	PlayerTextDrawTextSize(playerid, Player_Hud[playerid][2], 224.500000, 315.500000);
	PlayerTextDrawSetOutline(playerid, Player_Hud[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Player_Hud[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, Player_Hud[playerid][2], 1);
	PlayerTextDrawColor(playerid, Player_Hud[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, Player_Hud[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, Player_Hud[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, Player_Hud[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, Player_Hud[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Hud[playerid][2], 0);

	Player_Hud[playerid][3] = CreatePlayerTextDraw(playerid, 545.000000, 406.000000, "_");
	PlayerTextDrawFont(playerid, Player_Hud[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, Player_Hud[playerid][3], 0.395832, 1.899999);
	PlayerTextDrawTextSize(playerid, Player_Hud[playerid][3], 468.000000, 176.500000);
	PlayerTextDrawSetOutline(playerid, Player_Hud[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Player_Hud[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, Player_Hud[playerid][3], 2);
	PlayerTextDrawColor(playerid, Player_Hud[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, Player_Hud[playerid][3], 1296911871);
	PlayerTextDrawBoxColor(playerid, Player_Hud[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, Player_Hud[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, Player_Hud[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Hud[playerid][3], 0);

	Player_Hud[playerid][4] = CreatePlayerTextDraw(playerid, 560.000000, 349.000000, "_");
	PlayerTextDrawFont(playerid, Player_Hud[playerid][4], 3);
	PlayerTextDrawLetterSize(playerid, Player_Hud[playerid][4], 0.341666, 1.350000);
	PlayerTextDrawTextSize(playerid, Player_Hud[playerid][4], 657.500000, 129.500000);
	PlayerTextDrawSetOutline(playerid, Player_Hud[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, Player_Hud[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, Player_Hud[playerid][4], 2);
	PlayerTextDrawColor(playerid, Player_Hud[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, Player_Hud[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, Player_Hud[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, Player_Hud[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, Player_Hud[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, Player_Hud[playerid][4], 0);
	return 1;
}

UI_StreetHuds(playerid)
{
	Street_Hud[playerid][0] = CreatePlayerTextDraw(playerid, 457.000000, 429.000000, "~l~N Market Street");
	PlayerTextDrawFont(playerid, Street_Hud[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, Street_Hud[playerid][0], 0.241666, 1.550000);
	PlayerTextDrawTextSize(playerid, Street_Hud[playerid][0], 614.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Street_Hud[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, Street_Hud[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Street_Hud[playerid][0], 1);
	PlayerTextDrawColor(playerid, Street_Hud[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Street_Hud[playerid][0], -1094795521);
	PlayerTextDrawBoxColor(playerid, Street_Hud[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, Street_Hud[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, Street_Hud[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Street_Hud[playerid][0], 0);

	Street_Hud[playerid][1] = CreatePlayerTextDraw(playerid, 26.000000, 425.000000, "N Market Street");
	PlayerTextDrawFont(playerid, Street_Hud[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, Street_Hud[playerid][1], 0.220833, 1.500000);
	PlayerTextDrawTextSize(playerid, Street_Hud[playerid][1], 198.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Street_Hud[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Street_Hud[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, Street_Hud[playerid][1], 1);
	PlayerTextDrawColor(playerid, Street_Hud[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, Street_Hud[playerid][1], 1296911871);
	PlayerTextDrawBoxColor(playerid, Street_Hud[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, Street_Hud[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, Street_Hud[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Street_Hud[playerid][1], 0);

	Street_Hud[playerid][2] = CreatePlayerTextDraw(playerid, 257.000000, 12.000000, " ~l~N Market Street");
	PlayerTextDrawFont(playerid, Street_Hud[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, Street_Hud[playerid][2], 0.241666, 1.500000);
	PlayerTextDrawTextSize(playerid, Street_Hud[playerid][2], 614.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Street_Hud[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Street_Hud[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, Street_Hud[playerid][2], 1);
	PlayerTextDrawColor(playerid, Street_Hud[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, Street_Hud[playerid][2], -1094795521);
	PlayerTextDrawBoxColor(playerid, Street_Hud[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, Street_Hud[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, Street_Hud[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, Street_Hud[playerid][2], 0);

	Street_Hud[playerid][3] = CreatePlayerTextDraw(playerid, 508.000000, 105.000000, "N Market Street");
	PlayerTextDrawFont(playerid, Street_Hud[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, Street_Hud[playerid][3], 0.195833, 1.250001);
	PlayerTextDrawTextSize(playerid, Street_Hud[playerid][3], 653.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Street_Hud[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, Street_Hud[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, Street_Hud[playerid][3], 1);
	PlayerTextDrawColor(playerid, Street_Hud[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, Street_Hud[playerid][3], 1296911871);
	PlayerTextDrawBoxColor(playerid, Street_Hud[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, Street_Hud[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, Street_Hud[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, Street_Hud[playerid][3], 0);

	Street_Hud[playerid][4] = CreatePlayerTextDraw(playerid, 33.000000, 303.000000, "N Market Street");
	PlayerTextDrawFont(playerid, Street_Hud[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, Street_Hud[playerid][4], 0.195833, 1.250001);
	PlayerTextDrawTextSize(playerid, Street_Hud[playerid][4], 653.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Street_Hud[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, Street_Hud[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, Street_Hud[playerid][4], 1);
	PlayerTextDrawColor(playerid, Street_Hud[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, Street_Hud[playerid][4], 1296911871);
	PlayerTextDrawBoxColor(playerid, Street_Hud[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, Street_Hud[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, Street_Hud[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, Street_Hud[playerid][4], 0);

	Street_Hud[playerid][5] = CreatePlayerTextDraw(playerid, 33.000000, 433.000000, "N Market Street");
	PlayerTextDrawFont(playerid, Street_Hud[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid, Street_Hud[playerid][5], 0.195833, 1.250001);
	PlayerTextDrawTextSize(playerid, Street_Hud[playerid][5], 653.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Street_Hud[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, Street_Hud[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, Street_Hud[playerid][5], 1);
	PlayerTextDrawColor(playerid, Street_Hud[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, Street_Hud[playerid][5], 1296911871);
	PlayerTextDrawBoxColor(playerid, Street_Hud[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, Street_Hud[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, Street_Hud[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, Street_Hud[playerid][5], 0);

	Street_Hud[playerid][6] = CreatePlayerTextDraw(playerid, 13.000000, 166.000000, "N Market Street");
	PlayerTextDrawFont(playerid, Street_Hud[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, Street_Hud[playerid][6], 0.341666, 1.750000);
	PlayerTextDrawTextSize(playerid, Street_Hud[playerid][6], 224.500000, 315.500000);
	PlayerTextDrawSetOutline(playerid, Street_Hud[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, Street_Hud[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, Street_Hud[playerid][6], 1);
	PlayerTextDrawColor(playerid, Street_Hud[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, Street_Hud[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, Street_Hud[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, Street_Hud[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, Street_Hud[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, Street_Hud[playerid][6], 0);
	return 1;
}

Hud_Change(playerid)
{
	if(!PlayerData[playerid][pHudStatus])
	{
		for(new i = 0; i < 5; i ++) PlayerTextDrawHide(playerid, Player_Hud[playerid][i]);
		return 1;
	}

	PlayerTextDrawShow(playerid, Player_Hud[playerid][PlayerData[playerid][pHudstyle]]);
	return 1;
}
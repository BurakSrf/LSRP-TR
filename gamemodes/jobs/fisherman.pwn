new Float:BoatCP[18][3] = {
	{60.2717,-2082.1567,-0.0762},
	{-27.3791,-2002.3693,-0.2581},
	{-113.7512,-2001.2771,-0.3227},
	{-94.7858,-1832.2515,-0.1204},
	{-10.9787,-1831.6937,-0.1850},
	{188.3772,-2075.5259,-0.0510},
	{136.4065,-2186.1221,-0.4349},
	{81.7984,-2345.2961,0.0240},
	{196.3303,-2435.1675,-0.2457},
	{325.3835,-2421.8608,-0.4293},
	{389.9152,-2328.5454,-0.1746},
	{367.0452,-2211.3184,-0.1155},
	{324.4887,-2159.2317,-0.2469},
	{9.7860,-1992.6770,-0.3811},
	{2.0233,-1893.1060,-0.0813},
	{-22.4129,-1845.0417,-0.2385},
	{-63.5448,-1786.5829,-0.3937},
	{-7.9743,-1729.3959,-0.3212}
};

#define MAX_FISH_TYPES  7

enum 	e_boat_fish
{
    FishName[20],
    FishMinWeight,
    FishMaxWeight,
    FishChance
}

new FishData[MAX_FISH_TYPES][e_boat_fish] = 
{
	{"Kalkan Balýðý",	1, 4,	85},
	{"Sazan Balýðý",	1, 4,	75},
    {"Müren Balýðý",    1, 7, 	65},
    {"Somon Balýðý",    2, 6,   50},
    {"Tuna Balýðý",		1, 3,	30},
    {"Köpekbalýðý",		7, 15,	20},
    {"Kýlýçbalýðý", 	6, 12,	10}
};

CatchFishOnBoat()
{
    new rnd = randomEx(10, 87), value = -1;
    for(new i; i < MAX_FISH_TYPES; i++)
    {
        if(FishData[i][FishChance] > rnd)
        {
            value = i;
        }
    }
    return value;
}

CatchFish()
{
    new rnd = randomEx(30, 110),  value = -1;
    for(new i; i < MAX_FISH_TYPES; i++)
    {
        if(FishData[i][FishChance] > rnd)
        {
            value = i;
        }
    }
    return value;
}

IsABoat(vehicleid)
{
    new modelid = GetVehicleModel(vehicleid);

	switch(modelid)
	{
	    case 473: return 1;
	}

    return 0;
}

CMD:balikgit(playerid, params[])
{
	if(PlayerData[playerid][pDrivingTest]) return SendServerMessage(playerid, "Ehliyet sýnavýndayken bu komutu kullanamazsýn.");
	if(PlayerData[playerid][pTaxiDrivingTest]) return SendServerMessage(playerid, "Taksi sýnavýndayken bu komutu kullanamazsýn.");

	new id;
	if(sscanf(params, "i", id)) return SendUsageMessage(playerid, "/balikgit [1(bot)/2(iskele)]");

	switch(id)
	{
		case 1: SetPlayerCheckpoint(playerid, 154.302, -1944.67, 4.17844, 3.0);
		case 2: SetPlayerCheckpoint(playerid, 403.8266, -2088.7598, 7.8359, 3.0);
		default: SendUsageMessage(playerid, "/balikgit [1(bot)/2(iskele)]");
	}
	return 1;
}

CMD:balikyardim(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "______________________________________________");
	SendClientMessage(playerid, COLOR_WHITE, "/balikgit /baliktut /baliksat /baliklarim");
	return 1;
}

CMD:baliktut(playerid, params[])
{
	if(!IsPlayerAtFishingPlace(playerid) && !IsABoat(GetPlayerVehicleID(playerid))) 
		return SendErrorMessage(playerid, "Burada balýk tutamazsýnýz.");

	if(PlayerData[playerid][pFishTime] > 0) 
		return SendClientMessage(playerid, COLOR_WHITE, "((Lütfen /baliktut komutunu 6 saniyede bir kullanýn.))");

	if(PlayerData[playerid][pFishCheckpoint])
		return SendInfoMessage(playerid, "Haritada iþaretlenmiþ olan kýrmýzý noktaya ilerle.");

	if(IsABoat(GetPlayerVehicleID(playerid)))
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Balýk tutabilmek için botun þoför koltuðunda olmalýsýn.");
		if(!CarEngine[GetPlayerVehicleID(playerid)]) return SendErrorMessage(playerid, "Ýlk önce botun motorunu açmalýsýn.");
		if(PlayerData[playerid][pFishWeight] >= 2500) return SendErrorMessage(playerid, "Botta 2,500 kgden fazla balýk tutamazsýn.");

		new rand = random(sizeof(BoatCP));
		SetPlayerRaceCheckpoint(playerid, 1, BoatCP[rand][0], BoatCP[rand][1], BoatCP[rand][2], 0.0, 0.0, 0.0, 8.0);
		PlayerData[playerid][pFishCheckpoint] = 1;
	}
	else 
	{
		if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid, COLOR_GREY, "Balýk tutabilmek için araçtan inmelisin.");
		if(PlayerData[playerid][pFishWeight] >= 450) return SendErrorMessage(playerid, "Üzerinde 450 kgden fazla balýk taþýyamazsýn.");

		ApplyAnimation(playerid, "SAMP", "FishingIdle", 4.1, 0, 0, 0, 1, 0, 1);
		SetPlayerAttachedObject(playerid, 9, 18632, 6, 0.112999, 0.024000, 0.000000, -172.999954, 28.499994, 0.000000);
		cmd_ame(playerid, "oltasýný suyun derinliklerine doðru sallar.");
		TogglePlayerControllable(playerid, 0);
		PlayerData[playerid][pFishTime] = 6;
	}
	return 1;
}

CMD:baliksat(playerid, params[])
{
	if(PlayerData[playerid][pFishTime] > 0) return SendErrorMessage(playerid, "Balýk tutarken bu komutu kullanamazsýn.");
	if(PlayerData[playerid][pDrivingTest]) return SendServerMessage(playerid, "Ehliyet sýnavýndayken bu komutu kullanamazsýn."); 

	if(!IsPlayerInRangeOfPoint(playerid, 5.0, 2475.6350,-2709.6445,3.0000))
    {
 		SetPlayerCheckpoint(playerid, 2475.6350,-2709.6445,3.0000, 3.0);
 	   	return SendInfoMessage(playerid, "Balýk satma noktasý iþaretlendi.");
	}

	if(!PlayerData[playerid][pFishWeight]) return SendErrorMessage(playerid, "Satabilecek balýðýn kalmamýþ.");

	new amount = PlayerData[playerid][pFishWeight] * randomEx(5, 6);

	GameTextForPlayer(playerid, sprintf("~p~%i KILO BALIK SATTIN~n~~w~$%i", PlayerData[playerid][pFishWeight], amount), 3000, 4);
	GiveMoney(playerid, amount);
	PlayerData[playerid][pFishWeight] = 0;
	return 1;
}

CMD:baliklarim(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "_________________________");
	SendClientMessageEx(playerid, COLOR_WHITE, "Balýklarýn aðýrlýðý:[%i] kg", PlayerData[playerid][pFishWeight]);
	return 1;
}

IsPlayerAtFishingPlace(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 1.0, 403.8266, -2088.7598, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 398.7553, -2088.7490, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 396.2197, -2088.6692, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 391.1094, -2088.7976, 7.8359)) {
		return 1;
	} else if(IsPlayerInRangeOfPoint(playerid, 1.0, 383.4157, -2088.7849, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 374.9598, -2088.7979, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 369.8107, -2088.7927, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 367.3637, -2088.7925, 7.8359)) {
	    return 1;
	} else if(IsPlayerInRangeOfPoint(playerid, 1.0, 362.2244, -2088.7981, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 354.5382, -2088.7979, 7.8359)) {
	    return 1;
	}

	return 0;
}
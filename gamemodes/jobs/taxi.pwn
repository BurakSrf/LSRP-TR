Server:OnTaxiCall(playerid)
{
	SendClientMessage(playerid, COLOR_GREY, "[!] �a�r� cevapland�.");
	TaxiCallTimer[playerid] = SetTimerEx("OnTaxiCallPickup", 1500, false, "i", playerid);
	return 1;
}

Server:OnTaxiCallPickup(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, "Taksi Operat�r� (telefon): Merhabalar, nereye gitmek istersiniz?");
	PlayerData[playerid][pCalling] = 0;
	return 1;
}

CMD:taksi(playerid, params[])
{
	new
		str_a[30], str_b[30];

	if(sscanf(params, "s[30]S()[30]", str_a, str_b))
	{
		SendClientMessage(playerid, COLOR_YELLOW, "KULLANIM: /taksi [parametre]");
		SendClientMessage(playerid, COLOR_WHITE, "KONTROL |");
		SendClientMessage(playerid, COLOR_WHITE, "TARIFE | BITIR | KABUL");
		SendClientMessage(playerid, COLOR_WHITE, "ISBASI | BASLA");
		SendClientMessage(playerid, COLOR_WHITE, "�PUCU: Taksimetrenin durmas� size otomatik para gelece�i anlam�na gelmez.");
		return 1;
	}

	if(!strcmp(str_a, "kontrol"))
	{
		new id;
		if(sscanf(str_b, "u", id)) {
			SendClientMessage(playerid, COLOR_YELLOW, "KULLANIM: /taksi kontrol [oyuncu ID/ad�]");
			SendClientMessage(playerid, COLOR_WHITE, "�PUCU: Bu komutla taksicinin tarifesini ��renebilirsin.");
			return 1;
		}

		if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
		if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
		if(!StartedTaxiJob[id]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i i�ba��nda g�z�km�yor.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "-> %s isimli taksicinin tarifesi: $%i/saniye", ReturnName(id), TaxiFair[id]);
		return 1;
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	if(PlayerData[playerid][pSideJob] != TAXI_JOB && PlayerData[playerid][pJob] != TAXI_JOB) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Taksi �of�r� de�ilsin.");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Herhangi bir ara� i�erisinde de�ilsin.");
	if(!IsTaxi(vehicleid)) return SendErrorMessage(playerid, "Takside i�erisinde olman gerekiyor.");

	if(!strcmp(str_a, "basla"))
	{
		new anyPlayers = 0;
		if(!StartedTaxiJob[playerid]) return SendClientMessage(playerid, COLOR_YELLOW, "-> /taksi isbasi yazmal�s�n.");
		if(TaxiFairStarted[playerid]) return SendClientMessage(playerid, COLOR_YELLOW, "-> Tarifen aktif ilk �nce kapat.");

		foreach (new i : Player)
		{
			if(i == playerid)
				continue;

			if(IsPlayerInVehicle(i, vehicleid))
			{
				anyPlayers++;

				InTaxiRide[i] = 1;
				TaxiDriver[i] = PlayerData[playerid][pSQLID];

				TaxiDuration[i] = gettime();
				TaxiPrice[i] = 0;

				for(new c = 0; c < 5; c++) PlayerTextDrawShow(i, TaxiFair_PTD[playerid][c]);
				TaxiDurationTimer[i] = SetTimerEx("UpdateTaxiDuration", 1000, true, "i", i);
				SendClientMessageEx(i, COLOR_YELLOW, "-> Taksi �of�r� %s tarifeyi ba�latt�. (Tarife: $%i/saniye)", ReturnName(playerid, 0), TaxiFair[playerid]);
			}
		}

		if(!anyPlayers) return SendClientMessage(playerid, COLOR_YELLOW, "-> Taksinde kimse yok, tarife ba�latamazs�n.");

		TaxiDriverTimer[playerid] = SetTimerEx("OnTaxiFair", 1000, true, "i", playerid);
		TaxiFairStarted[playerid] = 1;
		TaxiDuration[playerid] = gettime();
		TaxiTotalFair[playerid] = 0;

		for(new f = 0; f < 5; f++) PlayerTextDrawShow(playerid, TaxiFair_PTD[playerid][f]);
	}
	else if(!strcmp(str_a, "kabul"))
	{
		if(!StartedTaxiJob[playerid]) return SendClientMessage(playerid, COLOR_YELLOW, "-> /taksi isbasi yazmal�s�n.");

		new ph;
		if(sscanf(str_b, "i", ph)) return SendClientMessage(playerid, COLOR_YELLOW, "KULLANIM: /taksi kabul [telefon numaras�]");
		
		new id = IsValidNumber(ph);
		if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_ADM, "Hatal� telefon numaras� girdiniz.");
		if(GetPVarInt(id, "NeedTaxi") == 0) return SendClientMessage(playerid, COLOR_ADM, "Bu �a�r� yan�tlanm�� veya �uanda ihtiyac� yok.");
	
		SendClientMessageEx(id, COLOR_YELLOW, "%s taksi �a�r�n� cevaplad�, sana do�ru geliyor. Tarifesi: $%i/saniye", ReturnName(playerid, 0), TaxiFair[playerid]);
		SendClientMessage(playerid, COLOR_WHITE, "Taksi �a�r�s�na ilk sen cevap verdin!");

		SendClientMessage(playerid, COLOR_YELLOW, "|_______________Taksi �a�r�s�_______________|");
		SendClientMessageEx(playerid, COLOR_YELLOW, "Arayan: %i", ReturnPhoneNumber(id));
		SendClientMessageEx(playerid, COLOR_YELLOW, "Lokasyon: %s", Player_GetLocation(id));
		SendClientMessageEx(playerid, COLOR_YELLOW, "Gidece�i Yer: %s", TaxiText[id]);

		format(TaxiText[id], 128, "");
		SetPVarInt(id, "NeedTaxi", 0);
	}
	else if(!strcmp(str_a, "bitir"))
	{
		if(!TaxiFairStarted[playerid]) return SendClientMessage(playerid, COLOR_YELLOW, "-> Tarifeyi ba�latmadan bitiremezsin.");

		foreach(new i : Player)
		{
			if(InTaxiRide[i] && TaxiDriver[i] == PlayerData[playerid][pSQLID])
			{
				EndTaxiFair(i);
				SendClientMessage(i, COLOR_YELLOW, "-> Taksi �of�r�n tarifeyi kapatt�.");
			}
		}

		EndTaxiFairDriver(playerid);
		SendClientMessage(playerid, COLOR_YELLOW, "-> Tarifen sona erdi.");
	}
	else if(!strcmp(str_a, "tarife"))
	{
		new
			price;

		if(sscanf(str_b, "i", price))
		{
			SendClientMessage(playerid, COLOR_ADM, "KULLANIM: /taksi tarife [$(1-25)]");
			SendClientMessageEx(playerid, COLOR_ADM, "[!] �u anki tarifen: $%i", TaxiFair[playerid]);
			return 1;
		}

		if(price < 1 || price > 25) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Miktar $1 - $25 aras�nda olmal�.");
		if(TaxiFairStarted[playerid]) return SendClientMessage(playerid, COLOR_ADM, "SERVER: �lk ba�ta aktif olan tarifeni kapat.");

		TaxiFair[playerid] = price;
		SendClientMessageEx(playerid, COLOR_YELLOW, "-> Tarifeni $%d olarak ayarlad�n.", price);
	}
	else if(!strcmp(str_a, "isbasi"))
	{
		if(StartedTaxiJob[playerid])
		{
			if(!PlayerData[playerid][pTesterDuty] && !PlayerData[playerid][pAdminDuty])
				SetPlayerColor(playerid, COLOR_WHITE);

			StartedTaxiJob[playerid] = false;
			SendClientMessage(playerid, COLOR_YELLOW, "-> Taksi i�ba��n� kapatt�n.");
		}
		else
		{
			if(!PlayerData[playerid][pTesterDuty] && !PlayerData[playerid][pAdminDuty])
				SetPlayerColor(playerid, COLOR_TAXIDUTY);

			StartedTaxiJob[playerid] = true;

			SendClientMessageEx(playerid, COLOR_YELLOW, "-> Taksi i�ba��n� a�t�n. (Tarife: $%i)", TaxiFair[playerid]);
		}
	}
	else return SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Hatal� parametre girdiniz.");
	return 1;
}

Server:UpdateTaxiDuration(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) {
		EndTaxiFair(playerid);
	}
	else
	{
		new
			driver;

		foreach(new i : Player) if(PlayerData[i][pSQLID] == TaxiDriver[playerid])
			driver = i;
		

		TaxiPrice[playerid]+= TaxiFair[driver];
		TaxiTotalFair[driver]+= TaxiFair[driver];

		new
			updateStr[90];

		format(updateStr, 90, "%i saniye", gettime() - TaxiDuration[playerid]);
		PlayerTextDrawSetString(playerid, TaxiFair_PTD[playerid][2], updateStr);

		format(updateStr, 90, " $%s", MoneyFormat(TaxiPrice[playerid]));
		PlayerTextDrawSetString(playerid, TaxiFair_PTD[playerid][4], updateStr);

		for(new i = 0; i < 5; i++) PlayerTextDrawShow(playerid, TaxiFair_PTD[playerid][i]);
	}
	return 1;
}

Server:OnTaxiFair(playerid)
{
	new
		updateStr[90],
		hasRiders = false;

	foreach(new i : Player)
	{
		if(i == playerid)
			continue;

		if(IsPlayerInVehicle(i, GetPlayerVehicleID(playerid)) && TaxiDriver[i] == PlayerData[playerid][pSQLID])
		{
			hasRiders = true;
		}
	}

	if(!hasRiders)
	{
		EndTaxiFairDriver(playerid);
		return 1;
	}

	if(!IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i : Player) if(TaxiDriver[i] == PlayerData[playerid][pSQLID])
		{
			SendClientMessage(i, COLOR_YELLOW, "-> Taksi �of�r� arac� terketti, tarifen sonra erdi.");
			EndTaxiFair(i);
		}

		SendClientMessage(playerid, COLOR_YELLOW, "-> Ara�tan ��karak tarifeyi sona erdirdin.");
		EndTaxiFairDriver(playerid);
		return 1;
	}

	format(updateStr, 90, "%i saniye", gettime() - TaxiDuration[playerid]);
	PlayerTextDrawSetString(playerid, TaxiFair_PTD[playerid][2], updateStr);

	format(updateStr, 90, " $%s", MoneyFormat(TaxiTotalFair[playerid]));
	PlayerTextDrawSetString(playerid, TaxiFair_PTD[playerid][4], updateStr);

	for(new i = 0; i < 5; i++) PlayerTextDrawShow(playerid, TaxiFair_PTD[playerid][i]);
	return 1;
}

stock EndTaxiFairDriver(playerid)
{
	for(new i = 0; i < 5; i++) PlayerTextDrawHide(playerid, TaxiFair_PTD[playerid][i]);

	KillTimer(TaxiDriverTimer[playerid]);

	TaxiFairStarted[playerid] = 0;
	TaxiDuration[playerid] = 0;
	TaxiTotalFair[playerid] = 0;
	return 1;
}

stock EndTaxiFair(playerid)
{
	for(new i = 0; i < 5; i++) PlayerTextDrawHide(playerid, TaxiFair_PTD[playerid][i]);

	InTaxiRide[playerid] = 0;
	TaxiDuration[playerid] = 0;

	//new
	//	foundDriver;

	foreach(new i : Player)
	{
		if(PlayerData[i][pSQLID] == TaxiDriver[playerid])
		{
			//foundDriver = 1;
			//GiveMoney(i, TaxiPrice[playerid]);
			//GiveMoney(playerid, -TaxiPrice[playerid]);
			EndTaxiFairDriver(i);
		}
	}

	//if(!foundDriver) GiveMoney(playerid, -TaxiPrice[playerid]);

	KillTimer(TaxiDurationTimer[playerid]);

	TaxiDriver[playerid] = 0;
	TaxiPrice[playerid] = 0;
	return 1;
}
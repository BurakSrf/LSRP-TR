Server:OnTaxiCall(playerid)
{
	SendClientMessage(playerid, COLOR_GREY, "[!] Çaðrý cevaplandý.");
	TaxiCallTimer[playerid] = SetTimerEx("OnTaxiCallPickup", 1500, false, "i", playerid);
	return 1;
}

Server:OnTaxiCallPickup(playerid)
{
	SendClientMessage(playerid, COLOR_YELLOW, "Taksi Operatörü (telefon): Merhabalar, nereye gitmek istersiniz?");
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
		SendClientMessage(playerid, COLOR_WHITE, "ÝPUCU: Taksimetrenin durmasý size otomatik para geleceði anlamýna gelmez.");
		return 1;
	}

	if(!strcmp(str_a, "kontrol"))
	{
		new id;
		if(sscanf(str_b, "u", id)) {
			SendClientMessage(playerid, COLOR_YELLOW, "KULLANIM: /taksi kontrol [oyuncu ID/adý]");
			SendClientMessage(playerid, COLOR_WHITE, "ÝPUCU: Bu komutla taksicinin tarifesini öðrenebilirsin.");
			return 1;
		}

		if(!IsPlayerConnected(id)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
		if(!pLoggedIn[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
		if(!StartedTaxiJob[id]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi iþbaþýnda gözükmüyor.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "-> %s isimli taksicinin tarifesi: $%i/saniye", ReturnName(id), TaxiFair[id]);
		return 1;
	}

	new vehicleid = GetPlayerVehicleID(playerid);
	if(PlayerData[playerid][pSideJob] != TAXI_JOB && PlayerData[playerid][pJob] != TAXI_JOB) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Taksi þoförü deðilsin.");
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendErrorMessage(playerid, "Herhangi bir araç içerisinde deðilsin.");
	if(!IsTaxi(vehicleid)) return SendErrorMessage(playerid, "Takside içerisinde olman gerekiyor.");

	if(!strcmp(str_a, "basla"))
	{
		new anyPlayers = 0;
		if(!StartedTaxiJob[playerid]) return SendClientMessage(playerid, COLOR_YELLOW, "-> /taksi isbasi yazmalýsýn.");
		if(TaxiFairStarted[playerid]) return SendClientMessage(playerid, COLOR_YELLOW, "-> Tarifen aktif ilk önce kapat.");

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
				SendClientMessageEx(i, COLOR_YELLOW, "-> Taksi þoförü %s tarifeyi baþlattý. (Tarife: $%i/saniye)", ReturnName(playerid, 0), TaxiFair[playerid]);
			}
		}

		if(!anyPlayers) return SendClientMessage(playerid, COLOR_YELLOW, "-> Taksinde kimse yok, tarife baþlatamazsýn.");

		TaxiDriverTimer[playerid] = SetTimerEx("OnTaxiFair", 1000, true, "i", playerid);
		TaxiFairStarted[playerid] = 1;
		TaxiDuration[playerid] = gettime();
		TaxiTotalFair[playerid] = 0;

		for(new f = 0; f < 5; f++) PlayerTextDrawShow(playerid, TaxiFair_PTD[playerid][f]);
	}
	else if(!strcmp(str_a, "kabul"))
	{
		if(!StartedTaxiJob[playerid]) return SendClientMessage(playerid, COLOR_YELLOW, "-> /taksi isbasi yazmalýsýn.");

		new ph;
		if(sscanf(str_b, "i", ph)) return SendClientMessage(playerid, COLOR_YELLOW, "KULLANIM: /taksi kabul [telefon numarasý]");
		
		new id = IsValidNumber(ph);
		if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_ADM, "Hatalý telefon numarasý girdiniz.");
		if(GetPVarInt(id, "NeedTaxi") == 0) return SendClientMessage(playerid, COLOR_ADM, "Bu çaðrý yanýtlanmýþ veya þuanda ihtiyacý yok.");
	
		SendClientMessageEx(id, COLOR_YELLOW, "%s taksi çaðrýný cevapladý, sana doðru geliyor. Tarifesi: $%i/saniye", ReturnName(playerid, 0), TaxiFair[playerid]);
		SendClientMessage(playerid, COLOR_WHITE, "Taksi çaðrýsýna ilk sen cevap verdin!");

		SendClientMessage(playerid, COLOR_YELLOW, "|_______________Taksi Çaðrýsý_______________|");
		SendClientMessageEx(playerid, COLOR_YELLOW, "Arayan: %i", ReturnPhoneNumber(id));
		SendClientMessageEx(playerid, COLOR_YELLOW, "Lokasyon: %s", Player_GetLocation(id));
		SendClientMessageEx(playerid, COLOR_YELLOW, "Gideceði Yer: %s", TaxiText[id]);

		format(TaxiText[id], 128, "");
		SetPVarInt(id, "NeedTaxi", 0);
	}
	else if(!strcmp(str_a, "bitir"))
	{
		if(!TaxiFairStarted[playerid]) return SendClientMessage(playerid, COLOR_YELLOW, "-> Tarifeyi baþlatmadan bitiremezsin.");

		foreach(new i : Player)
		{
			if(InTaxiRide[i] && TaxiDriver[i] == PlayerData[playerid][pSQLID])
			{
				EndTaxiFair(i);
				SendClientMessage(i, COLOR_YELLOW, "-> Taksi þoförün tarifeyi kapattý.");
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
			SendClientMessageEx(playerid, COLOR_ADM, "[!] Þu anki tarifen: $%i", TaxiFair[playerid]);
			return 1;
		}

		if(price < 1 || price > 25) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Miktar $1 - $25 arasýnda olmalý.");
		if(TaxiFairStarted[playerid]) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Ýlk baþta aktif olan tarifeni kapat.");

		TaxiFair[playerid] = price;
		SendClientMessageEx(playerid, COLOR_YELLOW, "-> Tarifeni $%d olarak ayarladýn.", price);
	}
	else if(!strcmp(str_a, "isbasi"))
	{
		if(StartedTaxiJob[playerid])
		{
			if(!PlayerData[playerid][pTesterDuty] && !PlayerData[playerid][pAdminDuty])
				SetPlayerColor(playerid, COLOR_WHITE);

			StartedTaxiJob[playerid] = false;
			SendClientMessage(playerid, COLOR_YELLOW, "-> Taksi iþbaþýný kapattýn.");
		}
		else
		{
			if(!PlayerData[playerid][pTesterDuty] && !PlayerData[playerid][pAdminDuty])
				SetPlayerColor(playerid, COLOR_TAXIDUTY);

			StartedTaxiJob[playerid] = true;

			SendClientMessageEx(playerid, COLOR_YELLOW, "-> Taksi iþbaþýný açtýn. (Tarife: $%i)", TaxiFair[playerid]);
		}
	}
	else return SendClientMessage(playerid, COLOR_YELLOW, "SERVER: Hatalý parametre girdiniz.");
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
			SendClientMessage(i, COLOR_YELLOW, "-> Taksi þoförü aracý terketti, tarifen sonra erdi.");
			EndTaxiFair(i);
		}

		SendClientMessage(playerid, COLOR_YELLOW, "-> Araçtan çýkarak tarifeyi sona erdirdin.");
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
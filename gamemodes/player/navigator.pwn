CMD:samaps(playerid, params[])
{
	if(!IsPlayerInAnyVehicle(playerid)) return SendErrorMessage(playerid, "Herhangi bir ara� i�erisinde de�ilsin.");
	if(GetPlayerVehicleSeat(playerid) > 1) return SendErrorMessage(playerid, "Arka koltukta bu komutu kullanamazs�n.");
	if(PlayerData[playerid][pDrivingTest]) return SendServerMessage(playerid, "Ehliyet s�nav�ndayken bu komutu kullanamazs�n."); 
	if(PlayerData[playerid][pTaxiDrivingTest]) return SendServerMessage(playerid, "Taksi s�nav�ndayken bu komutu kullanamazs�n."); 

	new primary_str[200];
	strcat(primary_str, "Sokak Bul\n");
	strcat(primary_str, "Ev Bul\n");
	strcat(primary_str, "En Yak�n Benzin �stasyonu\n");
	strcat(primary_str, "En Yak�n 24/7\n");
	strcat(primary_str, "En Yak�n Bar/Kul�p\n");
	strcat(primary_str, "En Yak�n Restaurant\n");
	strcat(primary_str, "T�m ��yerleri\n");
	strcat(primary_str, "�nemli Noktalar\n");
	Dialog_Show(playerid, GPS_MAIN, DIALOG_STYLE_LIST, "SA Maps - Ana Men�", primary_str, "�leri", "Kapat");
	return 1;
}

Dialog:GPS_MAIN(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		ShowNavigatorSys(playerid, listitem);
		return 1;
	}
	return 1;
}

ShowNavigatorSys(playerid, panel, error[] = "")
{
	new
		string[330];

	switch(panel)
	{
		case 0: //sokak
		{
			if(isnull(error)) string = "Bulmaya �al��t���n�z soka��n ad�n� girin.";
			else format(string, sizeof(string), "%s\n\nBulmaya �al��t���n�z soka��n ad�n� girin.", error);
			Dialog_Show(playerid, GPS_STREET, DIALOG_STYLE_INPUT, "SA Maps - Sokak Bul", string, "�leri", "Geri");
		}
		case 1: //ev kap� no
		{
			if(isnull(error)) format(string, sizeof(string), "Bulmaya �al��t���n�z evin kap� numaras�n� girin. (�rne�in: %i)", randomEx(1, 2000));
			else format(string, sizeof(string), "%s\n\nBulmaya �al��t���n�z evin kap� numaras�n� girin. (�rne�in: %i)", error, strlen(PropertyNameHolder[playerid]) > 0 ? strval(PropertyNameHolder[playerid]) : randomEx(1, 2000));
			Dialog_Show(playerid, GPS_PROPERTY_NO, DIALOG_STYLE_INPUT, "SA Maps - Ev Bul", string, "�leri", "Geri");
		}
		case 2: // benzinlik
		{
			new id = Business_Closest(playerid, BUSINESS_GASSTATION);
			if (id != -1)
			{
				SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritan�zda i�aretlendi.", BusinessData[id][BusinessName]);
			    SetPlayerCheckpoint(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], 5.0);
			}
			else SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yak�n�n�zda benzinlik bulunamad�.");
		}
		case 3: // 24/7
		{
			new id = Business_Closest(playerid, BUSINESS_STORE || BUSINESS_GENERAL);
			if (id != -1)
			{
				SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritan�zda i�aretlendi.", BusinessData[id][BusinessName]);
			    SetPlayerCheckpoint(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], 5.0);
			}
			else SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yak�n�n�zda 24/7 bulunamad�.");
		}
		case 4: // Bar/Kul�p
		{
			new id = Business_Closest(playerid, BUSINESS_CLUB);
			if (id != -1)
			{
				SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritan�zda i�aretlendi.", BusinessData[id][BusinessName]);
			    SetPlayerCheckpoint(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], 5.0);
			}
			else SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yak�n�n�zda bar/kul�p bulunamad�.");
		}
		case 5: // Restaurant
		{
			new id = Business_Closest(playerid, BUSINESS_RESTAURANT);
			if (id != -1)
			{
				SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritan�zda i�aretlendi.", BusinessData[id][BusinessName]);
			    SetPlayerCheckpoint(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], 5.0);
			}
			else SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Yak�n�n�zda restaurant bulunamad�.");
		}
		case 6: // t�m i�yerleri 200mt
		{
			new sira, primary_str[750], sub_str[75];
			strcat(primary_str, "#\t��yeri Ad�\n");

			foreach(new i : Businesses)
			{
				if(!IsPlayerInRangeOfPoint(playerid, 200.0, BusinessData[i][EnterPos][0], BusinessData[i][EnterPos][1], BusinessData[i][EnterPos][2])) continue;

				format(sub_str, sizeof(sub_str), "%i\t%s\n", i, BusinessData[i][BusinessName]);
				strcat(primary_str, sub_str);
				sira++;

				if(sira > 10) break;
			}

			if(!sira) strcat(primary_str, "Hi� i�yeri yok.");

			Dialog_Show(playerid, GPS_BUSINESS_LIST, DIALOG_STYLE_TABLIST_HEADERS, "SA Maps - T�m ��yerleri", primary_str, "��aretle", "Geri");

		}
	}
	return 1;
}

Dialog:GPS_STREET(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return cmd_samaps(playerid, "");
	}

	new bool: found, id;
	foreach (new i : Streets)
	{
		if(strfind(StreetData[i][StreetName], inputtext, true) != -1)
		{
			found = true;
			id = i;
			break;
		}
	}

	if(!found) {
		ShowNavigatorSys(playerid, 0, "Hi� sonu� bulunamad�.");
		return 1;
	}

	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritan�zda i�aretlendi.", StreetData[id][StreetName]);
	SetPlayerCheckpoint(playerid, StreetData[id][StreetX], StreetData[id][StreetY], 0.0, 5.0);
	return 1;
}

Dialog:GPS_PROPERTY_NO(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return cmd_samaps(playerid, "");
	}

	if(!IsNumeric(inputtext)) {
		return ShowNavigatorSys(playerid, 1, "Girdi�in kap� numaras� say�sal bir de�er olmal�d�r.");
	}

	if(strval(inputtext) < 0 || strval(inputtext) > 10000) {
		return ShowNavigatorSys(playerid, 1, "Girdi�in kap� numaras� 0 ile 10000 aras�nda olmal�d�r.");
	}

	strcat(PropertyNameHolder[playerid], inputtext);
	Dialog_Show(playerid, GPS_PROPERTY_STREET, DIALOG_STYLE_INPUT, "SA Maps - Ev Bul", "Evin bulundu�u soka��n ad� nedir? (�rne�in: Ferndale Avenue)", "�leri", "Geri");
	return 1;
}

Dialog:GPS_PROPERTY_STREET(playerid, response, listitem, inputtext[])
{
	if(!response) {
		return cmd_samaps(playerid, "");
	}

	if(strlen(inputtext) < 1) {
		Dialog_Show(playerid, GPS_PROPERTY_STREET, DIALOG_STYLE_INPUT, "SA Maps - Ev Bul", "Evin bulundu�u soka��n ad� nedir? (�rne�in: Ferndale Avenue)", "�leri", "Geri");
		return 1;
	}

	format(PropertyNameHolder[playerid], 35, "%s %s", PropertyNameHolder[playerid], inputtext); 

	new bool: found, id;
	foreach(new i : Properties)
	{
		if(strfind(PropertyData[i][PropertyAddress], PropertyNameHolder[playerid], true) != -1)
		{
			found = true;
			id = i;
			break;
		}
	}

	if(!found) {
		ShowNavigatorSys(playerid, 1, "Hi� sonu� bulunamad�.");
		return 1;
	}

	SendClientMessage(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Ev haritan�zda i�aretlendi.");
	SetPlayerCheckpoint(playerid, PropertyData[id][PropertyEnter][0], PropertyData[id][PropertyEnter][1], PropertyData[id][PropertyEnter][2], 3.0);
	return 1;
}

Dialog:GPS_BUSINESS_LIST(playerid, response, listitem, inputtext[])
{
	if(!response)
	{
		return cmd_samaps(playerid, "");
	}

	new id;
	sscanf(inputtext, "i", id);
	SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s haritan�zda i�aretlendi.", BusinessData[id][BusinessName]);
	SetPlayerCheckpoint(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], 5.0);
	return 1;
}
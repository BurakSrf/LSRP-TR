CMD:dosign(playerid, params[])
{
	new b = -1;
	if((b = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri i�erisinde de�ilsin.");
	if(BusinessData[b][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

	new time, msg[128];
	if(sscanf(params, "is[128]", time, msg)) return SendUsageMessage(playerid, "/dosign [s�re(1-600 saniye)] [eylem]");
    if(time < 1 || time > 600) return SendServerMessage(playerid, "S�re en az 1 en fazla 600 saniye olmal�d�r.");
	if(strlen(msg) > 100) return SendServerMessage(playerid, "Eylem i�eri�i en fazla 100 karakteri olmal�d�r.");

	SetPlayerChatBubble(playerid, sprintf("* %s %s", ReturnName(playerid, 0), msg), COLOR_EMOTE, 25.0, time*1000);
	SendClientMessageEx(playerid, COLOR_EMOTE, "> %s %s", ReturnName(playerid, 0), msg);

	new id = Iter_Free(Dosigns);
	if (id == -1) return SendErrorMessage(playerid, "�u anda daha fazla bilgi yaz�s� eklenemiyor.");

	if(Dosign_PlayerInQueue(playerid) > 1)
	{
	   	SendErrorMessage(playerid, "��yerine en fazla 2 adet ekleyebilirsin, silinmelerini bekle.");
		return 1;
	}

	format(DosignData[id][DosignPlacedBy], 25, "%s", ReturnName(playerid));
	GetPlayerPos(playerid, DosignData[id][DosignPos][0], DosignData[id][DosignPos][1], DosignData[id][DosignPos][2]);
    DosignData[id][DosignInterior] = GetPlayerInterior(playerid); DosignData[id][DosignWorld] = GetPlayerVirtualWorld(playerid);
    DosignData[id][DosignLabel] = CreateDynamic3DTextLabel(sprintf("(( %s )) %s", ReturnName(playerid, 1), msg), COLOR_EMOTE, DosignData[id][DosignPos][0], DosignData[id][DosignPos][1], DosignData[id][DosignPos][2], 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, DosignData[id][DosignWorld], DosignData[id][DosignInterior]);
   	DosignData[id][DosignTimer] = SetTimerEx("Dosign_Clear", time*1000, false, "i", id);
   	SendClientMessageEx(playerid, -1, "SERVER: {ADC3E7}Bilgi yaz�s� {FFFFFF}ekledin, %i saniye sonra otomatik silinecektir.", time);
   	Iter_Add(Dosigns, id);
	return 1;
}

Dosign_PlayerInQueue(playerid)
{
   	new sayi;
 	foreach(new i : Dosigns)
 	{
 		if(strfind(DosignData[i][DosignPlacedBy], ReturnName(playerid, 1), true) != -1) sayi++;
	}
	return sayi;
}

Server:Dosign_Clear(id)
{
	KillTimer(DosignData[id][DosignTimer]); DosignData[id][DosignTimer] = -1;
	if(IsValidDynamic3DTextLabel(DosignData[id][DosignLabel])) DestroyDynamic3DTextLabel(DosignData[id][DosignLabel]);
	DosignData[id][DosignPos][0] = DosignData[id][DosignPos][1] = DosignData[id][DosignPos][2] = 0.0;
	Iter_Remove(Dosigns, id);
	return 1;
}

CMD:isyeri(playerid, params[])
{
	static type[24], string[128];
	if (sscanf(params, "s[24]S()[128]", type, string))
 	{
		SendUsageMessage(playerid, "/isyeri [parametre]");
		if(!Business_Count(playerid)) SendClientMessage(playerid, COLOR_ADM, "-> satinal");
		else 
		{
			SendClientMessage(playerid, COLOR_ADM, "-> sat, bilgi, gelistir, giris, isim, paracek, motd, saat, isik");
			SendClientMessage(playerid, COLOR_ADM, "-> parayatir, calisanlar, al, kov, iptal, kabul, red, cik");
			SendClientMessage(playerid, COLOR_ADM, "-> kargofiyati, kargosayisi");
		}
		return 1;
	}

	if (!strcmp(type, "satinal", true))
	{
		new b = -1;
		if((b = IsPlayerNearBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri kap�s�nda de�ilsin.");
		if(Business_Count(playerid) == 1) return SendErrorMessage(playerid, "Maksimum sahip olabilece�in i�yerine say�s�na ula�m��s�n.");
		if(BusinessData[b][BusinessOwnerSQLID]) return SendErrorMessage(playerid, "Sahibi olan bir i�yerini sat�n alamazs�n.");
		
		if(BusinessData[b][BusinessType] == BUSINESS_BANK || BusinessData[b][BusinessType] == BUSINESS_DEALERSHIP) 
			return SendErrorMessage(playerid, "Bu i�yeri t�r�n� sat�n alamazs�n.");
		
		if(PlayerData[playerid][pMoney] < BusinessData[b][BusinessPrice]) 
			return SendErrorMessage(playerid, "Bu i�yerini sat�n almak i�in yeterli paran yok. (%s)", MoneyFormat(BusinessData[b][BusinessPrice]));
		
		if(PlayerData[playerid][pLevel] < BusinessData[b][BusinessLevel]) 
			return SendErrorMessage(playerid, "Bu i�yerini sat�n almak i�in seviyen yetersiz.");
			
		BusinessData[b][BusinessOwnerSQLID] = PlayerData[playerid][pSQLID];
		SaveSQLInt(BusinessData[b][BusinessID], "businesses", "BusinessOwner", PlayerData[playerid][pSQLID]);
		GameTextForPlayer(playerid, "Tebrikler!~n~Bu isyerinin yeni sahibi sensin!", 4000, 5);
		GiveMoney(playerid, -BusinessData[b][BusinessPrice]);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		Business_Refresh(b);
		return 1;
	}
	else if(!strcmp(type, "sat", true))
	{
		new b = -1;
		if((b = IsPlayerNearBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri kap�s�nda de�ilsin.");
		if(!Business_Count(playerid)) return SendErrorMessage(playerid, "Hi� i�yerin yok.");
		if(BusinessData[b][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		new onayla[5];
		if(sscanf(string, "s[5]", onayla)) return SendUsageMessage(playerid, "/isyeri sat {FFFF00}onay");
		
		if(!strcmp(onayla, "onay", true))
		{
			BusinessData[b][BusinessOwnerSQLID] = 0;
			SaveSQLInt(BusinessData[b][BusinessID], "businesses", "BusinessOwner", 0);
			SendClientMessageEx(playerid, COLOR_ADM, "SERVER: {FFFFFF}��yerini $%s olarak yar� fiyat�na satt�n.", MoneyFormat(BusinessData[b][BusinessPrice] / 2));
			GiveMoney(playerid, BusinessData[b][BusinessPrice] / 2);
			GameTextForPlayer(playerid, "ISYERINI SATTIN!", 3000, 5);
		} 
		else SendUsageMessage(playerid, "/isyeri sat {FFFF00}onay");
		return 1;
	}
	else if (!strcmp(type, "kargosayisi", true))
	{
		new b = -1;
		if((b = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri i�erisinde de�ilsin.");
		if(BusinessData[b][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		static level;
		if(sscanf(string, "i", level)) return SendUsageMessage(playerid, "/isyeri kargosayisi [0-100]");
		if(level < 0 || level > 100) return SendErrorMessage(playerid, "Kargo say�s� 0 - 100 aral���nda olmal�d�r.");
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: ��yeri istenen kargo say�s�n� %i olarak ayarlad�n�z.", level);
		BusinessData[b][BusinessWantedProduct] = level;
		Business_Save(b);
		return 1;
	}
	else if (!strcmp(type, "kargofiyati", true))
	{
		new b = -1;
		if((b = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri i�erisinde de�ilsin.");
		if(BusinessData[b][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		static level;
		if(sscanf(string, "i", level)) return SendUsageMessage(playerid, "/isyeri kargofiyati [0-100$]");
		if(level < 0 || level > 100) return SendErrorMessage(playerid, "Kargo fiyat� 0 - 100$ aral���nda olmal�d�r.");
		SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: Bu i�yerinin kargo al�� fiyat�n� %s olarak g�ncelledin.", MoneyFormat(level));
		BusinessData[b][BusinessProductPrice] = level;
		Business_Save(b);
		return 1;
	}
	else if(!strcmp(type, "saat", true))
	{
		new b = -1;
		if((b = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri i�erisinde de�ilsin.");
		if(BusinessData[b][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		new interval;
		if(sscanf(string, "i", interval)) return SendUsageMessage(playerid, "/isyeri saat [0-23]");
		if(interval < 0 || interval > 23) return SendErrorMessage(playerid, "Saat de�eri 0 - 23 aral���nda olmal�d�r.");

		BusinessData[b][BusinessTime] = interval;
		SaveSQLInt(BusinessData[b][BusinessID], "businesses", "Time", BusinessData[b][BusinessTime]);
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: ��yeri saatini %i olarak ayarlad�n�z.", interval);

		foreach(new i : Player) if(PlayerData[i][pInsideBusiness] == b)
		{
			SetPlayerTime(i, BusinessData[b][BusinessTime], 0);
		}
		return 1;
	}
	else if(!strcmp(type, "isik", true))
	{
		new b = -1;
		if((b = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri i�erisinde de�ilsin.");
		if(BusinessData[b][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		if(!BusinessData[b][BusinessLights])
		{
			BusinessData[b][BusinessLights] = true;
			cmd_ame(playerid, "kom�tat�r anahtar�na basar ve ����� kapat�r.");
			foreach (new i : Player) if(PlayerData[i][pInsideBusiness] == b)
			{
				PlayerTextDrawShow(i, PropertyLightsTXD[i]);
			}
		} 
		else 
		{
			BusinessData[b][BusinessLights] = false;
			cmd_ame(playerid, "kom�tat�r anahtar�na basar ve ����� a�ar.");
			foreach (new i : Player) if(PlayerData[i][pInsideBusiness] == b)
			{
				PlayerTextDrawHide(i, PropertyLightsTXD[i]);
			}
		}
		return 1;
	}
	else if(!strcmp(type, "gelistir", true))
	{
		new b = -1;
		if((b = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri i�erisinde de�ilsin.");
		if(BusinessData[b][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		new type_two[24], string_two[128];
		if(sscanf(string, "s[24]S()[128]", type_two, string_two))
		{
			SendUsageMessage(playerid, "/isyeri gelistir [item]");
			SendClientMessage(playerid, COLOR_GREY, "|_________��yeri �temleri_________|");
			SendClientMessage(playerid, COLOR_GREY, "| 1. xmr (/istasyon)");
			return 1;
		}

		if(!strcmp(type_two, "xmr", true))
		{
			if(BusinessData[b][BusinessHasXMR]) return SendErrorMessage(playerid, "��yerinde XM radyo var.");
			if(PlayerData[playerid][pMoney] < 5000) return SendErrorMessage(playerid, "Bu geli�tirme i�in yeterli paran yok. ($5,000)");
			SendClientMessage(playerid, COLOR_GRAD2, "SERVER: ��yerine XM radyo sat�n ald�n! /istasyon");
	        BusinessData[b][BusinessHasXMR] = true;
	        GiveMoney(playerid, -5000);
			return 1;
		}
		else SendErrorMessage(playerid, "Ge�ersiz parametre girdiniz.");
	}
	else if (!strcmp(type, "parayatir", true))
	{
		new b = -1;
		if((b = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri i�erisinde de�ilsin.");
		if(!Business_Count(playerid)) return SendErrorMessage(playerid, "Hi� i�yerin yok.");
		if(BusinessData[b][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");
	
		new interval;
		if(sscanf(string, "i", interval)) return SendUsageMessage(playerid, "/isyeri parayatir [miktar]");
		if(interval < 1 || interval > PlayerData[playerid][pMoney]) return SendErrorMessage(playerid, "Ge�ersiz de�er belirttin.");

		GiveMoney(playerid, -interval);
		BusinessData[b][BusinessCashbox] += interval;
		SaveSQLInt(BusinessData[b][BusinessID], "businesses", "BusinessCashbox", BusinessData[b][BusinessCashbox]);
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: ��yeri kasas�na $%s koydun. (Kasa Toplam�: $%s)", MoneyFormat(interval), MoneyFormat(BusinessData[b][BusinessCashbox]));
		return 1;
	}
	else if (!strcmp(type, "paracek", true))
	{
		new b = -1;
		if((b = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri i�erisinde de�ilsin.");
		if(!Business_Count(playerid)) return SendErrorMessage(playerid, "Hi� i�yerin yok.");
		if(BusinessData[b][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		new interval;
		if(sscanf(string, "i", interval)) return SendUsageMessage(playerid, "/isyeri paracek [miktar]");
		if(interval < 1 || interval >BusinessData[b][BusinessCashbox]) return SendErrorMessage(playerid, "Ge�ersiz de�er belirttin.");

		GiveMoney(playerid, interval);
		BusinessData[b][BusinessCashbox] -= interval;
		SaveSQLInt(BusinessData[b][BusinessID], "businesses", "BusinessCashbox", BusinessData[b][BusinessCashbox]);
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: ��yeri kasas�ndan $%s �ektin. (Kasa Toplam�: $%s)", MoneyFormat(interval), MoneyFormat(BusinessData[b][BusinessCashbox]));
        return 1;
	}
	else if (!strcmp(type, "bilgi", true))
	{
		if(!Business_Count(playerid)) return SendErrorMessage(playerid, "Hi� i�yerin yok.");

		new id;
		if((id = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri i�erisinde de�ilsin.");
		if(BusinessData[id][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID] && !PlayerData[playerid][pAdminDuty]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		SendClientMessageEx(playerid, COLOR_DARKGREEN, "|__________________%s [%i]__________________|", BusinessData[id][BusinessName], id);
		SendClientMessageEx(playerid, COLOR_WHITE, "ID:[%i] Sahip:[%s] Level:[%i] De�er:[$%s] Tip:[%i] Kilitli:[%s]", BusinessData[id][BusinessID], ReturnName(playerid, 1), BusinessData[id][BusinessLevel], MoneyFormat(BusinessData[id][BusinessPrice]), BusinessData[id][BusinessType], BusinessData[id][BusinessLocked] ? ("Evet") : ("Hay�r"));
		//SendClientMessageEx(playerid, COLOR_WHITE, "Kasa:[$%s] Giri� Fiyat�:[$%s] �r�n Say�s�:[%i] �r�n Tipi:[%s] �r�n Fiyat�:[$%s]", MoneyFormat(BusinessData[id][BusinessCashbox]), MoneyFormat(BusinessData[id][BusinessFee]), BusinessData[id][BusinessProduct], Industry_CargoName(BusinessData[id][BusinessProduct]), MoneyFormat(BusinessData[id][BusinessProductPrice]));
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "|__________________%s [%i]__________________|", BusinessData[id][BusinessName], id);
		return 1;
	}
	else if (!strcmp(type, "giris", true))
	{
		new b = -1;
		if((b = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "Herhangi bir i�yeri i�erisinde de�ilsin.");
		if(!Business_Count(playerid)) return SendErrorMessage(playerid, "Hi� i�yerin yok.");
		if(BusinessData[b][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		new interval;
		if(sscanf(string, "i", interval)) return SendUsageMessage(playerid, "/isyeri giris [miktar]");
		if(interval < 0 || interval > 500) return SendErrorMessage(playerid, "��yeri giri� fiyat� $0-$500 aras� olmal�d�r.");

		BusinessData[b][BusinessFee] = interval;
		SaveSQLInt(BusinessData[b][BusinessID], "businesses", "BusinessFee", BusinessData[b][BusinessFee]);
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: ��yeri giri� fiyat� $%d olarak ayarland�!", interval);
		return 1;
 	}
	else if (!strcmp(type, "isim", true))
	{
		if(!Business_Count(playerid)) return SendErrorMessage(playerid, "Hi� i�yerin yok.");
		
		static id = -1;
		if((id = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "��yeri i�erisinde de�ilsin.");
		if(BusinessData[id][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");
	
		new business_name[45];
		if(sscanf(string, "s[45]", business_name)) return SendUsageMessage(playerid, "/isyeri isim [metin]");
		if(isnull(business_name) || strlen(business_name) > 45) return SendErrorMessage(playerid, "��yeri ismi maksimum 45 karakter olabilir.");
    	if(ContainsInvalidCharacters(business_name)) return SendErrorMessage(playerid, "��yeri ismi i�erisinde T�rk�e karakter kullanamazs�n.");

		SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: ��yerinin ismi %s olarak de�i�ti!", business_name);
		format(BusinessData[id][BusinessName], 45, "%s", business_name);
		Business_Save(id);
		return 1;
 	}
 	else if (!strcmp(type, "motd", true))
	{
		if(!Business_Count(playerid)) return SendErrorMessage(playerid, "Hi� i�yerin yok.");
		
		static id = -1;
		if((id = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "��yeri i�erisinde de�ilsin.");
		if(BusinessData[id][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");
	
		new business_motd[128];
		if(sscanf(string, "s[128]", business_motd)) return SendUsageMessage(playerid, "/isyeri motd [metin]");
		if(isnull(business_motd) || strlen(business_motd) > 128) return SendErrorMessage(playerid, "��yeri metni maksimum 128 karakter olabilir.");
    	//if(ContainsInvalidCharacters(business_name)) return SendErrorMessage(playerid, "��yeri ismi i�erisinde T�rk�e karakter kullanamazs�n.");

		if(!strcmp(business_motd, "kaldir", true))
		{
			SendClientMessage(playerid, COLOR_DARKGREEN, "��yerinin metni ba�ar�yla kald�r�ld�.");
			format(BusinessData[id][BusinessMOTD], 128, "Yok");
			Business_Save(id);
		    return 1;
		}

		SendClientMessageEx(playerid, COLOR_DARKGREEN, "��yerinin metni %s olarak de�i�ti! (kald�rmak i�in /isyeri motd kaldir)", business_motd);
		format(BusinessData[id][BusinessMOTD], 128, "%s", business_motd);
		Business_Save(id);
		return 1;
 	}
 	else if (!strcmp(type, "cik", true))
	{
		if(PlayerData[playerid][pWorkOn] == -1) return SendErrorMessage(playerid, "Herhangi bir yerde �al��m�yorsun.");
		SendClientMessageEx(playerid, COLOR_RED, "SERVER: %s adl� i�yerinde �al��may� b�rakt�n.", BusinessData[PlayerData[playerid][pWorkOn]][BusinessName]);
		SaveSQLInt(PlayerData[playerid][pSQLID], "players", "WorkOn", -1);
		PlayerData[playerid][pWorkOn] = -1;
	    return 1;
	}
	else if (!strcmp(type, "calisanlar", true))
	{
		if(!Business_Count(playerid)) return SendErrorMessage(playerid, "Hi� i�yerin yok.");
		
		static id = -1;
		if((id = IsPlayerInBusiness(playerid)) == -1) return SendErrorMessage(playerid, "��yeri i�erisinde de�ilsin.");
		if(BusinessData[id][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");
			
		new query[60];
		mysql_format(m_Handle, query, sizeof(query), "SELECT * FROM players WHERE WorkOn = %i LIMIT 20", id);
		new Cache:cache = mysql_query(m_Handle, query);
		if(cache_num_rows())
		{
			new str[128], worker_name[24];
			for(new i = 0, j = cache_num_rows(); i < j; i++)
			{
				cache_get_value_name(i, "Name", worker_name, 24);
				format(str, sizeof(str), "%s%d. %s\n", str, (i+1), worker_name);
			}
			ShowPlayerDialog(playerid, DIALOG_USE, DIALOG_STYLE_LIST, sprintf("%s �al��anlar�", BusinessData[id][BusinessName]), str, ">>>", "");
		}
		else SendClientMessage(playerid, COLOR_ADM, "SERVER: ��yerinde kimse �al��m�yor.");
		cache_delete(cache);
		return 1;
	}
	/*else if(strmatch(specifier, "iptal"))
	{
		if(CountPlayerBusinesses(playerid) == 0)
			return SendErrorMessage(playerid, "Hi� i�yerin yok.");

		new bizid;
		if((bizid = IsPlayerInBusiness(playerid)) == 0)
			return SendErrorMessage(playerid, "��yeri i�erisinde de�ilsin.");

		if(BusinessData[bizid][businessOwnerSQL] != PlayerData[playerid][pSQLID])
			return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		if(OfferedHireTo[playerid] == INVALID_PLAYER_ID)
			return SendUsageMessage(playerid, "Hen�z birisine teklif yapmam��s�n.");

		SendClientMessageEx(OfferedHireTo[playerid], COLOR_RED, "SERVER: %s sana olan teklifini iptal etti.", ReturnName(playerid));
		SendClientMessageEx(playerid, COLOR_RED, "SERVER: %s adl� ki�iye yapt���n teklifi iptal ettin.", ReturnName(OfferedHireTo[playerid]));

		OfferedHireBy[OfferedHireTo[playerid]] = INVALID_PLAYER_ID;
		OfferedHireTo[playerid] = INVALID_PLAYER_ID;
		OfferedHireBusinessID[playerid] = 0;
	    return 1;
	}
	else if(strmatch(specifier, "al"))
	{
		if(CountPlayerBusinesses(playerid) == 0)
			return SendErrorMessage(playerid, "Hi� i�yerin yok.");

		new bizid;
		if((bizid = IsPlayerInBusiness(playerid)) == 0)
			return SendErrorMessage(playerid, "��yeri i�erisinde de�ilsin.");

		if(BusinessData[bizid][businessOwnerSQL] != PlayerData[playerid][pSQLID])
			return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");

		if(OfferedHireTo[playerid] != INVALID_PLAYER_ID)
			return SendUsageMessage(playerid, "Aktif bir teklifin var, de�erlendirmesini beklemelisin.");

		if (interval == -1)
 			return SendUsageMessage(playerid, "/isyeri al [oyuncu ID]");
			
		if(interval == playerid)
			return SendErrorMessage(playerid, "Kendini i�e alamazs�n.");
			
		if(!IsPlayerConnected(interval))
			return SendErrorMessage(playerid, "Belirtti�in ki�i aktif de�il.");

		if(!pLoggedIn[interval])
			return SendErrorMessage(playerid, "Belirtti�in ki�i giri� yapmam��.");
			
		if(!GetDistanceBetweenPlayers(playerid, interval, 5.0))
			return SendErrorMessage(playerid, "Belirtti�in ki�iye yak�n de�ilsin.");

		if(OfferedHireBy[interval] != INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "Bu ki�iye zaten bir teklif yap�lm��..");

		SendClientMessageEx(playerid, COLOR_RED, "SERVER: %s isimli ki�iye %s i�yerinde �al��mas� i�in teklif g�nderdin.", ReturnName(interval, 0), BusinessData[bizid][businessName]);
		SendClientMessage(playerid, COLOR_RED, "SERVER: /isyeri al iptal yazarak teklifini iptal edebilirsin.");

		SendClientMessageEx(interval, COLOR_RED, "SERVER: %s sana %s adl� i�yerinde i� teklif etti. /isyeri [kabul/red] komutu ile de�erlendirebilirsin.", ReturnName(playerid, 0), BusinessData[bizid][businessName]);
		OfferedHireBusinessID[playerid] = bizid;
		OfferedHireBy[interval] = playerid;
		OfferedHireTo[playerid] = interval;
		return 1;
  	}
	else if(strmatch(specifier, "kov"))
	{
		if(CountPlayerBusinesses(playerid) == 0)
			return SendErrorMessage(playerid, "Hi� i�yerin yok.");

		new bizid;
		if((bizid = IsPlayerInBusiness(playerid)) == 0)
			return SendErrorMessage(playerid, "��yeri i�erisinde de�ilsin.");

		if(BusinessData[bizid][businessOwnerSQL] != PlayerData[playerid][pSQLID])
			return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");
	
		if (interval == -1)
 			return SendUsageMessage(playerid, "/isyeri kov [oyuncu ID]");

		if(interval == playerid)
			return SendErrorMessage(playerid, "Kendini kovamazs�n.");

		if(!IsPlayerConnected(interval))
			return SendErrorMessage(playerid, "Belirtti�in ki�i aktif de�il.");

		if(!pLoggedIn[interval])
			return SendErrorMessage(playerid, "Belirtti�in ki�i giri� yapmam��.");

		if(PlayerData[interval][pWorkOn] != BusinessData[bizid][businessID])
			return SendErrorMessage(playerid, "Bu ki�i senin �al��an�n de�il.");

		SendClientMessageEx(interval, COLOR_RED, "SERVER: %s seni i�yerinden kovdu.", ReturnName(playerid));
		SendClientMessageEx(playerid, COLOR_RED, "SERVER: %s isimli ki�iyi i�yerinden kovdun.", ReturnName(interval));
		SaveSQLInt(PlayerData[interval][pSQLID], "players", "WorkOn", -1);
		PlayerData[interval][pWorkOn] = -1;
	    return 1;
	}
	else if(strmatch(specifier, "kabul"))
	{
		if(OfferedHireBy[playerid] == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "Kimse sana i� teklifi yapmad�.");
			
		SendClientMessageEx(playerid, COLOR_RED, "SERVER: %s isimli ki�inin i�yeri teklifini kabul ettin.", ReturnName(OfferedHireBy[playerid]));
		SendClientMessageEx(OfferedHireBy[playerid], COLOR_RED, "SERVER: %s senin i�yerini teklifini kabul etti.", ReturnName(playerid));

		SaveSQLInt(PlayerData[playerid][pSQLID], "players", "WorkOn", OfferedHireBusinessID[OfferedHireBy[playerid]]);
		PlayerData[playerid][pWorkOn] = OfferedHireBusinessID[OfferedHireBy[playerid]];

		OfferedHireTo[OfferedHireBy[playerid]] = INVALID_PLAYER_ID;
		OfferedHireBusinessID[OfferedHireBy[playerid]] = 0;
		OfferedHireBy[playerid] = INVALID_PLAYER_ID;
 		return 1;
	}
	else if(strmatch(specifier, "red"))
	{
		if(OfferedHireBy[playerid] == INVALID_PLAYER_ID)
			return SendErrorMessage(playerid, "Kimse sana i� teklifi yapmad�.");

		SendClientMessageEx(playerid, COLOR_RED, "SERVER: %s isimli ki�inin i�yeri teklifini reddettin.", ReturnName(OfferedHireBy[playerid]));
		SendClientMessageEx(OfferedHireBy[playerid], COLOR_RED, "SERVER: %s senin i�yeri teklifini reddetti.", ReturnName(playerid));

		OfferedHireTo[OfferedHireBy[playerid]] = INVALID_PLAYER_ID;
		OfferedHireBusinessID[OfferedHireBy[playerid]] = 0;
		OfferedHireBy[playerid] = INVALID_PLAYER_ID;
 		return 1;
	}*/
	else SendErrorMessage(playerid, "Hatal� parametre girdin.");
	return 1;
}

Business_Create(playerid, type, name[])
{
	new id = Iter_Free(Businesses);
   	if (id == -1) return SendErrorMessage(playerid, "Maksimum eklenebilecek i�yeri s�n�r�na ula��lm��.");

	BusinessData[id][BusinessOwnerSQLID] = 0;
	format(BusinessData[id][BusinessName], 128, name);

   	BusinessData[id][BusinessLevel] = 1;
   	BusinessData[id][BusinessPrice] = 50000;
   	BusinessData[id][BusinessRestaurantType] = 0;
   	BusinessData[id][BusinessType] = type;

    GetPlayerPos(playerid, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2]);
    GetPlayerFacingAngle(playerid, BusinessData[id][EnterPos][3]);
	BusinessData[id][EnterInterior] = GetPlayerInterior(playerid);
	BusinessData[id][EnterWorld] = GetPlayerVirtualWorld(playerid);

    GetPlayerPos(playerid, BusinessData[id][ExitPos][0], BusinessData[id][ExitPos][1], BusinessData[id][ExitPos][2]);
    GetPlayerFacingAngle(playerid, BusinessData[id][ExitPos][3]);
	BusinessData[id][ExitPos][2] = 10000;
	BusinessData[id][ExitInterior] = 99;
	BusinessData[id][ExitWorld] = 99;

   	BusinessData[id][BusinessFee] = 1;
   	BusinessData[id][BusinessCashbox] = 0;
   	BusinessData[id][BusinessLocked] = true;
   	BusinessData[id][BusinessHasXMR] = false;

   	BusinessData[id][BusinessTime] = 12;
   	BusinessData[id][BusinessLights] = true;

   	BusinessData[id][BusinessProduct] = 100;
  	BusinessData[id][BusinessWantedProduct] = 0;
   	BusinessData[id][BusinessProductPrice] = 75;

   	BusinessData[id][BusinessFood][0] = 0;
	BusinessData[id][BusinessFoodPrice][0] = 50;

	BusinessData[id][BusinessFood][1] = 1;
	BusinessData[id][BusinessFoodPrice][1] = 50;

	BusinessData[id][BusinessFood][2] = 2;
	BusinessData[id][BusinessFoodPrice][2] = 50;
	Iter_Add(Businesses, id);

	SendClientMessageEx(playerid, COLOR_YELLOW, "SERVER: %i numaral� i�yerini ekledin. (kilidi a��p, i� k�sm� ayarlamay� unutmay�n)", id);
	mysql_tquery(m_Handle, "INSERT INTO businesses (BusinessLocked) VALUES(1)", "OnBusinessCreated", "d", id);
	Business_Refresh(id);
	return 1;
}

Server:OnBusinessCreated(id)
{
	BusinessData[id][BusinessID] = cache_insert_id();
	Business_Save(id);
	return 1;
}

stock Business_Count(playerid)
{
	new sayi = 0;
	foreach(new i : Businesses) if(BusinessData[i][BusinessOwnerSQLID] == PlayerData[playerid][pSQLID]) sayi++;
	return sayi;
}

Business_Save(id)
{
	new
	    query[545];

	mysql_format(m_Handle, query, sizeof(query), "UPDATE businesses SET BusinessOwner = %i, BusinessName = '%e', BusinessMOTD = '%e', BusinessPrice = %i, BusinessLevel = %i, BusinessType = %i WHERE id = %i",
		BusinessData[id][BusinessOwnerSQLID],
	    BusinessData[id][BusinessName],
	    BusinessData[id][BusinessMOTD],
	    BusinessData[id][BusinessPrice],
	    BusinessData[id][BusinessLevel],
	    BusinessData[id][BusinessType],
	    BusinessData[id][BusinessID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE businesses SET EnterX = %f, EnterY = %f, EnterZ = %f, EnterA = %f, EnterInterior = %i, EnterWorld = %i WHERE id = %i",
		BusinessData[id][EnterPos][0],
	    BusinessData[id][EnterPos][1],
	    BusinessData[id][EnterPos][2],
	    BusinessData[id][EnterPos][3],
	    BusinessData[id][EnterInterior],
	    BusinessData[id][EnterWorld],
	    BusinessData[id][BusinessID]
	);
	mysql_tquery(m_Handle, query);
	
	mysql_format(m_Handle, query, sizeof(query), "UPDATE businesses SET ExitX = %f, ExitY = %f, ExitZ = %f, ExitA = %f, ExitInterior = %i, ExitWorld = %i WHERE id = %i",
		BusinessData[id][ExitPos][0],
	    BusinessData[id][ExitPos][1],
	    BusinessData[id][ExitPos][2],
	    BusinessData[id][ExitPos][3],
	    BusinessData[id][ExitInterior],
	    BusinessData[id][ExitWorld],
	    BusinessData[id][BusinessID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE businesses SET BankX = %f, BankY = %f, BankZ = %f, BankInterior = %i, BankWorld = %i, Time = %i, Lights = %i WHERE id = %i",
		BusinessData[id][BankPos][0],
	    BusinessData[id][BankPos][1],
	    BusinessData[id][BankPos][2],
	    BusinessData[id][BankInterior],
	    BusinessData[id][BankWorld],
	    BusinessData[id][BusinessTime],
   		BusinessData[id][BusinessLights],
	    BusinessData[id][BusinessID]
	);
	mysql_tquery(m_Handle, query);
	
	mysql_format(m_Handle, query, sizeof(query), "UPDATE businesses SET BusinessLocked = %i, BusinessHasXMR = %i, BusinessCashbox = %i, BusinessFee = %i, BusinessProduct = %i, BusinessWantedProduct = %i, BusinessProductPrice = %i WHERE id = %i",
        BusinessData[id][BusinessLocked],
        BusinessData[id][BusinessHasXMR],
		BusinessData[id][BusinessCashbox],
	    BusinessData[id][BusinessFee],
	    BusinessData[id][BusinessProduct],
	    BusinessData[id][BusinessWantedProduct],
	    BusinessData[id][BusinessProductPrice],
	    BusinessData[id][BusinessID]
	);
	mysql_tquery(m_Handle, query);

	mysql_format(m_Handle, query, sizeof(query), "UPDATE businesses SET BusinessRType = %i, Food1 = %i, Food2 = %i, Food3 = %i, Price1 = %i, Price2 = %i, Price3 = %i WHERE id = %i",
        BusinessData[id][BusinessRestaurantType],
		BusinessData[id][BusinessFood][0],
	    BusinessData[id][BusinessFood][1],
	    BusinessData[id][BusinessFood][2],
		BusinessData[id][BusinessFoodPrice][0],
	    BusinessData[id][BusinessFoodPrice][1],
	    BusinessData[id][BusinessFoodPrice][2],
	    BusinessData[id][BusinessID]
	);
	mysql_tquery(m_Handle, query);
	return 1;
}

Business_Refresh(id)
{
	if (IsValidDynamicPickup(BusinessData[id][BusinessPickup])) DestroyDynamicPickup(BusinessData[id][BusinessPickup]);
	if (IsValidDynamicPickup(BusinessData[id][BankPickup])) DestroyDynamicPickup(BusinessData[id][BankPickup]);

	if (IsValidDynamicArea(BusinessData[id][BusinessAreaID][0])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, BusinessData[id][BusinessAreaID][0], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(BusinessData[id][BusinessAreaID][0]);
	}
	if (IsValidDynamicArea(BusinessData[id][BusinessAreaID][1])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, BusinessData[id][BusinessAreaID][1], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(BusinessData[id][BusinessAreaID][1]);
	}

	if(BusinessData[id][BusinessType] != BUSINESS_GASSTATION)
	{
		if(BusinessData[id][BusinessType] == BUSINESS_RESTAURANT) 
			BusinessData[id][BusinessPickup] = CreateDynamicPickup(!BusinessData[id][BusinessOwnerSQLID] ? (1272) : (1239), 1, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], BusinessData[id][EnterWorld], BusinessData[id][EnterInterior]);
		else 
			BusinessData[id][BusinessPickup] = CreateDynamicPickup(1239, 1, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], BusinessData[id][EnterWorld], BusinessData[id][EnterInterior]);
	}

	if(BusinessData[id][BusinessType] == BUSINESS_BANK) BusinessData[id][BankPickup] = CreateDynamicPickup(1274, 2, BusinessData[id][BankPos][0], BusinessData[id][BankPos][1], BusinessData[id][BankPos][2], BusinessData[id][ExitWorld], BusinessData[id][ExitInterior]);

	new array[2]; array[0] = 16; array[1] = id;
	BusinessData[id][BusinessAreaID][0] = CreateDynamicSphere(BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], BusinessData[id][BusinessType] == BUSINESS_GASSTATION ? 7.0 : 3.0, BusinessData[id][EnterWorld], BusinessData[id][EnterInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, BusinessData[id][BusinessAreaID][0], E_STREAMER_EXTRA_ID, array, 2);
	
	array[0] = 17; array[1] = id;
	BusinessData[id][BusinessAreaID][1] = CreateDynamicSphere(BusinessData[id][ExitPos][0], BusinessData[id][ExitPos][1], BusinessData[id][ExitPos][2], 3.0, BusinessData[id][ExitWorld], BusinessData[id][ExitInterior]);
	Streamer_SetArrayData(STREAMER_TYPE_AREA, BusinessData[id][BusinessAreaID][1], E_STREAMER_EXTRA_ID, array, 2);
	return 1;
}

Business_Delete(id)
{
	foreach(new i : Player) if(PlayerData[i][pInsideBusiness] == id)
	{
		SendPlayer(i, BusinessData[id][EnterPos][0], BusinessData[id][EnterPos][1], BusinessData[id][EnterPos][2], BusinessData[id][EnterPos][3], BusinessData[id][EnterInterior], BusinessData[id][EnterWorld]);
		SendClientMessage(i, COLOR_YELLOW, "SERVER: Bu i�yeri silindi�i i�in d��ar� ��kar�ld�n�z.");
		PlayerData[i][pInsideBusiness] = 0;
		SetCameraBehindPlayer(i);
	}

	new
		query[64];

	mysql_format(m_Handle, query, sizeof(query), "DELETE FROM businesses WHERE id = %i", BusinessData[id][BusinessID]);
	mysql_tquery(m_Handle, query);

	if (IsValidDynamicPickup(BusinessData[id][BusinessPickup])) DestroyDynamicPickup(BusinessData[id][BusinessPickup]);
	if (IsValidDynamicPickup(BusinessData[id][BankPickup])) DestroyDynamicPickup(BusinessData[id][BankPickup]);

	if (IsValidDynamicArea(BusinessData[id][BusinessAreaID][0])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, BusinessData[id][BusinessAreaID][0], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(BusinessData[id][BusinessAreaID][0]);
	}

	if (IsValidDynamicArea(BusinessData[id][BusinessAreaID][1])) {
    	Streamer_RemoveArrayData(STREAMER_TYPE_AREA, BusinessData[id][BusinessAreaID][1], E_STREAMER_PLAYER_ID, id);
	    DestroyDynamicArea(BusinessData[id][BusinessAreaID][1]);
	}
	
	Iter_Remove(Businesses, id);
	return 1;
}

Business_Message(playerid, id)
{
	/*
	This business is looking for cargo to buy now.
	(Wanted: 5 crates of appliances, paying $500 per each one.)

	*/

	switch(BusinessData[id][BusinessType])
	{
		case BUSINESS_STORE: SendClientMessage(playerid, COLOR_DARKGREEN, "24/7 Supermarket /satinal");
		case BUSINESS_GENERAL: SendClientMessage(playerid, COLOR_DARKGREEN, "Genel Ma�aza /satinal");
		case BUSINESS_PAWNSHOP: SendClientMessage(playerid, COLOR_DARKGREEN, "Pawnshop /satinal /telsatinal");
		case BUSINESS_RESTAURANT: SendClientMessage(playerid, COLOR_DARKGREEN, "Restaurant /yemek");
		case BUSINESS_AMMUNATION: SendClientMessage(playerid, COLOR_DARKGREEN, "Silah�� /silahsatinal, /mermisatinal");
		case BUSINESS_CLOTHING: SendClientMessage(playerid, COLOR_WHITE, "/kiyafetsatinal");
		case BUSINESS_BANK: SendClientMessage(playerid, COLOR_DARKGREEN, "Banka /bakiye /mevduat /paracek /parayatir");
		case BUSINESS_CLUB: SendClientMessage(playerid, COLOR_DARKGREEN, "Gece Kul�b� /icecekal");
		case BUSINESS_ADVERT: SendClientMessage(playerid, COLOR_DARKGREEN, "Reklamlar�n�z� yay�nl�yoruz! /sreklam /reklam");
	}

	if(strcmp(BusinessData[id][BusinessMOTD], "Yok", true)) SendClientMessageEx(playerid, -1, "%s", BusinessData[id][BusinessMOTD]);
	return 1;
}

IsPlayerInBusiness(playerid)
{
	return PlayerData[playerid][pInsideBusiness];
}

IsPlayerNearBusiness(playerid)
{
	if(GetPVarInt(playerid, "AtBusiness") != -1)
	{
		new bb = GetPVarInt(playerid, "AtBusiness");
		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessData[bb][EnterPos][0], BusinessData[bb][EnterPos][1], BusinessData[bb][EnterPos][2]))
		{
			return bb;
		}	
	}	
	return -1;
}

Business_Closest(playerid, type)
{
	new Float: distance[2] = {99999.0, 0.0}, index = -1;
	foreach(new i : Businesses) if (BusinessData[i][BusinessType] == type)
	{
		distance[1] = GetPlayerDistanceFromPoint(playerid, BusinessData[i][EnterPos][0], BusinessData[i][EnterPos][1], BusinessData[i][EnterPos][2]);
		if (distance[1] < distance[0])
		{
		    distance[0] = distance[1];
		   	index = i;
		}
	}
	return index;
}
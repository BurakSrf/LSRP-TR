CMD:reklamlar(playerid, params[]) 
{
	if(GetPVarInt(playerid, "AtBusiness") != -1)
	{
		new b = GetPVarInt(playerid, "AtBusiness");
		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessData[b][EnterPos][0], BusinessData[b][EnterPos][1], BusinessData[b][EnterPos][2]))
		{
			if(BusinessData[b][BusinessType] != BUSINESS_ADVERT) return SendErrorMessage(playerid, "Bu iþyeri reklam noktasý deðil.");

			Advert_List(playerid);
			return 1;
		}
	}

	SendErrorMessage(playerid, "Yakýnýnda reklam noktasý yok.");
	return 1;
}

CMD:sonreklamlar(playerid, params[]) 
{
	if(Dialog_Opened(playerid)) return SendErrorMessage(playerid, "Bu komutu kullanmak için ilk önce baktýðýn menüyü kapat.");
	
    new sub[128], primary[512];
	new advert_text[128], advert_number, adverttype, id;

	strcat(primary, "#\tReklam\tÝletiþim\n");
	new Cache:cache = mysql_query(m_Handle, "SELECT * FROM adverts ORDER BY id DESC LIMIT 10");
	if(!cache_num_rows()) 
	{
		strcat(primary, "Hiç reklam bulunamadý.");
	}
	else
	{
		for(new i = 0, j = cache_num_rows(); i < j; i++)
		{
			cache_get_value_name_int(i, "id", id);
			cache_get_value_name_int(i, "adverttype", adverttype);
			cache_get_value_name_int(i, "advertnumber", advert_number);
			cache_get_value_name(i, "adverttext", advert_text, sizeof(advert_text));

			if(adverttype == 1)
				format(sub, sizeof(sub), "%i\t%.40s...\t%i\n", id, advert_text, advert_number);
			else
				format(sub, sizeof(sub), "%i\t%.40s...\t-\n", id, advert_text);

			strcat(primary, sub);
		}
	}
	cache_delete(cache);
	Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_TABLIST_HEADERS, "Son Reklamlar", primary, "<<", "");
	return 1;
}

Advert_List(playerid)
{
    new ad_count = 0;
    new sub[128], primary[512];

	strcat(primary, "#\tReklam\tSaniye\n");
	foreach(new i : Adverts)
	{
		format(sub, sizeof(sub), "%i\t%.40s...\t~%is\n", (i+1), AdvertData[i][AdvertText], AdvertData[i][PublishTime]);
		strcat(primary, sub);
        ad_count++;
	}
	
	if(!ad_count) Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_TABLIST, "Reklamlar", "Yakýnda yayýnlanacak hiç reklam yok.", "<<", "");
	else Dialog_Show(playerid, DIALOG_DEFAULT, DIALOG_STYLE_TABLIST_HEADERS, "Reklamlar", primary, "<<", "");
	return 1;
}

PlayerInQueue(playerid)
{
   	new max_count = 0;
 	foreach(new i : Adverts)
 	{
 	    if(AdvertData[i][AdvertPlaceBy] == PlayerData[playerid][pSQLID]) max_count++;
	}
	return max_count;
}

Advert_Publish(playerid, text[], personal = 1)
{
	new id = Iter_Free(Adverts);
	if(id == -1) return SendClientMessage(playerid, COLOR_ADM, "SERVER: Reklam listesi dolmuþ, biraz bekleyin.");

	AdvertData[id][AdvertType] = personal;
	format(AdvertData[id][AdvertText], 256, text);
	AdvertData[id][AdvertPlaceBy] = PlayerData[playerid][pSQLID];
	AdvertData[id][AdvertContact] = PlayerData[playerid][pPhone];
	AdvertData[id][PublishTime] = id == 0 ? (id+1) * 60 : id * 60;
	AdvertData[id][AdvertTimer] = SetTimerEx("OnAdvertPublish", 1000, true, "i", id);
	Iter_Add(Adverts, id);

	new query[454];
	mysql_format(m_Handle, query, sizeof(query), "INSERT INTO adverts (advertby, advertnumber, adverttype, adverttext, adverttime) VALUES (%i, %i, %i, '%e', %i)", AdvertData[id][AdvertPlaceBy], AdvertData[id][AdvertContact], AdvertData[id][AdvertType], AdvertData[id][AdvertText], Time());
    mysql_tquery(m_Handle, query);

    SendClientMessage(playerid, COLOR_ADM, "SERVER: Reklamýnýz en kýsa sürede yayýnlanacaktýr, teþekkürler.");
	GiveMoney(playerid, -150);
	return 1;
}

Server:OnAdvertPublish(id)
{
	AdvertData[id][PublishTime] = AdvertData[id][PublishTime] - 1;

	if(AdvertData[id][PublishTime] <= 0)
    {
		switch(AdvertData[id][AdvertType])
		{
			case 1:
			{
				foreach(new i : Player) {
					if(strlen(AdvertData[id][AdvertText]) > 80)
					{
						SendClientMessageEx(i, COLOR_DARKGREEN, "[Reklam] %.80s ...", AdvertData[id][AdvertText]);
						SendClientMessageEx(i, COLOR_DARKGREEN, "[Reklam] ...%s, Tel: [%i]", AdvertData[id][AdvertText][80], AdvertData[id][AdvertContact]);
					}
					else SendClientMessageEx(i, COLOR_DARKGREEN, "[Reklam] %s, Tel: [%i]", AdvertData[id][AdvertText], AdvertData[id][AdvertContact]);
				}
			}
			case 2:
			{
				foreach(new i : Player) {
					if(strlen(AdvertData[id][AdvertText]) > 80)
					{
						SendClientMessageEx(i, COLOR_DARKGREEN, "[Þirket Reklamý] %.80s ...", AdvertData[id][AdvertText]);
						SendClientMessageEx(i, COLOR_DARKGREEN, "[Þirket Reklamý] ...%s", AdvertData[id][AdvertText][80]);
					}
					else SendClientMessageEx(i, COLOR_DARKGREEN, "[Þirket Reklamý] %s", AdvertData[id][AdvertText]);
				}
			}
		}

		Advert_Clear(id);
	}
}

Advert_Clear(id)
{
	KillTimer(AdvertData[id][AdvertTimer]);
	AdvertData[id][AdvertTimer] = -1;

	AdvertData[id][AdvertType] = 0;
	AdvertData[id][AdvertPlaceBy] = 0;
	AdvertData[id][AdvertContact] = 0;
	AdvertData[id][PublishTime] = 0;
	Iter_Remove(Adverts, id);
	return 1;
}

Advert_GetLimit(playerid)
{
	switch(PlayerData[playerid][pDonator])
	{
	    case 0: return 1;
		case 1: return 1;
		case 2: return 2;
		case 3: return 3;
	}
	return 1;
}

//Ad
CMD:sreklam(playerid, params[])
{
	if(GetPVarInt(playerid, "AtBusiness") != -1)
	{
		new b = GetPVarInt(playerid, "AtBusiness");
		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessData[b][EnterPos][0], BusinessData[b][EnterPos][1], BusinessData[b][EnterPos][2]))
		{
			if(BusinessData[b][BusinessType] != BUSINESS_ADVERT) return SendErrorMessage(playerid, "Bu iþyeri reklam noktasý deðil.");
			if(PlayerData[playerid][pMoney] < 150) return SendErrorMessage(playerid, "Reklam vermek için yeterli paran yok. ($150)");

			new ad_text[128];
			if(sscanf(params, "s[128]",ad_text)) 
			{
				SendUsageMessage(playerid, "/sreklam [reklam metniniz]");
				return 1;
			}

			if(strlen(ad_text) < 1 || strlen(ad_text) > 128)
			{
				SendErrorMessage(playerid, "Reklamýn içeriði en az 1 karakter en fazla 128 karakter olmalýdýr.");
				return 1;
			}

			if(PlayerInQueue(playerid) > Advert_GetLimit(playerid))
			{
			    SendClientMessageEx(playerid, COLOR_ADM, "SERVER: %i kiþi sýrada görünüyor, lütfen bekleyin.", PlayerInQueue(playerid));
				return 1;
			}

			Advert_Publish(playerid, ad_text, 2);
			return 1;
		}
	}

	SendErrorMessage(playerid, "Yakýnýnda reklam noktasý yok.");
	return 1;
}

CMD:reklam(playerid, params[])
{
	if(GetPVarInt(playerid, "AtBusiness") != -1)
	{
		new b = GetPVarInt(playerid, "AtBusiness");
		if(IsPlayerInRangeOfPoint(playerid, 3.0, BusinessData[b][EnterPos][0], BusinessData[b][EnterPos][1], BusinessData[b][EnterPos][2]))
		{
			if(BusinessData[b][BusinessType] != BUSINESS_ADVERT) return SendErrorMessage(playerid, "Bu iþyeri reklam noktasý deðil.");
			if(PlayerData[playerid][pMoney] < 150) return SendErrorMessage(playerid, "Reklam vermek için yeterli paran yok. ($150)");

			new ad_text[128];
			if(sscanf(params, "s[128]",ad_text)) 
			{
				SendUsageMessage(playerid, "/reklam [reklam metniniz]");
				return 1;
			}

			if(strlen(ad_text) < 1 || strlen(ad_text) > 128)
			{
				SendErrorMessage(playerid, "Reklamýn içeriði en az 1 karakter en fazla 128 karakter olmalýdýr.");
				return 1;
			}

			if(PlayerInQueue(playerid) > Advert_GetLimit(playerid))
			{
			    SendClientMessageEx(playerid, COLOR_ADM, "SERVER: %i kiþi sýrada görünüyor, lütfen bekleyin.", PlayerInQueue(playerid));
				return 1;
			}

			Advert_Publish(playerid, ad_text, 1);
			return 1;
		}
	}
	return 1;
}

CMD:reklamsil(playerid, params[])
{
	if(!PlayerData[playerid][pAdmin]) return UnAuthMessage(playerid);
	static id;
	if(sscanf(params, "i", id)) return SendUsageMessage(playerid, "/reklamsil [reklam ID]");
	if(!Iter_Contains(Adverts, id)) return SendErrorMessage(playerid, "Belirttiðin reklam ID bulunamadý.");
	AdmWarnEx(1, sprintf("%s, %i numaralý reklamý yayýnlanacaklar listesinden kaldýrdý.", ReturnName(playerid, 1), id));
	Advert_Clear(id);
	return 1;
}
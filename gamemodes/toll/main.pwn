CMD:giseyonetim(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak için iþbaþýnda olman gerekiyor.");

	new sub[128], primary[512];
	strcat(primary, "Giþe yönetim menüsüne hoþ geldin!\n\n");
	strcat(primary, "Bu menü aracýlýðý ile giþelerin kilit durumunu yönetebilir ve\n");
	strcat(primary, "San Andreas etrafýndaki belirli giþelerin bilgilerine göz atabilirsin.\n\n");
	strcat(primary, "Bu ekranda, son 60 dakika içerisindeki\n");
	strcat(primary, "bütün giþelerin giriþ - çýkýþlarýný ve fiyatlandýrmalarýný\n");
	strcat(primary, "istatistiksel ve finansal olarak görebilirsin.\n\n");
	strcat(primary, "{85A82B}Ýstatiktiksel Bilgiler:\n");
	format(sub, sizeof(sub), "{FFFFFF}Açýk Giþeler: %i          Ödemeler: $%i          Kaç Kez Kilitlendi: %i", Toll_OpenedCount(), TotalTollPayment, TollTimesLocked);
	strcat(primary, sub);

	Dialog_Show(playerid, TOLL_LIST, DIALOG_STYLE_MSGBOX, "Giþe Yönetimi", primary, "Ýlerle", "Kapat");
	return 1;
}

CMD:gise(playerid, params[])
{
	if(GetPVarInt(playerid, "AtToll") != -1)
	{
		new t = GetPVarInt(playerid, "AtToll");
		if(IsPlayerInRangeOfPoint(playerid, 6.0, TollData[t][TollPos][0], TollData[t][TollPos][1], TollData[t][TollPos][2]))
		{
			if(TollData[t][TollStatus]) return SendClientMessage(playerid, COLOR_ADM, "Giþe Görevlisi: {FFFFFF}Giþe zaten açýk!");
			if(TollData[t][TollLocked] && !PlayerData[playerid][pLAWduty] && !PlayerData[playerid][pMEDduty])
				return SendClientMessage(playerid, COLOR_ADM, "Giþe Görevlisi: {FFFFFF}Giþeler þu anda kullanýma kapatýlmýþ.");

			if(PlayerData[playerid][pMoney] < TollData[t][TollPrice] && !PlayerData[playerid][pLAWduty])
				return SendClientMessage(playerid, COLOR_ADM, "Giþe Görevlisi: {FFFFFF}Giþelerin açýlmasý için para ödemelisin.");

			SendClientMessage(playerid, COLOR_ADM, "Giþe Görevlisi: {FFFFFF}Giþeler 6 saniyeliðine açýldý. Kapanmadan geç!");

			if(!PlayerData[playerid][pLAWduty] && !PlayerData[playerid][pMEDduty]) 
			{
				GiveMoney(playerid, -TollData[t][TollPrice]);
				TotalTollPayment += TollData[t][TollPrice];
			}

			TollData[t][TollStatus] = true;
			SetDynamicObjectRot(TollData[t][TollObject], TollData[t][TollMovePos][3], TollData[t][TollMovePos][4], TollData[t][TollMovePos][5]);
			TollData[t][TollTimer] = SetTimerEx("Toll_Close", 6000, false, "i", t);
		}
	}
	return 1;
}

Server:Toll_Close(id)
{
	SetDynamicObjectRot(TollData[id][TollObject], TollData[id][TollPos][3], TollData[id][TollPos][4], TollData[id][TollPos][5]);
	TollData[id][TollStatus] = false;
	return 1;
}

Dialog:TOLL_LIST(playerid, response, listitem, inputtext[])
{
	if(response) 
	{
		new sub[129], longstr[1024];
		format(sub, sizeof(sub), "{AFAFAF}Giþe Adý\t\t\tDurum\t\t\tAcil Durum\n");
		strcat(longstr, sub);

		foreach(new i : Tolls)
		{
			format(sub, sizeof(sub), "{FFFFFF}%s{AFAFAF}\t\t\t%s\t\t\t%s\n", TollData[i][TollName], TollData[i][TollStatus] ? ("Açýk") : ("Kapalý"), TollData[i][TollLocked] ? ("{BF605C}Kilitli") : ("{85A82B}Kilitli Deðil"));
			strcat(longstr, sub);
		}

		format(sub, sizeof(sub), "{AFAFAF}Tüm giþeleri kilitle\n{AFAFAF}Tüm giþelerin kilitlerini aç");
		strcat(longstr, sub);

		Dialog_Show(playerid, TOLL_MANAGEMENT, DIALOG_STYLE_TABLIST_HEADERS, "Giþe Yönetimi", longstr, "Seç", "Kapat");
	}
	return 1;	
}

Dialog:TOLL_MANAGEMENT(playerid, response, listitem, inputtext[])
{
	if(!response) return cmd_giseyonetim(playerid, ""); 

	new string[128];
	if(!strcmp(inputtext, "Tüm giþeleri kilitle"))
	{
		foreach(new i : Tolls) TollData[i][TollLocked] = true;
		format(string, sizeof(string), "** HQ Duyurusu: Tüm giþeler %s %s tarafýndan KÝLÝTLENDÝ! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0));
		SendLawMessage(COLOR_COP, string);
		TollTimesLocked++;
	}
	else if(!strcmp(inputtext, "Tüm giþelerin kilitlerini aç"))
	{
		foreach(new i : Tolls) TollData[i][TollLocked] = false;
		format(string, sizeof(string), "** HQ Duyurusu: Tüm giþeler %s %s tarafýndan KÝLÝDÝ AÇILDI! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0));
		SendLawMessage(COLOR_COP, string);
	}
	else
	{
		if(TollData[listitem][TollLocked])
		{
			TollData[listitem][TollLocked] = false;
			format(string, sizeof(string), "** HQ Duyurusu: %s giþesi %s %s tarafýndan KÝLÝDÝ AÇILDI! **", TollData[listitem][TollName], Player_GetFactionRank(playerid), ReturnName(playerid, 0));
			SendLawMessage(COLOR_COP, string);
		}
		else
		{
			TollData[listitem][TollLocked] = true;
			format(string, sizeof(string), "** HQ Duyurusu: %s giþesi %s %s tarafýndan KÝLÝTLENDÝ! **", TollData[listitem][TollName], Player_GetFactionRank(playerid), ReturnName(playerid, 0));
			SendLawMessage(COLOR_COP, string);
			TollTimesLocked++;
		}
	}
	return 1;
}
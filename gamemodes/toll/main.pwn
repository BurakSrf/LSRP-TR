CMD:giseyonetim(playerid, params[])
{
	if(!IsPoliceFaction(playerid)) return UnAuthMessage(playerid);
	if(!PlayerData[playerid][pLAWduty]) return SendServerMessage(playerid, "Bu komutu kullanmak i�in i�ba��nda olman gerekiyor.");

	new sub[128], primary[512];
	strcat(primary, "Gi�e y�netim men�s�ne ho� geldin!\n\n");
	strcat(primary, "Bu men� arac�l��� ile gi�elerin kilit durumunu y�netebilir ve\n");
	strcat(primary, "San Andreas etraf�ndaki belirli gi�elerin bilgilerine g�z atabilirsin.\n\n");
	strcat(primary, "Bu ekranda, son 60 dakika i�erisindeki\n");
	strcat(primary, "b�t�n gi�elerin giri� - ��k��lar�n� ve fiyatland�rmalar�n�\n");
	strcat(primary, "istatistiksel ve finansal olarak g�rebilirsin.\n\n");
	strcat(primary, "{85A82B}�statiktiksel Bilgiler:\n");
	format(sub, sizeof(sub), "{FFFFFF}A��k Gi�eler: %i          �demeler: $%i          Ka� Kez Kilitlendi: %i", Toll_OpenedCount(), TotalTollPayment, TollTimesLocked);
	strcat(primary, sub);

	Dialog_Show(playerid, TOLL_LIST, DIALOG_STYLE_MSGBOX, "Gi�e Y�netimi", primary, "�lerle", "Kapat");
	return 1;
}

CMD:gise(playerid, params[])
{
	if(GetPVarInt(playerid, "AtToll") != -1)
	{
		new t = GetPVarInt(playerid, "AtToll");
		if(IsPlayerInRangeOfPoint(playerid, 6.0, TollData[t][TollPos][0], TollData[t][TollPos][1], TollData[t][TollPos][2]))
		{
			if(TollData[t][TollStatus]) return SendClientMessage(playerid, COLOR_ADM, "Gi�e G�revlisi: {FFFFFF}Gi�e zaten a��k!");
			if(TollData[t][TollLocked] && !PlayerData[playerid][pLAWduty] && !PlayerData[playerid][pMEDduty])
				return SendClientMessage(playerid, COLOR_ADM, "Gi�e G�revlisi: {FFFFFF}Gi�eler �u anda kullan�ma kapat�lm��.");

			if(PlayerData[playerid][pMoney] < TollData[t][TollPrice] && !PlayerData[playerid][pLAWduty])
				return SendClientMessage(playerid, COLOR_ADM, "Gi�e G�revlisi: {FFFFFF}Gi�elerin a��lmas� i�in para �demelisin.");

			SendClientMessage(playerid, COLOR_ADM, "Gi�e G�revlisi: {FFFFFF}Gi�eler 6 saniyeli�ine a��ld�. Kapanmadan ge�!");

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
		format(sub, sizeof(sub), "{AFAFAF}Gi�e Ad�\t\t\tDurum\t\t\tAcil Durum\n");
		strcat(longstr, sub);

		foreach(new i : Tolls)
		{
			format(sub, sizeof(sub), "{FFFFFF}%s{AFAFAF}\t\t\t%s\t\t\t%s\n", TollData[i][TollName], TollData[i][TollStatus] ? ("A��k") : ("Kapal�"), TollData[i][TollLocked] ? ("{BF605C}Kilitli") : ("{85A82B}Kilitli De�il"));
			strcat(longstr, sub);
		}

		format(sub, sizeof(sub), "{AFAFAF}T�m gi�eleri kilitle\n{AFAFAF}T�m gi�elerin kilitlerini a�");
		strcat(longstr, sub);

		Dialog_Show(playerid, TOLL_MANAGEMENT, DIALOG_STYLE_TABLIST_HEADERS, "Gi�e Y�netimi", longstr, "Se�", "Kapat");
	}
	return 1;	
}

Dialog:TOLL_MANAGEMENT(playerid, response, listitem, inputtext[])
{
	if(!response) return cmd_giseyonetim(playerid, ""); 

	new string[128];
	if(!strcmp(inputtext, "T�m gi�eleri kilitle"))
	{
		foreach(new i : Tolls) TollData[i][TollLocked] = true;
		format(string, sizeof(string), "** HQ Duyurusu: T�m gi�eler %s %s taraf�ndan K�L�TLEND�! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0));
		SendLawMessage(COLOR_COP, string);
		TollTimesLocked++;
	}
	else if(!strcmp(inputtext, "T�m gi�elerin kilitlerini a�"))
	{
		foreach(new i : Tolls) TollData[i][TollLocked] = false;
		format(string, sizeof(string), "** HQ Duyurusu: T�m gi�eler %s %s taraf�ndan K�L�D� A�ILDI! **", Player_GetFactionRank(playerid), ReturnName(playerid, 0));
		SendLawMessage(COLOR_COP, string);
	}
	else
	{
		if(TollData[listitem][TollLocked])
		{
			TollData[listitem][TollLocked] = false;
			format(string, sizeof(string), "** HQ Duyurusu: %s gi�esi %s %s taraf�ndan K�L�D� A�ILDI! **", TollData[listitem][TollName], Player_GetFactionRank(playerid), ReturnName(playerid, 0));
			SendLawMessage(COLOR_COP, string);
		}
		else
		{
			TollData[listitem][TollLocked] = true;
			format(string, sizeof(string), "** HQ Duyurusu: %s gi�esi %s %s taraf�ndan K�L�TLEND�! **", TollData[listitem][TollName], Player_GetFactionRank(playerid), ReturnName(playerid, 0));
			SendLawMessage(COLOR_COP, string);
			TollTimesLocked++;
		}
	}
	return 1;
}
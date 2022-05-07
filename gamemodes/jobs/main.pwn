stock ReturnJobName(jobid)
{
	new job[13];

	switch (jobid)
	{
		case 0: job = "��siz";
		case 1: job = "Mekanik";
		case 2: job = "Taksi �of�r�";
		case 3: job = "Kamyoncu";
	}
	return job;
}

stock ReturnJobNameTXD(jobid)
{
	new job[13];

	switch (jobid)
	{
		case 0: job = "Issiz";
		case 1: job = "Mekanik";
		case 2: job = "Taksi Soforu";
		case 3: job = "Kamyoncu";
	}
	return job;
}

CMD:meslek(playerid, params[])
{
	new type[15], interval;
	if (sscanf(params, "s[15]I(-1)", type, interval))
	{
		SendUsageMessage(playerid, "/meslek [meslek adi]");
		SendClientMessage(playerid, COLOR_GREY, "Tipler: mekanik, kamyoncu");
		SendClientMessage(playerid, COLOR_GREY, "Ekstra: yardim, anacikis, yancikis, degistir");
		return 1;
	}

	if (!strcmp(type, "yardim", true))
	{
		if (!PlayerData[playerid][pJob]) return SendErrorMessage(playerid, "Herhangi bir ana mesle�in bulunmuyor.");

		if (PlayerData[playerid][pJob])
		{
			switch (PlayerData[playerid][pJob])
			{
				case MECHANIC_JOB:
				{
					SendClientMessageEx(playerid, COLOR_ADM, "%s Komutlar�:", ReturnJobName(PlayerData[playerid][pJob]));
					SendClientMessage(playerid, COLOR_WHITE, "/parcaal /parcadurum /aracitamiret /araciboya");
					SendClientMessage(playerid, COLOR_WHITE, "/renkler /aracicek /aracidoldur");
				}
				case TAXI_JOB:
				{
					SendClientMessageEx(playerid, COLOR_ADM, "%s Komutlar�:", ReturnJobName(PlayerData[playerid][pJob]));
					SendClientMessage(playerid, COLOR_WHITE, "/taksi [kabul / isbasi / tarife / basla / bitir]");
				}
				case TRUCKER_JOB:
				{
					SendClientMessageEx(playerid, COLOR_ADM, "%s Komutlar�:", Player_GetTruckerRank(playerid));
					SendClientMessage(playerid, COLOR_WHITE, "Ayarlanmam��, geli�tiriciye bildirin.");
					SendClientMessage(playerid, COLOR_WHITE, "Forumdaki d�k�manlar� okuyun.");
					SendClientMessage(playerid, COLOR_WHITE, "Sunucu Bilgileri -> Sistem Tan�t�mlar� -> Trucker Sistemi");
					SendClientMessage(playerid, COLOR_WHITE, "(https://forum.ls-rp.web.tr/viewtopic.php?f=10&t=185)");
					SendClientMessage(playerid, COLOR_WHITE, "Bu i�i yapabilmek i�in pikap, kamyonet veya t�ra ihtiyac�n var.");
					SendClientMessage(playerid, COLOR_WHITE, "T�m aksiyonlar i�in {FFFF00}/kargo {FFFFFF}komutunu kullan�n.");
					SendClientMessage(playerid, COLOR_WHITE, "T�m kargo noktalar� i�in {FFFF00}/tpda {FFFFFF}komutunu kullan�n.");
					SendClientMessage(playerid, COLOR_WHITE, "T�m kargo noktalar� i�in {FFFF00}/endustri {FFFFFF}komutunu kullan�n.");
					SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Bu meslekte %i saat ge�irmi�sin.", PlayerData[playerid][pJobTime]);
				}
			}
		}

		if (PlayerData[playerid][pSideJob])
		{
			switch (PlayerData[playerid][pSideJob])
			{
				case MECHANIC_JOB:
				{
					SendClientMessageEx(playerid, COLOR_ADM, "%s Komutlar�: [Yan Meslek]", ReturnJobName(PlayerData[playerid][pSideJob]));
					SendClientMessage(playerid, COLOR_WHITE, "/parcaal /parcadurum /aracitamiret /araciboya");
					SendClientMessage(playerid, COLOR_WHITE, "/renkler /aracicek /aracidoldur");
				}
				case TAXI_JOB:
				{
					SendClientMessageEx(playerid, COLOR_ADM, "%s Komutlar�: [Yan Meslek]", ReturnJobName(PlayerData[playerid][pSideJob]));
					SendClientMessage(playerid, COLOR_WHITE, "/taksi [kabul / isbasi / tarife / basla / bitir]");
				}
				case TRUCKER_JOB:
				{
					SendClientMessageEx(playerid, COLOR_ADM, "%s Komutlar�: [Yan Meslek]", Player_GetTruckerRank(playerid));
					SendClientMessage(playerid, COLOR_WHITE, "Ayarlanmam��, geli�tiriciye bildirin.");
					SendClientMessage(playerid, COLOR_WHITE, "Forumdaki d�k�manlar� okuyun.");
					SendClientMessage(playerid, COLOR_WHITE, "Sunucu Bilgileri -> Sistem Tan�t�mlar� -> Trucker Sistemi");
					SendClientMessage(playerid, COLOR_WHITE, "(https://forum.ls-rp.web.tr/viewtopic.php?f=10&t=185)");
					SendClientMessage(playerid, COLOR_WHITE, "Bu i�i yapabilmek i�in pikap, kamyonet veya t�ra ihtiyac�n var.");
					SendClientMessage(playerid, COLOR_WHITE, "T�m aksiyonlar i�in {FFFF00}/kargo {FFFFFF}komutunu kullan�n.");
					SendClientMessage(playerid, COLOR_WHITE, "T�m kargo noktalar� i�in {FFFF00}/tpda {FFFFFF}komutunu kullan�n.");
					SendClientMessage(playerid, COLOR_WHITE, "T�m kargo noktalar� i�in {FFFF00}/endustri {FFFFFF}komutunu kullan�n.");
					SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}Bu meslekte %i saat ge�irmi�sin.", PlayerData[playerid][pSideJobLevel]);
				}
			}
		}
	}
	else if (!strcmp(type, "degistir", true))
	{
		if(interval == -1) return SendUsageMessage(playerid, "/meslek degistir [(1)yanmeslek / (2)anameslek]");
		if(interval < 1 || interval > 2) return SendErrorMessage(playerid, "Hatal� meslek tipi girdin, ipucu ba��ndaki say�y� yaz.");

		switch (interval)
		{
			case 1:
			{
				if(PlayerData[playerid][pSideJob]) return SendErrorMessage(playerid, "Zaten yan mesle�indesin.");

				PlayerData[playerid][pSideJob] = PlayerData[playerid][pJob];
				PlayerData[playerid][pJob] = 0;

				SendInfoMessage(playerid, "Yan mesle�ine ge�i� yapt�n!");
				return 1;
			}
			case 2:
			{
				if(PlayerData[playerid][pJob]) return SendErrorMessage(playerid, "Zaten ana mesle�indesin.");

				PlayerData[playerid][pJob] = PlayerData[playerid][pSideJob];
				PlayerData[playerid][pSideJob] = 0;

				SendInfoMessage(playerid, "Ana mesle�ine ge�i� yapt�n!");
				return 1;
			}
		}

	}
	else if (!strcmp(type, "mekanik", true))
	{
		if(PlayerData[playerid][pDrivingTest]) return SendServerMessage(playerid, "Ehliyet s�nav�ndayken bu komutu kullanamazs�n.");
		if(PlayerData[playerid][pTaxiDrivingTest]) return SendServerMessage(playerid, "Taksi s�nav�ndayken bu komutu kullanamazs�n."); 
	    if(PlayerData[playerid][pJob]) return SendErrorMessage(playerid, "Herhangi bir mesle�in bulunuyor, ilk olarak meslekten ��kmay� dene.");

	    if(!IsPlayerInRangeOfPoint(playerid, MECHANIC_POS_RANGE, MECHANIC_POS_X, MECHANIC_POS_Y, MECHANIC_POS_Z))
	    {
     		SetPlayerCheckpoint(playerid, MECHANIC_POS_X, MECHANIC_POS_Y, MECHANIC_POS_Z, MECHANIC_POS_RANGE);
	 	   	return SendErrorMessage(playerid, "Ara� tamircisi mesle�i noktas�nda de�ilsiniz.");
		}

		PlayerData[playerid][pJob] = MECHANIC_JOB;
		InfoTD_MSG(playerid, 1, 3000, sprintf("TEBRIKLER!~n~%s MESLEGINE GIRDINIZ.~n~/meslek yardim", ReturnJobNameTXD(PlayerData[playerid][pJob])));
    }
    else if (!strcmp(type, "kamyoncu", true))
	{
		if(PlayerData[playerid][pDrivingTest]) return SendServerMessage(playerid, "Ehliyet s�nav�ndayken bu komutu kullanamazs�n.");
		if(PlayerData[playerid][pTaxiDrivingTest]) return SendServerMessage(playerid, "Taksi s�nav�ndayken bu komutu kullanamazs�n."); 
	    if(PlayerData[playerid][pJob]) return SendErrorMessage(playerid, "Herhangi bir mesle�in bulunuyor, ilk olarak meslekten ��kmay� dene.");

	    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2676.0427, -2539.7114, 13.4232))
	    {
     		SetPlayerCheckpoint(playerid, 2676.0427, -2539.7114, 13.4232, 3.0);
	 	   	return SendInfoMessage(playerid, "Kamyoncu mesle�i noktas�nda haritada i�aretlendi.");
		}

		PlayerData[playerid][pJob] = TRUCKER_JOB;
		InfoTD_MSG(playerid, 1, 3000, sprintf("TEBRIKLER!~n~%s MESLEGINE GIRDINIZ.~n~/meslek yardim", ReturnJobNameTXD(PlayerData[playerid][pJob])));
    }
    else if (!strcmp(type, "cikis", true))
	{
		if(!PlayerData[playerid][pJob]) return SendServerMessage(playerid, "Herhangi bir mesle�in bulunmuyor.");
		if(PlayerData[playerid][pJobTime] < 4) return SendServerMessage(playerid, "Mesle�ini b�rakabilmek i�in en az 4 saat ge�irmen gerekiyor.");

		PlayerData[playerid][pJob] = 0;
		PlayerData[playerid][pJobTime] = 0;
		PlayerData[playerid][pJobLevel] = 0;
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s mesle�ini b�rakt�n�z.", ReturnJobName(PlayerData[playerid][pJob]));
		return 1;
	}
 	else if (!strcmp(type, "yancikis", true))
	{
		if(!PlayerData[playerid][pSideJob]) return SendErrorMessage(playerid, "Herhangi bir yan mesle�in bulunmuyor.");
		if(PlayerData[playerid][pSideJobTime] < 4) return SendServerMessage(playerid, "Mesle�ini b�rakabilmek i�in en az 4 saat ge�irmen gerekiyor.");

		PlayerData[playerid][pSideJob] = 0;
		PlayerData[playerid][pSideJobTime] = 0;
		PlayerData[playerid][pSideJobLevel] = 0;
		SendClientMessageEx(playerid, COLOR_ADM, "[ ! ] {FFFFFF}%s mesle�ini b�rakt�n�z.", ReturnJobName(PlayerData[playerid][pSideJob]));
		return 1;
	}
    return 1;
}
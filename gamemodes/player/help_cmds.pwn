CMD:yardim(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "______________www.ls-rp.web.tr______________");
	SendClientMessage(playerid, COLOR_GRAD1, "[HESAP] /kurallar /karakter /seviyeatla /levelinfo(?) /stilayarla");
	SendClientMessage(playerid, COLOR_GRAD2, "[GENEL] /id /saat /satinal /gozbagla /yazitura /not /rapor /rsayi /lisans");
	SendClientMessage(playerid, COLOR_GRAD1, "[GENEL] /(pkr)poker /aksesuar /reklam /sreklam /kilit /ekilit /gkilit /fkilit /giris /cikis /maske /ustara");
	SendClientMessage(playerid, COLOR_GRAD2, "[GENEL] /gise /yemek /candoldur /anims /kapi /gates(?) /ozellik /incele /pitems(?) /releaseme(?) /meslek");
	SendClientMessage(playerid, COLOR_GRAD1, "[GENEL] /bar(?) /leavebar(?) /selldrink(?) /showmenu(?) /icecek /icecekver /bdrink(?) /lisanssat(?) /collect(?)");
	SendClientMessage(playerid, COLOR_GRAD2, "[GENEL] /kabuletolum /tedaviol /hasarlar /spawndegistir /isbasindakiler /sigara /jog(?)");
	SendClientMessage(playerid, COLOR_GRAD1, "[ARA�] /arac /arackirala /arackiraiptal(?) /arackapi(?) /cam /carsign /aracaat");
	SendClientMessage(playerid, COLOR_GRAD2, "[UYU�TURUCU] /uyusturucularim /ukullan /ubirak /transferdrug(?) /uver /buildpackage(?) /adjustpackage(?) /tuk /tua");
	SendClientMessage(playerid, COLOR_GRAD1, "[S�LAH] /paketlerim /silahlarim /silahbirak /silahal /unpackage(?) /sellpackage(?) /silahkoy /kontrol");
	SendClientMessage(playerid, COLOR_GRAD2, "[CHAT] /(w)hisper /low /(l)ocal(?) /b (OOC) /t(?) /tlow(?) /(s)hout /ds /cw /cb (OOC) /pm (OOC) /sohbet (OOC)");
	SendClientMessage(playerid, COLOR_GRAD1, "[EMOTELAR] /me(low) /do(low) /my /ame /amy /ddo /tokalas");
	SendClientMessage(playerid, COLOR_GRAD2, "[BANKA] /parayatir /paracek /bakiye /mevduat /transfer");
	SendClientMessage(playerid, COLOR_GRAD1, "[YARDIM] /telefonyardim /evyardim /isyeriyardim /meslekyardim /birlikyardim /balikyardim");
	SendClientMessage(playerid, COLOR_GRAD2, "[YARDIM] /radyoyardim /uyusturucuyardim /lisansyardim /ytelyardim");
	SendClientMessage(playerid, COLOR_GRAD1, "[TOG] /tog /bblok(?) /pmblok(?)");
	return 1;
}

CMD:aracyardim(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________www.ls-rp.web.tr__________________________________");
	SendClientMessage(playerid, COLOR_GRAD1, "[ARA�] /arac, /kilit, /cw, /aractanat, /far, /motor");
	SendClientMessage(playerid, COLOR_GRAD2, "[ARA�] /uns, /araccam");
	SendClientMessage(playerid, COLOR_GRAD1, "[K�RALIK] /arackirala, /arackiraiptal");
	SendClientMessage(playerid, COLOR_GRAD2, "[S�LAH] /silahkoy, /kontrol (s)ilah");
	SendClientMessage(playerid, COLOR_GRAD2, "[UYU�TURUCU] /ukoy, /kontrol (u)yusturucu");
	SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________www.ls-rp.web.tr__________________________________");
	return 1;
}

CMD:evyardim(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________www.ls-rp.web.tr__________________________________");
	SendClientMessage(playerid, COLOR_GRAD1, "[EV]  B�t�n ev komutlar� (/ev) alt�na toplanm��t�r.");
	SendClientMessage(playerid, COLOR_GRAD1, "[EV] /(ev) satinal, /(ev) sat, /kilit, /evgelistir, /evitem");
	SendClientMessage(playerid, COLOR_GRAD2, "[MOB�LYA] /mobilyaizin, /mobilyaizinal");
	SendClientMessage(playerid, COLOR_GRAD1, "[EYLEM] /kapical, /ds, /ddo, /candoldur");
	SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________www.ls-rp.web.tr__________________________________");
	return 1;
}

CMD:telefonyardim(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________www.ls-rp.web.tr__________________________________");
	SendClientMessage(playerid, COLOR_WHITE, "[TELEFON] /telefon, /tc, /ara, /(tkap)at, /tcevap(/tac), /hoparlor, /sms, /telefonpasla");
	SendClientMessage(playerid, COLOR_DARKGREEN, "__________________________________www.ls-rp.web.tr__________________________________");
	return 1;
}

CMD:isyeriyardim(playerid, params[])
{
    SendClientMessage(playerid, COLOR_RED, "__________________________________www.ls-rp.web.tr__________________________________");
    SendClientMessage(playerid, COLOR_GRAD2, "[��YER�] T�m i�yeri komutlar�n� g�rebilmek i�in /isyeri yazabilirsin.");
    SendClientMessage(playerid, COLOR_RED, "__________________________________www.ls-rp.web.tr__________________________________");
    return 1;
}

CMD:ytelyardim(playerid, params[])
{
	SendClientMessage(playerid, COLOR_DARKGREEN, "|__________________Burner Telefon_________________|");
	SendClientMessage(playerid, COLOR_YELLOW, "�PUCU: Pawnshop ve Genel ma�azalardan alabilirsin!");
	SendClientMessage(playerid, COLOR_WHITE, "/telsatinal - Burner telefon alman�z� sa�lar.");
	SendClientMessage(playerid, COLOR_WHITE, "/yedektelefon - Yedek telefonu a��p-kapatman�z� sa�lar.");
	SendClientMessage(playerid, COLOR_WHITE, "/telefondegistir - Ana telefonunuz ile Burner telefonu de�i�tirir.");
	SendClientMessage(playerid, COLOR_WHITE, "/yedektelbirak - Yedek telefonu b�rakman�z� sa�lar.");
	SendClientMessage(playerid, COLOR_DARKGREEN, "______________________________________________");
	return 1;
}

CMD:uyusturucuyardim(playerid, params[])
{
	SendClientMessage(playerid, COLOR_ADM, "Uyu�turucu Komutlar�:");
	SendClientMessage(playerid, COLOR_WHITE, "/uyusturucularim - /uver - /ubirak - /ukullan");
	SendClientMessage(playerid, COLOR_WHITE, "/ukoy (/uk) - /ual - /tumuyusturucularikoy (/tuk) - /tumuyusturucularial (/tua)");
	return 1;
}

CMD:birlikyardim(playerid, params[])
{
	if(PlayerData[playerid][pFaction] == -1) return SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}/birlikler");

	SendClientMessageEx(playerid, COLOR_ADM, "%s birli�inin komutlar�:", FactionData[PlayerData[playerid][pFaction]][FactionName]);
	SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}/birlikler, /f, /fuyeler");

	if(FactionData[PlayerData[playerid][pFaction]][FactionCopPerms])
	{
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}/isbasi, /ekipman /uniforma, /kelepce, /kelepcecoz, /callsign, /(m)egafon, /mdc, /taser, /plastikmermi, /kapikir");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}/dep(artman), /hapis, /engel, /cezakes, /acezakes, /giseyonetim, /hq, /swat, /takip, /ftakip, /apb /cctv");
		SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}/pfver, /elkoy, /siren, /rozet, /carsign, /carsign_sil, /aracbagla, /mdc, /aranmaemri, /setp, /uyustest");
	    SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Birli�inin el kitab�nda radyo frekans�n� bulabilirsin.");
	}

	if(FactionData[PlayerData[playerid][pFaction]][FactionMedPerms])
	{
	    SendClientMessage(playerid, COLOR_ADM, "->{FFFFFF} /isbasi, /uniforma, /callsign, /candoldur, /ambulansakoy, /opbitir, /hq");
	    SendClientMessage(playerid, COLOR_ADM, "[!] {FFFFFF}Birli�inin el kitab�nda radyo frekans�n� bulabilirsin.");
	}

	if(PlayerData[playerid][pFactionRank] <= FactionData[PlayerData[playerid][pFaction]][FactionEditrank])
	{
		SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}/birlikpanel /gov /hq");
	    SendClientMessage(playerid, COLOR_ADM, "-> {FFFFFF}/fdavet /fkov /frenk /fspawn /fpspawn /fkasa");
	}

	return 1;
}
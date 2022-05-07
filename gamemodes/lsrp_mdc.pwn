new PlayerText: MDC_UI[MAX_PLAYERS][61];
new PlayerText: MDC_Criminal[MAX_PLAYERS][21];
new PlayerText: MDC_WantedReasons[MAX_PLAYERS][21];
new PlayerText: MDC_PropertAddresses[MAX_PLAYERS][11];

new PlayerText: MDC_LastRequestLeft[MAX_PLAYERS][5],
	PlayerText: MDC_LastRequestRight[MAX_PLAYERS][5],
	PlayerText: MDC_LastRequestAcceptBtn[MAX_PLAYERS][5],
	PlayerText: MDC_LastRequestDetailBtn[MAX_PLAYERS][5];

MDC_Toggle(playerid, bool:toggle)
{
	if(toggle)
	{
	  	PlayerTextDrawSetString(playerid, MDC_UI[playerid][6], sprintf("%s", MDC_Page(0)));
	  	PlayerTextDrawSetString(playerid, MDC_UI[playerid][7], sprintf("%s", ReturnName(playerid)));
	    PlayerTextDrawSetPreviewModel(playerid, MDC_UI[playerid][10], GetPlayerSkin(playerid));
	 	PlayerTextDrawSetString(playerid, MDC_UI[playerid][11], sprintf("%s_%s", MDC_Duzelt(Player_GetFactionRank(playerid)), ReturnName(playerid)));
		for(new i; i < 16; i ++) PlayerTextDrawShow(playerid, MDC_UI[playerid][i]);	
		SelectTextDraw(playerid, COLOR_DARKGREEN);
		SetPVarInt(playerid, "Viewing_MDC", 1);
	}
	else
	{
		for(new i; i < 16; i ++) PlayerTextDrawHide(playerid, MDC_UI[playerid][i]);	
	    SetPVarInt(playerid, "Viewing_MDC", 0);
		CancelSelectTextDraw(playerid);
	}
	return 1;
}

MDC_Page(page)
{
	new txt[64];
	switch(page)
	{
		case 0: txt = "Los_Santos_Police_Department_-_www.pd.ls-gov.us";
		case 1: txt = "POLICE_~>~_Look-Up";
		case 2: txt = "POLICE_~>~_Emergency";
		case 3: txt = "POLICE_~>~_Roster";
		case 4: txt = "POLICE_~>~_Records_DB";
		case 5: txt = "POLICE_~>~_CCTV";
	}
	return txt;
}

/*

	MDC_UI[playerid][0] - giriþ arkaplaný
	MDC_UI[playerid][1] - anasayfa butonu
	MDC_UI[playerid][2] - kontrol et butonu
	MDC_UI[playerid][3] - acil durumu butonu
	MDC_UI[playerid][4] - ekipler butonu
	MDC_UI[playerid][5] - cctv butonu
	MDC_UI[playerid][6] - baslik
	MDC_UI[playerid][7] - karakter adi
	MDC_UI[playerid][8] - (-) butonu
	MDC_UI[playerid][9] - (x) butonu

	// Anasayfa
	MDC_UI[playerid][10] - profil resmi
	MDC_UI[playerid][11] - profil altý rütbe isim soyisim
	MDC_UI[playerid][12] - profil resmi altýný kapatan textdraw
	MDC_UI[playerid][13] - giriþ sol kýsýmdaki yazýlar iki satýr
	MDC_UI[playerid][14] - giriþ sað kýsýmdaki yazýlar üç satýr
	MDC_UI[playerid][15] - giriþ sol kýsýmdaki yazýlar sonuçlarý iki satýr
	MDC_UI[playerid][16] - giriþ sað kýsýmdaki yazýlar sonuçlarý üç satýr

	// Kontrol
	MDC_UI[playerid][17] - kontrol arkaplaný
	MDC_UI[playerid][18] - isimle arama
	MDC_UI[playerid][19] - plakayla arama
	MDC_UI[playerid][20] - yenile
	MDC_UI[playerid][21] - arama kutucuðu ve metni
	MDC_UI[playerid][22] - eslesme bulunamadi yazisi


	// Kontrol - Ýsim
	MDC_UI[playerid][23] - resim
	MDC_UI[playerid][24] - resim gizleyici
	MDC_UI[playerid][25] - profil resmi yok
	MDC_UI[playerid][26] - sol bilgi
	MDC_UI[playerid][27] - sag bilgi adressiz
	MDC_UI[playerid][28] - sag bilgi adres
	MDC_UI[playerid][29] - coklu adres
	MDC_UI[playerid][30] - lisans yonet
	MDC_UI[playerid][31] - sabika ekle
	MDC_UI[playerid][32] - tutuklama raporu
	MDC_UI[playerid][33] - önceki kriminal kayýtlarý
	MDC_WantedReasons[playerid][0-20] - þimdiki aranma sebepleri

	// Kontrol - Plaka
	MDC_UI[playerid][34] - araç resmi
	MDC_UI[playerid][35] - bilgiler sol
	MDC_UI[playerid][36] - bilgiler sag

	// Kriminal Kayýt - Listesi (MDC_UI[playerid][25])
	MDC_UI[playerid][37] - kriminal arkaplaný
	MDC_UI[playerid][38] - geri dön butonu
	MDC_UI[playerid][39] - sayfa bilgisi
	MDC_Criminal[playerid][0-20] - kayýtlar

	// Kontrol - Adresler
	MDC_UI[playerid][40] - geri dön
	MDC_UI[playerid][41] - harita
	MDC_UI[playerid][42] - secili adres
	MDC_UI[playerid][43] - secili adres yazisi
	MDC_UI[playerid][44] - diger adres
	MDC_PropertAddresses[playerid][0-10] - diðer adresler

	// Lisanslar
	MDC_UI[playerid][45] - lisans arkaplaný
	MDC_UI[playerid][46] - geri dön butonu
	MDC_UI[playerid][47] - ehliyet bilgileri
	MDC_UI[playerid][48] - silah bilgileri
	MDC_UI[playerid][49] - medik bilgileri
	MDC_UI[playerid][50] - pilot bilgileri
	MDC_UI[playerid][51] - kamyoncu bilgileri

	// ehliyet
	MDC_UI[playerid][52] - ehliyet el koy
	MDC_UI[playerid][53] - ehliyet uyar
	MDC_UI[playerid][54] - ehliyet izin ver
	MDC_UI[playerid][55] - pilot el koy
	MDC_UI[playerid][56] - silah el koy
	MDC_UI[playerid][57] - medik el koy

	// ihbarlar
	MDC_UI[playerid][58] - ihbarlar arkaplan
	MDC_UI[playerid][59] - sað
	MDC_UI[playerid][60] - sol

*/

MDC_Duzelt(string[])
{
	ReplaceText(string, "ð", "g");
	ReplaceText(string, "Ð", "G");
	ReplaceText(string, "ü", "u");
	ReplaceText(string, "Ü", "U");
	ReplaceText(string, "þ", "S");
	ReplaceText(string, "Þ", "S");
	ReplaceText(string, "ç", "c");
	ReplaceText(string, "Ç", "C");
	ReplaceText(string, "ö", "o");
	ReplaceText(string, "Ö", "O");
	ReplaceText(string, "Ý", "I");
	return 1;
}

UI_MDC(playerid)
{
	MDC_UI[playerid][0] = CreatePlayerTextDraw(playerid, 120.000000, 126.000000, "mdl-2002:giris_mdc");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][0], 4);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][0], 392.500000, 291.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][0], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][0], 0);

	MDC_UI[playerid][1] = CreatePlayerTextDraw(playerid, 156.000000, 145.000000, "ANASAYFA");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][1], 2);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][1], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][1], 0.200000, 1.200000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][1], 438.500000, 62.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][1], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][1], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][1], 50);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][1], 1);

	MDC_UI[playerid][2] = CreatePlayerTextDraw(playerid, 156.000000, 163.000000, "KONTROL ET");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][2], 0.200000, 1.200000);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][2], 1);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][2], 438.500000, 62.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][2], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][2], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][2], 50);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][2], 1);

	MDC_UI[playerid][3] = CreatePlayerTextDraw(playerid, 156.000000, 181.000000, "IHBARLAR");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][3], 0.200000, 1.200000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][3], 438.500000, 62.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][3], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][3], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][3], 1);

	MDC_UI[playerid][4] = CreatePlayerTextDraw(playerid, 156.000000, 213.000000, "EKIPLER");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][4], 0.200000, 1.200000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][4], 438.500000, 62.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][4], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][4], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][4], 1);

	MDC_UI[playerid][5] = CreatePlayerTextDraw(playerid, 156.000000, 231.000000, "CCTV");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][5], 0.200000, 1.200000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][5], 438.500000, 62.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][5], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][5], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][5], 1);

	MDC_UI[playerid][6] = CreatePlayerTextDraw(playerid, 139.000000, 129.000000, "POLICE ~>~ Kontrol Et");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][6], 0.216666, 1.049999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][6], 262.000000, -83.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][6], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][6], 0);

	MDC_UI[playerid][7] = CreatePlayerTextDraw(playerid, 424.000000, 129.000000, "KarakterAdi_KarakterSoyadi");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][7], 0.216666, 1.049999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][7], 254.500000, 117.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][7], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][7], 0);

	MDC_UI[playerid][8] = CreatePlayerTextDraw(playerid, 488.000000, 128.000000, "-");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][8], 0.216666, 1.049999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][8], 489.000000, -18.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][8], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][8], 0);

	MDC_UI[playerid][9] = CreatePlayerTextDraw(playerid, 503.000000, 128.000000, "x");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][9], 0.216666, 1.049999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][9], 489.000000, -18.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][9], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][9], 1);

	// Anasayfa
	MDC_UI[playerid][10] = CreatePlayerTextDraw(playerid, 193.000000, 155.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][10], 5);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][10], 297.500000, 182.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][10], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][10], 0);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][10], 255);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][10], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDC_UI[playerid][10], 305);
	PlayerTextDrawSetPreviewRot(playerid, MDC_UI[playerid][10], -15.000000, 0.000000, -4.000000, 0.900000);

	MDC_UI[playerid][11] = CreatePlayerTextDraw(playerid, 351.000000, 226.000000, "Chief Of Police Kevin McCavish");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][11], 0.262500, 1.450000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][11], 482.500000, 302.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][11], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][11], 255);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][11], -1313623553);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][11], 0);

	MDC_UI[playerid][12] = CreatePlayerTextDraw(playerid, 341.000000, 244.000000, "_");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][12], 0);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][12], 1.058333, 12.450001);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][12], 358.500000, 165.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][12], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][12], -589308673);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][12], -589308673);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][12], -589308673);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][12], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][12], 0);

	MDC_UI[playerid][13] = CreatePlayerTextDraw(playerid, 205.000000, 249.000000, "GOREVDEKI UYELER SON ARANMA EMIRLERI");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][13], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][13], 0.262500, 1.150001);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][13], 325.000000, 82.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][13], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][13], 255);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][13], 0);

	MDC_UI[playerid][14] = CreatePlayerTextDraw(playerid, 358.000000, 249.000000, "SON IHBARLAR     SON TUTUKLAMALAR SON CEZALAR");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][14], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][14], 0.258333, 1.150001);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][14], 467.000000, 82.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][14], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][14], 255);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][14], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][14], 0);

	MDC_UI[playerid][15] = CreatePlayerTextDraw(playerid, 331.000000, 249.000000, "128 128");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][15], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][15], 0.262500, 1.150001);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][15], 325.000000, 82.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][15], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][15], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][15], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][15], 0);

	MDC_UI[playerid][16] = CreatePlayerTextDraw(playerid, 472.000000, 249.000000, "128 128 128");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][16], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][16], 0.262500, 1.150001);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][16], 325.000000, 82.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][16], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][16], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][16], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][16], 0);

	// Kontrol
	MDC_UI[playerid][17] = CreatePlayerTextDraw(playerid, 120.000000, 126.000000, "mdl-2005:mdc_kontrol");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][17], 4);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][17], 392.500000, 291.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][17], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][17], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][17], 0);

	MDC_UI[playerid][18] = CreatePlayerTextDraw(playerid, 217.000000, 152.000000, "ISIM");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][18], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][18], 0.224999, 1.050000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][18], 234.000000, 34.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][18], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][18], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][18], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][18], 1);

	MDC_UI[playerid][19] = CreatePlayerTextDraw(playerid, 259.000000, 152.000000, "PLAKA");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][19], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][19], 0.224999, 1.050000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][19], 234.000000, 34.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][19], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][19], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][19], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][19], 1);

	MDC_UI[playerid][20] = CreatePlayerTextDraw(playerid, 487.000000, 152.000000, "YENILE");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][20], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][20], 0.224999, 1.050000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][20], 234.000000, 35.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][20], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][20], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][20], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][20], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][20], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][20], 1);

	MDC_UI[playerid][21] = CreatePlayerTextDraw(playerid, 284.000000, 152.000000, "test");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][21], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][21], 0.224998, 1.049999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][21], 461.000000, 35.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][21], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][21], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][21], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][21], -1);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][21], 1);

	MDC_UI[playerid][22] = CreatePlayerTextDraw(playerid, 200.000000, 167.000000, "HATA: Eslesme saglanamadi.");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][22], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][22], 0.191663, 1.099997);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][22], 505.000000, 34.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][22], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][22], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][22], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][22], -1962934017);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][22], -1962934017);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][22], 0);

	// Kontrol - Ýsim
	MDC_UI[playerid][23] = CreatePlayerTextDraw(playerid, 128.000000, 165.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][23], 5);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][23], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][23], 231.000000, 215.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][23], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][23], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][23], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][23], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][23], 0);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][23], 255);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][23], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][23], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][23], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDC_UI[playerid][23], 305);
	PlayerTextDrawSetPreviewRot(playerid, MDC_UI[playerid][23], -6.000000, -1.000000, 33.000000, 0.879999);
	PlayerTextDrawSetPreviewVehCol(playerid, MDC_UI[playerid][23], 1, 1);

	MDC_UI[playerid][24] = CreatePlayerTextDraw(playerid, 245.000000, 247.000000, "_");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][24], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][24], 0.616666, 15.300003);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][24], 298.500000, 83.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][24], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][24], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][24], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][24], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][24], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][24], -572662273);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][24], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][24], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][24], 0);

	MDC_UI[playerid][25] = CreatePlayerTextDraw(playerid, 240.000000, 167.000000, "Profil Resmi Yok");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][25], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][25], 0.483333, 2.749997);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][25], 285.500000, 78.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][25], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][25], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][25], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][25], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][25], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][25], 225);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][25], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][25], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][25], 0);

	MDC_UI[playerid][26] = CreatePlayerTextDraw(playerid, 284.000000, 177.000000, "Isim: Numara: Sabika: Lisanslar: Adres:");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][26], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][26], 0.224997, 1.049998);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][26], 346.000000, 35.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][26], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][26], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][26], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][26], 255);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][26], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][26], -1061109505);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][26], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][26], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][26], 0);

	MDC_UI[playerid][27] = CreatePlayerTextDraw(playerid, 341.000000, 177.000000, "Kevin_McCavish~n~12435243543~n~5 kodes cezasi, 1 hapis cezasi~n~Surucu, silah lisansi");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][27], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][27], 0.224997, 1.049998);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][27], 496.000000, 35.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][27], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][27], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][27], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][27], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][27], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][27], -1061109505);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][27], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][27], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][27], 0);

	MDC_UI[playerid][28] = CreatePlayerTextDraw(playerid, 341.000000, 215.000000, "810 Market Street~n~Marina~n~Los Santos, 313");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][28], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][28], 0.224997, 1.049998);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][28], 496.000000, 35.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][28], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][28], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][28], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][28], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][28], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][28], -1061109505);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][28], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][28], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][28], 1);

	MDC_UI[playerid][29] = CreatePlayerTextDraw(playerid, 200.000000, 247.000000, "] Bu kisi birden fazla adrese sahip, tiklayarak hepsini gorebilirsin.");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][29], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][29], 0.191664, 1.099998);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][29], 505.000000, 34.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][29], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][29], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][29], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][29], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][29], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][29], -16900353);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][29], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][29], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][29], 1);

	MDC_UI[playerid][30] = CreatePlayerTextDraw(playerid, 200.000000, 264.000000, "~>~ LISANSLARI YONET");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][30], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][30], 0.224997, 1.049998);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][30], 360.500000, 34.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][30], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][30], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][30], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][30], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][30], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][30], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][30], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][30], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][30], 1);

	MDC_UI[playerid][31] = CreatePlayerTextDraw(playerid, 200.000000, 281.000000, "~>~ SABIKA EKLE");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][31], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][31], 0.224997, 1.049998);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][31], 360.500000, 34.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][31], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][31], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][31], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][31], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][31], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][31], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][31], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][31], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][31], 1);

	MDC_UI[playerid][32] = CreatePlayerTextDraw(playerid, 200.000000, 298.000000, "~>~ TUTUKLAMA RAPORU YAZ");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][32], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][32], 0.224997, 1.049998);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][32], 360.500000, 34.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][32], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][32], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][32], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][32], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][32], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][32], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][32], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][32], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][32], 1);

	MDC_UI[playerid][33] = CreatePlayerTextDraw(playerid, 435.000000, 264.000000, "] KRIMINAL KAYITLARI ]");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][33], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][33], 0.224997, 1.049998);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][33], 577.500000, 137.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][33], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][33], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][33], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][33], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][33], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][33], 858993663);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][33], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][33], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][33], 1);

	/*new 
		Float: wanted_reasons = 279.000000;

	for(new i; i < 21; ++i)
	{
		MDC_WantedReasons[playerid][i] = CreatePlayerTextDraw(playerid, 366.000000, wanted_reasons ? wanted_reasons+10.000000 : wanted_reasons, "Aranma sebebi yok.");
		PlayerTextDrawFont(playerid, MDC_WantedReasons[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, MDC_WantedReasons[playerid][i], 0.224997, 1.049998);
		PlayerTextDrawTextSize(playerid, MDC_WantedReasons[playerid][i], 503.500000, 35.500000);
		PlayerTextDrawSetOutline(playerid, MDC_WantedReasons[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, MDC_WantedReasons[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, MDC_WantedReasons[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_WantedReasons[playerid][i], 255);
		PlayerTextDrawBackgroundColor(playerid, MDC_WantedReasons[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, MDC_WantedReasons[playerid][i], -1061109505);
		PlayerTextDrawUseBox(playerid, MDC_WantedReasons[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, MDC_WantedReasons[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, MDC_WantedReasons[playerid][i], 0);
	}*/

	// Kontrol - Plaka
	MDC_UI[playerid][34] = CreatePlayerTextDraw(playerid, 195.000000, 144.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][34], 5);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][34], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][34], 112.500000, 115.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][34], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][34], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][34], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][34], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][34], 0);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][34], 255);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][34], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][34], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][34], 0);
	PlayerTextDrawSetPreviewModel(playerid, MDC_UI[playerid][34], 411);
	PlayerTextDrawSetPreviewRot(playerid, MDC_UI[playerid][34], -5.000000, -1.000000, 86.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, MDC_UI[playerid][34], 1, 1);

	MDC_UI[playerid][35] = CreatePlayerTextDraw(playerid, 313.000000, 177.000000, "Model: Plaka: Sahip: Sigorta: Cekilmis: Cezalar:");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][35], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][35], 0.224998, 1.049999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][35], 346.000000, 35.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][35], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][35], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][35], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][35], 255);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][35], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][35], -1061109505);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][35], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][35], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][35], 0);

	MDC_UI[playerid][36] = CreatePlayerTextDraw(playerid, 363.000000, 177.000000, "2018 Range Rover~n~34GMG345~n~Kevin_McCavish~n~Sigorta Yok~n~Hayir~n~Yok");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][36], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][36], 0.224998, 1.049999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][36], 496.000000, 35.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][36], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][36], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][36], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][36], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][36], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][36], -1061109505);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][36], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][36], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][36], 0);

	// Kriminal Kayýt - Listesi (MDC_UI[playerid][25])
	MDC_UI[playerid][37] = CreatePlayerTextDraw(playerid, 120.000000, 126.000000, "mdl-2004:mdc_kriminal");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][37], 4);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][37], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][37], 392.500000, 291.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][37], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][37], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][37], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][37], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][37], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][37], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][37], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][37], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][37], 0);

	MDC_UI[playerid][38] = CreatePlayerTextDraw(playerid, 196.000000, 143.000000, "~<~ Kevin McCavish Geri Don");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][38], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][38], 0.170833, 1.300000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][38], 313.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][38], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][38], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][38], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][38], 1296911788);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][38], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][38], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][38], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][38], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][38], 1);

	MDC_UI[playerid][39] = CreatePlayerTextDraw(playerid, 336.000000, 405.000000, "10/10");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][39], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][39], 0.208333, 0.999998);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][39], 359.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][39], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][39], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][39], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][39], 1296911871);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][39], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][39], 1296911788);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][39], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][39], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][39], 0);

	/*new 
		Float: criminal_base = 157.000000;

	for(new i; i < 21; ++i)
	{
		MDC_Criminal[playerid][i] = CreatePlayerTextDraw(playerid, 200.000000, criminal_base ? criminal_base+14.000000 : criminal_base, "08/06/2020 ->");
		PlayerTextDrawFont(playerid, MDC_Criminal[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, MDC_Criminal[playerid][i], 0.208333, 0.999998);
		PlayerTextDrawTextSize(playerid, MDC_Criminal[playerid][i], 505.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, MDC_Criminal[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, MDC_Criminal[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, MDC_Criminal[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_Criminal[playerid][i], 1296911871);
		PlayerTextDrawBackgroundColor(playerid, MDC_Criminal[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, MDC_Criminal[playerid][i], 1296911788);
		PlayerTextDrawUseBox(playerid, MDC_Criminal[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_Criminal[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, MDC_Criminal[playerid][i], 1);	
	}*/

	// Kontrol - Adresler
	MDC_UI[playerid][40] = CreatePlayerTextDraw(playerid, 196.000000, 143.000000, "~<~ Kevin McCavish Geri Don");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][40], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][40], 0.170833, 1.300000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][40], 313.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][40], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][40], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][40], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][40], 1296911788);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][40], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][40], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][40], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][40], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][40], 1);

	MDC_UI[playerid][41] = CreatePlayerTextDraw(playerid, 326.000000, 145.000000, "samaps:map");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][41], 4);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][41], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][41], 181.500000, 167.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][41], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][41], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][41], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][41], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][41], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][41], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][41], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][41], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][41], 0);

	MDC_UI[playerid][42] = CreatePlayerTextDraw(playerid, 200.000000, 159.000000, "Secili Adres");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][42], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][42], 0.245833, 1.300000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][42], 313.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][42], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][42], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][42], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][42], 172);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][42], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][42], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][42], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][42], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][42], 0);

	MDC_UI[playerid][43] = CreatePlayerTextDraw(playerid, 200.000000, 172.000000, "1403 Martin Luther King Drive~n~Idlewood Los Santos,  415~n~San Andreas");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][43], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][43], 0.216667, 1.250000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][43], 313.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][43], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][43], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][43], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][43], 1296911788);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][43], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][43], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][43], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][43], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][43], 1);

	MDC_UI[playerid][44] = CreatePlayerTextDraw(playerid, 200.000000, 208.000000, "Diger Adresler");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][44], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][44], 0.245833, 1.300000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][44], 313.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][44], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][44], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][44], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][44], 172);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][44], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][44], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][44], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][44], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][44], 0);

	/*new 
		Float: adres_base = 225.000000;

	for(new i; i < 11; ++i)
	{
		MDC_PropertAddresses[playerid][i] = CreatePlayerTextDraw(playerid, 200.000000, adres_base ? adres_base+18.000000 : adres_base, "- 240 Alandele Avenue");
		PlayerTextDrawFont(playerid, MDC_PropertAddresses[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, MDC_PropertAddresses[playerid][i], 0.216667, 1.250000);
		PlayerTextDrawTextSize(playerid, MDC_PropertAddresses[playerid][i], 313.000000, 17.000000);
		PlayerTextDrawSetOutline(playerid, MDC_PropertAddresses[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, MDC_PropertAddresses[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, MDC_PropertAddresses[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_PropertAddresses[playerid][i], 1296911788);
		PlayerTextDrawBackgroundColor(playerid, MDC_PropertAddresses[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, MDC_PropertAddresses[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, MDC_PropertAddresses[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_PropertAddresses[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, MDC_PropertAddresses[playerid][i], 1);
	}*/

	// Lisanlar
	MDC_UI[playerid][45] = CreatePlayerTextDraw(playerid, 120.000000, 126.000000, "mdl-2003:mdc_lisanslar");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][45], 4);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][45], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][45], 392.500000, 291.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][45], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][45], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][45], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][45], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][45], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][45], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][45], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][45], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][45], 0);

	MDC_UI[playerid][46] = CreatePlayerTextDraw(playerid, 196.000000, 143.000000, "~<~ Kevin McCavish Geri Don");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][46], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][46], 0.170833, 1.300000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][46], 313.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][46], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][46], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][46], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][46], 1296911788);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][46], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][46], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][46], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][46], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][46], 1);

	MDC_UI[playerid][47] = CreatePlayerTextDraw(playerid, 261.000000, 172.000000, "~g~Gecerli ~l~0");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][47], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][47], 0.291666, 1.299999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][47], 299.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][47], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][47], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][47], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][47], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][47], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][47], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][47], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][47], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][47], 0);

	MDC_UI[playerid][48] = CreatePlayerTextDraw(playerid, 424.000000, 171.000000, "~g~Gecerli ~l~N/A N/A");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][48], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][48], 0.291666, 1.299999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][48], 299.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][48], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][48], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][48], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][48], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][48], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][48], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][48], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][48], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][48], 0);

	MDC_UI[playerid][49] = CreatePlayerTextDraw(playerid, 424.000000, 253.000000, "~g~Gecerli ~l~N/A");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][49], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][49], 0.291666, 1.299999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][49], 299.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][49], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][49], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][49], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][49], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][49], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][49], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][49], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][49], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][49], 0);

	MDC_UI[playerid][50] = CreatePlayerTextDraw(playerid, 261.000000, 255.000000, "~g~Gecersiz");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][50], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][50], 0.291666, 1.299999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][50], 299.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][50], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][50], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][50], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][50], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][50], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][50], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][50], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][50], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][50], 0);

	MDC_UI[playerid][51] = CreatePlayerTextDraw(playerid, 265.000000, 336.000000, "~g~Gecerli ~l~Profesyonel Kurye");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][51], 1);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][51], 0.291666, 1.299999);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][51], 354.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][51], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][51], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][51], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][51], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][51], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][51], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][51], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][51], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][51], 0);

	MDC_UI[playerid][52] = CreatePlayerTextDraw(playerid, 203.000000, 215.000000, "EL KOY");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][52], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][52], 0.212500, 1.450000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][52], 234.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][52], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][52], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][52], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][52], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][52], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][52], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][52], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][52], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][52], 1);

	MDC_UI[playerid][53] = CreatePlayerTextDraw(playerid, 246.000000, 215.000000, "UYAR");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][53], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][53], 0.212500, 1.450000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][53], 274.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][53], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][53], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][53], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][53], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][53], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][53], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][53], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][53], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][53], 1);

	MDC_UI[playerid][54] = CreatePlayerTextDraw(playerid, 281.000000, 215.000000, "IZIN VER");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][54], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][54], 0.212500, 1.450000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][54], 321.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][54], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][54], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][54], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][54], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][54], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][54], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][54], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][54], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][54], 1);

	MDC_UI[playerid][55] = CreatePlayerTextDraw(playerid, 203.000000, 299.000000, "EL KOY");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][55], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][55], 0.212500, 1.450000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][55], 234.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][55], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][55], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][55], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][55], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][55], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][55], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][55], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][55], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][55], 1);

	MDC_UI[playerid][56] = CreatePlayerTextDraw(playerid, 359.000000, 215.000000, "EL KOY");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][56], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][56], 0.212500, 1.450000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][56], 395.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][56], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][56], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][56], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][56], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][56], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][56], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][56], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][56], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][56], 1);

	MDC_UI[playerid][57] = CreatePlayerTextDraw(playerid, 359.000000, 298.000000, "EL KOY");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][57], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][57], 0.212500, 1.450000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][57], 395.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][57], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][57], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][57], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][57], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][57], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][57], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][57], 0);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][57], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][57], 1);

	// Ýhbarlar
	MDC_UI[playerid][58] = CreatePlayerTextDraw(playerid, 120.000000, 126.000000, "mdl-2006:mdc_ihbarlar");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][58], 4);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][58], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][58], 392.500000, 291.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][58], 1);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][58], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][58], 1);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][58], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][58], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][58], 50);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][58], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][58], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][58], 0);

	MDC_UI[playerid][59] = CreatePlayerTextDraw(playerid, 428.000000, 404.000000, "~>~");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][59], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][59], 0.291666, 1.200000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][59], 10.500000, 156.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][59], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][59], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][59], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][59], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][59], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][59], 1465342207);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][59], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][59], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][59], 1);

	MDC_UI[playerid][60] = CreatePlayerTextDraw(playerid, 278.000000, 404.000000, "~<~");
	PlayerTextDrawFont(playerid, MDC_UI[playerid][60], 2);
	PlayerTextDrawLetterSize(playerid, MDC_UI[playerid][60], 0.291666, 1.200000);
	PlayerTextDrawTextSize(playerid, MDC_UI[playerid][60], 10.500000, 156.500000);
	PlayerTextDrawSetOutline(playerid, MDC_UI[playerid][60], 0);
	PlayerTextDrawSetShadow(playerid, MDC_UI[playerid][60], 0);
	PlayerTextDrawAlignment(playerid, MDC_UI[playerid][60], 2);
	PlayerTextDrawColor(playerid, MDC_UI[playerid][60], -1);
	PlayerTextDrawBackgroundColor(playerid, MDC_UI[playerid][60], 255);
	PlayerTextDrawBoxColor(playerid, MDC_UI[playerid][60], 1465342207);
	PlayerTextDrawUseBox(playerid, MDC_UI[playerid][60], 1);
	PlayerTextDrawSetProportional(playerid, MDC_UI[playerid][60], 1);
	PlayerTextDrawSetSelectable(playerid, MDC_UI[playerid][60], 1);

	/*new 
		Float: em_text = 147.000000,
		Float: btn_text = 189.000000;

	for(new i; i < 5; ++i)
	{
		MDC_LastRequestLeft[playerid][i] = CreatePlayerTextDraw(playerid, 200.000000, em_text ? em_text+64.000000 : em_text, "Arayan: Servis: Lokasyon: Aciklama: Tarih: Durum:");
		PlayerTextDrawFont(playerid, MDC_LastRequestLeft[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, MDC_LastRequestLeft[playerid][i], 0.283333, 1.049998);
		PlayerTextDrawTextSize(playerid, MDC_LastRequestLeft[playerid][i], 226.500000, 17.000000);
		PlayerTextDrawSetOutline(playerid, MDC_LastRequestLeft[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, MDC_LastRequestLeft[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, MDC_LastRequestLeft[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_LastRequestLeft[playerid][i], 255);
		PlayerTextDrawBackgroundColor(playerid, MDC_LastRequestLeft[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, MDC_LastRequestLeft[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, MDC_LastRequestLeft[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, MDC_LastRequestLeft[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, MDC_LastRequestLeft[playerid][i], 0);

		MDC_LastRequestRight[playerid][i] = CreatePlayerTextDraw(playerid, 248.000000, em_text ? em_text+64.000000 : em_text, "#1338 Kevin_McCavish~n~Kevin_McCavish~n~Verona Mall~n~Bicakli saldiri~n~08/06/2020~n~~r~Beklemede");
		PlayerTextDrawFont(playerid, MDC_LastRequestRight[playerid][i], 1);
		PlayerTextDrawLetterSize(playerid, MDC_LastRequestRight[playerid][i], 0.283333, 1.049998);
		PlayerTextDrawTextSize(playerid, MDC_LastRequestRight[playerid][i], 409.500000, 17.000000);
		PlayerTextDrawSetOutline(playerid, MDC_LastRequestRight[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, MDC_LastRequestRight[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, MDC_LastRequestRight[playerid][i], 1);
		PlayerTextDrawColor(playerid, MDC_LastRequestRight[playerid][i], -741092353);
		PlayerTextDrawBackgroundColor(playerid, MDC_LastRequestRight[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, MDC_LastRequestRight[playerid][i], 50);
		PlayerTextDrawUseBox(playerid, MDC_LastRequestRight[playerid][i], 0);
		PlayerTextDrawSetProportional(playerid, MDC_LastRequestRight[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, MDC_LastRequestRight[playerid][i], 0);

		MDC_LastRequestAcceptBtn[playerid][i] = CreatePlayerTextDraw(playerid, 427.000000, btn_text ? btn_text+65.000000 : btn_text, "YONLEN");
		PlayerTextDrawFont(playerid, MDC_LastRequestAcceptBtn[playerid][i], 2);
		PlayerTextDrawLetterSize(playerid, MDC_LastRequestAcceptBtn[playerid][i], 0.258332, 1.750000);
		PlayerTextDrawTextSize(playerid, MDC_LastRequestAcceptBtn[playerid][i], 10.500000, 50.500000);
		PlayerTextDrawSetOutline(playerid, MDC_LastRequestAcceptBtn[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, MDC_LastRequestAcceptBtn[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, MDC_LastRequestAcceptBtn[playerid][i], 2);
		PlayerTextDrawColor(playerid, MDC_LastRequestAcceptBtn[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, MDC_LastRequestAcceptBtn[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, MDC_LastRequestAcceptBtn[playerid][i], -2078135553);
		PlayerTextDrawUseBox(playerid, MDC_LastRequestAcceptBtn[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_LastRequestAcceptBtn[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, MDC_LastRequestAcceptBtn[playerid][i], 1);

		MDC_LastRequestDetailBtn[playerid][i] = CreatePlayerTextDraw(playerid, 481.000000, btn_text ? btn_text+65.000000 : btn_text, "DETAY");
		PlayerTextDrawFont(playerid, MDC_LastRequestDetailBtn[playerid][i], 2);
		PlayerTextDrawLetterSize(playerid, MDC_LastRequestDetailBtn[playerid][i], 0.229166, 1.799999);
		PlayerTextDrawTextSize(playerid, MDC_LastRequestDetailBtn[playerid][i], 10.500000, 50.500000);
		PlayerTextDrawSetOutline(playerid, MDC_LastRequestDetailBtn[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, MDC_LastRequestDetailBtn[playerid][i], 0);
		PlayerTextDrawAlignment(playerid, MDC_LastRequestDetailBtn[playerid][i], 2);
		PlayerTextDrawColor(playerid, MDC_LastRequestDetailBtn[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, MDC_LastRequestDetailBtn[playerid][i], 255);
		PlayerTextDrawBoxColor(playerid, MDC_LastRequestDetailBtn[playerid][i], 589374975);
		PlayerTextDrawUseBox(playerid, MDC_LastRequestDetailBtn[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, MDC_LastRequestDetailBtn[playerid][i], 1);
		PlayerTextDrawSetSelectable(playerid, MDC_LastRequestDetailBtn[playerid][i], 1);
	}*/
	return 1;
}	



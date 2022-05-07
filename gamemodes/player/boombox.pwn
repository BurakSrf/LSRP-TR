CMD:boombox(playerid, params[])
{
	new specifier[40], specifier_ex[40];
	if (sscanf(params, "s[40]S()[40]", specifier, specifier_ex))
	{
		SendUsageMessage(playerid, "/boombox [eylem]");
		SendClientMessage(playerid, COLOR_ADM, "[Eylem] koy, duzenle, yoket, al, ver");
		SendClientMessage(playerid, COLOR_ADM, "** /istasyon komutunu kullanarak kanal ayarlayabilirsin. **");
		return 1;
	}

	if (!PlayerData[playerid][pHasBoombox]) return SendErrorMessage(playerid, "Boombox'un yok.");

	if (!strcmp(specifier, "koy"))
	{
		if (Boombox_Placed(playerid) != -1) return SendErrorMessage(playerid, "Zaten bir boombox koymuþsun.");
		if (Boombox_Nearest(playerid) != -1) return SendErrorMessage(playerid, "Yakýnlarýnda bir yere boombox koyulmuþ.");

		Boombox_Create(playerid);
		return 1;
	}
	else if (!strcmp(specifier, "duzenle"))
	{
		static id = -1;
		if((id = Boombox_Nearest(playerid, 4.0)) == -1) return SendErrorMessage(playerid, "Yakýnýnda boombox yok.");
		if (BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu boombox senin deðil.");

		EditingID[playerid] = id;
		EditingObject[playerid] = 14;
		EditDynamicObject(playerid, BoomboxData[id][BoomboxObject]);
		return 1;
	}
	else if (!strcmp(specifier, "yoket"))
	{
		static id = -1;
		if((id = Boombox_Nearest(playerid, 4.0)) == -1) return SendErrorMessage(playerid, "Yakýnýnda boombox yok.");
		if (BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu boombox senin deðil.");
		SendClientMessage(playerid, COLOR_DARKGREEN, "SERVER: Boombox'unu yokettin.");
		foreach (new i : Player) if(Boombox_Nearest(i, 10.0) != -1) StopAudioStreamForPlayer(i);
		PlayerData[playerid][pHasBoombox] = false;
		Boombox_Delete(id);
		return 1;
	}
	else if (!strcmp(specifier, "al"))
	{
		static id = -1;
		if((id = Boombox_Nearest(playerid, 4.0)) == -1) return SendErrorMessage(playerid, "Yakýnýnda boombox yok.");
		if (BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu boombox senin deðil.");
		SendClientMessage(playerid, COLOR_DARKGREEN, "SERVER: Boombox'unu kaldýrdýn, tekrar yerleþtirmek için /boombox koy yazabilirsin.");
		foreach (new i : Player) if(Boombox_Nearest(i, 10.0) != -1) StopAudioStreamForPlayer(i);
		Boombox_Delete(id);
		return 1;
	}
	else if (!strcmp(specifier, "ver"))
	{
		static id = -1, playerb;
		if((id = Boombox_Nearest(playerid, 4.0)) == -1) return SendErrorMessage(playerid, "Yakýnýnda boombox yok.");
		if (BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu boombox senin deðil.");
		if (sscanf(specifier_ex, "u", playerb)) return SendUsageMessage(playerid, "/boombox ver [oyuncu ID/isim]");
		if(!IsPlayerConnected(playerb)) return SendErrorMessage(playerid, "Belirttiðiniz kiþi oyunda yok.");
		if(!pLoggedIn[playerb]) return SendErrorMessage(playerid, "Belirttiðiniz kiþi henüz þifresini girmemiþ.");
		if(!GetDistanceBetweenPlayers(playerid, playerb, 4.5)) return SendErrorMessage(playerid, "Belirttiðin kiþiye yakýn deðilsin.");
		if (PlayerData[playerb][pHasBoombox]) return SendErrorMessage(playerid, "Belirttiðin kiþinin zaten boomboxý var.");
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: %s adlý kiþiye Boombox verdin.", ReturnName(playerb, 0));
		SendClientMessageEx(playerb, COLOR_DARKGREEN, "SERVER: %s sana Boombox'unu verdi.", ReturnName(playerid, 0));
		BoomboxData[id][BoomboxOwnerID] = PlayerData[playerb][pSQLID];
		PlayerData[playerid][pHasBoombox] = false;
		return 1;
	}
	else SendClientMessage(playerid, COLOR_ADM, "SERVER: Hatalý parametre girdiniz.");
	return 1;
}

CMD:fixr(playerid, params[]) return StopAudioStreamForPlayer(playerid);

CMD:istasyon(playerid, params[])
{
	if (!strcmp(params, "kapat"))
	{
		new id = -1; 
		if((id = Boombox_Nearest(playerid, 4.0)) != -1)
		{
			if(BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID] && !PlayerData[playerid][pAdmin]) return SendErrorMessage(playerid, "Bu boomboxa eriþimin yok.");
			if(!BoomboxData[id][BoomboxStatus]) return SendServerMessage(playerid, "Zaten bu boombox çalýþmýyor.");

			foreach (new i : Player) if(Boombox_Nearest(i, 10.0) == id)
			{
				SendClientMessage(i, COLOR_DARKGREEN, "SERVER: Boombox durduruldu.");
				StopAudioStreamForPlayer(i);
			}

			BoomboxData[id][BoomboxStatus] = false;
			return 1;
		}

		if(IsPlayerInAnyVehicle(playerid))
		{
			if(GetPlayerVehicleSeat(playerid) > 1) return SendErrorMessage(playerid, "Ön tarafta oturan kiþiler radyoyu ayarlayabilir.");
			
			new vehicleid = GetPlayerVehicleID(playerid);
			if(!CarData[vehicleid][carXMR]) return SendServerMessage(playerid, "Bu aracýn XM radyosu yok.");
			if(!CarData[vehicleid][carXMROn]) return SendServerMessage(playerid, "Zaten bu araçta XMR radyosu çalýþmýyor.");

			foreach (new i : Player) if(IsPlayerInVehicle(i, vehicleid))
			{	
				SendClientMessage(i, COLOR_DARKGREEN, "SERVER: Radyo durduruldu.");
				StopAudioStreamForPlayer(i);
			}

			CarData[vehicleid][carXMROn] = false;
			return 1;
		}

		if((id = IsPlayerInProperty(playerid)) != -1)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[id][PropertyXMR][0], PropertyData[id][PropertyXMR][1], PropertyData[id][PropertyXMR][2]))
			{
				if(PropertyData[id][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendServerMessage(playerid, "Bu eve sahip deðilsin.");
				if(!PropertyData[id][PropertyXMROn]) return SendServerMessage(playerid, "Bu radyo zaten çalýþmýyor.");

				foreach (new i : Player) if (IsPlayerInProperty(i) == id)
				{
					SendClientMessage(i, COLOR_DARKGREEN, "SERVER: Radyo durduruldu.");
					StopAudioStreamForPlayer(i);
				}

				PropertyData[id][PropertyXMROn] = false;
				return 1;
			}
		}

		if((id = IsPlayerInBusiness(playerid)) != -1)
		{
			if(BusinessData[id][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu iþyerine sahip deðilsin.");
			if(!BusinessData[id][BusinessXMROn]) return SendServerMessage(playerid, "Bu radyo zaten çalýþmýyor.");

			foreach(new i : Player) if(IsPlayerInBusiness(i) == id)
			{
				SendClientMessage(i, COLOR_DARKGREEN, "SERVER: Radyo durduruldu.");
				StopAudioStreamForPlayer(i);
			}

			BusinessData[id][BusinessXMROn] = false;
			return 1;
		}

		SendClientMessage(playerid, COLOR_DARKGREEN, "SERVER: Radyoya yakýn deðilsin.");
		return 1;
	}
	else
	{
		new id = -1, near_anything = 0;
		if((id = Boombox_Nearest(playerid, 4.0)) != -1)
		{
			if(BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID] && !PlayerData[playerid][pAdmin])
				return SendErrorMessage(playerid, "Bu boomboxa eriþimin yok.");

			near_anything++;
		}

		if(IsPlayerInAnyVehicle(playerid))
		{
			if(GetPlayerVehicleSeat(playerid) > 1) return SendErrorMessage(playerid, "Ön tarafta oturan kiþiler radyoyu ayarlayabilir.");
			if(!CarData[GetPlayerVehicleID(playerid)][carXMR]) return SendServerMessage(playerid, "Bu aracýn XM radyosu yok.");
			
			near_anything++;
		}

		if((id = IsPlayerInProperty(playerid)) != -1)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[id][PropertyXMR][0], PropertyData[id][PropertyXMR][1], PropertyData[id][PropertyXMR][2]))
			{
				if(PropertyData[id][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip deðilsin.");
				if(!PropertyData[id][PropertyHasXMR]) return SendErrorMessage(playerid, "Bu evin XM radyosu yok.");
				near_anything++;
			}
		}

		if((id = IsPlayerInBusiness(playerid)) != -1)
		{
			if(BusinessData[id][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu iþyerine sahip deðilsin.");
			if(!BusinessData[id][BusinessHasXMR]) return SendServerMessage(playerid, "Bu iþyerinin XM radyosu yok.");
			near_anything++;
		}

		if(!near_anything) return SendErrorMessage(playerid, "Herhangi bir radyoya yakýn deðilsin.");

		if(sscanf(params, "i", id))
		{
			ShowXMRDialog(playerid);
			return 1;
		}

		if(!XMRData[id][xmrID]) return SendErrorMessage(playerid, "Geçersiz istasyon ID belirttin.");
        cmd_ame(playerid, sprintf("radyo üzerinde %s kanalýný açar.", XMRData[id][xmrName]));
 
 		new idx = -1;
		if((idx = Boombox_Nearest(playerid, 4.0)) != -1)
		{
			foreach (new i : Player) if(Boombox_Nearest(i, 25.0) == idx)
			{
				SendClientMessageEx(i, COLOR_ADM, "SERVER: Radyo istasyonu %s olarak deðiþtirildi.", XMRData[id][xmrName]);
				PlayAudioStreamForPlayer(i, XMRData[id][xmrStationURL], BoomboxData[idx][BoomboxLocation][0], BoomboxData[idx][BoomboxLocation][1], BoomboxData[idx][BoomboxLocation][2], 25.0, 1);
			}

			format(BoomboxData[idx][BoomboxURL], 128, "%s", XMRData[id][xmrStationURL]);
			BoomboxData[idx][BoomboxStatus] = true;
			return 1;
		}

		if((idx = IsPlayerInProperty(playerid)) != -1)
		{
			foreach(new i : Player) if(IsPlayerInProperty(i) == idx)
			{
				SendClientMessageEx(i, COLOR_ADM, "SERVER: Radyo istasyonu %s olarak deðiþtirildi.", XMRData[id][xmrName]);
				PlayAudioStreamForPlayer(i, XMRData[id][xmrStationURL]);
			}

			format(PropertyData[idx][PropertyXMRUrl], 128, "%s", XMRData[id][xmrStationURL]);
			PropertyData[idx][PropertyXMROn] = true;
			return 1;
		}

		if((idx = IsPlayerInBusiness(playerid)) != -1)
		{
			foreach(new i : Player) if(IsPlayerInBusiness(i) == id)
			{
				SendClientMessageEx(i, COLOR_ADM, "SERVER: Radyo istasyonu %s olarak deðiþtirildi.", XMRData[id][xmrName]);
				PlayAudioStreamForPlayer(i, XMRData[id][xmrStationURL]);
			}

			format(BusinessData[idx][BusinessXMRUrl], 128, "%s", XMRData[SubXMRHolder[playerid]][xmrStationURL]);
			BusinessData[idx][BusinessXMROn] = true;
			return 1;
		}

		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			foreach(new i : Player) if(IsPlayerInVehicle(i, vehicleid))
			{
				SendClientMessageEx(i, COLOR_ADM, "SERVER: Radyo istasyonu %s olarak deðiþtirildi.", XMRData[id][xmrName]);
				PlayAudioStreamForPlayer(i, XMRData[id][xmrStationURL]);
			}

			format(CarData[vehicleid][carXMRUrl], 128, "%s", XMRData[id][xmrStationURL]);
			CarData[vehicleid][carXMROn] = true;
			return 1;
		}
	}
	return 1;
}
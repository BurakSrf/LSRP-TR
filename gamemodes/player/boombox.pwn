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
		if (Boombox_Placed(playerid) != -1) return SendErrorMessage(playerid, "Zaten bir boombox koymu�sun.");
		if (Boombox_Nearest(playerid) != -1) return SendErrorMessage(playerid, "Yak�nlar�nda bir yere boombox koyulmu�.");

		Boombox_Create(playerid);
		return 1;
	}
	else if (!strcmp(specifier, "duzenle"))
	{
		static id = -1;
		if((id = Boombox_Nearest(playerid, 4.0)) == -1) return SendErrorMessage(playerid, "Yak�n�nda boombox yok.");
		if (BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu boombox senin de�il.");

		EditingID[playerid] = id;
		EditingObject[playerid] = 14;
		EditDynamicObject(playerid, BoomboxData[id][BoomboxObject]);
		return 1;
	}
	else if (!strcmp(specifier, "yoket"))
	{
		static id = -1;
		if((id = Boombox_Nearest(playerid, 4.0)) == -1) return SendErrorMessage(playerid, "Yak�n�nda boombox yok.");
		if (BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu boombox senin de�il.");
		SendClientMessage(playerid, COLOR_DARKGREEN, "SERVER: Boombox'unu yokettin.");
		foreach (new i : Player) if(Boombox_Nearest(i, 10.0) != -1) StopAudioStreamForPlayer(i);
		PlayerData[playerid][pHasBoombox] = false;
		Boombox_Delete(id);
		return 1;
	}
	else if (!strcmp(specifier, "al"))
	{
		static id = -1;
		if((id = Boombox_Nearest(playerid, 4.0)) == -1) return SendErrorMessage(playerid, "Yak�n�nda boombox yok.");
		if (BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu boombox senin de�il.");
		SendClientMessage(playerid, COLOR_DARKGREEN, "SERVER: Boombox'unu kald�rd�n, tekrar yerle�tirmek i�in /boombox koy yazabilirsin.");
		foreach (new i : Player) if(Boombox_Nearest(i, 10.0) != -1) StopAudioStreamForPlayer(i);
		Boombox_Delete(id);
		return 1;
	}
	else if (!strcmp(specifier, "ver"))
	{
		static id = -1, playerb;
		if((id = Boombox_Nearest(playerid, 4.0)) == -1) return SendErrorMessage(playerid, "Yak�n�nda boombox yok.");
		if (BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu boombox senin de�il.");
		if (sscanf(specifier_ex, "u", playerb)) return SendUsageMessage(playerid, "/boombox ver [oyuncu ID/isim]");
		if(!IsPlayerConnected(playerb)) return SendErrorMessage(playerid, "Belirtti�iniz ki�i oyunda yok.");
		if(!pLoggedIn[playerb]) return SendErrorMessage(playerid, "Belirtti�iniz ki�i hen�z �ifresini girmemi�.");
		if(!GetDistanceBetweenPlayers(playerid, playerb, 4.5)) return SendErrorMessage(playerid, "Belirtti�in ki�iye yak�n de�ilsin.");
		if (PlayerData[playerb][pHasBoombox]) return SendErrorMessage(playerid, "Belirtti�in ki�inin zaten boombox� var.");
		SendClientMessageEx(playerid, COLOR_DARKGREEN, "SERVER: %s adl� ki�iye Boombox verdin.", ReturnName(playerb, 0));
		SendClientMessageEx(playerb, COLOR_DARKGREEN, "SERVER: %s sana Boombox'unu verdi.", ReturnName(playerid, 0));
		BoomboxData[id][BoomboxOwnerID] = PlayerData[playerb][pSQLID];
		PlayerData[playerid][pHasBoombox] = false;
		return 1;
	}
	else SendClientMessage(playerid, COLOR_ADM, "SERVER: Hatal� parametre girdiniz.");
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
			if(BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID] && !PlayerData[playerid][pAdmin]) return SendErrorMessage(playerid, "Bu boomboxa eri�imin yok.");
			if(!BoomboxData[id][BoomboxStatus]) return SendServerMessage(playerid, "Zaten bu boombox �al��m�yor.");

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
			if(GetPlayerVehicleSeat(playerid) > 1) return SendErrorMessage(playerid, "�n tarafta oturan ki�iler radyoyu ayarlayabilir.");
			
			new vehicleid = GetPlayerVehicleID(playerid);
			if(!CarData[vehicleid][carXMR]) return SendServerMessage(playerid, "Bu arac�n XM radyosu yok.");
			if(!CarData[vehicleid][carXMROn]) return SendServerMessage(playerid, "Zaten bu ara�ta XMR radyosu �al��m�yor.");

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
				if(PropertyData[id][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendServerMessage(playerid, "Bu eve sahip de�ilsin.");
				if(!PropertyData[id][PropertyXMROn]) return SendServerMessage(playerid, "Bu radyo zaten �al��m�yor.");

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
			if(BusinessData[id][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");
			if(!BusinessData[id][BusinessXMROn]) return SendServerMessage(playerid, "Bu radyo zaten �al��m�yor.");

			foreach(new i : Player) if(IsPlayerInBusiness(i) == id)
			{
				SendClientMessage(i, COLOR_DARKGREEN, "SERVER: Radyo durduruldu.");
				StopAudioStreamForPlayer(i);
			}

			BusinessData[id][BusinessXMROn] = false;
			return 1;
		}

		SendClientMessage(playerid, COLOR_DARKGREEN, "SERVER: Radyoya yak�n de�ilsin.");
		return 1;
	}
	else
	{
		new id = -1, near_anything = 0;
		if((id = Boombox_Nearest(playerid, 4.0)) != -1)
		{
			if(BoomboxData[id][BoomboxOwnerID] != PlayerData[playerid][pSQLID] && !PlayerData[playerid][pAdmin])
				return SendErrorMessage(playerid, "Bu boomboxa eri�imin yok.");

			near_anything++;
		}

		if(IsPlayerInAnyVehicle(playerid))
		{
			if(GetPlayerVehicleSeat(playerid) > 1) return SendErrorMessage(playerid, "�n tarafta oturan ki�iler radyoyu ayarlayabilir.");
			if(!CarData[GetPlayerVehicleID(playerid)][carXMR]) return SendServerMessage(playerid, "Bu arac�n XM radyosu yok.");
			
			near_anything++;
		}

		if((id = IsPlayerInProperty(playerid)) != -1)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3.0, PropertyData[id][PropertyXMR][0], PropertyData[id][PropertyXMR][1], PropertyData[id][PropertyXMR][2]))
			{
				if(PropertyData[id][PropertyOwnerID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu eve sahip de�ilsin.");
				if(!PropertyData[id][PropertyHasXMR]) return SendErrorMessage(playerid, "Bu evin XM radyosu yok.");
				near_anything++;
			}
		}

		if((id = IsPlayerInBusiness(playerid)) != -1)
		{
			if(BusinessData[id][BusinessOwnerSQLID] != PlayerData[playerid][pSQLID]) return SendErrorMessage(playerid, "Bu i�yerine sahip de�ilsin.");
			if(!BusinessData[id][BusinessHasXMR]) return SendServerMessage(playerid, "Bu i�yerinin XM radyosu yok.");
			near_anything++;
		}

		if(!near_anything) return SendErrorMessage(playerid, "Herhangi bir radyoya yak�n de�ilsin.");

		if(sscanf(params, "i", id))
		{
			ShowXMRDialog(playerid);
			return 1;
		}

		if(!XMRData[id][xmrID]) return SendErrorMessage(playerid, "Ge�ersiz istasyon ID belirttin.");
        cmd_ame(playerid, sprintf("radyo �zerinde %s kanal�n� a�ar.", XMRData[id][xmrName]));
 
 		new idx = -1;
		if((idx = Boombox_Nearest(playerid, 4.0)) != -1)
		{
			foreach (new i : Player) if(Boombox_Nearest(i, 25.0) == idx)
			{
				SendClientMessageEx(i, COLOR_ADM, "SERVER: Radyo istasyonu %s olarak de�i�tirildi.", XMRData[id][xmrName]);
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
				SendClientMessageEx(i, COLOR_ADM, "SERVER: Radyo istasyonu %s olarak de�i�tirildi.", XMRData[id][xmrName]);
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
				SendClientMessageEx(i, COLOR_ADM, "SERVER: Radyo istasyonu %s olarak de�i�tirildi.", XMRData[id][xmrName]);
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
				SendClientMessageEx(i, COLOR_ADM, "SERVER: Radyo istasyonu %s olarak de�i�tirildi.", XMRData[id][xmrName]);
				PlayAudioStreamForPlayer(i, XMRData[id][xmrStationURL]);
			}

			format(CarData[vehicleid][carXMRUrl], 128, "%s", XMRData[id][xmrStationURL]);
			CarData[vehicleid][carXMROn] = true;
			return 1;
		}
	}
	return 1;
}
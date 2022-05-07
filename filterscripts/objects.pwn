#include <a_samp>
#include <streamer>

new tmpobjid;

#include "247s/main.pwn"
#include "clubs/main.pwn"
#include "bars/main.pwn"
#include "complexs/main.pwn"
#include "lspd/main.pwn"
#include "lsfd/main.pwn"
#include "sadcr/main.pwn"
#include "san/main.pwn"
#include "gov/main.pwn"
#include "asgh/main.pwn"
#include "banks/main.pwn"
#include "cafes/main.pwn"
#include "exteriors/main.pwn"
#include "motels/main.pwn"
#include "studios/main.pwn"
#include "tattoos/main.pwn"
#include "warehouses/main.pwn"
#include "gym/main.pwn"
#include "pawnshops/main.pwn"
#include "offices/main.pwn"


public OnFilterScriptInit()
{
	Load_All247();
	Load_AllBars();
	Load_AllClubs();
	Load_AllComplexs();
	Load_AllLSPD();
	Load_AllLSFD();
	Load_AllSADCR();
	Load_AllSAN();
	Load_AllASGH();
	Load_AllBanks();
	Load_AllGYMs();
	Load_AllPawnshops();
	Load_AllGOV();
	Load_AllCafes();
	Load_AllExteriors();
	Load_AllMotels();
	Load_AllStudios();
	Load_AllOffices();
	Load_AllTattoos();
	Load_AllWarehouses();
	return 1;
}

public OnPlayerConnect(playerid)
{
	// Verona Mall
	RemoveBuildingForPlayer(playerid, 6130, 1117.589, -1490.010, 32.718, 0.250);
	RemoveBuildingForPlayer(playerid, 6255, 1117.589, -1490.010, 32.718, 0.250);

	// Modifiyeci
	RemoveBuildingForPlayer(playerid, 6359, 421.429, -1307.992, 24.265, 0.250);
	RemoveBuildingForPlayer(playerid, 6355, 421.429, -1307.992, 24.265, 0.250);
	RemoveBuildingForPlayer(playerid, 6363, 428.101, -1348.812, 29.257, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 441.867, -1305.839, 14.359, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 418.695, -1321.550, 13.953, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 404.976, -1329.099, 13.703, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 404.835, -1303.729, 13.671, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 394.117, -1317.880, 13.234, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 395.859, -1323.760, 13.000, 0.250);


	// Willowfield Complex
	RemoveBuildingForPlayer(playerid, 3744, 2331.382, -2001.671, 15.023, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2313.046, -2008.539, 15.023, 0.250);
	RemoveBuildingForPlayer(playerid, 1266, 2336.914, -1987.632, 21.828, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2313.046, -2008.539, 15.023, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2331.382, -2001.671, 15.023, 0.250);
	RemoveBuildingForPlayer(playerid, 1260, 2336.914, -1987.632, 21.828, 0.250);
	RemoveBuildingForPlayer(playerid, 5311, 2287.340, -2024.380, 12.539, 0.250);
	RemoveBuildingForPlayer(playerid, 5319, 2287.340, -2024.380, 12.539, 0.250);

	// Hastane Otopark
	RemoveBuildingForPlayer(playerid, 620, 1240.920, -1300.920, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1240.920, -1317.739, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1240.920, -1335.050, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1240.920, -1356.550, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1240.920, -1374.609, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1222.660, -1374.609, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1222.660, -1356.550, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1222.660, -1335.050, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1222.660, -1317.739, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1222.660, -1300.920, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 739, 1231.140, -1356.209, 12.734, 0.250);
	RemoveBuildingForPlayer(playerid, 739, 1231.140, -1341.849, 12.734, 0.250);
	RemoveBuildingForPlayer(playerid, 739, 1231.140, -1328.089, 12.734, 0.250);

	// Crenshaw Çevre Paketi
	RemoveBuildingForPlayer(playerid, 3582, 2263.719, -1464.800, 25.437, 0.250);
	RemoveBuildingForPlayer(playerid, 3562, 2263.719, -1464.800, 25.437, 0.250);
	RemoveBuildingForPlayer(playerid, 3582, 2247.530, -1464.800, 25.546, 0.250);
	RemoveBuildingForPlayer(playerid, 3562, 2247.530, -1464.800, 25.546, 0.250);
	RemoveBuildingForPlayer(playerid, 3582, 2232.399, -1464.800, 25.648, 0.250);
	RemoveBuildingForPlayer(playerid, 3562, 2232.399, -1464.800, 25.648, 0.250);
	RemoveBuildingForPlayer(playerid, 3582, 2230.610, -1401.780, 25.640, 0.250);
	RemoveBuildingForPlayer(playerid, 3562, 2230.610, -1401.780, 25.640, 0.250);
	RemoveBuildingForPlayer(playerid, 3582, 2243.709, -1401.780, 25.640, 0.250);
	RemoveBuildingForPlayer(playerid, 3562, 2243.709, -1401.780, 25.640, 0.250);
	RemoveBuildingForPlayer(playerid, 3582, 2256.659, -1401.780, 25.640, 0.250);
	RemoveBuildingForPlayer(playerid, 3562, 2256.659, -1401.780, 25.640, 0.250);
	RemoveBuildingForPlayer(playerid, 1224, 2225.679, -1468.619, 23.429, 0.250);
	RemoveBuildingForPlayer(playerid, 1221, 2225.850, -1466.650, 23.273, 0.250);
	RemoveBuildingForPlayer(playerid, 645, 2239.570, -1468.800, 22.687, 0.250);

	// 54th Gas Station
	RemoveBuildingForPlayer(playerid, 17535, 2364.050, -1391.530, 41.351, 0.250);
	RemoveBuildingForPlayer(playerid, 17970, 2364.050, -1391.530, 41.351, 0.250);
	RemoveBuildingForPlayer(playerid, 1260, 2317.590, -1355.818, 37.226, 0.250);
	RemoveBuildingForPlayer(playerid, 17543, 2322.280, -1355.198, 25.406, 0.250);
	RemoveBuildingForPlayer(playerid, 17965, 2322.280, -1355.198, 25.406, 0.250);
	RemoveBuildingForPlayer(playerid, 17542, 2347.918, -1364.290, 27.156, 0.250);
	RemoveBuildingForPlayer(playerid, 17966, 2347.918, -1364.290, 27.156, 0.250);
	RemoveBuildingForPlayer(playerid, 955, 2352.178, -1357.160, 23.773, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 2336.979, -1350.578, 22.725, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 2331.448, -1373.530, 23.093, 0.250);

	// Rina Silahçý
	RemoveBuildingForPlayer(playerid, 1411, 1417.310, -1321.349, 14.117, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 1417.310, -1316.099, 14.117, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 1417.310, -1310.849, 14.117, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 1417.310, -1305.599, 14.117, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 1417.310, -1333.949, 14.117, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 1417.310, -1339.199, 14.117, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 1417.310, -1344.449, 14.117, 0.250);

	// Impound Lot
	RemoveBuildingForPlayer(playerid, 5244, 2198.850, -2213.919, 14.882, 0.250);
	RemoveBuildingForPlayer(playerid, 5305, 2198.850, -2213.919, 14.882, 0.250);
	RemoveBuildingForPlayer(playerid, 3627, 2195.090, -2216.840, 15.906, 0.250);
	RemoveBuildingForPlayer(playerid, 3686, 2195.090, -2216.840, 15.906, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2174.639, -2215.659, 15.101, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2174.639, -2215.659, 15.101, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2193.060, -2196.639, 15.101, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2193.060, -2196.639, 15.101, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 2223.739, -2207.189, 16.312, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2194.479, -2242.879, 13.257, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2183.169, -2237.270, 14.812, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2183.169, -2237.270, 14.812, 0.250);

	// Traffic Division Exterior
	RemoveBuildingForPlayer(playerid, 6495, 343.125, -1340.382, 28.789, 0.250);
	RemoveBuildingForPlayer(playerid, 1268, 311.953, -1383.148, 19.671, 0.250);
	RemoveBuildingForPlayer(playerid, 1266, 326.296, -1365.375, 29.828, 0.250);
	RemoveBuildingForPlayer(playerid, 1261, 359.062, -1351.687, 24.007, 0.250);
	RemoveBuildingForPlayer(playerid, 1259, 311.953, -1383.148, 19.671, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 315.343, -1379.257, 14.843, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 320.054, -1377.062, 14.843, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 324.765, -1374.867, 14.843, 0.250);
	RemoveBuildingForPlayer(playerid, 1260, 326.296, -1365.382, 29.820, 0.250);
	RemoveBuildingForPlayer(playerid, 6369, 343.125, -1340.382, 28.789, 0.250);
	RemoveBuildingForPlayer(playerid, 1267, 359.062, -1351.687, 24.007, 0.250);
	RemoveBuildingForPlayer(playerid, 6363, 428.101, -1348.812, 29.257, 0.250);
	RemoveBuildingForPlayer(playerid, 6328, 294.976, -1366.739, 18.929, 0.250);
	RemoveBuildingForPlayer(playerid, 6496, 294.976, -1366.739, 18.929, 0.250);
	RemoveBuildingForPlayer(playerid, 1308, 326.960, -1375.800, 13.210, 0.250);

	// Persing Square
	RemoveBuildingForPlayer(playerid, 4057, 1479.554, -1693.140, 19.578, 0.250);
	RemoveBuildingForPlayer(playerid, 4210, 1479.562, -1631.453, 12.078, 0.250);
	RemoveBuildingForPlayer(playerid, 713, 1457.937, -1620.695, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 713, 1496.867, -1707.820, 13.406, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 1451.625, -1727.671, 16.421, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 1467.984, -1727.671, 16.421, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 1485.171, -1727.671, 16.421, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1468.984, -1713.507, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1479.695, -1716.703, 15.625, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 1505.179, -1727.671, 16.421, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1488.765, -1713.703, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1289, 1504.750, -1711.882, 13.593, 0.250);
	RemoveBuildingForPlayer(playerid, 1258, 1445.007, -1704.765, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 1258, 1445.007, -1692.234, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1445.812, -1650.023, 22.257, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1457.726, -1710.062, 12.398, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1461.656, -1707.687, 11.835, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1468.984, -1704.640, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 700, 1463.062, -1701.570, 13.726, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1479.695, -1702.531, 15.625, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1457.554, -1697.289, 12.398, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1468.984, -1694.046, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1479.382, -1692.390, 15.632, 0.250);
	RemoveBuildingForPlayer(playerid, 4186, 1479.554, -1693.140, 19.578, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1461.125, -1687.562, 11.835, 0.250);
	RemoveBuildingForPlayer(playerid, 700, 1463.062, -1690.648, 13.726, 0.250);
	RemoveBuildingForPlayer(playerid, 641, 1458.617, -1684.132, 11.101, 0.250);
	RemoveBuildingForPlayer(playerid, 625, 1457.273, -1666.296, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1468.984, -1682.718, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1471.406, -1666.179, 22.257, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1479.382, -1682.312, 15.632, 0.250);
	RemoveBuildingForPlayer(playerid, 625, 1458.257, -1659.257, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1449.851, -1655.937, 22.257, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1477.937, -1652.726, 15.632, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1479.609, -1653.250, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 625, 1457.351, -1650.570, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 625, 1454.421, -1642.492, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1467.851, -1646.593, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1472.898, -1651.507, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1465.937, -1639.820, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1466.468, -1637.960, 15.632, 0.250);
	RemoveBuildingForPlayer(playerid, 625, 1449.593, -1635.046, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1467.710, -1632.890, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1232, 1465.890, -1629.976, 15.531, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1472.664, -1627.882, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1479.468, -1626.023, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 3985, 1479.562, -1631.453, 12.078, 0.250);
	RemoveBuildingForPlayer(playerid, 4206, 1479.554, -1639.609, 13.648, 0.250);
	RemoveBuildingForPlayer(playerid, 1232, 1465.835, -1608.375, 15.375, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1488.765, -1704.593, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 700, 1494.210, -1694.437, 13.726, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1488.765, -1693.734, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1496.976, -1686.851, 11.835, 0.250);
	RemoveBuildingForPlayer(playerid, 641, 1494.140, -1689.234, 11.101, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1488.765, -1682.671, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1480.609, -1666.179, 22.257, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1488.226, -1666.179, 22.257, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1486.406, -1651.390, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1491.367, -1646.382, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1493.132, -1639.453, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1486.179, -1627.765, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1280, 1491.218, -1632.679, 13.453, 0.250);
	RemoveBuildingForPlayer(playerid, 1232, 1494.414, -1629.976, 15.531, 0.250);
	RemoveBuildingForPlayer(playerid, 1232, 1494.359, -1608.375, 15.375, 0.250);
	RemoveBuildingForPlayer(playerid, 1288, 1504.750, -1705.406, 13.593, 0.250);
	RemoveBuildingForPlayer(playerid, 1287, 1504.750, -1704.468, 13.593, 0.250);
	RemoveBuildingForPlayer(playerid, 1286, 1504.750, -1695.054, 13.593, 0.250);
	RemoveBuildingForPlayer(playerid, 1285, 1504.750, -1694.039, 13.593, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1498.960, -1684.609, 12.398, 0.250);
	RemoveBuildingForPlayer(playerid, 625, 1504.164, -1662.015, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 625, 1504.718, -1670.921, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1503.187, -1621.125, 11.835, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1501.281, -1624.578, 12.398, 0.250);
	RemoveBuildingForPlayer(playerid, 673, 1498.359, -1616.968, 12.398, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1508.445, -1668.742, 22.257, 0.250);
	RemoveBuildingForPlayer(playerid, 625, 1505.695, -1654.835, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 625, 1508.515, -1647.859, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 625, 1513.273, -1642.492, 13.695, 0.250);
	RemoveBuildingForPlayer(playerid, 1258, 1510.890, -1607.312, 13.695, 0.250);

	// Unity Station
	RemoveBuildingForPlayer(playerid, 4019, 1777.839, -1773.910, 12.523, 0.250);
	RemoveBuildingForPlayer(playerid, 4025, 1777.839, -1773.910, 12.523, 0.250);
	RemoveBuildingForPlayer(playerid, 4215, 1777.550, -1775.040, 36.750, 0.250);

	// Tren Ýstasyonu
    RemoveBuildingForPlayer(playerid, 1308, 2280.8281, -1310.3906, 23.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 2281.2500, -1281.4297, 23.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 2281.3828, -1338.7109, 23.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 2280.8906, -1250.3750, 23.0000, 0.25);
	RemoveBuildingForPlayer(playerid, 1308, 2280.9688, -1219.0625, 23.3828, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 2294.9375, -1310.1797, 22.7266, 0.25);

	// Santa Maria Project
	RemoveBuildingForPlayer(playerid, 6280, 260.023, -1839.910, -1.453, 0.250);
	RemoveBuildingForPlayer(playerid, 6437, 260.023, -1839.910, -1.453, 0.250);
	
	// Alhambra Project
	RemoveBuildingForPlayer(playerid, 5536, 1866.3281, -1789.7813, 20.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 5397, 1866.3281, -1789.7813, 20.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 5503, 1927.699, -1754.310, 12.460, 0.250);
	RemoveBuildingForPlayer(playerid, 5534, 1927.699, -1754.310, 12.460, 0.250);
	RemoveBuildingForPlayer(playerid, 5501, 1884.660, -1613.420, 12.460, 0.250);
	RemoveBuildingForPlayer(playerid, 5542, 1884.660, -1613.420, 12.460, 0.250);
	RemoveBuildingForPlayer(playerid, 5408, 1873.739, -1682.479, 34.796, 0.250);
	RemoveBuildingForPlayer(playerid, 5544, 1873.739, -1682.479, 34.796, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1832.380, -1694.310, 9.718, 0.250);
	RemoveBuildingForPlayer(playerid, 1537, 1837.439, -1686.979, 12.312, 0.250);
	RemoveBuildingForPlayer(playerid, 1533, 1837.439, -1683.949, 12.304, 0.250);
	RemoveBuildingForPlayer(playerid, 1533, 1837.439, -1680.939, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 1533, 1837.439, -1677.920, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 1537, 1837.439, -1683.969, 12.304, 0.250);
	RemoveBuildingForPlayer(playerid, 1537, 1837.439, -1680.949, 12.296, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1832.900, -1670.770, 9.718, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1855.719, -1623.280, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1879.510, -1623.099, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1908.219, -1622.979, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1929.579, -1627.630, 21.390, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1931.040, -1637.900, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1931.040, -1667.030, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1931.040, -1702.290, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1929.579, -1694.459, 21.390, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1931.040, -1726.329, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 712, 1929.579, -1736.910, 21.390, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1908.219, -1741.479, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1879.510, -1741.479, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1855.719, -1741.540, 10.804, 0.250);
	RemoveBuildingForPlayer(playerid, 1524, 1837.660, -1640.380, 13.757, 0.250);
	RemoveBuildingForPlayer(playerid, 5397, 1866.329, -1789.780, 20.945, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 1883.819, -1616.430, 16.390, 0.250);

	// SADOC Exterior Baþlangýç
	RemoveBuildingForPlayer(playerid, 3366, 276.656, 2023.757, 16.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3366, 276.656, 1989.546, 16.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3366, 276.656, 1955.765, 16.632, 0.250);
	RemoveBuildingForPlayer(playerid, 16619, 199.335, 1943.875, 18.203, 0.250);
	RemoveBuildingForPlayer(playerid, 3267, 188.242, 2081.648, 22.445, 0.250);
	RemoveBuildingForPlayer(playerid, 3277, 188.242, 2081.648, 22.406, 0.250);
	RemoveBuildingForPlayer(playerid, 16294, 15.179, 1719.390, 21.617, 0.250);
	RemoveBuildingForPlayer(playerid, 3267, 15.617, 1719.164, 22.414, 0.250);
	RemoveBuildingForPlayer(playerid, 3277, 15.601, 1719.171, 22.375, 0.250);
	RemoveBuildingForPlayer(playerid, 3267, 237.695, 1696.875, 22.414, 0.250);
	RemoveBuildingForPlayer(playerid, 3277, 237.679, 1696.882, 22.375, 0.250);
	RemoveBuildingForPlayer(playerid, 16293, 238.070, 1697.554, 21.632, 0.250);
	RemoveBuildingForPlayer(playerid, 16093, 211.648, 1810.156, 20.734, 0.250);
	RemoveBuildingForPlayer(playerid, 16638, 211.726, 1809.187, 18.984, 0.250);
	RemoveBuildingForPlayer(playerid, 3279, 262.093, 1807.671, 16.820, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 347.195, 1799.265, 18.757, 0.250);
	RemoveBuildingForPlayer(playerid, 1411, 342.937, 1796.289, 18.757, 0.250);
	RemoveBuildingForPlayer(playerid, 16670, 330.789, 1813.218, 17.828, 0.250);
	RemoveBuildingForPlayer(playerid, 3279, 113.382, 1814.453, 16.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3279, 165.953, 1849.992, 16.820, 0.250);
	RemoveBuildingForPlayer(playerid, 1697, 220.382, 1835.343, 23.234, 0.250);
	RemoveBuildingForPlayer(playerid, 1697, 228.796, 1835.343, 23.234, 0.250);
	RemoveBuildingForPlayer(playerid, 1697, 236.992, 1835.343, 23.234, 0.250);
	RemoveBuildingForPlayer(playerid, 16095, 279.132, 1829.781, 16.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3280, 245.375, 1862.367, 20.132, 0.250);
	RemoveBuildingForPlayer(playerid, 3280, 246.617, 1863.375, 20.132, 0.250);
	RemoveBuildingForPlayer(playerid, 16094, 191.140, 1870.039, 21.476, 0.250);
	RemoveBuildingForPlayer(playerid, 3279, 103.890, 1901.101, 16.820, 0.250);
	RemoveBuildingForPlayer(playerid, 16096, 120.507, 1934.031, 19.828, 0.250);
	RemoveBuildingForPlayer(playerid, 3279, 161.906, 1933.093, 16.820, 0.250);
	RemoveBuildingForPlayer(playerid, 16323, 199.335, 1943.875, 18.203, 0.250);
	RemoveBuildingForPlayer(playerid, 16671, 193.953, 2051.796, 20.179, 0.250);
	RemoveBuildingForPlayer(playerid, 3279, 233.429, 1934.843, 16.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3279, 267.062, 1895.296, 16.820, 0.250);
	RemoveBuildingForPlayer(playerid, 3268, 276.656, 2023.757, 16.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3268, 276.656, 1989.546, 16.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3268, 276.656, 1955.765, 16.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3267, 354.429, 2028.492, 22.414, 0.250);
	RemoveBuildingForPlayer(playerid, 3277, 354.414, 2028.500, 22.375, 0.250);
	RemoveBuildingForPlayer(playerid, 16668, 357.937, 2049.421, 16.843, 0.250);
	RemoveBuildingForPlayer(playerid, 16669, 380.257, 1914.960, 17.429, 0.250);
	RemoveBuildingForPlayer(playerid, 2887, 103.945, 1901.046, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2888, 103.945, 1901.046, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2889, 103.945, 1901.046, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2887, 161.962, 1933.042, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2888, 161.962, 1933.042, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2889, 161.962, 1933.042, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2887, 233.485, 1934.788, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2888, 233.485, 1934.788, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2889, 233.485, 1934.788, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2887, 267.115, 1895.240, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2888, 267.115, 1895.240, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2889, 267.115, 1895.240, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2887, 262.144, 1807.619, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2888, 262.144, 1807.619, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2889, 262.144, 1807.619, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2887, 166.003, 1849.937, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2888, 166.003, 1849.937, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2889, 166.003, 1849.937, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2887, 113.439, 1814.405, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2888, 113.439, 1814.405, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 2889, 113.439, 1814.405, 36.245, 0.250);
	RemoveBuildingForPlayer(playerid, 3280, 245.375, 1862.369, 20.132, 0.250);
	RemoveBuildingForPlayer(playerid, 3280, 246.617, 1863.380, 20.132, 0.250);
	RemoveBuildingForPlayer(playerid, 16203, 199.343, 1943.790, 18.203, 0.250);
	RemoveBuildingForPlayer(playerid, 16590, 199.343, 1943.790, 18.203, 0.250);
	// SADOC Exterior Bitiþ

	// Ocean Docks Gemi
	RemoveBuildingForPlayer(playerid, 5156, 2838.0391, -2423.8828, 10.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 5159, 2838.0313, -2371.9531, 7.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 5160, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5161, 2838.0234, -2358.4766, 21.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 5162, 2838.0391, -2423.8828, 10.9609, 0.25);
	RemoveBuildingForPlayer(playerid, 5163, 2838.0391, -2532.7734, 17.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 5164, 2838.1406, -2447.8438, 15.7266, 0.25);
	RemoveBuildingForPlayer(playerid, 5165, 2838.0313, -2520.1875, 18.4141, 0.25);
	RemoveBuildingForPlayer(playerid, 5166, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5167, 2838.0313, -2371.9531, 7.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 5335, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5336, 2829.9531, -2479.5703, 5.2656, 0.25);
	RemoveBuildingForPlayer(playerid, 5352, 2838.1953, -2488.6641, 29.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 5157, 2838.0391, -2532.7734, 17.0234, 0.25);
	RemoveBuildingForPlayer(playerid, 5154, 2838.1406, -2447.8438, 15.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 3724, 2838.1953, -2488.6641, 29.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 5155, 2838.0234, -2358.4766, 21.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 3724, 2838.1953, -2407.1406, 29.3125, 0.25);
	RemoveBuildingForPlayer(playerid, 5158, 2837.7734, -2334.4766, 11.9922, 0.25);
	//RemoveBuildingForPlayer(playerid, 4267, 2882.0781, -2411.4531, -4.0000, 0.25);
	//RemoveBuildingForPlayer(playerid, 4401, 2882.0781, -2411.4531, -4.0000, 0.25);

	// Ocean Docks
	RemoveBuildingForPlayer(playerid, 3689, 2685.382, -2366.054, 19.953, 0.250);
	RemoveBuildingForPlayer(playerid, 3707, 2716.234, -2452.593, 20.203, 0.250);
	RemoveBuildingForPlayer(playerid, 3707, 2720.320, -2530.914, 19.976, 0.250);
	RemoveBuildingForPlayer(playerid, 3690, 2685.382, -2366.054, 19.953, 0.250);
	RemoveBuildingForPlayer(playerid, 3710, 2788.156, -2417.789, 16.726, 0.250);
	RemoveBuildingForPlayer(playerid, 3710, 2788.156, -2455.882, 16.726, 0.250);
	RemoveBuildingForPlayer(playerid, 3710, 2788.156, -2493.984, 16.726, 0.250);
	RemoveBuildingForPlayer(playerid, 3709, 2660.476, -2429.296, 17.070, 0.250);
	RemoveBuildingForPlayer(playerid, 3708, 2720.320, -2530.914, 19.976, 0.250);
	RemoveBuildingForPlayer(playerid, 3708, 2716.234, -2452.593, 20.203, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2771.070, -2372.445, 15.218, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2789.210, -2377.625, 15.218, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2774.796, -2386.851, 15.218, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2771.070, -2520.546, 15.218, 0.250);
	RemoveBuildingForPlayer(playerid, 3744, 2774.796, -2534.953, 15.218, 0.250);
	RemoveBuildingForPlayer(playerid, 3746, 2814.265, -2356.570, 25.515, 0.250);
	RemoveBuildingForPlayer(playerid, 3746, 2814.265, -2521.492, 25.515, 0.250);
	RemoveBuildingForPlayer(playerid, 3758, 2748.015, -2571.593, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 3758, 2702.398, -2324.257, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 3770, 2795.828, -2394.242, 14.171, 0.250);
	RemoveBuildingForPlayer(playerid, 3770, 2746.406, -2453.484, 14.078, 0.250);
	RemoveBuildingForPlayer(playerid, 1635, 2704.367, -2487.867, 20.562, 0.250);
	RemoveBuildingForPlayer(playerid, 1306, 2742.265, -2481.515, 19.843, 0.250);
	RemoveBuildingForPlayer(playerid, 5326, 2661.515, -2465.140, 20.109, 0.250);
	RemoveBuildingForPlayer(playerid, 1306, 2669.906, -2447.289, 19.843, 0.250);
	RemoveBuildingForPlayer(playerid, 3623, 2660.476, -2429.296, 17.070, 0.250);
	RemoveBuildingForPlayer(playerid, 1307, 2629.210, -2419.687, 12.289, 0.250);
	RemoveBuildingForPlayer(playerid, 1307, 2649.898, -2419.687, 12.289, 0.250);
	RemoveBuildingForPlayer(playerid, 1306, 2742.265, -2416.523, 19.843, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2639.195, -2392.820, 13.171, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2663.835, -2392.820, 13.171, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 2637.171, -2385.867, 16.414, 0.250);
	RemoveBuildingForPlayer(playerid, 1306, 2669.906, -2394.507, 19.843, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 2692.679, -2387.476, 16.414, 0.250);
	RemoveBuildingForPlayer(playerid, 1278, 2708.406, -2391.523, 26.703, 0.250);
	RemoveBuildingForPlayer(playerid, 3753, 2748.015, -2571.593, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2774.796, -2534.953, 15.218, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2771.070, -2520.546, 15.218, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2783.781, -2501.835, 14.695, 0.250);
	RemoveBuildingForPlayer(playerid, 3624, 2788.156, -2493.984, 16.726, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2783.781, -2486.960, 14.656, 0.250);
	RemoveBuildingForPlayer(playerid, 3578, 2747.007, -2480.242, 13.171, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2783.781, -2463.820, 14.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3624, 2788.156, -2455.882, 16.726, 0.250);
	RemoveBuildingForPlayer(playerid, 3626, 2746.406, -2453.484, 14.078, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2783.781, -2448.476, 14.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3577, 2744.570, -2436.187, 13.343, 0.250);
	RemoveBuildingForPlayer(playerid, 3577, 2744.570, -2427.320, 13.351, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2783.781, -2425.351, 14.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2774.796, -2386.851, 15.218, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2771.070, -2372.445, 15.218, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2783.781, -2410.210, 14.671, 0.250);
	RemoveBuildingForPlayer(playerid, 3624, 2788.156, -2417.789, 16.726, 0.250);
	RemoveBuildingForPlayer(playerid, 3574, 2789.210, -2377.625, 15.218, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2791.953, -2501.835, 14.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2797.515, -2486.828, 14.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2791.953, -2486.960, 14.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2791.953, -2463.820, 14.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2797.515, -2448.343, 14.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2791.953, -2448.476, 14.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2791.953, -2425.351, 14.671, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2791.953, -2410.210, 14.656, 0.250);
	RemoveBuildingForPlayer(playerid, 5351, 2789.656, -2418.695, 12.664, 0.250);
	RemoveBuildingForPlayer(playerid, 3761, 2797.515, -2410.078, 14.632, 0.250);
	RemoveBuildingForPlayer(playerid, 3626, 2795.828, -2394.242, 14.171, 0.250);
	RemoveBuildingForPlayer(playerid, 3620, 2814.265, -2521.492, 25.515, 0.250);
	RemoveBuildingForPlayer(playerid, 3620, 2814.265, -2356.570, 25.515, 0.250);
	RemoveBuildingForPlayer(playerid, 3753, 2702.398, -2324.257, 3.039, 0.250);
	RemoveBuildingForPlayer(playerid, 5145, 2716.800, -2447.879, 2.156, 0.250);
	RemoveBuildingForPlayer(playerid, 5235, 2716.800, -2447.879, 2.156, 0.250);
	RemoveBuildingForPlayer(playerid, 1306, 2669.909, -2518.659, 19.843, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 2696.020, -2474.860, 16.414, 0.250);
	RemoveBuildingForPlayer(playerid, 1226, 2696.020, -2446.629, 16.414, 0.250);
	RemoveBuildingForPlayer(playerid, 1278, 2626.229, -2391.520, 26.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1278, 2592.489, -2359.419, 26.703, 0.250);
	RemoveBuildingForPlayer(playerid, 1315, 2672.590, -2408.250, 15.812, 0.250);
	RemoveBuildingForPlayer(playerid, 1315, 2672.590, -2506.860, 15.812, 0.250);
	
	// Gece Kulübü Interior (6 - Galaxy) Baþlangýç
	RemoveBuildingForPlayer(playerid, 14784, 1281.140625, -30.093800, 1009.414124, 0.250000);
	RemoveBuildingForPlayer(playerid, 14795, 1388.882813, -20.882799, 1005.203125, 0.250000);
	// Gece Kulübü Interior (6 - Galaxy) Bitiþ

	// FD HQ Exterior
	RemoveBuildingForPlayer(playerid, 5857, 1259.439, -1246.810, 17.109, 0.250);
	RemoveBuildingForPlayer(playerid, 5967, 1259.439, -1246.810, 17.109, 0.250);
	RemoveBuildingForPlayer(playerid, 1388, 1238.380, -1258.280, 57.203, 0.250);
	RemoveBuildingForPlayer(playerid, 1391, 1238.380, -1258.270, 44.664, 0.250);
	RemoveBuildingForPlayer(playerid, 1219, 1284.180, -1239.640, 12.914, 0.250);
	RemoveBuildingForPlayer(playerid, 1219, 1284.180, -1239.640, 12.914, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1327.430, -1239.979, 13.937, 0.250);
	RemoveBuildingForPlayer(playerid, 1412, 1327.430, -1234.739, 13.937, 0.250);
	RemoveBuildingForPlayer(playerid, 1219, 1332.839, -1241.719, 13.414, 0.250);
	RemoveBuildingForPlayer(playerid, 1227, 1322.189, -1235.880, 13.437, 0.250);
	RemoveBuildingForPlayer(playerid, 1297, 1337.880, -1237.719, 15.492, 0.250);
	RemoveBuildingForPlayer(playerid, 1294, 1254.689, -1276.160, 17.078, 0.250);
	RemoveBuildingForPlayer(playerid, 1283, 1269.550, -1280.319, 15.710, 0.250);
	RemoveBuildingForPlayer(playerid, 1283, 1245.729, -1281.339, 15.710, 0.250);
	RemoveBuildingForPlayer(playerid, 1283, 1216.319, -1281.410, 15.593, 0.250);
	RemoveBuildingForPlayer(playerid, 1283, 1216.849, -1270.770, 15.710, 0.250);
	RemoveBuildingForPlayer(playerid, 1283, 1261.359, -1291.180, 15.710, 0.250);
	RemoveBuildingForPlayer(playerid, 1294, 1282.270, -1284.890, 17.078, 0.250);

	// PD ASU HQ Exterior
	RemoveBuildingForPlayer(playerid, 5137, 2005.250, -2137.459, 16.515, 0.250);
	RemoveBuildingForPlayer(playerid, 5195, 2005.250, -2137.459, 16.515, 0.250);

	// PD Harbor HQ Exterior
	RemoveBuildingForPlayer(playerid, 3687, 2135.7422, -2186.4453, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3687, 2162.8516, -2159.7500, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3687, 2150.1953, -2172.3594, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1531, 2173.5938, -2165.1875, 15.3047, 0.25);
	RemoveBuildingForPlayer(playerid, 3622, 2135.7422, -2186.4453, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3622, 2150.1953, -2172.3594, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 3622, 2162.8516, -2159.7500, 15.6719, 0.25);
	RemoveBuildingForPlayer(playerid, 1306, 2001.0234, -2119.9844, 19.7500, 0.25);
	RemoveBuildingForPlayer(playerid, 5337, 1995.4375, -2066.1484, 18.5313, 0.25);

	// PD Vinewood HQ Exterior
	RemoveBuildingForPlayer(playerid, 5738, 1292.069, -1122.020, 37.406, 0.250);
	RemoveBuildingForPlayer(playerid, 5842, 1292.069, -1122.020, 37.406, 0.250);
	RemoveBuildingForPlayer(playerid, 717, 1322.270, -1134.229, 23.000, 0.250);
	RemoveBuildingForPlayer(playerid, 727, 1327.979, -1124.339, 21.968, 0.250);
	RemoveBuildingForPlayer(playerid, 727, 1319.689, -1112.910, 22.257, 0.250);

	// PD Metro HQ Exterior
    RemoveBuildingForPlayer(playerid, 6194, 1116.6250, -1542.9063, 22.4688, 0.25);
	RemoveBuildingForPlayer(playerid, 6063, 1087.979, -1682.329, 19.437, 0.25);
	RemoveBuildingForPlayer(playerid, 6071, 1087.979, -1682.329, 19.437, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1101.660, -1699.560, 14.687, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1097.430, -1699.420, 14.687, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1058.310, -1695.770, 14.687, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1055.619, -1692.650, 14.460, 0.25);
	RemoveBuildingForPlayer(playerid, 647, 1051.880, -1680.520, 14.460, 0.25);
	RemoveBuildingForPlayer(playerid, 615, 1051.250, -1678.020, 13.289, 0.25);
	RemoveBuildingForPlayer(playerid, 6061, 1093.640, -1619.160, 15.359, 0.25);
	RemoveBuildingForPlayer(playerid, 6070, 1093.640, -1619.160, 15.359, 0.25);
	RemoveBuildingForPlayer(playerid, 3586, 1106.770, -1619.260, 15.937, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1065.459, -1620.790, 19.367, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1061.530, -1617.520, 19.609, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1057.430, -1630.280, 19.703, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1075.630, -1630.280, 19.703, 0.25);
	RemoveBuildingForPlayer(playerid, 6110, 1093.880, -1630.020, 20.328, 0.25);
	RemoveBuildingForPlayer(playerid, 6069, 1093.880, -1630.020, 20.328, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1112.239, -1630.280, 19.703, 0.25);
	RemoveBuildingForPlayer(playerid, 6060, 1093.880, -1630.020, 20.328, 0.25);
	RemoveBuildingForPlayer(playerid, 6069, 1093.880, -1630.020, 20.328, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1093.270, -1630.280, 19.703, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1112.239, -1607.959, 19.703, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1093.270, -1607.959, 19.703, 0.25);
	RemoveBuildingForPlayer(playerid, 792, 1075.630, -1607.959, 19.703, 0.25);
	RemoveBuildingForPlayer(playerid, 6062, 1137.150, -1631.290, 14.484, 0.25);

	RemoveBuildingForPlayer(playerid, 5422, 2071.4766, -1831.4219, 14.5625, 0.25); // Idlewood PNS
	RemoveBuildingForPlayer(playerid, 6400, 488.2813, -1734.6953, 12.3906, 0.25); // Santa Maria PNS
	RemoveBuildingForPlayer(playerid, 5856, 1024.9844, -1029.3516, 33.1953, 0.25); // Temple PNS
	RemoveBuildingForPlayer(playerid, 13028, 720.0156, -462.5234, 16.8594, 0.25); // Dillimore PNS
	RemoveBuildingForPlayer(playerid, 3294, -100.0000, 1111.4141, 21.6406, 0.25); // Fort Carson PNS
	RemoveBuildingForPlayer(playerid, 3294, -1420.5469, 2591.1563, 57.7422, 0.25); // El Q ... PNS
	RemoveBuildingForPlayer(playerid, 11319, -1904.5313, 277.8984, 42.9531, 0.25); // SF PNS
	RemoveBuildingForPlayer(playerid, 11313, -1935.8594, 239.5313, 35.3516, 0.25); // SF Carshop East
	RemoveBuildingForPlayer(playerid, 10575, -2716.3516, 217.4766, 5.3828, 0.25); // SF Carshop West
	RemoveBuildingForPlayer(playerid, 9093, 2386.6563, 1043.6016, 11.5938, 0.25); // LV Carshop
	RemoveBuildingForPlayer(playerid, 5340, 2644.8594, -2039.2344, 14.0391, 0.25); // Seville Carshop
	RemoveBuildingForPlayer(playerid, 5779, 1041.3516, -1025.9297, 32.6719, 0.25); // Temple Carshop
	RemoveBuildingForPlayer(playerid, 792, 1279.7344, -1552.9453, 12.2188, 0.25); // Market DMV
	RemoveBuildingForPlayer(playerid, 1231, 1273.6094, -1542.3750, 15.2344, 0.25); // Market DMV
	RemoveBuildingForPlayer(playerid, 792, 1280.0313, -1531.1406, 12.0703, 0.25); // Market DMV
	RemoveBuildingForPlayer(playerid, 1231, 1263.3047, -1520.1484, 15.1953, 0.25); // Market DMV
	return 1;
}
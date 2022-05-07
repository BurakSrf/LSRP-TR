main () {}
new MySQL: m_Handle;

//#define TEST_SERVER
#define LIVE_SERVER

#if defined LIVE_SERVER
	#define MYSQL_HOSTNAME "127.0.0.1"
	#define MYSQL_USERNAME "root"
	#define MYSQL_DATABASE "lsrp"
	#define MYSQL_PASSWORD ""
#else
	#define MYSQL_HOSTNAME "localhost"
	#define MYSQL_USERNAME "root"
	#define MYSQL_DATABASE "lsrp"
	#define MYSQL_PASSWORD ""
#endif

echo "* Stat iot.db setup in sqlite3."
sudo apt install -y sqlite3

cd ~
mkdir dbs

cd /home/pi/dbs
wget https://github.com/pappavis/ESP8266_MQQT_Weerstation/blob/master/dbs/iot.db
sudo chmod 777 /home/pi/dbs -R
sudo chmod 666 /home/pi/dbs/iot.db
cd

		sqlite3 /home/pi/dbs/iot.db << EOF		
		CREATE TABLE IF NOT EXISTS \`pinDescription\` (
		 \`pinID\` INTEGER PRIMARY KEY NOT NULL,
		 \`pinNumber\` varchar(2) NOT NULL,
		 \`pinDescription\` varchar(255) NOT NULL
		);
		CREATE TABLE IF NOT EXISTS \`pinDirection\` (
		 \`pinID\` INTEGER PRIMARY KEY NOT NULL,
		 \`pinNumber\` varchar(2) NOT NULL,
		 \`pinDirection\` varchar(3) NOT NULL
		);
		CREATE TABLE IF NOT EXISTS \`pinStatus\` (
		 \`pinID\` INTEGER PRIMARY KEY NOT NULL,
		 \`pinNumber\` varchar(2)  NOT NULL,
		 \`pinStatus\` varchar(1) NOT NULL
		);
		CREATE TABLE IF NOT EXISTS \`users\` (
		 \`userID\` INTEGER PRIMARY KEY NOT NULL,
		 \`username\` varchar(28) NOT NULL,
		 \`password\` varchar(64) NOT NULL,
		 \`salt\` varchar(8) NOT NULL
		);
		CREATE TABLE IF NOT EXISTS \`device_list\` (
		 \`device_name\` varchar(80) NOT NULL DEFAULT '',
		 \`device_description\` varchar(80) DEFAULT NULL,
		 \`device_attribute\` varchar(80) DEFAULT NULL,
		 \`logins\` int(11) DEFAULT NULL,
		 \`creation_date\` datetime DEFAULT NULL,
		 \`last_update\` datetime DEFAULT NULL,
		 PRIMARY KEY (\`device_name\`)
		);
		CREATE TABLE IF NOT EXISTS \`readings\` (
		 \`recnum\` INTEGER PRIMARY KEY,
		 \`location\` varchar(20),
		 \`value\` int(11) NOT NULL,
		 \`logged\` timestamp not NULL DEFAULT CURRENT_TIMESTAMP ,
		 \`device_name\` varchar(40) not null,
		 \`topic\` varchar(40) not null
		);
		CREATE TABLE IF NOT EXISTS \`pins\` (
		 \`gpio0\` int(11) NOT NULL DEFAULT '0',
		 \`gpio1\` int(11) NOT NULL DEFAULT '0',
		 \`gpio2\` int(11) NOT NULL DEFAULT '0',
		 \`gpio3\` int(11) NOT NULL DEFAULT '0'
		);
		INSERT INTO PINS VALUES(0,0,0,0);
		CREATE TABLE IF NOT EXISTS \`temperature_record\` (
		 \`device_name\` varchar(64) NOT NULL,
		 \`rec_num\` INTEGER PRIMARY KEY,
		 \`temperature\` float NOT NULL,
		 \`date_time\` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
		);
		CREATE TABLE IF NOT EXISTS \`Device\` (
		 \`DeviceID\` INTEGER PRIMARY KEY,
		 \`DeviceName\` TEXT NOT NULL
		);
		CREATE TABLE IF NOT EXISTS \`DeviceData\` (
		 \`DataID\` INTEGER PRIMARY KEY,
		DeviceID INTEGER,
		 \`DataName\` TEXT, FOREIGN KEY(DeviceID ) REFERENCES Device(DeviceID)
		);
		CREATE TABLE IF NOT EXISTS \`Data\` (
		SequenceID INTEGER PRIMARY KEY,
		 \`DeviceID\` INTEGER NOT NULL,
		 \`DataID\` INTEGER NOT NULL,
		 \`DataValue\` NUMERIC NOT NULL,
		 \`epoch\` NUMERIC NOT NULL,
		 \`timestamp\` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , FOREIGN KEY(DataID, DeviceID ) REFERENCES DeviceData(DAtaID, DeviceID )
		);
    


cd
sudo chmod 777 /home/pi/dbs
sudo chmod 666 /home/pi/dbs/iot.db
cd

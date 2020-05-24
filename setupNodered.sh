
for addonnodes in moment node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer \
node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms node-red-node-geofence node-red-contrib-moment node-red-contrib-particle \
node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb \
node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino \
node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp \
node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller ; do
    printstatus "Installing node \"${addonnodes}\""
    npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

printstatus "Installing node \"node-red-node-sqlite\""
npm $NQUIET install --unsafe-perm node-red-node-sqlite 2>&1 | tee -a $LOGFILE

printstatus "Installing nodes \"serialport and i2c-bus\""
npm $NQUIET install node-red-node-serialport i2c-bus 2>&1 | tee -a $LOGFILE

getent group gpio || sudo groupadd gpio 2>&1 | tee -a $LOGFILE
getent group gpio | grep -w -l pi || sudo adduser pi gpio 2>&1 | tee -a $LOGFILE

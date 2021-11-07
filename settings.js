/**
 * Originale latest version: https://raw.githubusercontent.com/node-red/node-red/master/settings.js
 **/

var fs = require("fs");
//var i2c = require("i2c-bus");
var mySettings;
try {
	mySettings = require("/home/pi/.node-red/redvars.js");
} catch(err) {
	mySettings = {};
}

module.exports = {
    uiPort: process.env.PORT || 1880,
    mqttReconnectTime: 15000,
    serialReconnectTime: 15000,
    debugMaxLength: 1000,
    flowFile: 'flows.json',
    flowFilePretty: true,
    httpStatic: '/home/pi/.node-red/public',
    functionGlobalContext: {
        os:require('os'),
        moment:require('moment'),
        fs:require('fs'),
		//i2c:require('i2c-bus'),
        mySettings:mySettings
    },
    logging: {
        console: {
            level: "info",
            metrics: false,
            audit: false
        }
    },
    //adminAuth: { type: "credentials", users: [{ username: "", password: "", permissions: "*" }] },
    //httpNodeAuth: {user:"", pass:""},
    editorTheme: { projects: { enabled: false }
    }

    // By default, credentials are encrypted in storage using a generated key. To
    // specify your own secret, set the following property.
    // If you want to disable encryption of credentials, set this property to false.
    // Note: once you set this property, do not change it - doing so will prevent
    // node-red from being able to decrypt your existing credentials and they will be
    // lost.
    //credentialSecret: "a-secret-key",

    //https: {
    //    key: fs.readFileSync('privatekey.pem'),
    //    cert: fs.readFileSync('certificate.pem')
    //},
    //requireHttps: true
}

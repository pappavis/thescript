[
    {
        "id": "f29ceabe41e28c63",
        "type": "tab",
        "label": "test 1 2 3",
        "disabled": false,
        "info": "",
        "env": []
    },
    {
        "id": "a7951a73.242a18",
        "type": "tab",
        "label": "WLED",
        "disabled": false,
        "info": ""
    },
    {
        "id": "5a52a983.5025e8",
        "type": "tab",
        "label": "deepsleep_hallo_wereld_20190123",
        "disabled": false
    },
    {
        "id": "95126d70a8834898",
        "type": "tab",
        "label": "Pi Camera Stills to Dashboard",
        "disabled": false,
        "info": "ref--> https://flows.nodered.org/flow/2b6c2f0d7a316f1a6831782d33a0d40c\r\n",
        "env": []
    },
    {
        "id": "259de6d950e7a792",
        "type": "tab",
        "label": "MaxInt_lichtkrant",
        "disabled": false,
        "info": ""
    },
    {
        "id": "b800f0d96601098f",
        "type": "tab",
        "label": "telegramSimpleBot",
        "disabled": false,
        "info": "",
        "env": []
    },
    {
        "id": "7003ac79.485954",
        "type": "mqtt-broker",
        "name": "michiele@pi4.local",
        "broker": "localhost",
        "port": "1883",
        "clientid": "michiele@pi4.local",
        "usetls": false,
        "protocolVersion": "4",
        "keepalive": "60",
        "cleansession": true,
        "birthTopic": "",
        "birthQos": "0",
        "birthRetain": "false",
        "birthPayload": "",
        "birthMsg": {},
        "closeTopic": "",
        "closeRetain": "false",
        "closePayload": "",
        "closeMsg": {},
        "willTopic": "",
        "willQos": "0",
        "willRetain": "false",
        "willPayload": "",
        "willMsg": {},
        "sessionExpiry": ""
    },
    {
        "id": "5c5d1421.257f6c",
        "type": "mqtt-broker",
        "name": "admin@dietpi.local",
        "broker": "dietpi.local",
        "port": "1883",
        "clientid": "",
        "autoConnect": true,
        "usetls": false,
        "protocolVersion": "4",
        "keepalive": "60",
        "cleansession": true,
        "birthTopic": "",
        "birthQos": "0",
        "birthPayload": "",
        "birthMsg": {},
        "closeTopic": "",
        "closePayload": "",
        "closeMsg": {},
        "willTopic": "",
        "willQos": "0",
        "willPayload": "",
        "willMsg": {},
        "sessionExpiry": ""
    },
    {
        "id": "a6a3041b.8ef2e8",
        "type": "mqtt-broker",
        "name": "",
        "broker": "localhost",
        "port": "1883",
        "clientid": "admin@localhost",
        "autoConnect": true,
        "usetls": false,
        "protocolVersion": "4",
        "keepalive": "60",
        "cleansession": true,
        "birthTopic": "",
        "birthQos": "0",
        "birthRetain": "false",
        "birthPayload": "",
        "birthMsg": {},
        "closeTopic": "",
        "closePayload": "",
        "closeMsg": {},
        "willTopic": "",
        "willQos": "0",
        "willRetain": "false",
        "willPayload": "",
        "willMsg": {},
        "sessionExpiry": ""
    },
    {
        "id": "c7a43587.2944e8",
        "type": "ui_group",
        "name": "Default",
        "tab": "fbd536a.22bf9c8",
        "order": 1,
        "disp": true,
        "width": "6",
        "collapse": false
    },
    {
        "id": "fbd536a.22bf9c8",
        "type": "ui_tab",
        "name": "Home",
        "icon": "dashboard"
    },
    {
        "id": "67232ccf60ca9487",
        "type": "ui_base",
        "theme": {
            "name": "theme-light",
            "lightTheme": {
                "default": "#0094CE",
                "baseColor": "#0094CE",
                "baseFont": "-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Oxygen-Sans,Ubuntu,Cantarell,Helvetica Neue,sans-serif",
                "edited": false
            },
            "darkTheme": {
                "default": "#097479",
                "baseColor": "#097479",
                "baseFont": "-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Oxygen-Sans,Ubuntu,Cantarell,Helvetica Neue,sans-serif",
                "edited": false
            },
            "customTheme": {
                "name": "Untitled Theme 1",
                "default": "#4B7930",
                "baseColor": "#4B7930",
                "baseFont": "-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Oxygen-Sans,Ubuntu,Cantarell,Helvetica Neue,sans-serif"
            },
            "themeState": {
                "base-color": {
                    "default": "#0094CE",
                    "value": "#0094CE",
                    "edited": false
                },
                "page-titlebar-backgroundColor": {
                    "value": "#0094CE",
                    "edited": false
                },
                "page-backgroundColor": {
                    "value": "#fafafa",
                    "edited": false
                },
                "page-sidebar-backgroundColor": {
                    "value": "#ffffff",
                    "edited": false
                },
                "group-textColor": {
                    "value": "#1bbfff",
                    "edited": false
                },
                "group-borderColor": {
                    "value": "#ffffff",
                    "edited": false
                },
                "group-backgroundColor": {
                    "value": "#ffffff",
                    "edited": false
                },
                "widget-textColor": {
                    "value": "#111111",
                    "edited": false
                },
                "widget-backgroundColor": {
                    "value": "#0094ce",
                    "edited": false
                },
                "widget-borderColor": {
                    "value": "#ffffff",
                    "edited": false
                },
                "base-font": {
                    "value": "-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Oxygen-Sans,Ubuntu,Cantarell,Helvetica Neue,sans-serif"
                }
            },
            "angularTheme": {
                "primary": "indigo",
                "accents": "blue",
                "warn": "red",
                "background": "grey",
                "palette": "light"
            }
        },
        "site": {
            "name": "Node-RED Dashboard",
            "hideToolbar": "false",
            "allowSwipe": "false",
            "lockMenu": "false",
            "allowTempTheme": "true",
            "dateFormat": "DD/MM/YYYY",
            "sizes": {
                "sx": 48,
                "sy": 48,
                "gx": 6,
                "gy": 6,
                "cx": 6,
                "cy": 6,
                "px": 0,
                "py": 0
            }
        }
    },
    {
        "id": "c3670dce.18aa8",
        "type": "telegram bot",
        "botname": "speelgoed_bot",
        "usernames": "",
        "chatids": "",
        "baseapiurl": "",
        "updatemode": "polling",
        "pollinterval": "300",
        "usesocks": false,
        "sockshost": "",
        "socksport": "",
        "socksusername": "anonymous",
        "sockspassword": "",
        "bothost": "",
        "botpath": "",
        "localbotport": "8443",
        "publicbotport": "8443",
        "privatekey": "",
        "certificate": "",
        "useselfsignedcertificate": false,
        "sslterminated": false,
        "verboselogging": true
    },
    {
        "id": "5431811de709fcc9",
        "type": "inject",
        "z": "f29ceabe41e28c63",
        "name": "",
        "props": [
            {
                "p": "payload"
            },
            {
                "p": "topic",
                "vt": "str"
            }
        ],
        "repeat": "",
        "crontab": "",
        "once": false,
        "onceDelay": 0.1,
        "topic": "",
        "payload": "",
        "payloadType": "date",
        "x": 120,
        "y": 60,
        "wires": [
            [
                "234f07316765180e"
            ]
        ]
    },
    {
        "id": "92d134b87baac249",
        "type": "debug",
        "z": "f29ceabe41e28c63",
        "name": "",
        "active": true,
        "tosidebar": true,
        "console": false,
        "tostatus": false,
        "complete": "false",
        "statusVal": "",
        "statusType": "auto",
        "x": 570,
        "y": 60,
        "wires": []
    },
    {
        "id": "234f07316765180e",
        "type": "function",
        "z": "f29ceabe41e28c63",
        "name": "",
        "func": "msg.payload += \" test 123\";\nreturn msg;\n",
        "outputs": 1,
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 340,
        "y": 80,
        "wires": [
            [
                "92d134b87baac249"
            ]
        ]
    },
    {
        "id": "fcbbfad.1e64e08",
        "type": "mqtt in",
        "z": "a7951a73.242a18",
        "name": "",
        "topic": "wled/light/status",
        "qos": "2",
        "datatype": "auto",
        "broker": "a6a3041b.8ef2e8",
        "nl": false,
        "rap": false,
        "rh": "0",
        "inputs": 0,
        "x": 170,
        "y": 100,
        "wires": [
            [
                "2af5f603.85ff3a"
            ]
        ]
    },
    {
        "id": "2af5f603.85ff3a",
        "type": "debug",
        "z": "a7951a73.242a18",
        "name": "",
        "active": true,
        "tosidebar": true,
        "console": false,
        "tostatus": false,
        "complete": "false",
        "x": 590,
        "y": 140,
        "wires": []
    },
    {
        "id": "528db2eb.2dea0c",
        "type": "mqtt in",
        "z": "a7951a73.242a18",
        "name": "",
        "topic": "led/light/switch",
        "qos": "2",
        "datatype": "auto",
        "broker": "5c5d1421.257f6c",
        "inputs": 0,
        "x": 180,
        "y": 200,
        "wires": [
            [
                "2af5f603.85ff3a"
            ]
        ]
    },
    {
        "id": "6ae77e2c.bb4c8",
        "type": "mqtt in",
        "z": "a7951a73.242a18",
        "name": "",
        "topic": "wled/79139d",
        "qos": "2",
        "datatype": "auto",
        "broker": "5c5d1421.257f6c",
        "inputs": 0,
        "x": 170,
        "y": 340,
        "wires": [
            [
                "2af5f603.85ff3a"
            ]
        ]
    },
    {
        "id": "88277a33.f22a58",
        "type": "mqtt in",
        "z": "5a52a983.5025e8",
        "name": "",
        "topic": "deepsleep_hallo_wereld_20190123/hallo",
        "qos": "2",
        "broker": "a6a3041b.8ef2e8",
        "inputs": 0,
        "x": 247.16668701171875,
        "y": 77.3333511352539,
        "wires": [
            [
                "66d547a1.fb2298"
            ]
        ]
    },
    {
        "id": "66d547a1.fb2298",
        "type": "debug",
        "z": "5a52a983.5025e8",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "payload",
        "x": 661.1666831970215,
        "y": 96.66667366027832,
        "wires": []
    },
    {
        "id": "90817a94.6fc3e8",
        "type": "mqtt in",
        "z": "5a52a983.5025e8",
        "name": "Wemos is wakker",
        "topic": "deepsleep_hallo_wereld_20190123/reboot/setup",
        "qos": "0",
        "broker": "a6a3041b.8ef2e8",
        "inputs": 0,
        "x": 124,
        "y": 407.0000009536743,
        "wires": [
            [
                "94d05079.7dcf8"
            ]
        ]
    },
    {
        "id": "94d05079.7dcf8",
        "type": "function",
        "z": "5a52a983.5025e8",
        "name": "setdeepSleepInterval 30minuten",
        "func": "var deepSleepInterval = 30*60;\n\nif(msg.topic == \"deepsleep_hallo_wereld_20190123/reboot/setup\")\n{\n    if(parseInt(msg.payload) == 1)\n    {\n        msg.payload = parseInt(deepSleepInterval);\n    }\n}\n\nreturn msg;\n",
        "outputs": 1,
        "noerr": 0,
        "x": 519.0000152587891,
        "y": 358.6666965484619,
        "wires": [
            [
                "ca04f79c.e1b9f8",
                "9ec4a980.817dc8"
            ]
        ]
    },
    {
        "id": "ca04f79c.e1b9f8",
        "type": "mqtt out",
        "z": "5a52a983.5025e8",
        "name": "",
        "topic": "deepsleep_hallo_wereld_20190123/deepSleepIntervalSekonden/waarde",
        "qos": "2",
        "retain": "",
        "broker": "a6a3041b.8ef2e8",
        "x": 989,
        "y": 316.3333330154419,
        "wires": []
    },
    {
        "id": "9ec4a980.817dc8",
        "type": "debug",
        "z": "5a52a983.5025e8",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "payload",
        "x": 820,
        "y": 432.3333578109741,
        "wires": []
    },
    {
        "id": "a1ffc9ea.dd7b98",
        "type": "inject",
        "z": "5a52a983.5025e8",
        "name": "inject deepSleepIntervalSekonden",
        "repeat": "",
        "crontab": "",
        "once": false,
        "topic": "deepsleep_hallo_wereld_20190123/reboot/setup",
        "payload": "30",
        "payloadType": "str",
        "x": 198.00001525878906,
        "y": 214,
        "wires": [
            [
                "ca04f79c.e1b9f8"
            ]
        ]
    },
    {
        "id": "fba66d89.3e7e3",
        "type": "mqtt in",
        "z": "5a52a983.5025e8",
        "name": "halloWereld",
        "topic": "halloWereld",
        "qos": "2",
        "broker": "a6a3041b.8ef2e8",
        "inputs": 0,
        "x": 205,
        "y": 537.0000486373901,
        "wires": [
            [
                "e49cf77d.a65f18"
            ]
        ]
    },
    {
        "id": "e49cf77d.a65f18",
        "type": "debug",
        "z": "5a52a983.5025e8",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "payload",
        "x": 523,
        "y": 549.3333616256714,
        "wires": []
    },
    {
        "id": "f606f3d2.82c61",
        "type": "inject",
        "z": "5a52a983.5025e8",
        "name": "",
        "repeat": "",
        "crontab": "",
        "once": false,
        "topic": "weatherstation/bmp1/debug",
        "payload": "1",
        "payloadType": "num",
        "x": 251.99998474121094,
        "y": 668.0000655651093,
        "wires": [
            [
                "6988fcf6.bc5954"
            ]
        ]
    },
    {
        "id": "6988fcf6.bc5954",
        "type": "mqtt out",
        "z": "5a52a983.5025e8",
        "name": "",
        "topic": "weatherstation/bmp1/debug",
        "qos": "2",
        "retain": "",
        "broker": "a6a3041b.8ef2e8",
        "x": 694.9999961853027,
        "y": 647.3333578109741,
        "wires": []
    },
    {
        "id": "da74b68c.1b7828",
        "type": "inject",
        "z": "5a52a983.5025e8",
        "name": "wakker worden!",
        "repeat": "",
        "crontab": "",
        "once": false,
        "topic": "deepsleep_hallo_wereld_20190123/reboot/setup",
        "payload": "true",
        "payloadType": "bool",
        "x": 137.1666717529297,
        "y": 282.333345413208,
        "wires": [
            [
                "94d05079.7dcf8"
            ]
        ]
    },
    {
        "id": "d0641d87c118146f",
        "type": "inject",
        "z": "95126d70a8834898",
        "name": "picamera",
        "props": [
            {
                "p": "payload"
            },
            {
                "p": "topic",
                "vt": "str"
            }
        ],
        "repeat": "",
        "crontab": "",
        "once": false,
        "onceDelay": "",
        "topic": "",
        "payload": "",
        "payloadType": "str",
        "x": 140,
        "y": 120,
        "wires": [
            [
                "28bef92a0654a485"
            ]
        ]
    },
    {
        "id": "28bef92a0654a485",
        "type": "exec",
        "z": "95126d70a8834898",
        "command": "raspistill",
        "addpay": false,
        "append": "-w 320 -h 240 -o -",
        "useSpawn": "false",
        "timer": "",
        "oldrc": false,
        "name": "",
        "x": 340,
        "y": 120,
        "wires": [
            [
                "9ef749d12b17fa5f"
            ],
            [],
            []
        ]
    },
    {
        "id": "9ef749d12b17fa5f",
        "type": "base64",
        "z": "95126d70a8834898",
        "name": "",
        "action": "str",
        "property": "payload",
        "x": 560,
        "y": 120,
        "wires": [
            [
                "a6571dd1361c2c86"
            ]
        ]
    },
    {
        "id": "a6571dd1361c2c86",
        "type": "template",
        "z": "95126d70a8834898",
        "name": "",
        "field": "payload",
        "fieldType": "msg",
        "format": "handlebars",
        "syntax": "mustache",
        "template": "<img width=\"320px\" height=\"240px\" src=\"data:image/jpg;base64,{{{payload}}}\">",
        "output": "str",
        "x": 760,
        "y": 120,
        "wires": [
            [
                "ae6dbd702b9c129c"
            ]
        ]
    },
    {
        "id": "ae6dbd702b9c129c",
        "type": "ui_template",
        "z": "95126d70a8834898",
        "group": "c7a43587.2944e8",
        "name": "",
        "order": 0,
        "width": "6",
        "height": "5",
        "format": "<div ng-bind-html=\"msg.payload\"></div>",
        "storeOutMessages": true,
        "fwdInMessages": true,
        "templateScope": "local",
        "x": 940,
        "y": 120,
        "wires": [
            []
        ]
    },
    {
        "id": "af0350a83fd0e793",
        "type": "mqtt out",
        "z": "259de6d950e7a792",
        "name": "",
        "topic": "lichtkrant/tape",
        "qos": "2",
        "retain": "true",
        "respTopic": "",
        "contentType": "",
        "userProps": "",
        "correl": "",
        "expiry": "",
        "broker": "5c5d1421.257f6c",
        "x": 952,
        "y": 217.33330917358398,
        "wires": []
    },
    {
        "id": "f6d94cfbaa03a69b",
        "type": "mqtt in",
        "z": "259de6d950e7a792",
        "name": "",
        "topic": "lichtkrant/mqqt_connect",
        "qos": "2",
        "datatype": "auto",
        "broker": "5c5d1421.257f6c",
        "nl": false,
        "rap": false,
        "rh": "0",
        "inputs": 0,
        "x": 126,
        "y": 289.9999809265137,
        "wires": [
            [
                "b50638d533b3cd62",
                "8bef64e35485aa0e"
            ]
        ]
    },
    {
        "id": "b50638d533b3cd62",
        "type": "debug",
        "z": "259de6d950e7a792",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "false",
        "x": 375.00000762939453,
        "y": 320.3333339691162,
        "wires": []
    },
    {
        "id": "bd5e384aaa90880d",
        "type": "inject",
        "z": "259de6d950e7a792",
        "name": "Wemos led uit",
        "repeat": "",
        "crontab": "",
        "once": false,
        "topic": "",
        "payload": "0",
        "payloadType": "num",
        "x": 114,
        "y": 460.9999828338623,
        "wires": [
            [
                "73b946fdffddfc28"
            ]
        ]
    },
    {
        "id": "73b946fdffddfc28",
        "type": "mqtt out",
        "z": "259de6d950e7a792",
        "name": "",
        "topic": "ledStatus",
        "qos": "2",
        "retain": "true",
        "respTopic": "",
        "contentType": "",
        "userProps": "",
        "correl": "",
        "expiry": "",
        "broker": "7003ac79.485954",
        "x": 400.00000762939453,
        "y": 443.33331775665283,
        "wires": []
    },
    {
        "id": "4f5b57ea272ff0ac",
        "type": "inject",
        "z": "259de6d950e7a792",
        "name": "Wemos led aan",
        "repeat": "",
        "crontab": "",
        "once": false,
        "topic": "",
        "payload": "1",
        "payloadType": "num",
        "x": 118.83331298828125,
        "y": 517.666651725769,
        "wires": [
            [
                "73b946fdffddfc28"
            ]
        ]
    },
    {
        "id": "7782d4a0f75e3f20",
        "type": "function",
        "z": "259de6d950e7a792",
        "name": "lichtkrant tekst",
        "func": "// msg.payload = \"aponsen.. Verlangen, vervloeken Verdoemen, verzoeking Verdoemenis beloven Verbranden en vernietigen Verspreiden ze geboden    liefde    aponsen@hotmail.com        knuffelbeest                    liefde                 xx          mens         \";\n// msg.payload = \"    MQQT tekst         niet ONS huis maar MIJN huis        is dat liefde?     Leef aponsen@hotmail.com         \";\nmsg.payload = \"    MQQT tekst           \";\n\n\nreturn msg;",
        "outputs": 1,
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 435,
        "y": 177.6666431427002,
        "wires": [
            [
                "af0350a83fd0e793"
            ]
        ]
    },
    {
        "id": "8bef64e35485aa0e",
        "type": "http request",
        "z": "259de6d950e7a792",
        "name": "GET chuck norris",
        "method": "GET",
        "ret": "txt",
        "url": "https://api.chucknorris.io/jokes/random",
        "tls": "",
        "x": 410.99999237060547,
        "y": 92.66664123535156,
        "wires": [
            [
                "5c4804dd173137a0",
                "7782d4a0f75e3f20"
            ]
        ]
    },
    {
        "id": "3d5ba6c743d0d136",
        "type": "inject",
        "z": "259de6d950e7a792",
        "name": "scrolltext hier",
        "repeat": "2040",
        "crontab": "",
        "once": true,
        "topic": "",
        "payload": "doen Chuck Norris lichtkrant",
        "payloadType": "str",
        "x": 127.83331298828125,
        "y": 64.66664218902588,
        "wires": [
            [
                "8bef64e35485aa0e"
            ]
        ]
    },
    {
        "id": "bbed6c78d8dc2430",
        "type": "debug",
        "z": "259de6d950e7a792",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "false",
        "x": 995.0000038146973,
        "y": 90.33331298828125,
        "wires": []
    },
    {
        "id": "9f4e2aae44614b78",
        "type": "function",
        "z": "259de6d950e7a792",
        "name": "",
        "func": "msg.payload = \" XX \" + msg.payload[\"value\"] + \"\";\nreturn msg;",
        "outputs": 1,
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 769,
        "y": 80.6666488647461,
        "wires": [
            [
                "bbed6c78d8dc2430",
                "af0350a83fd0e793"
            ]
        ]
    },
    {
        "id": "5c4804dd173137a0",
        "type": "json",
        "z": "259de6d950e7a792",
        "name": "",
        "property": "payload",
        "action": "",
        "pretty": true,
        "x": 605,
        "y": 74.66663932800293,
        "wires": [
            [
                "9f4e2aae44614b78"
            ]
        ]
    },
    {
        "id": "a42b2347.05b25",
        "type": "catch",
        "z": "b800f0d96601098f",
        "name": "",
        "x": 180,
        "y": 620,
        "wires": [
            [
                "bd03654d.09ecb8"
            ]
        ]
    },
    {
        "id": "bd03654d.09ecb8",
        "type": "debug",
        "z": "b800f0d96601098f",
        "name": "Debug",
        "active": true,
        "console": "false",
        "complete": "payload",
        "x": 616,
        "y": 618,
        "wires": []
    },
    {
        "id": "614d1cf1.695f64",
        "type": "function",
        "z": "b800f0d96601098f",
        "name": "confirmation message",
        "func": "var opts = {\n  reply_to_message_id: msg.payload.messageId,\n  reply_markup: JSON.stringify({\n    keyboard: [\n      ['Yes'],\n      ['No']],\n      'resize_keyboard' : true, \n      'one_time_keyboard' : true\n  })\n};\n\nmsg.payload.content = 'Really?';\nmsg.payload.options = opts;\n\nreturn [ msg ];\n",
        "outputs": "1",
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 411,
        "y": 191,
        "wires": [
            [
                "9e138687.ee43a8"
            ]
        ]
    },
    {
        "id": "93c8fa9f.7a1138",
        "type": "telegram command",
        "z": "b800f0d96601098f",
        "name": "/foo",
        "command": "/foo",
        "description": "Reactie van NodeRed NL00016",
        "registercommand": true,
        "language": "",
        "scope": "default",
        "bot": "c3670dce.18aa8",
        "strict": false,
        "hasresponse": true,
        "useregex": false,
        "removeregexcommand": false,
        "outputs": 2,
        "x": 194,
        "y": 244,
        "wires": [
            [
                "614d1cf1.695f64"
            ],
            [
                "4e1d3979.e32fa8"
            ]
        ]
    },
    {
        "id": "4e1d3979.e32fa8",
        "type": "function",
        "z": "b800f0d96601098f",
        "name": "create response",
        "func": "if(msg.payload.content === 'Yes')\n{\n    msg.payload.content = 'Yes';\n    return [msg, null];   \n}\nelse\n{\n    msg.payload.content = 'No';\n    return [null, msg];   \n}\n",
        "outputs": "2",
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 395,
        "y": 250,
        "wires": [
            [
                "9e138687.ee43a8"
            ],
            []
        ]
    },
    {
        "id": "9e138687.ee43a8",
        "type": "telegram sender",
        "z": "b800f0d96601098f",
        "name": "send response",
        "bot": "c3670dce.18aa8",
        "haserroroutput": false,
        "outputs": 1,
        "x": 1000,
        "y": 260,
        "wires": [
            []
        ]
    },
    {
        "id": "6908dd72.a30c74",
        "type": "telegram command",
        "z": "b800f0d96601098f",
        "name": "/help",
        "command": "/help",
        "bot": "c3670dce.18aa8",
        "strict": false,
        "hasresponse": false,
        "outputs": 2,
        "x": 190,
        "y": 356,
        "wires": [
            [
                "c105c26c.7cbe5"
            ],
            []
        ]
    },
    {
        "id": "c105c26c.7cbe5",
        "type": "function",
        "z": "b800f0d96601098f",
        "name": "create help text",
        "func": "\nvar helpMessage = \"/help - shows help\\r\\n\";\nhelpMessage += \"/foo - opens a dialog\\r\\n\";\nhelpMessage += \"/Chuck - Toon Chuck Norris quote\\r\\n\";\nhelpMessage += \"Your chat id is \" + msg.payload.chatId;\n\nhelpMessage += \"\\r\\n\";\nhelpMessage += \"Dankuwel: \"+msg.originalMessage.from.username;\nhelpMessage += \"\\r\\n\";\n\n\n\nmsg.payload.content = helpMessage;\nreturn msg;",
        "outputs": 1,
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 391,
        "y": 350,
        "wires": [
            [
                "9e138687.ee43a8",
                "e5b2bd4e99f71343"
            ]
        ]
    },
    {
        "id": "511a51f2.dd1b6",
        "type": "telegram receiver",
        "z": "b800f0d96601098f",
        "name": "location",
        "bot": "c3670dce.18aa8",
        "saveDataDir": "",
        "x": 193,
        "y": 442,
        "wires": [
            [
                "90bfc801.af6738"
            ],
            []
        ]
    },
    {
        "id": "90bfc801.af6738",
        "type": "function",
        "z": "b800f0d96601098f",
        "name": "create location message",
        "func": "if(msg.payload.type == 'location')\n{\n    var lat = msg.payload.content.latitude;\n    var lng = msg.payload.content.longitude;\n    \n    msg.payload.type = 'message';\n    msg.payload.content = 'lat=' + lat + ' lon=' + lng;\n    return msg;\n}\nelse\n{\n    return null;\n}\n",
        "outputs": 1,
        "noerr": 0,
        "x": 416,
        "y": 442,
        "wires": [
            [
                "9e138687.ee43a8"
            ]
        ]
    },
    {
        "id": "dbc2c834.f29f98",
        "type": "inject",
        "z": "b800f0d96601098f",
        "name": "ping",
        "props": [
            {
                "p": "payload"
            },
            {
                "p": "topic",
                "vt": "str"
            }
        ],
        "repeat": "",
        "crontab": "",
        "once": false,
        "onceDelay": "",
        "topic": "",
        "payload": "ping",
        "payloadType": "str",
        "x": 190,
        "y": 544,
        "wires": [
            [
                "f1873176.02a26"
            ]
        ]
    },
    {
        "id": "f1873176.02a26",
        "type": "function",
        "z": "b800f0d96601098f",
        "name": "send to specific chat",
        "func": "\nmsg.payload = {chatId : 138708568, type : 'message', content : 'ping'}\nreturn msg;",
        "outputs": 1,
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 398,
        "y": 544,
        "wires": [
            [
                "9e138687.ee43a8"
            ]
        ]
    },
    {
        "id": "e5b2bd4e99f71343",
        "type": "debug",
        "z": "b800f0d96601098f",
        "name": "",
        "active": true,
        "tosidebar": true,
        "console": false,
        "tostatus": false,
        "complete": "payload",
        "targetType": "msg",
        "statusVal": "",
        "statusType": "auto",
        "x": 970,
        "y": 360,
        "wires": []
    },
    {
        "id": "b59c9e2434d4d73d",
        "type": "telegram command",
        "z": "b800f0d96601098f",
        "name": "/Chuck",
        "command": "/Chuck",
        "description": "ChuckNorris quote van NodeRed NL00016",
        "registercommand": true,
        "language": "",
        "scope": "default",
        "bot": "c3670dce.18aa8",
        "strict": false,
        "hasresponse": true,
        "useregex": false,
        "removeregexcommand": false,
        "outputs": 2,
        "x": 130,
        "y": 120,
        "wires": [
            [
                "bdbe841f0e0f14ac"
            ],
            []
        ]
    },
    {
        "id": "bdbe841f0e0f14ac",
        "type": "http request",
        "z": "b800f0d96601098f",
        "name": "GET chuck norris",
        "method": "GET",
        "ret": "txt",
        "url": "https://api.chucknorris.io/jokes/random",
        "tls": "",
        "x": 370,
        "y": 40,
        "wires": [
            [
                "3b827e787defd51c"
            ]
        ]
    },
    {
        "id": "8113894c26c67c03",
        "type": "debug",
        "z": "b800f0d96601098f",
        "name": "",
        "active": true,
        "tosidebar": true,
        "console": false,
        "tostatus": false,
        "complete": "false",
        "statusVal": "",
        "statusType": "auto",
        "x": 990,
        "y": 60,
        "wires": []
    },
    {
        "id": "77dee75adcc0d53c",
        "type": "function",
        "z": "b800f0d96601098f",
        "name": "chuck concat",
        "func": "\nvar helpMessage = \"\\r\\n\";\nhelpMessage += msg.payload.content + \"\\r\\n\";\nhelpMessage += \" ontvangen van: \" + msg.payload.chatId;\nhelpMessage += \"\\r\\n\";\nhelpMessage += \"Dankuwel: \"+msg.originalMessage.from.username;\nhelpMessage += \"\\r\\n\";\n\n\n\nmsg.payload.content = helpMessage;\nreturn msg;",
        "outputs": 1,
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 970,
        "y": 120,
        "wires": [
            []
        ]
    },
    {
        "id": "3b827e787defd51c",
        "type": "json",
        "z": "b800f0d96601098f",
        "name": "",
        "property": "payload",
        "action": "",
        "pretty": true,
        "x": 570,
        "y": 60,
        "wires": [
            [
                "dbcc6937fb14447d"
            ]
        ]
    },
    {
        "id": "98b5ab4a196a0f42",
        "type": "function",
        "z": "b800f0d96601098f",
        "name": "concat1",
        "func": "msg.payload = \" SpeelgoedBot \" + msg.payload[\"value\"] + \"\";\nvar helpMessage = \"Chuck Norris quote\\r\\n\";\nhelpMessage += \"Your chat id is \" + msg.payload.chatId;\n\nhelpMessage += \"\\r\\n\";\nhelpMessage += \"Dankuwel: \"+msg.originalMessage.from.username;\nhelpMessage += \"\\r\\n\";\n\n\n\nmsg.payload.content = helpMessage;\nreturn msg;",
        "outputs": 1,
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 740,
        "y": 40,
        "wires": [
            []
        ]
    },
    {
        "id": "4624c35a92a03d57",
        "type": "inject",
        "z": "b800f0d96601098f",
        "name": "",
        "props": [
            {
                "p": "payload"
            },
            {
                "p": "topic",
                "vt": "str"
            }
        ],
        "repeat": "",
        "crontab": "",
        "once": false,
        "onceDelay": 0.1,
        "topic": "",
        "payload": "",
        "payloadType": "date",
        "x": 120,
        "y": 40,
        "wires": [
            [
                "bdbe841f0e0f14ac"
            ]
        ]
    },
    {
        "id": "dbcc6937fb14447d",
        "type": "function",
        "z": "b800f0d96601098f",
        "name": "create help text",
        "func": "\nvar helpMessage = \"/help - shows help\\r\\n\";\nhelpMessage += \"/foo - opens a dialog\\r\\n\";\nhelpMessage += \"Chuck Norris quote -->\\r\\n\";\nhelpMessage += \"\\r\\n\";\nhelpMessage += \"\\r\\n\";\nhelpMessage += \"Your chat id is \" + msg.payload.chatId;\nhelpMessage += \"\\r\\n\";\n\nhelpMessage += \"\\r\\n\";\nhelpMessage += \"Dankuwel: \" + msg.originalMessage.from.username;\nhelpMessage += \"\\r\\n\";\n\n\n\nmsg.payload.content = helpMessage;\nreturn msg;",
        "outputs": 1,
        "noerr": 0,
        "initialize": "",
        "finalize": "",
        "libs": [],
        "x": 740,
        "y": 100,
        "wires": [
            [
                "8113894c26c67c03",
                "9e138687.ee43a8"
            ]
        ]
    }
]

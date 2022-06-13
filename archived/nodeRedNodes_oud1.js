[
    {
        "id": "69238f4c.8e23f",
        "type": "tab",
        "label": "Weerstation-micropython",
        "disabled": false,
        "info": ""
    },
    {
        "id": "43f95fa6.1e9ed",
        "type": "tab",
        "label": "JSON_test",
        "disabled": false,
        "info": ""
    },
    {
        "id": "a64e0c32.c396f",
        "type": "tab",
        "label": "TTN_test",
        "disabled": false,
        "info": ""
    },
    {
        "id": "5ba46c1d.b961a4",
        "type": "tab",
        "label": "MaxInt_lichtkrant",
        "disabled": false,
        "info": ""
    },
    {
        "id": "855b7076.01ac4",
        "type": "tab",
        "label": "Octoprint op octopi1",
        "disabled": false,
        "info": ""
    },
    {
        "id": "95a267b0.dfbf78",
        "type": "tab",
        "label": "p1mon",
        "disabled": false,
        "info": ""
    },
    {
        "id": "a7951a73.242a18",
        "type": "tab",
        "label": "WLED",
        "disabled": false,
        "info": ""
    },
    {
        "id": "eab7e4b1.f833c",
        "type": "tab",
        "label": "Homebridge",
        "disabled": false,
        "info": ""
    },
    {
        "id": "fb508433.7560a8",
        "type": "ui_group",
        "z": "",
        "name": "p1mon",
        "tab": "7fcb832a.37aa3c",
        "order": 2,
        "disp": true,
        "width": "18",
        "collapse": false
    },
    {
        "id": "b74d5871.22be88",
        "type": "sqlitedb",
        "z": "",
        "db": "/home/pi/dbs/iot.db"
    },
    {
        "id": "5c5d1421.257f6c",
        "type": "mqtt-broker",
        "z": "",
        "name": "admin@dietpi",
        "broker": "dietpi",
        "port": "1883",
        "clientid": "",
        "usetls": false,
        "compatmode": true,
        "keepalive": "60",
        "cleansession": true,
        "birthTopic": "",
        "birthQos": "0",
        "birthPayload": "",
        "closeTopic": "",
        "closePayload": "",
        "willTopic": "",
        "willQos": "0",
        "willPayload": ""
    },
    {
        "id": "7fcb832a.37aa3c",
        "type": "ui_tab",
        "z": "",
        "name": "p1mon",
        "icon": "dashboard",
        "order": 9,
        "disabled": false,
        "hidden": false
    },
    {
        "id": "c43f31b9.9864",
        "type": "mqtt-broker",
        "z": "",
        "name": "",
        "broker": "localhost",
        "port": "1883",
        "clientid": "michiele-mosquitto",
        "usetls": false,
        "compatmode": true,
        "keepalive": "60",
        "cleansession": true,
        "birthTopic": "",
        "birthQos": "0",
        "birthPayload": "",
        "closeTopic": "",
        "closePayload": "",
        "willTopic": "",
        "willQos": "0",
        "willPayload": ""
    },
    {
        "id": "e57c1143.ae121",
        "type": "ttn app",
        "z": "",
        "appId": "384976234897",
        "accessKey": "ttn-account-v2.PNVnl3M3kMF0LKgqgfHv3IIVn-UVJfmBvdWF4gDaZB4",
        "discovery": "discovery.thethingsnetwork.org:1900"
    },
    {
        "id": "8bbab171.219ac",
        "type": "ui_base",
        "theme": {
            "name": "theme-light",
            "lightTheme": {
                "default": "#0094CE",
                "baseColor": "#0094CE",
                "baseFont": "-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Oxygen-Sans,Ubuntu,Cantarell,Helvetica Neue,sans-serif",
                "edited": true,
                "reset": false
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
                "background": "grey"
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
        "id": "9c5b957f.fdcba8",
        "type": "mqtt in",
        "z": "69238f4c.8e23f",
        "name": "",
        "topic": "weestation/hallo",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 180,
        "y": 40,
        "wires": [
            [
                "eb9d9210.304dc"
            ]
        ]
    },
    {
        "id": "eb9d9210.304dc",
        "type": "debug",
        "z": "69238f4c.8e23f",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "payload",
        "x": 673.9999961853027,
        "y": 59.333322525024414,
        "wires": []
    },
    {
        "id": "c762c561.8290d8",
        "type": "mqtt in",
        "z": "69238f4c.8e23f",
        "name": "Wemos reboot setup",
        "topic": "weatherStation/reboot/setup",
        "qos": "0",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 170,
        "y": 360,
        "wires": [
            [
                "3f295a28.6d0cd6"
            ]
        ]
    },
    {
        "id": "3f295a28.6d0cd6",
        "type": "function",
        "z": "69238f4c.8e23f",
        "name": "setdeepSleepInterval 30minuten",
        "func": "var deepSleepInterval = 30*60;\n\nif(msg.topic == \"weatherStation/reboot/setup\")\n{\n    if(parseInt(msg.payload) == 1)\n    {\n        msg.payload = parseInt(deepSleepInterval);\n    }\n}\n\nreturn msg;\n",
        "outputs": 1,
        "noerr": 0,
        "x": 531.8333282470703,
        "y": 321.333345413208,
        "wires": [
            [
                "104131d1.05643e",
                "317b823c.f6816e"
            ]
        ]
    },
    {
        "id": "104131d1.05643e",
        "type": "mqtt out",
        "z": "69238f4c.8e23f",
        "name": "",
        "topic": "weatherStation/deepSleepIntervalSekonden/waarde",
        "qos": "2",
        "retain": "",
        "broker": "c43f31b9.9864",
        "x": 931.8333129882812,
        "y": 278.999981880188,
        "wires": []
    },
    {
        "id": "317b823c.f6816e",
        "type": "debug",
        "z": "69238f4c.8e23f",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "payload",
        "x": 832.8333129882812,
        "y": 395.0000066757202,
        "wires": []
    },
    {
        "id": "787b60b3.0b0c3",
        "type": "inject",
        "z": "69238f4c.8e23f",
        "name": "inject deepSleepIntervalSekonden",
        "topic": "weatherStation/ONTWAAK",
        "payload": "30",
        "payloadType": "str",
        "repeat": "",
        "crontab": "",
        "once": false,
        "x": 210.8333282470703,
        "y": 176.6666488647461,
        "wires": [
            [
                "104131d1.05643e"
            ]
        ]
    },
    {
        "id": "8b761385.62351",
        "type": "mqtt in",
        "z": "69238f4c.8e23f",
        "name": "halloWereld",
        "topic": "weatherStation/halloWereld",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 217.83331680297852,
        "y": 537.6667137145996,
        "wires": [
            [
                "e941fa34.b09f48"
            ]
        ]
    },
    {
        "id": "e941fa34.b09f48",
        "type": "debug",
        "z": "69238f4c.8e23f",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "payload",
        "x": 535.8333129882812,
        "y": 512.0000104904175,
        "wires": []
    },
    {
        "id": "29d86698.b5a39a",
        "type": "inject",
        "z": "69238f4c.8e23f",
        "name": "",
        "topic": "weatherStation/bmp1/debug",
        "payload": "1",
        "payloadType": "num",
        "repeat": "",
        "crontab": "",
        "once": false,
        "x": 235.8332977294922,
        "y": 638.6666870117188,
        "wires": [
            [
                "e5343a0.3e2acc8"
            ]
        ]
    },
    {
        "id": "e5343a0.3e2acc8",
        "type": "mqtt out",
        "z": "69238f4c.8e23f",
        "name": "",
        "topic": "weatherstation/bmp1/debug",
        "qos": "2",
        "retain": "",
        "broker": "c43f31b9.9864",
        "x": 707.833309173584,
        "y": 610.0000066757202,
        "wires": []
    },
    {
        "id": "b1ae6907.105048",
        "type": "inject",
        "z": "69238f4c.8e23f",
        "name": "wakker worden!",
        "topic": "weatherStation/ONTWAAK",
        "payload": "true",
        "payloadType": "bool",
        "repeat": "",
        "crontab": "",
        "once": false,
        "x": 149.99998474121094,
        "y": 244.9999942779541,
        "wires": [
            [
                "3f295a28.6d0cd6",
                "7829b1e8.85ee"
            ]
        ]
    },
    {
        "id": "c9bd2aec.b70218",
        "type": "mqtt in",
        "z": "69238f4c.8e23f",
        "name": "Wemos is wakker",
        "topic": "weatherStation/ONTWAAKT",
        "qos": "0",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 135.83331298828125,
        "y": 435.6666793823242,
        "wires": [
            [
                "3f295a28.6d0cd6"
            ]
        ]
    },
    {
        "id": "72a24e15.efc13",
        "type": "mqtt in",
        "z": "69238f4c.8e23f",
        "name": "",
        "topic": "weatherStation/DHT/humidity",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 211,
        "y": 752,
        "wires": [
            [
                "93432ecb.847c9"
            ]
        ]
    },
    {
        "id": "846ac47f.678f58",
        "type": "debug",
        "z": "69238f4c.8e23f",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "payload",
        "x": 725.9999923706055,
        "y": 791.3333396911621,
        "wires": []
    },
    {
        "id": "93432ecb.847c9",
        "type": "function",
        "z": "69238f4c.8e23f",
        "name": "percentSimbool",
        "func": "if(msg.topic == \"weatherStation/DHT/humidity\") {\n    msg.payload += \"%\";\n    return msg;\n}\n",
        "outputs": 1,
        "noerr": 0,
        "x": 479.00000762939453,
        "y": 753.6666631698608,
        "wires": [
            [
                "846ac47f.678f58",
                "ba17a75a.c27508"
            ]
        ]
    },
    {
        "id": "ba17a75a.c27508",
        "type": "ui_text",
        "z": "69238f4c.8e23f",
        "group": "fb508433.7560a8",
        "order": 0,
        "width": 0,
        "height": 0,
        "name": "Luchtvochtigheid",
        "label": "python Luchtvochtigheid: ",
        "format": "{{msg.payload}}",
        "layout": "row-spread",
        "x": 737.9999923706055,
        "y": 720.6666564941406,
        "wires": []
    },
    {
        "id": "bf07352c.e84938",
        "type": "mqtt in",
        "z": "69238f4c.8e23f",
        "name": "dht/temperature",
        "topic": "weatherStation/DHT/temperature",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 149.00001525878906,
        "y": 949.9999990463257,
        "wires": [
            [
                "27ed9bcd.c466d4",
                "266f2c47.d909f4",
                "f5eb4255.41c5f"
            ]
        ]
    },
    {
        "id": "266f2c47.d909f4",
        "type": "function",
        "z": "69238f4c.8e23f",
        "name": "gradenSimbool",
        "func": "if(msg.topic == \"weatherStation/DHT/temperature\") {\n    msg.payload += \"°C\";\n    return msg;\n}\n",
        "outputs": 1,
        "noerr": 0,
        "x": 409.8334426879883,
        "y": 988.6667032241821,
        "wires": [
            [
                "1c87110c.c2029f"
            ]
        ]
    },
    {
        "id": "1c87110c.c2029f",
        "type": "ui_text",
        "z": "69238f4c.8e23f",
        "group": "fb508433.7560a8",
        "order": 0,
        "width": 0,
        "height": 0,
        "name": "temperatuur",
        "label": "python Temp. laatste sensor meting:",
        "format": "{{msg.payload}}",
        "layout": "row-spread",
        "x": 674.8333969116211,
        "y": 977.6666669845581,
        "wires": []
    },
    {
        "id": "d295f5d1.2915d8",
        "type": "mqtt in",
        "z": "69238f4c.8e23f",
        "name": "weatherStation/DHT/luchtdruk",
        "topic": "weatherStation/DHT/luchtdruk",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 200,
        "y": 1080,
        "wires": [
            [
                "212655df.48861a"
            ]
        ]
    },
    {
        "id": "212655df.48861a",
        "type": "function",
        "z": "69238f4c.8e23f",
        "name": "hpa simbool",
        "func": "if(msg.topic == \"weatherStation/DHT/luchtdruk\") {\n    msg.payload = parseInt(msg.payload) / 100 + \"hPa\";\n    return msg;\n}\n",
        "outputs": 1,
        "noerr": 0,
        "x": 439.8333435058594,
        "y": 1076.6666259765625,
        "wires": [
            [
                "4c00a780.1afc98"
            ]
        ]
    },
    {
        "id": "4c00a780.1afc98",
        "type": "ui_text",
        "z": "69238f4c.8e23f",
        "group": "fb508433.7560a8",
        "order": 0,
        "width": 0,
        "height": 0,
        "name": "Lugdruk",
        "label": "python Luchtdruk: ",
        "format": "{{msg.payload}}",
        "layout": "row-spread",
        "x": 651.8333892822266,
        "y": 1080.6666240692139,
        "wires": []
    },
    {
        "id": "6bb7f00d.b6b06",
        "type": "sqlite",
        "z": "69238f4c.8e23f",
        "mydb": "b74d5871.22be88",
        "sql": "",
        "name": "iot.db",
        "x": 430,
        "y": 1260,
        "wires": [
            [
                "b25c5696.89f7c8"
            ]
        ]
    },
    {
        "id": "59899cfd.2426f4",
        "type": "debug",
        "z": "69238f4c.8e23f",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "false",
        "x": 890,
        "y": 1280,
        "wires": []
    },
    {
        "id": "308e9406.31355c",
        "type": "inject",
        "z": "69238f4c.8e23f",
        "name": "lijst temperature_record  ",
        "topic": "SELECT  strftime('%Y-%m-%d', \"date_time\") datum, round(avg(\"temperature\" ), 1) gem_tempC, round(min(\"temperature\" ), 1) minC, round(max(\"temperature\" ), 1) maxC, round(count(\"temperature\" ), 1) aantalMetingen  FROM temperature_record  WHERE \"date_time\" >= \"2018-12-01 10:00:00\"  and  \"2018-12-31 13:00:00\"  GROUP BY strftime('%Y-%m-%d', \"date_time\")  Order BY strftime('%Y-%m-%d', \"date_time\") desc  limit 0, 30",
        "payload": "",
        "payloadType": "date",
        "repeat": "",
        "crontab": "",
        "once": false,
        "x": 193.99999237060547,
        "y": 1212.6666622161865,
        "wires": [
            [
                "6bb7f00d.b6b06"
            ]
        ]
    },
    {
        "id": "1f344aed.47b8e5",
        "type": "inject",
        "z": "69238f4c.8e23f",
        "name": "laatste tempC",
        "topic": "SELECT  strftime('%Y-%m-%d', \"date_time\") datum, round(avg(\"temperature\" ), 1) gem_tempC, round(min(\"temperature\" ), 1) minC, round(max(\"temperature\" ), 1) maxC, round(count(\"temperature\" ), 1) aantalMetingen  FROM temperature_record  WHERE \"date_time\" >= \"2018-12-01 10:00:00\"  and  \"2018-12-31 13:00:00\"  GROUP BY strftime('%Y-%m-%d', \"date_time\")  Order BY strftime('%Y-%m-%d', \"date_time\") desc  limit 0, 1",
        "payload": "",
        "payloadType": "str",
        "repeat": "",
        "crontab": "",
        "once": false,
        "x": 171.0000114440918,
        "y": 1322.0000343322754,
        "wires": [
            [
                "6bb7f00d.b6b06"
            ]
        ]
    },
    {
        "id": "deaf9be2.4bf608",
        "type": "debug",
        "z": "69238f4c.8e23f",
        "name": "temp debug",
        "active": true,
        "console": "false",
        "complete": "payload",
        "x": 855.1666946411133,
        "y": 903.3333339691162,
        "wires": []
    },
    {
        "id": "27ed9bcd.c466d4",
        "type": "function",
        "z": "69238f4c.8e23f",
        "name": "sql insert temperature_record",
        "func": "var overrideMain = global.get('overrideMain');\nvar overrideTable = global.get('overrideTable');\n\n\n// Update the status with current timestamp\nvar now = new Date();\nvar yyyy = now.getFullYear();\nvar mm = now.getMonth() < 9 ? \"0\" + (now.getMonth() + 1) : (now.getMonth() + 1); // getMonth() is zero-based\nvar dd  = now.getDate() < 10 ? \"0\" + now.getDate() : now.getDate();\nvar hh = now.getHours() < 10 ? \"0\" + now.getHours() : now.getHours();\nvar mmm  = now.getMinutes() < 10 ? \"0\" + now.getMinutes() : now.getMinutes();\nvar ss  = now.getSeconds() < 10 ? \"0\" + now.getSeconds() : now.getSeconds();\nvar timeFormat= dd + \".\" + mm + \".\" + yyyy + \" \" + hh + \":\" + mmm + \":\" + ss;\nnode.status({fill:\"blue\",shape:\"ring\",text:\"Last update: \"+timeFormat});    \n\n//var top=msg.topic.toString();\nvar device_name=\"1fe58100\";\nvar pay=msg.payload;\nvar rec_num=Math.floor((Math.random() * 10000000) + 1) ;\n\nif(msg.topic.includes(\"temperature\"))\n{\n    msg.topic = \"INSERT INTO temperature_record (device_name,rec_num,temperature) VALUES (?,?,?)\";\n    msg.payload = [device_name,rec_num,pay];\n    return msg;\n}\n",
        "outputs": 1,
        "noerr": 0,
        "x": 427.83343505859375,
        "y": 911.6666655540466,
        "wires": [
            [
                "52e9dcc9.fe9a64"
            ]
        ]
    },
    {
        "id": "b25c5696.89f7c8",
        "type": "ui_template",
        "z": "69238f4c.8e23f",
        "group": "fb508433.7560a8",
        "name": "toon Tabel",
        "order": 0,
        "width": 0,
        "height": 0,
        "format": "<table style=\"width:320% height=250%\">\n  <tr>\n    <th colspan=\"5\">Meest recente meetdata</th> \n  </tr>\n  <tr>\n    <th>datum</th> \n    <th>gem_tempC</th>\n    <th>minC</th> \n    <th>maxC</th>\n    <th>aantalMetingen</th>\n  </tr>\n  <tr ng-repeat=\"row in msg.payload | limitTo:30\">\n    <td>{{msg.payload[$index].datum}}</td>\n    <td>{{msg.payload[$index].gem_tempC}}</td> \n    <td>{{msg.payload[$index].minC}}</td>\n    <td>{{msg.payload[$index].maxC}}</td>\n    <td>{{msg.payload[$index].aantalMetingen}}</td>\n  </tr>\n</table>\n",
        "storeOutMessages": true,
        "fwdInMessages": true,
        "x": 690.1666793823242,
        "y": 1263.9999980926514,
        "wires": [
            [
                "59899cfd.2426f4"
            ]
        ]
    },
    {
        "id": "ef7e26f5.afc488",
        "type": "ui_button",
        "z": "69238f4c.8e23f",
        "name": "",
        "group": "fb508433.7560a8",
        "order": 0,
        "width": 0,
        "height": 0,
        "label": "Laatse 30 metingen",
        "color": "",
        "bgcolor": "",
        "icon": "",
        "payload": "",
        "payloadType": "str",
        "topic": "SELECT  strftime('%Y-%m-%d', \"date_time\") datum, round(avg(\"temperature\" ), 1) gem_tempC, round(min(\"temperature\" ), 1) minC, round(max(\"temperature\" ), 1) maxC, round(count(\"temperature\" ), 1) aantalMetingen  FROM temperature_record  WHERE \"date_time\" >= \"2018-12-01 10:00:00\"  and  \"2018-12-31 13:00:00\"  GROUP BY strftime('%Y-%m-%d', \"date_time\")  Order BY strftime('%Y-%m-%d', \"date_time\") desc  limit 0, 30",
        "x": 170.16668701171875,
        "y": 1251.666452407837,
        "wires": [
            [
                "6bb7f00d.b6b06",
                "3129bae7.9f02a6"
            ]
        ]
    },
    {
        "id": "d93f2308.61bc6",
        "type": "ui_button",
        "z": "69238f4c.8e23f",
        "name": "",
        "group": "fb508433.7560a8",
        "order": 0,
        "width": 0,
        "height": 0,
        "label": "Laatste temp",
        "color": "",
        "bgcolor": "",
        "icon": "",
        "payload": "",
        "payloadType": "str",
        "topic": "SELECT  strftime('%Y-%m-%d', \"date_time\") datum, round(avg(\"temperature\" ), 1) gem_tempC, round(min(\"temperature\" ), 1) minC, round(max(\"temperature\" ), 1) maxC, round(count(\"temperature\" ), 1) aantalMetingen  FROM temperature_record  WHERE \"date_time\" >= \"2018-12-01 10:00:00\"  and  \"2018-12-31 13:00:00\"  GROUP BY strftime('%Y-%m-%d', \"date_time\")  Order BY strftime('%Y-%m-%d', \"date_time\") desc  limit 0, 1",
        "x": 160.1666717529297,
        "y": 1369.6664581298828,
        "wires": [
            [
                "6bb7f00d.b6b06"
            ]
        ]
    },
    {
        "id": "52e9dcc9.fe9a64",
        "type": "sqlite",
        "z": "69238f4c.8e23f",
        "mydb": "b74d5871.22be88",
        "sql": "",
        "name": "iot.db",
        "x": 672.8333930969238,
        "y": 900.6667442321777,
        "wires": [
            [
                "deaf9be2.4bf608"
            ]
        ]
    },
    {
        "id": "7829b1e8.85ee",
        "type": "function",
        "z": "69238f4c.8e23f",
        "name": "setWakkerTotSlaaptijdMinuten",
        "func": "var setWakkerTotSlaaptijdMinuten = 1\n\nvar today = new Date();\n\nif(msg.topic == \"weatherStation/ONTWAAK\")\n{\n    if(msg.payload == \"getWakkerBlijvenInterval\")\n    {\n        msg.payload = parseInt(setWakkerTotSlaaptijdMinuten);\n    }\n    \n    if(parseInt(msg.payload) == 1)\n    {\n        msg.payload = setWakkerTotSlaaptijdMinuten;\n    }\n    \n}\n\nreturn msg;\n",
        "outputs": 1,
        "noerr": 0,
        "x": 516.0000076293945,
        "y": 269.00000953674316,
        "wires": [
            [
                "f26ad3b1.62ecf"
            ]
        ]
    },
    {
        "id": "f26ad3b1.62ecf",
        "type": "mqtt out",
        "z": "69238f4c.8e23f",
        "name": "",
        "topic": "weatherStation/INSTELLINGEN/getWakkerBlijvenInterval",
        "qos": "2",
        "retain": "true",
        "broker": "c43f31b9.9864",
        "x": 936.0000152587891,
        "y": 223.0000286102295,
        "wires": []
    },
    {
        "id": "7c920fee.25bf3",
        "type": "debug",
        "z": "69238f4c.8e23f",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "false",
        "x": 711.1666831970215,
        "y": 1403.0000324249268,
        "wires": []
    },
    {
        "id": "bfc89662.a05218",
        "type": "inject",
        "z": "69238f4c.8e23f",
        "name": "testwaarde",
        "topic": "",
        "payload": "{ \"weerdata\": [{ \"clientid\": \"1fe58100\", \"temp\": 24.0833, \"luchtdruk\": 100879.0 }] }",
        "payloadType": "str",
        "repeat": "",
        "crontab": "",
        "once": false,
        "x": 165.16668701171875,
        "y": 1499.6667003631592,
        "wires": [
            [
                "f7a8cc69.ecbff"
            ]
        ]
    },
    {
        "id": "f7a8cc69.ecbff",
        "type": "json",
        "z": "69238f4c.8e23f",
        "name": "",
        "x": 453.16667556762695,
        "y": 1468.333366394043,
        "wires": [
            [
                "7c920fee.25bf3"
            ]
        ]
    },
    {
        "id": "db55df26.8fec6",
        "type": "mqtt in",
        "z": "69238f4c.8e23f",
        "name": "",
        "topic": "weatherStation/DHT/temperature_json",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 170,
        "y": 1420,
        "wires": [
            [
                "f7a8cc69.ecbff"
            ]
        ]
    },
    {
        "id": "4252a52.ac3975c",
        "type": "http in",
        "z": "69238f4c.8e23f",
        "name": "chuck_norris_api",
        "url": "https://api.chucknorris.io/jokes/random",
        "method": "get",
        "swaggerDoc": "",
        "x": 166.16668319702148,
        "y": 1573.666696548462,
        "wires": [
            [
                "f7a8cc69.ecbff"
            ]
        ]
    },
    {
        "id": "f5eb4255.41c5f",
        "type": "mqtt out",
        "z": "69238f4c.8e23f",
        "name": "",
        "topic": "dht/temperature",
        "qos": "2",
        "retain": "true",
        "broker": "c43f31b9.9864",
        "x": 387.99999618530273,
        "y": 848.3333225250244,
        "wires": []
    },
    {
        "id": "e6f61d9b.d76cf",
        "type": "ttn event",
        "z": "a64e0c32.c396f",
        "name": "",
        "app": "e57c1143.ae121",
        "dev_id": "m50_pro_mini_node1",
        "event": "#",
        "x": 140,
        "y": 60,
        "wires": [
            [
                "e2de1e80.3fa9e"
            ]
        ]
    },
    {
        "id": "4439166a.2db398",
        "type": "ttn uplink",
        "z": "a64e0c32.c396f",
        "name": "vogeldev2736452736",
        "app": "e57c1143.ae121",
        "dev_id": "vogeldev2736452736",
        "field": "",
        "x": 184.8333282470703,
        "y": 143.66666412353516,
        "wires": [
            [
                "e2de1e80.3fa9e"
            ]
        ]
    },
    {
        "id": "e2de1e80.3fa9e",
        "type": "debug",
        "z": "a64e0c32.c396f",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "false",
        "x": 400.8333282470703,
        "y": 58.666664123535156,
        "wires": []
    },
    {
        "id": "fb6542bb.08ccf",
        "type": "ttn downlink",
        "z": "a64e0c32.c396f",
        "name": "vogeldev348976394876iuysoiudfy",
        "app": "e57c1143.ae121",
        "dev_id": "m50_pro_mini_node1",
        "port": "",
        "confirmed": false,
        "schedule": "replace",
        "x": 448.8333282470703,
        "y": 320.66666412353516,
        "wires": []
    },
    {
        "id": "da519387.fb352",
        "type": "inject",
        "z": "a64e0c32.c396f",
        "name": "",
        "topic": "",
        "payload": "",
        "payloadType": "date",
        "repeat": "",
        "crontab": "",
        "once": false,
        "x": 117.83332824707031,
        "y": 288.66666412353516,
        "wires": [
            [
                "fb6542bb.08ccf"
            ]
        ]
    },
    {
        "id": "9d0096c9.3e80b8",
        "type": "mqtt in",
        "z": "855b7076.01ac4",
        "name": "",
        "topic": "octoPrint/",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 120,
        "y": 60,
        "wires": [
            [
                "6b843a66.0bdf14"
            ]
        ]
    },
    {
        "id": "6b843a66.0bdf14",
        "type": "debug",
        "z": "855b7076.01ac4",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "false",
        "x": 730,
        "y": 40,
        "wires": []
    },
    {
        "id": "8d5f9cf8.29366",
        "type": "mqtt in",
        "z": "855b7076.01ac4",
        "name": "",
        "topic": "octoPrint/event/",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 134,
        "y": 181,
        "wires": [
            [
                "6b843a66.0bdf14"
            ]
        ]
    },
    {
        "id": "e1eef909.58c3c8",
        "type": "mqtt in",
        "z": "43f95fa6.1e9ed",
        "name": "",
        "topic": "json_test/hello",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 130,
        "y": 120,
        "wires": [
            [
                "b8145a34.4f46f8"
            ]
        ]
    },
    {
        "id": "b8145a34.4f46f8",
        "type": "json",
        "z": "43f95fa6.1e9ed",
        "name": "",
        "x": 336.0000228881836,
        "y": 83.66665840148926,
        "wires": [
            [
                "a7544bfd.b633d8"
            ]
        ]
    },
    {
        "id": "a7544bfd.b633d8",
        "type": "debug",
        "z": "43f95fa6.1e9ed",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "false",
        "x": 512.0000152587891,
        "y": 139.3333282470703,
        "wires": []
    },
    {
        "id": "4cb76ea8.a22a5",
        "type": "find-my-iphone",
        "z": "43f95fa6.1e9ed",
        "devicename": "iPhoneSE",
        "x": 338.0000228881836,
        "y": 252.3333511352539,
        "wires": [
            [
                "a7544bfd.b633d8"
            ]
        ]
    },
    {
        "id": "217d6796.1af0e8",
        "type": "inject",
        "z": "43f95fa6.1e9ed",
        "name": "",
        "topic": "",
        "payload": "",
        "payloadType": "date",
        "repeat": "",
        "crontab": "",
        "once": false,
        "x": 130.99999618530273,
        "y": 247.99999618530273,
        "wires": [
            [
                "4cb76ea8.a22a5"
            ]
        ]
    },
    {
        "id": "352eed92.0a2882",
        "type": "mqtt in",
        "z": "a64e0c32.c396f",
        "name": "",
        "topic": "ttn/hallo",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 90,
        "y": 360,
        "wires": [
            [
                "fb6542bb.08ccf",
                "e2de1e80.3fa9e"
            ]
        ]
    },
    {
        "id": "8b250227.d5409",
        "type": "mqtt out",
        "z": "5ba46c1d.b961a4",
        "name": "",
        "topic": "lichtkrant/tape",
        "qos": "2",
        "retain": "true",
        "broker": "c43f31b9.9864",
        "x": 952,
        "y": 217.33330917358398,
        "wires": []
    },
    {
        "id": "b07b1590.a1ed58",
        "type": "mqtt in",
        "z": "5ba46c1d.b961a4",
        "name": "",
        "topic": "lichtkrant/mqqt_connect",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 126,
        "y": 289.9999809265137,
        "wires": [
            [
                "859ea37d.fbb3f",
                "73634d93.e89724"
            ]
        ]
    },
    {
        "id": "859ea37d.fbb3f",
        "type": "debug",
        "z": "5ba46c1d.b961a4",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "false",
        "x": 375.00000762939453,
        "y": 320.3333339691162,
        "wires": []
    },
    {
        "id": "6b4a6abd.f44294",
        "type": "inject",
        "z": "5ba46c1d.b961a4",
        "name": "Wemos led uit",
        "topic": "",
        "payload": "0",
        "payloadType": "num",
        "repeat": "",
        "crontab": "",
        "once": false,
        "x": 114,
        "y": 460.9999828338623,
        "wires": [
            [
                "f201b039.b81b6"
            ]
        ]
    },
    {
        "id": "f201b039.b81b6",
        "type": "mqtt out",
        "z": "5ba46c1d.b961a4",
        "name": "",
        "topic": "ledStatus",
        "qos": "2",
        "retain": "true",
        "broker": "c43f31b9.9864",
        "x": 400.00000762939453,
        "y": 443.33331775665283,
        "wires": []
    },
    {
        "id": "26b22f80.ccc09",
        "type": "inject",
        "z": "5ba46c1d.b961a4",
        "name": "Wemos led aan",
        "topic": "",
        "payload": "1",
        "payloadType": "num",
        "repeat": "",
        "crontab": "",
        "once": false,
        "x": 118.83331298828125,
        "y": 517.666651725769,
        "wires": [
            [
                "f201b039.b81b6"
            ]
        ]
    },
    {
        "id": "9c7cc292.01f24",
        "type": "function",
        "z": "5ba46c1d.b961a4",
        "name": "lichtkrant tekst",
        "func": "// msg.payload = \"aponsen.. Verlangen, vervloeken Verdoemen, verzoeking Verdoemenis beloven Verbranden en vernietigen Verspreiden ze geboden    liefde    aponsen@hotmail.com        knuffelbeest                    liefde                 xx          mens         \";\n// msg.payload = \"    MQQT tekst         niet ONS huis maar MIJN huis        is dat liefde?     Leef aponsen@hotmail.com         \";\nmsg.payload = \"    MQQT tekst           \";\n\n\nreturn msg;",
        "outputs": 1,
        "noerr": 0,
        "x": 435,
        "y": 177.6666431427002,
        "wires": [
            [
                "8b250227.d5409"
            ]
        ]
    },
    {
        "id": "73634d93.e89724",
        "type": "http request",
        "z": "5ba46c1d.b961a4",
        "name": "GET chuck norris",
        "method": "GET",
        "ret": "txt",
        "url": "https://api.chucknorris.io/jokes/random",
        "tls": "",
        "x": 410.99999237060547,
        "y": 92.66664123535156,
        "wires": [
            [
                "3e52107.b8623f",
                "9c7cc292.01f24"
            ]
        ]
    },
    {
        "id": "1f8b7fe2.09836",
        "type": "inject",
        "z": "5ba46c1d.b961a4",
        "name": "scrolltext hier",
        "topic": "",
        "payload": "doen Chuck Norris lichtkrant",
        "payloadType": "str",
        "repeat": "2040",
        "crontab": "",
        "once": true,
        "x": 127.83331298828125,
        "y": 64.66664218902588,
        "wires": [
            [
                "73634d93.e89724"
            ]
        ]
    },
    {
        "id": "86aa11d4.fd819",
        "type": "debug",
        "z": "5ba46c1d.b961a4",
        "name": "",
        "active": true,
        "console": "false",
        "complete": "false",
        "x": 995.0000038146973,
        "y": 90.33331298828125,
        "wires": []
    },
    {
        "id": "611533f.5ad21cc",
        "type": "function",
        "z": "5ba46c1d.b961a4",
        "name": "",
        "func": "msg.payload = \" XX \" + msg.payload[\"value\"] + \"\";\nreturn msg;",
        "outputs": 1,
        "noerr": 0,
        "x": 769,
        "y": 80.6666488647461,
        "wires": [
            [
                "86aa11d4.fd819",
                "8b250227.d5409"
            ]
        ]
    },
    {
        "id": "3e52107.b8623f",
        "type": "json",
        "z": "5ba46c1d.b961a4",
        "name": "",
        "x": 605,
        "y": 74.66663932800293,
        "wires": [
            [
                "611533f.5ad21cc"
            ]
        ]
    },
    {
        "id": "eb0fa79d.86c0f8",
        "type": "mqtt in",
        "z": "95a267b0.dfbf78",
        "name": "timestamp_utc",
        "topic": "p1monitor/smartmeter/timestamp_utc",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 170,
        "y": 160,
        "wires": [
            [
                "7b117f5c.ba908"
            ]
        ]
    },
    {
        "id": "7b117f5c.ba908",
        "type": "debug",
        "z": "95a267b0.dfbf78",
        "name": "",
        "active": true,
        "tosidebar": true,
        "console": false,
        "tostatus": false,
        "complete": "false",
        "x": 610,
        "y": 220,
        "wires": []
    },
    {
        "id": "836fb51a.227c38",
        "type": "ui_text",
        "z": "95a267b0.dfbf78",
        "group": "fb508433.7560a8",
        "order": 6,
        "width": 0,
        "height": 0,
        "name": "",
        "label": "kw.U verbruik",
        "format": "{{msg.payload}}",
        "layout": "row-spread",
        "x": 540,
        "y": 300,
        "wires": []
    },
    {
        "id": "3129bae7.9f02a6",
        "type": "mqtt out",
        "z": "69238f4c.8e23f",
        "name": "",
        "topic": "dietpi/lijstweer",
        "qos": "",
        "retain": "true",
        "broker": "5c5d1421.257f6c",
        "x": 500,
        "y": 1180,
        "wires": []
    },
    {
        "id": "41901133.14a2d",
        "type": "mqtt in",
        "z": "69238f4c.8e23f",
        "name": "",
        "topic": "dietpi/getweer",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 148,
        "y": 1163.3331146240234,
        "wires": [
            [
                "6bb7f00d.b6b06"
            ]
        ]
    },
    {
        "id": "8ac88b07.cc4ad8",
        "type": "mqtt in",
        "z": "95a267b0.dfbf78",
        "name": "consumption_gas_m3",
        "topic": "p1monitor/smartmeter/consumption_gas_m3",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 200,
        "y": 380,
        "wires": [
            []
        ]
    },
    {
        "id": "f1a9aa5c.541238",
        "type": "mqtt in",
        "z": "95a267b0.dfbf78",
        "name": "consumption_kw",
        "topic": "p1monitor/smartmeter/consumption_kw",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 180,
        "y": 280,
        "wires": [
            [
                "7b117f5c.ba908",
                "6eb63f94.937a2",
                "836fb51a.227c38"
            ]
        ]
    },
    {
        "id": "6eb63f94.937a2",
        "type": "ui_gauge",
        "z": "95a267b0.dfbf78",
        "name": "",
        "group": "fb508433.7560a8",
        "order": 7,
        "width": 0,
        "height": 0,
        "gtype": "gage",
        "title": "gauge",
        "label": "units",
        "format": "{{value}}",
        "min": 0,
        "max": "4000",
        "colors": [
            "#00b500",
            "#e6e600",
            "#ca3838"
        ],
        "seg1": "",
        "seg2": "",
        "x": 520,
        "y": 400,
        "wires": []
    },
    {
        "id": "fcbbfad.1e64e08",
        "type": "mqtt in",
        "z": "a7951a73.242a18",
        "name": "",
        "topic": "wled/light/status",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
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
        "x": 170,
        "y": 340,
        "wires": [
            [
                "2af5f603.85ff3a"
            ]
        ]
    },
    {
        "id": "fac93b98.785d8",
        "type": "mqtt in",
        "z": "eab7e4b1.f833c",
        "name": "",
        "topic": "homebridge/seton",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 260,
        "y": 100,
        "wires": [
            [
                "f7353cc8.73fb18"
            ]
        ]
    },
    {
        "id": "f7353cc8.73fb18",
        "type": "debug",
        "z": "eab7e4b1.f833c",
        "name": "",
        "active": true,
        "tosidebar": true,
        "console": false,
        "tostatus": false,
        "complete": "false",
        "x": 650,
        "y": 180,
        "wires": []
    },
    {
        "id": "467cba3e.0eb19c",
        "type": "mqtt in",
        "z": "eab7e4b1.f833c",
        "name": "",
        "topic": "homebridge/getonline",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 290,
        "y": 220,
        "wires": [
            [
                "f7353cc8.73fb18"
            ]
        ]
    },
    {
        "id": "61013161.70e69",
        "type": "mqtt in",
        "z": "eab7e4b1.f833c",
        "name": "",
        "topic": "homebridge/startup",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 280,
        "y": 320,
        "wires": [
            [
                "f7353cc8.73fb18"
            ]
        ]
    },
    {
        "id": "49e0a796.e405a8",
        "type": "mqtt in",
        "z": "855b7076.01ac4",
        "name": "",
        "topic": "homeassistant/switch/octoprint_PSUControl_switch/set",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 240,
        "y": 260,
        "wires": [
            [
                "6b843a66.0bdf14"
            ]
        ]
    },
    {
        "id": "784d4782.239258",
        "type": "mqtt in",
        "z": "855b7076.01ac4",
        "name": "",
        "topic": "homeassistant/switch/octoprint_PSUControl_switch/state",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 250,
        "y": 340,
        "wires": [
            [
                "6b843a66.0bdf14"
            ]
        ]
    },
    {
        "id": "fa08b4da.102618",
        "type": "mqtt in",
        "z": "855b7076.01ac4",
        "name": "",
        "topic": "homeassistant/switch/octoprint_PSUControl_switch/availability",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 260,
        "y": 420,
        "wires": [
            [
                "6b843a66.0bdf14"
            ]
        ]
    },
    {
        "id": "ba7520f3.d26278",
        "type": "mqtt in",
        "z": "95a267b0.dfbf78",
        "name": "p1monitor/smartmeter/timestamp_local",
        "topic": "p1monitor/smartmeter/timestamp_local",
        "qos": "2",
        "datatype": "auto",
        "broker": "c43f31b9.9864",
        "x": 230,
        "y": 60,
        "wires": [
            [
                "7b117f5c.ba908"
            ]
        ]
    }
]

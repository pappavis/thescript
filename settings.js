module.exports = {

    /** The file containing the flows. If not set, defaults to flows_<hostname>.json **/
    flowFile: "flows.json",
    credentialSecret: false,
    flowFilePretty: true,
    //userDir: '/home/pi/.node-red/',
    //nodesDir: '/home/nol/.node-red/nodes',

    /** the tcp port that the Node-RED web server is listening on */
    uiPort: process.env.PORT || 1880,
     /** Configure the logging output */
     logging: {
         /** Only console logging is currently supported */
         console: {
             level: "info",
             /** Whether or not to include metric events in the log output */
             metrics: false,
             /** Whether or not to include audit events in the log output */
             audit: false
         }
     },

     exportGlobalContextKeys: false,

     externalModules: {
          autoInstall: false,   /** Whether the runtime will attempt to automatically install missing modules */
     },

    editorTheme: {
        palette: {
        },
        projects: {
            enabled: false,
            workflow: {
                mode: "manual"
            }
        },
        codeEditor: {
            lib: "monaco",
            options: {
                theme: "vs",
            }
        }
    },

    functionExternalModules: true,
    functionGlobalContext: {
        // os:require('os'),
    },

    debugMaxLength: 1000,
    mqttReconnectTime: 15000,
    serialReconnectTime: 15000,
}

PhoneGap-SpeechRecognitionPlugin
================================

Mobile Speech Recognition Plugin For PhoneGap.

This Phonegap Plugin has been developed by AnGe724.  
Feel free to use the code in any projects according the the license at the bottom of this readme.

I am happy to offer my consulting services if needed and can be contacted at: edmondan724@gmail.com

## DESCRIPTION ##

* This plugin provides a simple way to use iOS and Android Speech Recognition using the iSpeech library in PhoneGap applications.

## Installation
The plugin can either be installed into the local development environment or cloud based through [PhoneGap Build][PGB].

### Adding the Plugin to your project
Through the [Command-line Interface][CLI]:
```bash
# ~~ from master ~~
cordova plugin add https://github.com/AnGe724/SpeechRecognitionPlugin.git && cordova prepare
```

### Removing the Plugin from your project
Through the [Command-line Interface][CLI]:
```bash
cordova plugin rm org.apache.cordova.speech.speechrecognition
```

## INCLUDED FUNTIONS ##

SpeechRecognition.js contains the following functions:

1. init - Init the plugin using the api key.
2. start - Start speech recognition.
3. stop - Stop speech recognition.

## PLUGIN CODE EXAMPLE ##



### index.js ###
```html

var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicitly call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        app.receivedEvent('deviceready');
    },
    // Update DOM on a Received Event
    receivedEvent: function(id) {
        
        var key = "9fa105fea74f0cfc6838e5ea351526b5";
        SpeechRecognition.init(key);
    }
};

app.initialize();

```


### index.html ###
```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="format-detection" content="telephone=no" />
        <meta name="msapplication-tap-highlight" content="no" />
        <!-- WARNING: for iOS 7, remove the width=device-width and height=device-height attributes. See https://issues.apache.org/jira/browse/CB-4323 -->
        <meta name="viewport" content="user-scalable=no, initial-scale=1, maximum-scale=1, minimum-scale=1, width=device-width, height=device-height, target-densitydpi=device-dpi" />
        <link rel="stylesheet" type="text/css" href="css/index.css" />
        <title>Hello World</title>
    </head>
    <body>
        <div class="app">
            <input type="text" id="message">
                
            <br/><br/>
            <input type="button" onClick="start();" value="Start">
            <br/><br/><br/>
            <input type="button" onClick="stop();" value="Stop">
        </div>
        <script type="text/javascript" src="cordova.js"></script>
        <script type="text/javascript" src="js/index.js"></script>
        <script type="text/javascript">
            function start()
            {
                SpeechRecognition.start(recognizePluginResultHandler, nativePluginErrorHandler);
            }
        
            function stop()
            {
                SpeechRecognition.stop();
            }
            
            function recognizePluginResultHandler(result)
            {
                alert("Result: " + result);
                var msg = document.getElementById("message");
                msg.value = result;
            }
            
            function nativePluginErrorHandler(result)
            {
                alert("error: "+result);
            }
        </script>
    </body>
</html>

```

## LICENSE ##

Copyright (c) 2015 AnGe724

EMAIL: edmondan724@gmail.com   

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

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
cordova plugin rm com.anh724.cordova.plugin.speechrecognition
```

## INCLUDED FUNTIONS ##

SS515CardReaderPlugin.js contains the following functions:

1. init - Initialize the variables for using the plugin.
2. initCard - Initialize the SS515 card reader device.
3. loadInitialKey - Load IPEK into the reader.
4. readCard - Get encrypted card data and decrypted card data.
5. getVersion - Get the Version.
6. getPAN - Get credit card's or bank card's first-4 digits, last-4 digits, card holder's name and expiration date.

## PLUGIN CODE EXAMPLE ##

### index.html ###
```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="format-detection" content="telephone=no" />
        <!-- WARNING: for iOS 7, remove the width=device-width and height=device-height attributes. See https://issues.apache.org/jira/browse/CB-4323 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, target-densitydpi=medium-dpi, user-scalable=0" />
        <link rel="stylesheet" type="text/css" href="css/index.css" />
        <meta name="msapplication-tap-highlight" content="no" />
        <title>Hello World</title>
    </head>
    <body>
        <div class="app">
            <h3>SS515 SReader Menu</h3></br>
            
            <input type="button" id="btnReadCard" name="btnReadCard" value="1. Read Magnetic Card" onclick="OnReadMagneticCard()" />
            <input type="button" id="btnLoadInitialKey" name="btnLoadInitialKey" value="2. Load Initial Key" onclick="OnLoadInitialKey()" />
            <input type="button" id="btnInitialCardReader" name="btnInitialCardReader" value="3. Initial Card Reader" onclick="OnInitialCardReader()" /></br></br>            

            <p id="pResult"></p>
        </div>
        <script type="text/javascript" src="cordova.js"></script>
        <script type="text/javascript" src="js/index.js"></script>
        <script type="text/javascript">
            app.initialize();
            
            btnReadCard = document.getElementById("btnReadCard");
            btnLoadInitialKey = document.getElementById("btnLoadInitialKey");
            btnInitialCardReader = document.getElementById("btnInitialCardReader");            
            pResult = document.getElementById("pResult");
            
            function OnReadMagneticCard()
            {
            	window.location = "readMagneticCard.html";
            }
            
            function OnLoadInitialKey()
            {
            	window.location = "loadInitialKey.html";	
            }
            
            function OnInitialCardReader()
            {
                SS515CardReaderPlugin.initCard(processSS515CardReaderCallback, function(error){alert(error);});
            }
            
            function OnInit()
            {
                SS515CardReaderPlugin.init(processSS515CardReaderCallback, function(error){alert(error);});
            }
            
            function processSS515CardReaderCallback(result)
            {
            	if (result.ButtonStatus == "disable_button") {
            		
            		btnReadCard.disabled = true;
            		btnLoadInitialKey.disabled = true;
            		btnInitialCardReader.disabled = true;
            	}
            	else if (result.ButtonStatus == "detecting_button") {
            		
            		btnReadCard.disabled = false;
            		btnLoadInitialKey.disabled = false;
            		btnInitialCardReader.disabled = false;
            	}
            	else if (result.ButtonStatus == "detect_ok") {
            		
            		btnReadCard.disabled = false;
            		btnLoadInitialKey.disabled = false;
            		btnInitialCardReader.disabled = true;
            	}
            	else if (result.ButtonStatus == "timeout_ack") {
            		
            		btnReadCard.disabled = true;
            		btnLoadInitialKey.disabled = true;
            		btnInitialCardReader.disabled = false;
            	}
            	else if (result.ButtonStatus == "unknown_err") {
            		
            		btnReadCard.disabled = true;
            		btnLoadInitialKey.disabled = true;
            		btnInitialCardReader.disabled = false;
            	}
            	else if (result.ButtonStatus == "Initialization") {
            		
            		btnInitialCardReader.disabled = true;
            	}
            	
        		pResult.innerHTML = result.ResultString;
            }
            
            setTimeout(OnInit, 2000);            
        </script>
    </body>
</html>

```

### loadInitialKey.html ###
```html
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="format-detection" content="telephone=no" />
        <!-- WARNING: for iOS 7, remove the width=device-width and height=device-height attributes. See https://issues.apache.org/jira/browse/CB-4323 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, target-densitydpi=medium-dpi, user-scalable=0" />
        <link rel="stylesheet" type="text/css" href="css/index.css" />
        <meta name="msapplication-tap-highlight" content="no" />
        <title>Hello World</title>
    </head>
    <body>
        <div class="app">
            <h3>SS515 Initial KEY</h3></br>
            
            <label>Base Derivation Key(BDK): 16byte</label>
            <input type="text" id="txtBDK" name="txtBDK" value="0123456789ABCDEFFEDCBA9876543210" /></br>
            
            <label>Key Serial Number(KSN): 10byte</label>
            <input type="text" id="txtKSN" name="txtKSN" value="FFFF9876543210E00000" /></br>
            
            <input type="button" id="btnLoadInitialKey" name="btnLoadInitialKey" value="Load Initial Key" onclick="OnLoadInitialKey()" /></br></br>

            <p id="pIPEK"></p>            
        </div>
        <script type="text/javascript" src="cordova.js"></script>
        <script type="text/javascript" src="js/index.js"></script>
        <script type="text/javascript">
            app.initialize();
            
            txtBDK = document.getElementById("txtBDK");
            txtKSN = document.getElementById("txtKSN");
            btnLoadInitialKey = document.getElementById("btnLoadInitialKey");            
            pIPEK = document.getElementById("pIPEK");
            
            function OnLoadInitialKey()
            {
            	strBDK = txtBDK.value;
            	strKSN = txtKSN.value;
                SS515CardReaderPlugin.loadInitialKey(processSS515LoadInitialKeyCallback, function(error){alert(error);}, [strBDK, strKSN]);                
            }
            
            function enableButton()
            {
            	txtBDK.disabled = false;
            	txtKSN.disabled = false;
            	btnLoadInitialKey.disabled = false;
            }
            
            function disableButton()
            {
            	txtBDK.disabled = true;
            	txtKSN.disabled = true;
            	btnLoadInitialKey.disabled = true;
            }
            
            function processSS515LoadInitialKeyCallback(result)
            {
            	if (result.ButtonStatus == "timeout_ack_loadinitialkey") {

            		enableButton();
            	}
            	else if (result.ButtonStatus == "unknown_err_loadinitialkey") {
            		
            		enableButton();
            	}
            	else if (result.ButtonStatus == "begin_loadkey") {
            		
            		disableButton();
            	}
            	else if (result.ButtonStatus == "display_ipek") {
            		
            		enableButton();
            	}
            	
            	pIPEK.innerHTML = result.ResultString;
            }
        </script>
    </body>
</html>

```

### readMagneticCard.html ###
```html
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="format-detection" content="telephone=no" />
        <!-- WARNING: for iOS 7, remove the width=device-width and height=device-height attributes. See https://issues.apache.org/jira/browse/CB-4323 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, target-densitydpi=medium-dpi, user-scalable=0" />
        <link rel="stylesheet" type="text/css" href="css/index.css" />
        <meta name="msapplication-tap-highlight" content="no" />
        <title>Hello World</title>
    </head>
    <body>
        <div class="app">
            <h3>SS515 Read Card</h3></br>
            
            <input type="button" id="btnReadCard" name="btnReadCard" value="Read Card" onclick="OnReadCard()" />
            <input type="button" id="btnGetVersion" name="btnGetVersion" value="Get Version" onclick="OnGetVersion()" />
            <input type="button" id="btnGetPAN" name="btnGetPAN" value="Get PAN" onclick="OnGetPAN()" /></br></br>
            
            <p id="pResult"></p>
        </div>
        <script type="text/javascript" src="cordova.js"></script>
        <script type="text/javascript" src="js/index.js"></script>
        <script type="text/javascript">
            app.initialize();
            
            btnReadCard = document.getElementById("btnReadCard");
            btnGetVersion = document.getElementById("btnGetVersion");
            btnGetPAN = document.getElementById("btnGetPAN");            
            pResult = document.getElementById("pResult");
            
            function OnReadCard()
            {
                SS515CardReaderPlugin.readCard(processSS515ReadCardCallback, function(error){alert(error);});                
            }
            
            function OnGetVersion()
            {
                SS515CardReaderPlugin.getVersion(processSS515ReadCardCallback, function(error){alert(error);});                
            }
            
            function OnGetPAN()
            {
                SS515CardReaderPlugin.getPAN(processSS515ReadCardCallback, function(error){alert(error);});                
            }
            
            function enableButton()
            {
            	btnReadCard.disabled = false;
            	btnGetVersion.disabled = false;
            	btnGetPAN.disabled = false;
            }
            
            function disableButton()
            {
            	btnReadCard.disabled = true;
            	btnGetVersion.disabled = true;
            	btnGetPAN.disabled = true;
            }
            
            function processSS515ReadCardCallback(result)
            {
            	if (result.ButtonStatus == "setversion") {

            		enableButton();
            	}
            	else if (result.ButtonStatus == "swipecard") {
            		
            		disableButton();
            	}
            	else if (result.ButtonStatus == "display_encryptiondata") {
            		
            		enableButton();
            	}
            	else if (result.ButtonStatus == "display_decryptiondata") {
            		
            		enableButton();
            	}
            	else if (result.ButtonStatus == "display_t1t2pandata") {
            		
            		enableButton();
            	}
            	else if (result.ButtonStatus == "timeout_ack_readcard") {
            		
            		enableButton();
            	}
            	else if (result.ButtonStatus == "unknown_err_readcard") {
            		
            		enableButton();
            	}
            	else if (result.ButtonStatus == "begin_version") {
            		
            		disableButton();
            	}
            	else if (result.ButtonStatus == "begin_swipe") {
            		
            		disableButton();
            	}
            	else if (result.ButtonStatus == "begin_getpan") {
            		
            		disableButton();
            	}
            	
            	pResult.innerHTML = result.ResultString;
            }
        </script>
    </body>
</html>

```


## LICENSE ##

Copyright (c) 2014 Dov Goldberg

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

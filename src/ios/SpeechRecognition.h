
#import <Cordova/CDV.h>
#import "iSpeechSDK.h"

@interface SpeechRecognition : CDVPlugin <ISSpeechSynthesisDelegate,ISSpeechRecognitionDelegate>
{
    ISSpeechRecognition *isSpeechRecog;
    
    CDVInvokedUrlCommand *recogCommand;
    CDVPluginResult *pluginResult;
}

-(void)init:(CDVInvokedUrlCommand*)command;
-(void)start:(CDVInvokedUrlCommand*)command;
-(void)stop:(CDVInvokedUrlCommand*)command;

@end

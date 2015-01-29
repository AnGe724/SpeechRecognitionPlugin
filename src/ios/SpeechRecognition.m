//
//  TTSAndSpeechRecognitionPlugin.m
//  TTSPlugin
//
//  Created by Admin on 28/01/15.
//
//

#import "SpeechRecognition.h"
#import "ISSpeechSynthesis.h"
#import "ISSpeechRecognition.h"


@implementation SpeechRecognition


-(void)init:(CDVInvokedUrlCommand *)command
{
    NSString* key = [command.arguments objectAtIndex:0];
    iSpeechSDK *sdk = [iSpeechSDK sharedSDK];
    sdk.APIKey = key;

    isSpeechRecog = [[ISSpeechRecognition alloc] init];
    [isSpeechRecog setDelegate:self];
    [isSpeechRecog setSilenceDetectionEnabled:NO];
    [isSpeechRecog setLocale:ISLocaleUSEnglish];
    [isSpeechRecog setFreeformType:ISFreeFormTypeDictation];
}

-(void)start:(CDVInvokedUrlCommand*)command
{
    recogCommand = command;
    
    [isSpeechRecog listen:nil];
}

-(void)stop:(CDVInvokedUrlCommand*)command {
    [isSpeechRecog finishListenAndStartRecognize];
}

#pragma ISSpeechRecognitionDelegate
-(void)recognition:(ISSpeechRecognition *)speechRecognition didGetRecognitionResult:(ISSpeechRecognitionResult *)result
{
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result.text];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:recogCommand.callbackId];
}

@end

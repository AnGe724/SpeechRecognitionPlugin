//
//  TTSAndSpeechRecognitionPlugin.m
//  TTSPlugin
//
//  Created by Admin on 30/04/13.
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
}

-(void)start:(CDVInvokedUrlCommand*)command
{
    recogCommand = command;
    
    isSpeechRecog = [[ISSpeechRecognition alloc] init];
    [isSpeechRecog setDelegate:self];
    [isSpeechRecog setSilenceDetectionEnabled:NO];
    [isSpeechRecog setLocale:ISLocaleUSEnglish];
    [isSpeechRecog setFreeformType:ISFreeFormTypeDictation];
    [isSpeechRecog listen:nil];
}

-(void)stop:(CDVInvokedUrlCommand*)command {
    [isSpeechRecog finishListenAndStartRecognize];
}

#pragma ISSpeechRecognitionDelegate
-(void)recognition:(ISSpeechRecognition *)speechRecognition didGetRecognitionResult:(ISSpeechRecognitionResult *)result
{
    if (result.confidence < 0.3) {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no confidence"] callbackId:recogCommand.callbackId];
    } else {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:result.text] callbackId:recogCommand.callbackId];
    }
}

@end

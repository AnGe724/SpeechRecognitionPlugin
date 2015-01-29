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
    NSMutableDictionary * resultDict = [[NSMutableDictionary alloc]init];
    [resultDict setValue:result.text forKey:@"transcript"];
    [resultDict setValue:[NSNumber numberWithBool:YES] forKey:@"final"];
    [resultDict setValue:[NSNumber numberWithFloat:result.confidence]forKey:@"confidence"];
    NSArray * alternatives = @[resultDict];
    NSArray * results = @[alternatives];
    
    NSMutableDictionary * event = [[NSMutableDictionary alloc]init];
    [event setValue:@"result" forKey:@"type"];
    [event setValue:nil forKey:@"emma"];
    [event setValue:nil forKey:@"interpretation"];
    [event setValue:results forKey:@"results"];
    
    self.pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:event];
    [self.pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:self.pluginResult callbackId:self.command.callbackId];
}

@end

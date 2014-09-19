//
//  ASBluetoothDataHandler.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-4-3.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import "ASBluetoothDataHandler.h"
#import "ASBluetoothViewController.h"

@interface ASBluetoothDataHandler()

+(NSTimeInterval) timeInterval;
+(void) sendBluetoothData:(ASBluetoothData *)bluetoothData;

@end

@implementation ASBluetoothDataHandler

#pragma mark - class methods
+ (ASBluetoothData *)unarchiverData:(NSData *)aData
{
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] 
                                     initForReadingWithData:aData];
    ASBluetoothData *bluetoothData = [unarchiver decodeObjectForKey:@"bluetoothData"];
    [unarchiver finishDecoding];
    [unarchiver release];
    
    return bluetoothData;
}

+(void) sendAcceptFilePacket:(BOOL)accept
{
    ASBluetoothData *bluetoothData = [[ASBluetoothData alloc] 
                                      initWithType:ASbluetoothFileAcceptOrNot
                                      andTimeInterval:[self timeInterval]
                                      andData:[NSNumber numberWithInt:accept]];
    [self sendBluetoothData:bluetoothData];
    [bluetoothData release];

}

+ (void) sendNumberOfFiles:(NSInteger)aNumber
{
    ASBluetoothData *bluetoothData = [[ASBluetoothData alloc] 
                                      initWithType:ASBluetoothNumberOfFiles
                                      andTimeInterval:[self timeInterval]
                                      andData:[NSNumber numberWithInt:aNumber]];
    [self sendBluetoothData:bluetoothData];
    [bluetoothData release];

}

+ (NSTimeInterval) sendFileData:(NSData *)aData andProgress:(float)aProgress
{
    NSTimeInterval time = [self timeInterval];
    NSDictionary *dataAndProgress = [[NSDictionary alloc] 
                                     initWithObjectsAndKeys:
                                     aData, @"fileData", 
                                     [NSNumber numberWithFloat:aProgress], @"progress",
                                     nil];
    
    ASBluetoothData *bluetoothData = [[ASBluetoothData alloc] 
                                      initWithType:ASBluetoothFileData
                                      andTimeInterval:time
                                      andData:dataAndProgress];
    [self sendBluetoothData:bluetoothData];
    [bluetoothData release];
    [dataAndProgress release];
    
    return time;
}

+(void) sendACKTime:(NSTimeInterval)sendTime
{
    ASBluetoothData *bluetoothData = [[ASBluetoothData alloc] 
                                      initWithType:ASBluetoothACK
                                      andTimeInterval:sendTime
                                      andData:nil];
    [self sendBluetoothData:bluetoothData];
    [bluetoothData release];
}

#pragma mark - self use
+(NSTimeInterval) timeInterval
{
    NSDate *date = [[NSDate alloc] init];
    NSTimeInterval timeinterval = [date timeIntervalSince1970];
    [date release];
    
    return timeinterval;
}

+(void) sendBluetoothData:(ASBluetoothData *)bluetoothData
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:bluetoothData forKey:@"bluetoothData"];
    [archiver finishEncoding];
    [archiver release];
    [[ASBluetoothViewController sharedManager] sendData:data];
    [data release];
}
@end

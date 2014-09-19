//
//  ASBluetoothsendingStatus.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-3-31.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import "ASBluetoothSendingStatus.h"
#import "ASBluetoothViewController.h"
#import "ASBluetoothDataHandler.h"
#import "ASBluetoothData.h"

#define packSize 1024

@interface ASBluetoothSendingStatus()
-(NSTimeInterval)timeInterval;
@end

@implementation ASBluetoothSendingStatus

@synthesize fileHandle;
@synthesize filePath;
@synthesize fileSize;
@synthesize sizeHasSended;

- (void) configView
{
    [super configView];
    
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController moveView:bluetoothViewController.mainView
                                   to:CGRectMake(40, 150, 240, 180)
                               during:0.3];
    
    bluetoothViewController.label.frame = CGRectMake(60, 50, 120, 21);
    bluetoothViewController.label.text = @"Sending...";
    bluetoothViewController.label.hidden = NO;
    [bluetoothViewController.label setNeedsDisplay];
    
    bluetoothViewController.progressView.frame = CGRectMake(20, 105, 200, 9);
    bluetoothViewController.progressView.hidden = NO;
}

- (void) sendData
{
    float progress;
    NSData *data;
    if (sizeHasSended + packSize < fileSize) {
        sizeHasSended += packSize;
        progress = ((double)sizeHasSended)/((double)fileSize);
        
        data = [fileHandle readDataOfLength:packSize];
    }
    else
    {
        sizeHasSended = fileSize;
        progress = 1.0;
        data = [fileHandle readDataToEndOfFile];
        [fileHandle closeFile];
        [fileHandle release];
        fileHandle = nil;
    }
    currentDataTimeInterval = [ASBluetoothDataHandler sendFileData:data andProgress:progress];
}

-(NSTimeInterval)timeInterval
{
    NSDate *date = [[NSDate alloc] init];
    currentDataTimeInterval = [date timeIntervalSince1970];
    [date release];
    
    return currentDataTimeInterval;
}

- (void) handleTheData:(NSData *)data
{
    ASBluetoothData *bluetoothData = [[ASBluetoothDataHandler unarchiverData:data] retain];
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    
    if (ASBluetoothACK == bluetoothData.dataType
        && currentDataTimeInterval == bluetoothData.timeIntervalSence1970
        ) {
        if (fileSize == sizeHasSended) {
            //断开链接
            [bluetoothViewController.statusManager changeToDisconnectedStatus];
        }
        else{
            float progress = ((double)sizeHasSended)/((double)fileSize);
            bluetoothViewController.progressView.progress = progress;
            [self sendData];
        }
    }
    [bluetoothData release];
}

- (void) disconnectCurrentPeer
{
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    //删除压缩文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
    
    //view
    if (fileSize == sizeHasSended) {
        bluetoothViewController.progressView.progress = 1.0;
        bluetoothViewController.label.text = @"Sent successfully!";
    }
    else{
        bluetoothViewController.label.text = @"sending fails!";
    }
    
    //断开链接
    [bluetoothViewController.theSession disconnectFromAllPeers];
    bluetoothViewController.theSession.available = YES;
}

@end

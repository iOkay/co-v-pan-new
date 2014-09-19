//
//  ASBluetoothReceivingStatus.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-3-31.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import "ASBluetoothReceivingStatus.h"
#import "ASBluetoothViewController.h"
#import "ASBluetoothDataHandler.h"

@implementation ASBluetoothReceivingStatus

@synthesize fileHandle;
@synthesize filePath;

- (void) configView
{
    [super configView];
    
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController moveView:bluetoothViewController.mainView
                                   to:CGRectMake(40, 150, 240, 180)
                               during:0.3];
    
    bluetoothViewController.label.frame = CGRectMake(60, 50, 120, 21);
    bluetoothViewController.label.text = @"Receiving...";
    bluetoothViewController.label.hidden = NO;
    [bluetoothViewController.label setNeedsDisplay];
    
    bluetoothViewController.progressView.frame = CGRectMake(20, 105, 200, 9);
    bluetoothViewController.progressView.hidden = NO; 
    isSuccessful = NO;
}

- (void) handleTheData:(NSData *)data
{
    ASBluetoothData *bluetoothData = [[ASBluetoothDataHandler unarchiverData:data] retain];
    if (ASBluetoothFileData == bluetoothData.dataType) {
        NSDictionary *dataDictionary = (NSDictionary *)bluetoothData.data;
        NSData *fileData = [dataDictionary objectForKey:@"fileData"];
        float progress = [[dataDictionary objectForKey:@"progress"] floatValue];
        
        //写入文件
        
        fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:fileData];
        [fileHandle closeFile];
        
        //发送ack
        [ASBluetoothDataHandler sendACKTime:bluetoothData.timeIntervalSence1970];
        
        //修改界面
        ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
        bluetoothViewController.progressView.progress = progress;
        isSuccessful = NO;
        if (1.0 == progress) {
            bluetoothViewController.label.text = @"Successfully received!";
            isSuccessful = YES;
        }
    }
    [bluetoothData release]; 
}

- (void) disconnectCurrentPeer
{
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];

    if (!isSuccessful) {
        bluetoothViewController.label.text = @"Receive failed!";
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
    //断开链接
    [bluetoothViewController.theSession disconnectFromAllPeers];
    bluetoothViewController.theSession.available = YES;
}

@end

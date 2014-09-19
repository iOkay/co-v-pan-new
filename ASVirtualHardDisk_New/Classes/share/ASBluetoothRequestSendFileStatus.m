//
//  ASBluetoothRequestSendFileStatus.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-4-1.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import "ASBluetoothRequestSendFileStatus.h"
#import "ASBluetoothViewController.h"
#import "ASBluetoothData.h"
#import "ASBluetoothDataHandler.h"

@implementation ASBluetoothRequestSendFileStatus
- (void) configView
{
    [super configView];
    
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController moveView:bluetoothViewController.mainView
                                   to:CGRectMake(40, 155, 240, 140)
                               during:0.3];
    
    bluetoothViewController.label.frame = CGRectMake(20, 60, 200, 25);
    bluetoothViewController.label.text = @"Wait for accept file...";
    bluetoothViewController.label.hidden = NO;
    [bluetoothViewController.label setNeedsDisplay];
}

- (void) handleTheData:(NSData *)data
{
    ASBluetoothData *bluetoothData = [[ASBluetoothDataHandler unarchiverData:data] retain];
    if (ASbluetoothFileAcceptOrNot == bluetoothData.dataType) {
        if ([((NSNumber *)bluetoothData.data) intValue]) {
            ASBluetoothViewController *bluetoothViewController = 
            [ASBluetoothViewController sharedManager];
            
            [bluetoothViewController.statusManager changeToSendingStatus];
        }
    }
    [bluetoothData release];
}

- (void) disconnectCurrentPeer
{
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    
    bluetoothViewController.label.clearsContextBeforeDrawing = YES;
    bluetoothViewController.label.text = @"Try to send files failed!";
    
    [bluetoothViewController.theSession disconnectFromAllPeers];
    bluetoothViewController.theSession.available = YES;
}

@end

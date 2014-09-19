//
//  ASBluetoothReceiveRequestStatus.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-4-1.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import "ASBluetoothReceiveRequestStatus.h"
#import "ASBluetoothViewController.h"
#import "ASBluetoothDataHandler.h"
#import "ASBluetoothData.h"

@interface ASBluetoothReceiveRequestStatus()
@end

@implementation ASBluetoothReceiveRequestStatus
- (void) configView
{
    [super configView];
    
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController moveView:bluetoothViewController.mainView
                                   to:CGRectMake(40, 150, 240, 180)
                               during:0.3];
    
    //label
    bluetoothViewController.label.frame = CGRectMake(20, 60, 200, 21);
    if (1 == numberOfFiles) {
        bluetoothViewController.label.text = @"Receive a file, accept or not?"; 
    }
    else{
        bluetoothViewController.label.text = [[NSString alloc] 
                                              initWithFormat:
                                              @"Receive %i files, accept or not?",numberOfFiles];
    }
    bluetoothViewController.label.hidden = NO;
    [bluetoothViewController.label setNeedsDisplay];
    
    //positiveButton
    bluetoothViewController.positiveButton.frame = CGRectMake(20, 120, 88, 30);
    bluetoothViewController.positiveButton.hidden = NO;
    
    //negativeButton
    bluetoothViewController.negativeButton.frame = CGRectMake(132, 120, 88, 30);
    bluetoothViewController.negativeButton.hidden = NO;
    
//    [bluetoothViewController.view drawRect:CGRectMake(0, 0, 320, 480)];
}

- (void) handleTheData:(NSData *)data
{
    ASBluetoothData *bluetoothData = [[ASBluetoothDataHandler unarchiverData:data] retain];
    if (ASBluetoothNumberOfFiles == bluetoothData.dataType) {
        numberOfFiles = [((NSNumber *)bluetoothData.data) intValue];
        [[ASBluetoothViewController sharedManager] show];
    }
    [bluetoothData release];
}

- (void) positiveButtonPressed
{
    [ASBluetoothDataHandler sendAcceptFilePacket:YES];
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController.statusManager changeToReceivingStatus];
}

- (void) negativeButtonPressed
{
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController dismiss:nil];
}

- (void) disconnectCurrentPeer
{
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController hiddenAllSubdvew];
    bluetoothViewController.label.frame = CGRectMake(70, 60, 100, 21);
    bluetoothViewController.label.clearsContextBeforeDrawing = YES;
    bluetoothViewController.label.text = @"Bluetooth unexpected quit!";
    bluetoothViewController.label.hidden = NO;
    
    [bluetoothViewController moveView:bluetoothViewController.mainView
                                   to:CGRectMake(40, 160, 240, 140)
                               during:0.3];
    
    [bluetoothViewController.theSession disconnectFromAllPeers];
    bluetoothViewController.theSession.available = YES;
}
@end

//
//  ASBluetoothConnectingStatus.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-3-31.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import "ASBluetoothConnectingStatus.h"
#import "ASBluetoothViewController.h"


@implementation ASBluetoothConnectingStatus
- (void) configView
{
    [super configView];
    
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    bluetoothViewController.label.frame = CGRectMake(70, 60, 100, 21);
    bluetoothViewController.label.text = @"Connecting...";
    bluetoothViewController.label.hidden = NO;
    [bluetoothViewController.label setNeedsDisplay];
    
    [bluetoothViewController moveView:bluetoothViewController.mainView
                                   to:CGRectMake(40, 156, 240, 140)
                               during:0.3];
}

- (void) connectionWasAccepted
{
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController.statusManager changeToRequestSendFileStatus];
}

- (void) disconnectCurrentPeer
{
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    
    [bluetoothViewController.theSession 
     cancelConnectToPeer:bluetoothViewController.currentConfPeerID];
    
    bluetoothViewController.label.text = @"Connecting failure!";
    
    [bluetoothViewController.theSession disconnectFromAllPeers];
    bluetoothViewController.theSession.available = YES;
}

@end

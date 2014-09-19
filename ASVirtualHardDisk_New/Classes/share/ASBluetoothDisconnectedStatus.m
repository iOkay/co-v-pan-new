//
//  ASBluetoothDisconnectedStatus.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-3-31.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import "ASBluetoothDisconnectedStatus.h"
#import "ASBluetoothViewController.h"


@implementation ASBluetoothDisconnectedStatus
- (void) configView
{
    [super configView];
    
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController moveView:bluetoothViewController.mainView
                                   to:CGRectMake(40, 130, 240, 220)
                               during:0.3];
    
    bluetoothViewController.label.frame = CGRectMake(99, 12, 42, 21);
    bluetoothViewController.label.text = @"Peers";
    bluetoothViewController.label.hidden = NO;
    [bluetoothViewController.label setNeedsDisplay];

    [bluetoothViewController.peerTableView reloadData];//用么？
    bluetoothViewController.peerTableView.hidden = NO;
}

- (void) connectionWasAccepted
{
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController.statusManager changeToReceiveRequestStatus];
}

- (void) didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
    ASBluetoothViewController *bluetoothViewController = 
    [ASBluetoothViewController sharedManager];
    
    NSError *error = nil;
    if (![bluetoothViewController.theSession
          acceptConnectionFromPeer:peerID
          error:&error])
    {
        NSLog(@"%@",[error localizedDescription]);
    }
}

- (void) disconnectCurrentPeer
{
}

@end

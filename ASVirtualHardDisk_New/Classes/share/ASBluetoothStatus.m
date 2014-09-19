//
//  ASBluetoothShowAvailablePeersStatus.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-4-1.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import "ASBluetoothStatus.h"
#import "ASBluetoothViewController.h"

@implementation ASBluetoothStatus
- (void) configView
{
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    
    [bluetoothViewController hiddenAllSubdvew];
    
}

//- (void) applicationWillTerminate
//{
//    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
//    [bluetoothViewController hiddenAllSubdvew];
//    
//    bluetoothViewController.mainView.frame = CGRectMake(40, 160, 240, 140);
//    bluetoothViewController.label.frame = CGRectMake(20, 60, 200, 21);
//    bluetoothViewController.label.text = @"Bluetooth unexpected quit!";
//    bluetoothViewController.label.hidden = NO;
//}

- (void) handleTheData:(NSData *)data
{
    
}

- (void) sendData
{
    
}

- (void) didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
    ASBluetoothViewController *bluetoothViewController = 
    [ASBluetoothViewController sharedManager];
    
    [bluetoothViewController.theSession denyConnectionFromPeer:peerID];
}
//
//- (void) connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
//{
//    
//}

//- (void) didFailWithError:(NSError*)error
//{
//    
//}

- (void) disconnectCurrentPeer
{
    
}

- (void) connectionWasAccepted
{
    
}

- (void) positiveButtonPressed
{
    
}

- (void) negativeButtonPressed
{
    
}

@end

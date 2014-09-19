//
//  ASBluetoothUnavailableStatus.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-3-31.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import "ASBluetoothUnavailableStatus.h"
#import "ASBluetoothViewController.h"


@implementation ASBluetoothUnavailableStatus
- (void) configView
{
    [super configView];
    
    ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
    [bluetoothViewController moveView:bluetoothViewController.mainView
                                   to:CGRectMake(40, 155, 240, 140)
                               during:0.3];

    bluetoothViewController.label.frame = CGRectMake(20, 60, 200, 21);
    bluetoothViewController.label.text = @"Bluetooth unavilable!";
    bluetoothViewController.label.hidden = NO;
    [bluetoothViewController.label setNeedsDisplay];
}
@end

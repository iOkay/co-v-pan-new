//
//  ASBluetoothStatusManager.h
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-4-1.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASBluetoothStatus.h"

@class ASBluetoothConnectingStatus;
@class ASBluetoothDisconnectedStatus;
@class ASBluetoothReceiveRequestStatus;
@class ASBluetoothReceivingStatus;
@class ASBluetoothRequestSendFileStatus;
@class ASBluetoothSendingStatus;
//@class ASBluetoothShowAvailablePeersStatus;
@class ASBluetoothUnavailableStatus;

@interface ASBluetoothStatusManager : NSObject {
    ASBluetoothStatus * status;
    
    ASBluetoothConnectingStatus *connectingStatus;
    ASBluetoothDisconnectedStatus *disconnectedStatus;
    ASBluetoothReceiveRequestStatus *receiveRequestStatus;
    ASBluetoothReceivingStatus *receivingStatus;
    ASBluetoothRequestSendFileStatus *requestSendFileStatus;
    ASBluetoothSendingStatus *sendingStatus;
    //ASBluetoothShowAvailablePeersStatus *showAvailablePeersStatus;
    ASBluetoothUnavailableStatus *unavailableStatus;
}

@property (nonatomic, assign) ASBluetoothStatus * status;

- (id)init;
- (void)dealloc;
- (void)changeToConnectingStatus;
- (void)changeToDisconnectedStatus;
- (void)changeToReceiveRequestStatus;
- (void)changeToReceivingStatus;
- (void)changeToRequestSendFileStatus;
- (void)changeToSendingStatus;
//- (void)changeToShowAvailablePeersStatus;
- (void)changeToUnavailableStatus;
@end

//
//  ASBluetoothStatus.h
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-3-31.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  ASBluetoothStatus: NSObject{
    
}

- (void) configView;
//- (void) applicationWillTerminate;//disconnectCurrentPeer;
- (void) handleTheData:(NSData *)data;
- (void) sendData;//只有send用
- (void) didReceiveConnectionRequestFromPeer:(NSString *)peerID;
//- (void) connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error;
//- (void) didFailWithError:(NSError*)error;//disconnectCurrentPeer;
- (void) disconnectCurrentPeer;
- (void) connectionWasAccepted;
- (void) positiveButtonPressed;
- (void) negativeButtonPressed;

@end

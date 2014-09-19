//
//  ASBluetoothDataHandler.h
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-4-3.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASBluetoothData.h"

@interface ASBluetoothDataHandler : NSObject {
    
}

+ (ASBluetoothData *)unarchiverData:(NSData *)aData;
+ (void) sendAcceptFilePacket:(BOOL)accept;//发送是否接收文件的包
+ (void) sendNumberOfFiles:(NSInteger)aNumber;
+ (NSTimeInterval) sendFileData:(NSData *)aData andProgress:(float)aProgress;
+ (void) sendACKTime:(NSTimeInterval)sendTime;

@end

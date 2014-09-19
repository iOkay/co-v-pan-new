//
//  ASBluetoothsendingStatus.h
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-3-31.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASBluetoothStatus.h"


@interface ASBluetoothSendingStatus : ASBluetoothStatus {
    NSFileHandle *fileHandle;
    NSString *filePath;
    unsigned long long fileSize;
    unsigned long long sizeHasSended;
    NSTimeInterval currentDataTimeInterval;
}

@property (retain) NSFileHandle *fileHandle;
@property (retain) NSString *filePath;
@property (nonatomic, assign)unsigned long long fileSize;
@property (nonatomic, assign)unsigned long long sizeHasSended;
@end

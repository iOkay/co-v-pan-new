//
//  ASBluetoothReceivingStatus.h
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-3-31.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASBluetoothStatus.h"

@interface ASBluetoothReceivingStatus : ASBluetoothStatus {
    NSFileHandle *fileHandle;
    NSString *filePath;
    BOOL isSuccessful;
}
@property (retain) NSFileHandle *fileHandle;
@property (retain) NSString *filePath;
@end

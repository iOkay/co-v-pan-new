//
//  bluetoothData.h
//  bluetoothSendFile
//
//  Created by wang qiushuang on 11-12-23.
//  Copyright 2011年 Alpha Studio All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ASBluetoothNumberOfFiles,
    ASbluetoothFileAcceptOrNot,
    ASBluetoothFileData,
    ASBluetoothACK    
} ASBluetoothDataType;

@interface ASBluetoothData : NSObject<NSCoding> {
    ASBluetoothDataType dataType;
    NSTimeInterval timeIntervalSence1970;
    id<NSObject,NSCoding> data;
}
@property (nonatomic,assign)ASBluetoothDataType dataType;
@property (nonatomic,assign)NSTimeInterval timeIntervalSence1970;
@property (nonatomic,retain)id<NSObject,NSCoding> data;

- (id)initWithType:(ASBluetoothDataType)aType 
   andTimeInterval:(NSTimeInterval)aTimeInterval
           andData:(id<NSObject,NSCoding>)aData;

- (void)dealloc;
@end

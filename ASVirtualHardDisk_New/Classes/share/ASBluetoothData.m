//
//  bluetoothData.m
//  bluetoothSendFile
//
//  Created by wang qiushuang on 11-12-23.
//  Copyright 2011年 Alpha Studio All rights reserved.
//

#import "ASBluetoothData.h"


@implementation ASBluetoothData
@synthesize dataType;
@synthesize timeIntervalSence1970;
@synthesize data;

- (id)initWithType:(ASBluetoothDataType)aType
   andTimeInterval:(NSTimeInterval)aTimeInterval
           andData:(id<NSObject,NSCoding>)aData
{
    self = [super init];
    if (self) {
        dataType = aType;
        timeIntervalSence1970 = aTimeInterval;
        self.data = aData;
    }
    return self;
}

- (void)dealloc {
    [data release];
    [super dealloc];
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithInt:dataType] forKey:@"dataType"];
    [aCoder encodeObject:[NSNumber numberWithDouble:timeIntervalSence1970]
                  forKey:@"timeInterval"];
    
    [aCoder encodeObject:data forKey:@"data"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSNumber *temp;
    temp = [aDecoder decodeObjectForKey:@"dataType"];
    dataType = [temp intValue];
    temp = [aDecoder decodeObjectForKey:@"timeInterval"];
    timeIntervalSence1970 = [temp doubleValue];
    
    data = [[aDecoder decodeObjectForKey:@"data"] retain];
    
    return self;
}
@end


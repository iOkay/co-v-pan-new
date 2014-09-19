//
//  ASFileEx.h
//  ASVirtualHardDisk
//
//  Created by liangxuan on 11-10-21.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASDataObject.h"

@interface ASFileEx : NSObject <ASDataObject>
{
    int fileStyle;
    NSString* fullPath;
    NSString* name;
    id<ASDataObject> parentPath;
}

@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* fullPath;
@property (nonatomic,retain) id<ASDataObject> parentPath;
@property int fileStyle;

- (NSString *) getFileCreateDate;

- (id) initWithFullPath:(NSString*)aFullPath;

- (id) initWithName:(NSString*)aName And:(id<ASDataObject>) aParentItem;
@end

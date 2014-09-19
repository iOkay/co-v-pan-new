//
//  ASScanMenuModel.h
//  ASVirtualHardDisk
//
//  Created by xieyajie on 11-12-7.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASMenuDataSource.h"

@interface ASScanMenuModel : NSObject <ASMenuDataSource>
{
@private
    UIImage *backgroundImage;
    UIImage *arrowImage;
    NSArray *item;
    NSArray *itemIcon;
}

+ (id)sharedASScanMenuModel;

@end

//
//  ASWebMenuModel.h
//  ASVirtualHardDisk
//
//  Created by 殿章 刘 on 11-11-22.
//  Copyright (c) 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASMenuDataSource.h"

@interface ASWebMenuModel : NSObject <ASMenuDataSource>
{
@private
    UIImage *backgroundImage;
    UIImage *arrowImage;
    NSArray *item;
    NSArray *itemIcon;
}

/*
 @function   singletonASWebMenuModel
 @abstract   init a model instance
 @param      none
 @result     id - return a single instance of ASWebMenuModel
 */
+ (id)sharedASRightMenuModel;

@end
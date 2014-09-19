//
//  ASSortMenuModel.h
//  ASVirtualHardDisk
//
//  Created by Liu Dong on 11-12-7.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASMenuDataSource.h"

@interface ASSortMenuModel : NSObject <ASMenuDataSource>
{
@private
	UIImage *backgroundImage;
    UIImage *arrowImage;
    NSArray *item;
    NSArray *itemIcon;
	int sortType;
	int sortFlag;
}

+(id) singletonASSortMenuModel;

-(void) dealloc;

-(void) saveSortInfo;

-(int) getSortType;

-(int) getSortFlag;

-(void) resignSortType:(int)aType andFlag:(int)aFlag;

@end

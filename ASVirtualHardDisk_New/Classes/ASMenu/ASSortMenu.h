//
//  ASSortMenu.h
//  ASVirtualHardDisk
//
//  Created by Liu Dong on 11-12-12.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASMenu.h"


@interface ASSortMenu : ASMenu 
{
@private
	int sortType;
	int sortFlag;
}

@property int sortType;
@property int sortFlag;

@end

//------------------------------------------------------------------------------
// Filename:        ASButton.h
// Project:         moveNav
// Author:          wangqiushuang
// Date:            11-9-23
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------
// Quote the standard library header files. 
#define buttonX 200
#define buttonTop 50
#define buttonBottom 450
#define missdistance 50

#import <UIKit/UIKit.h>
#import "ASMenuDelegate.h"
#import "ASMenuDataSource.h"


@interface ASMenu : UIButton <UITableViewDelegate, UITableViewDataSource>
{
	id<ASMenuDelegate>     delegate;
    id<ASMenuDataSource>   dataSource;  
	NSArray                *item;
	NSArray                *itemIcon;
}

@property (nonatomic, assign) id<ASMenuDelegate>   delegate;
@property (nonatomic, assign) id<ASMenuDataSource> dataSource;
@property (nonatomic, retain) UITableView *menuView;


/*
 @function   initWithPoint:andArrowPoint:andDataSource:
 @abstract   initial a menu
 @param      (CGPoint)menuPoint - point of menu
             (CGPoint)arrowPoint - point of arrow
 @result     id - a point of ASMenu
 */
- (id)initWithPoint:(CGPoint)menuPoint 
      andArrowPoint:(CGPoint)arrowPoint
      andDataSource:(id<ASMenuDataSource>)data;   

@end
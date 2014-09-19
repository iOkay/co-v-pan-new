//------------------------------------------------------------------------------
// Filename:        ASZipStrategy.h
// Project:         ASStrategy
// Author:          wangqiushuang
// Date:            11-10-23
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------
// Quote the standard library header files. 
#import <Foundation/Foundation.h>
#import "ASFileStrategy.h"
#import "MBProgressHUD.h"
/*
    @abstract	
*/

@class ASTableViewCell;
@class ASFileListViewController;

@interface ASZipStrategy : NSObject <ASFileStrategy,MBProgressHUDDelegate>
{
@private
    
    //Declare instance variaites.
	ASTableViewCell *cell;
	id<ASDataObject> zipDataObject;
    ASFileListViewController *viewController;
    MBProgressHUD *HUD;
}

/*
 @abstract    
 @result      
 */
@property(nonatomic, retain)id<ASDataObject> zipDataObject;

@end

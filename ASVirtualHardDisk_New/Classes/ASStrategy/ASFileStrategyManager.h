//------------------------------------------------------------------------------
// Filename:        ASFileStrategyManager.h
// Project:         ASStrategy
// Author:          wangqiushuang
// Date:            11-10-22
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------
// Quote the standard library header files. 
#import <Foundation/Foundation.h>
#import "ASTableViewCellState.h"
#import "ASDataObject.h"

/*
    @abstract	
*/

@interface ASFileStrategyManager : NSObject 
{
@private
    
    //Declare instance variaites.
	NSDictionary *strategis;
}

@property (nonatomic, retain) NSDictionary* strategis;

/*
 @abstract    
 @result      
 */
+ (ASFileStrategyManager *) sharedASFileStrategyManager;
- (void) dealloc;
-(void) execOnState:(ASTableViewCellState)state inViewController:(UIViewController *)viewController withDataObject:(id<ASDataObject>)dataObject;
@end

//------------------------------------------------------------------------------
// Filename:        ASTextStrategy.m
// Project:         ASStrategy
// Author:          wangqiushuang
// Date:            11-10-23
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------

// Quote header files.
#import "ASTextStrategy.h"
#import "ASTextViewController.h"
#import "ASDirectoryEx.h"
#import "ASFileEx.h"
#import "ASFileType.h"

@implementation ASTextStrategy

-(void) execOnState:(ASTableViewCellState)state 
   inViewController:(UIViewController *)viewController 
	 withDataObject:(id<ASDataObject>)dataObject
{
	if(Selected == state)
	{
		ASTextViewController *childViewController = 
		[[ASTextViewController alloc] 
		 initWithNibName:@"ASTextViewController"
		 bundle:nil];
		
		NSMutableString *ap = [[NSMutableString alloc] initWithString:NSHomeDirectory()];
		[ap appendString:@"/Documents"];
		[ap appendString:[dataObject getFullItemName]];
		childViewController.textPath = ap;
		[ap release];
        
        childViewController.file = (ASFileEx *)dataObject;

        viewController.navigationItem.backBarButtonItem = nil;
        
		[viewController.navigationController pushViewController:childViewController
											 animated:YES];
		[childViewController release];
	}
}
@end

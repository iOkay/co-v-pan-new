//------------------------------------------------------------------------------
// Filename:        ASReaderStrategy.m
// Project:         ASStrategy
// Author:          wangqiushuang
// Date:            11-10-23
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------

// Quote header files.
#import "ASReaderStrategy.h"
#import "ASReaderViewController.h"
@class ASFileEx;

@implementation ASReaderStrategy


-(void) execOnState:(ASTableViewCellState)state 
   inViewController:(UIViewController *)viewController 
	 withDataObject:(id<ASDataObject>)dataObject
{
    
	if(Selected == state)
	{
		ASReaderViewController *childViewController = 
		[[ASReaderViewController alloc] 
		 initWithNibName:@"ASReaderViewController"
		 bundle:nil];

		childViewController.file = (ASFileEx *)dataObject;
		
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:[[ASDeclare singletonASDeclare] navBack]
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:nil];
        
        viewController.navigationItem.backBarButtonItem = backButton;
        [backButton release];

        
		[viewController.navigationController pushViewController:childViewController
													   animated:YES];
		[childViewController release];
	}
}
@end

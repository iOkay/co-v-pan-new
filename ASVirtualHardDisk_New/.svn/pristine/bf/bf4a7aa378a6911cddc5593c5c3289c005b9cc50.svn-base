//------------------------------------------------------------------------------
// Filename:        ASCanNotOpenStrategy.m
// Project:         ASVirtualHardDisk
// Author:          wangqiushuang
// Date:            11-11-15
// Version:         
// Copyright 2011 AlphaStudio. All rights reserved. 
//------------------------------------------------------------------------------

// Quote header files.
#import "ASCanNotOpenStrategy.h"
#import "ASCanNotOpenViewController.h"
#import "ASTableViewCellState.h"
#import "ASDataObject.h"
#import "ASDeclare.h"
//#import "ASDirectoryEx.h"
//#import "ASFileEx.h"
//#import "ASFileType.h"

@implementation ASCanNotOpenStrategy
- (void) execOnState:(ASTableViewCellState)state 
    inViewController:(UIViewController *)viewController 
      withDataObject:(id<ASDataObject>)dataObject
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    if(Selected == state)
    {
		ASCanNotOpenViewController *childViewController = 
		[[ASCanNotOpenViewController alloc] 
		 initWithNibName:@"ASCanNotOpenViewController"
		 bundle:nil];
		
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

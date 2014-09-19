//
//  ASDirectoryStrategy.m
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-11-1.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASDataObject.h"
#import "ASDirectoryEx.h"
#import "ASDirectoryStrategy.h"
#import "ASFileListViewController.h"
#import "ASLocalDefine.h"
#import "ASTableViewCell.h"


@implementation ASDirectoryStrategy

- (void) execOnState:(ASTableViewCellState)state 
    inViewController:(UIViewController *)viewController 
      withDataObject:(id<ASDataObject>)dataObject
{    
    if(Selected == state)
    {
        ASFileListViewController *childViewController = 
           [[ASFileListViewController alloc] 
            initWithNibName:@"ASFileListViewController" bundle:nil];
                
        ASDirectoryEx *directory = (ASDirectoryEx *)dataObject;
        
        childViewController.title = [dataObject getItemName];
        childViewController.currentDirectory = directory;
        
        [viewController.navigationController pushViewController:childViewController 
                                             animated:YES];
        
        [childViewController release];

    }
}

@end

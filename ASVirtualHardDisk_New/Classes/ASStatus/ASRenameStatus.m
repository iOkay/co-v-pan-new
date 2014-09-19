//
//  ASRenameStatus.m
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-24.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASRenameStatus.h"
#import "ASFileListViewController.h"
#import "ASTableViewCell.h"
#import "ASStatusManager.h"

@implementation ASRenameStatus
//------------------------------------------------------------------------------
// - (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer
//------------------------------------------------------------------------------
- (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer
{
    NSLog(@"RenameStatus - tapGesture");
    NSArray *arrayDoc = viewController.filesInCurrentDocument;
    NSIndexPath *index = viewController.indexPath;
    UITableView *tableViewDoc = viewController.documentTableView;
    
    if ([arrayDoc count] > [index row]) 
    {
		ASTableViewCell *cell = (ASTableViewCell *)[tableViewDoc 
													cellForRowAtIndexPath:index];
		
		if (0 != [[[arrayDoc objectAtIndex:[index row]] name] length]) 
        {
			cell.mainText.text = [[[arrayDoc objectAtIndex:[index row]] name]
                                  stringByDeletingPathExtension];
		}
		else 
        {
			cell.mainText.text = [[arrayDoc objectAtIndex:[index row]] name];
		}
		
		[cell.mainText resignFirstResponder];
		cell.mainText.enabled = NO;
		viewController.addDirectory.enabled = YES;
	}
    
    [viewController.statusManager changeToNormalWithoutMenuStatus];
    viewController.documentTableView.userInteractionEnabled = YES;
//    [viewController addDirectoryWatcher];
}

//------------------------------------------------------------------------------
// - (void) handleForToolBar
//------------------------------------------------------------------------------
- (void) handleForToolBar
{
//    NSArray *items = viewController.toolBar.items;
//    for (int i = 0; i < [items count]; i++)
//    {
//        UIBarButtonItem *item = (UIBarButtonItem *)[items objectAtIndex:i];
//        item.enabled = NO;
//    }
//    
//    viewController.tapGestureRecognizer.cancelsTouchesInView = YES;
}

//------------------------------------------------------------------------------
// - (void) handleSwipeFrom:(UISwipeGestureRecognizer *)gestureRecognizer
//------------------------------------------------------------------------------
- (void) handleSwipeFrom:(UISwipeGestureRecognizer *)gestureRecognizer
{
    
}

//------------------------------------------------------------------------------
// - (void) handleDidDeselectRowAtIndexPath:(NSIndexPath *)aIndexPath
//------------------------------------------------------------------------------
- (void) handleDidDeselectRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    
}

//------------------------------------------------------------------------------
// - (void) handleAccessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)aIndexPath
//------------------------------------------------------------------------------
- (void) handleAccessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)aIndexPath
{
    
}

//------------------------------------------------------------------------------
// - (void) handleDidSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
//------------------------------------------------------------------------------
- (void) handleDidSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    
}

#pragma mark -
#pragma mark life cycle
- (id) initWithViewController:(ASFileListViewController *) aViewController
{
    self = [super init];
    if(self)
    {
        viewController = aViewController;
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}


@end

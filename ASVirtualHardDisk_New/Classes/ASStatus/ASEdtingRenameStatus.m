//
//  ASEdtingRenameStatus.m
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-25.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASEdtingRenameStatus.h"
#import "ASFileListViewController.h"
#import "ASTableViewCell.h"
#import "ASStatusManager.h"

@implementation ASEdtingRenameStatus

//------------------------------------------------------------------------------
// - (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer
//------------------------------------------------------------------------------
- (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer
{
    NSLog(@"EdtingRenameStatus - tapGesture");
    NSArray *arrayDoc = viewController.filesInCurrentDocument;
    NSIndexPath *index = viewController.indexPath;
    UITableView *tableViewDoc = viewController.documentTableView;
    
    if ([arrayDoc count] > [index row]) {
		ASTableViewCell *cell = (ASTableViewCell *)[tableViewDoc 
													cellForRowAtIndexPath:index];
		
		if (0 != [[[[arrayDoc objectAtIndex:[index row]] getItemName] pathExtension] length]) 
        {
			cell.mainText.text = [[[arrayDoc objectAtIndex:[index row]] getItemName] 
                                  stringByDeletingPathExtension];
		}
		else 
        {
			cell.mainText.text = [[arrayDoc objectAtIndex:[index row]] getItemName];
		}
		
        [viewController.documentTableView setContentOffset: viewController.pointOfCell animated: YES];
        
		[cell.mainText resignFirstResponder];
		cell.mainText.enabled = NO;
		viewController.addDirectory.enabled = YES;
	}
    
    [viewController.statusManager changeToEdtingStatus];
//    [viewController addDirectoryWatcher];
}

//------------------------------------------------------------------------------
// - (void) handleForToolBar
//------------------------------------------------------------------------------
- (void) handleForToolBar
{

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

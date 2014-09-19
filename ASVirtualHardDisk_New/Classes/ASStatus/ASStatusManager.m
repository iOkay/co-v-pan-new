//
//  ASStatusManager.m
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-23.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASStatusManager.h"
#import "ASFileListViewController.h"
#import "ASNormalWithMenuStatus.h"
#import "ASNormalWithoutMenuStatus.h"
#import "ASEdtingRenameStatus.h"
#import "ASEdtingStatus.h"
#import "ASRenameStatus.h"

@implementation ASStatusManager

@synthesize status;
//@synthesize viewController;

#pragma mark - 
#pragma mark cycle life
//------------------------------------------------------------------------------
// - (void) config:(ASFileListViewController *) aViewController
//------------------------------------------------------------------------------
- (void) config:(ASFileListViewController *) aViewController
{
    normalWithoutMenuStatus  = [[ASNormalWithoutMenuStatus alloc] 
        initWithViewController:aViewController];
    
    normalWithMenuStatus = [[ASNormalWithMenuStatus alloc] 
        initWithViewController:aViewController];
    
    edtingRenameStatus = [[ASEdtingRenameStatus alloc] 
        initWithViewController:aViewController];
    
    edtingStatus = [[ASEdtingStatus alloc] 
        initWithViewController:aViewController];
    
    renameStatus = [[ASRenameStatus alloc] 
        initWithViewController:aViewController];
    
    //viewController = aViewController;
    status = normalWithoutMenuStatus;
}
//------------------------------------------------------------------------------
// - (id) initWithViewController:(ASFileListViewController *)aViewController
//------------------------------------------------------------------------------
- (id) initWithViewController:(ASFileListViewController *)aViewController
{
    self = [super init];
    if(self)
    {
        [self config:aViewController];
    }
    
    return self;
}

//------------------------------------------------------------------------------
// - (void) dealloc
//------------------------------------------------------------------------------
- (void) dealloc
{   
    //viewController = nil;
    
    [normalWithoutMenuStatus release];
    [normalWithMenuStatus release];
    [edtingRenameStatus release];
    [edtingStatus release];
    [renameStatus release];
    
    status = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark Method
//------------------------------------------------------------------------------
// - (void) changeToNormalWithoutMenuStatus
//------------------------------------------------------------------------------
- (void) changeToNormalWithoutMenuStatus
{
    status = normalWithoutMenuStatus;
}

//------------------------------------------------------------------------------
// - (void) changeToNormalWithMenuStatus
//------------------------------------------------------------------------------
- (void) changeToNormalWithMenuStatus
{
    status = normalWithMenuStatus;
}

//------------------------------------------------------------------------------
// - (void) changeToEdtingStatus
//------------------------------------------------------------------------------
- (void) changeToEdtingStatus
{
    status = edtingStatus;
}

//------------------------------------------------------------------------------
// - (void) changeToRenameStatus
//------------------------------------------------------------------------------
- (void) changeToRenameStatus
{
    status = renameStatus;
}

//------------------------------------------------------------------------------
// - (void) changeToEdtingRenameStatus
//------------------------------------------------------------------------------
- (void) changeToEdtingRenameStatus
{
    status = edtingRenameStatus;
}

//------------------------------------------------------------------------------
// - (void) handleForToolBar
//------------------------------------------------------------------------------
- (void) handleForToolBar
{
    [status handleForToolBar];
}

//------------------------------------------------------------------------------
// - (void) handleSwipeFrom:(UISwipeGestureRecognizer *)gestureRecognizer
//------------------------------------------------------------------------------
- (void) handleSwipeFrom:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [status handleSwipeFrom:gestureRecognizer];
}

//------------------------------------------------------------------------------
// - (void) handleDidSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
//------------------------------------------------------------------------------
- (void) handleDidSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    [status handleDidSelectRowAtIndexPath:aIndexPath];
}

//------------------------------------------------------------------------------
// - (void) handleDidDeselectRowAtIndexPath:(NSIndexPath *)aIndexPath  
//------------------------------------------------------------------------------
- (void) handleDidDeselectRowAtIndexPath:(NSIndexPath *)aIndexPath  
{
    [status handleDidDeselectRowAtIndexPath:aIndexPath];
}

//------------------------------------------------------------------------------
// - (void) handleAccessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)aIndexPath
//------------------------------------------------------------------------------
- (void) handleAccessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)aIndexPath   
{
    [status handleAccessoryButtonTappedForRowWithIndexPath:aIndexPath];
}

//------------------------------------------------------------------------------
// - (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer
//------------------------------------------------------------------------------
- (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer
{
    [status handleTapGesture:gestureRecognizer];
}
@end

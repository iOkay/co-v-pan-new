//
//  ASStatus.h
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-23.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASFileListViewController;

@protocol ASStatus <NSObject>

/*
    @function   handleForToolBar
    @abstract   format toolBar
    @param      none
    @result     void
*/
- (void) handleForToolBar;

/*
    @function   handleSwipeFrom:
    @abstract   resopnder to swipe gesture
    @param      UISwipeGestureRecognizer * - a gesture
    @result     void
*/
- (void) handleSwipeFrom:(UISwipeGestureRecognizer *) gestureRecognizer;

/*
    @function   handleDidDeselectRowAtIndexPath:
    @abstract   <#statements#>
    @param      NSIndexPath * 
    @result     <#return type#>
*/
- (void) handleDidDeselectRowAtIndexPath:(NSIndexPath *)aIndexPath;

/*
    @function   handleAccessoryButtonTappedForRowWithIndexPath:
    @abstract   <#statements#>
    @param      NSIndexPath *
    @result     <#return type#>
*/
- (void) handleAccessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)aIndexPath;

/*
    @function   handleDidSelectRowAtIndexPath:
    @abstract   <#statements#>
    @param      NSIndexPath *
    @result     <#return type#>
*/
- (void) handleDidSelectRowAtIndexPath:(NSIndexPath *)aIndexPath;

/*
 @function   handleTapGesture:
 @abstract   <#statements#>
 @param      <#function parameters#>
 @result     <#return type#>
 */
- (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer;

@end

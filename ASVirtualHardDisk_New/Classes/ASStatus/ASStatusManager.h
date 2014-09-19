//
//  ASStatusManager.h
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-23.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASStatus.h"

@class ASFileListViewController;
@class ASNormalWithoutMenuStatus;
@class ASNormalWithMenuStatus;
@class ASEdtingRenameStatus;
@class ASEdtingStatus;
@class ASRenameStatus;

@interface ASStatusManager : NSObject {
@private
    //ASFileListViewController  *viewController;
    
    ASNormalWithoutMenuStatus *normalWithoutMenuStatus;
    ASNormalWithMenuStatus    *normalWithMenuStatus;
    ASEdtingRenameStatus      *edtingRenameStatus;
    ASEdtingStatus            *edtingStatus;
    ASRenameStatus            *renameStatus;
    
    id<ASStatus> status;
}

//@property (nonatomic, assign) ASFileListViewController *viewController;
@property (nonatomic, assign) id <ASStatus> status;

/*
    @function   initWithViewController:
    @abstract   <#statements#>
    @param      <#function parameters#>
    @result     <#return type#>
*/
- (id) initWithViewController:(ASFileListViewController *) aViewController;

/*
    @function   dealloc
    @abstract   <#statements#>
    @param      <#function parameters#>
    @result     <#return type#>
*/
- (void) dealloc;

/*
    @function   changeToNormalWithoutMenuStatus
    @abstract   change to normalWithoutMenuStatus
    @param      none
    @result     void
*/
- (void) changeToNormalWithoutMenuStatus;

/*
    @function   changeToNormalWithMenuStatus
    @abstract   change to normalWithMenuStatuss
    @param      none
    @result     void
*/
- (void) changeToNormalWithMenuStatus;

/*
    @function   changeToEdtingStatus
    @abstract   change to edtingStatus
    @param      none
    @result     void
*/
- (void) changeToEdtingStatus;

/*
 @function   changeToEdtingRenameStatus
 @abstract   change to edtingRenameStatus
 @param      none
 @result     void
 */
- (void) changeToEdtingRenameStatus;

/*
    @function   changeToRenameStatus
    @abstract   change to rename staus
    @param      none
    @result     void
*/
- (void) changeToRenameStatus;

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

//
//  ASMenuDataSource.h
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-21.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASMenu;

@protocol ASMenuDataSource 
@required
/*
    @function   numberOfItems
    @abstract   return the number of items in the menu
    @param      none
    @result     int - the number of items in the menu
*/
- (int) numberOfItems:(ASMenu *)menu;

/*
    @function   itemsForMenu
    @abstract   get the items for menu
    @param      none
    @result     NSArray* - items aggregate
*/
- (NSArray *) itemsForMenu:(ASMenu *)menu;

/*
    @function   iconsForMenu
    @abstract   get the icon for ervery item in the menu 
    @param      none
    @result     NSArray * - icons aggregate
*/
- (NSArray *) iconsForMenu:(ASMenu *)menu;

/*
    @function   backgroundForMenu
    @abstract   get background for item
    @param      none
    @result     UIImage * - return the background image
*/
- (UIImage *) backgroundForMenu:(ASMenu *)menu;

/*
    @function   arrowForItem
    @abstract   get arrow image for menu
    @param      none
    @result     UIImage *
*/
- (UIImage *) arrowImageForMenu:(ASMenu *)menu;

@optional
//add by Liu Dong on Dec 12th,2011
//just for sort
-(int) getSortType;

-(int) getSortFlag;

-(void) resignSortType:(int)aType andFlag:(int)aFlag;

@end

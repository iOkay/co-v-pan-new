//
//  ASBottomMenuModel.m
//  ASVirtualHardDisk
//
//  Created by 窦 伟超 on 11-11-15.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASBottomMenuModel.h"
#import "ASMenu.h"

@implementation ASBottomMenuModel

static  ASBottomMenuModel *bottomMenuModel;


//------------------------------------------------------------------------------
// - (void) configModel
//------------------------------------------------------------------------------
- (void) configModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bottomMenu"
                                                     ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSString *bgImage = [dic objectForKey:@"backgroundImage"];
    backgroundImage = [[UIImage imageNamed:bgImage] retain];
    NSString *arImage = [dic objectForKey:@"arrowImage"];
    NSLog(@"%@",arImage);
    arrowImage = [[UIImage imageNamed:arImage] retain];
    
    item = [[dic objectForKey:@"item"] retain];
    
    itemIcon = [[dic objectForKey:@"itemIcon"] retain];   
    [dic release];
    
}

#pragma mark -
//------------------------------------------------------------------------------
// + (id) singletonASBottomMenuModel
//------------------------------------------------------------------------------
+ (id) singletonASBottomMenuModel
{
    if(nil == bottomMenuModel)
    {
        bottomMenuModel = [[ASBottomMenuModel alloc] init];
        [bottomMenuModel configModel];
    }
    return bottomMenuModel;
}

//------------------------------------------------------------------------------
// - (void) dealloc
//------------------------------------------------------------------------------
- (void) dealloc
{
    [item release];
    [itemIcon release];
    [arrowImage release];
    [backgroundImage release];
    
    bottomMenuModel = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark ASMenuDataSource Delegate
//------------------------------------------------------------------------------
// - (int) numberOfItems:(ASMenu *)menu
//------------------------------------------------------------------------------
- (int) numberOfItems:(ASMenu *)menu
{
    return [item count];
}

//------------------------------------------------------------------------------
// - (NSArray *) itemsForMenu:(ASMenu *)menu
//------------------------------------------------------------------------------
- (NSArray *) itemsForMenu:(ASMenu *)menu
{
    return item;
}

//------------------------------------------------------------------------------
// - (NSArray *) iconsForMenu:(ASMenu *)menu
//------------------------------------------------------------------------------
- (NSArray *) iconsForMenu:(ASMenu *)menu
{
    return itemIcon;
}
//------------------------------------------------------------------------------
// - (UIImage *) backgroundForMenu:(ASMenu *)menu
//------------------------------------------------------------------------------
- (UIImage *) backgroundForMenu:(ASMenu *)menu
{
    return backgroundImage;
}

//------------------------------------------------------------------------------
// - (UIImage *) arrowImageForMenu:(ASMenu *)menu
//------------------------------------------------------------------------------
- (UIImage *) arrowImageForMenu:(ASMenu *)menu
{
    return arrowImage;
}


@end

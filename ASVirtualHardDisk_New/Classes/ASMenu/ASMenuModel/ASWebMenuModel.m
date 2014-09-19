//
//  ASWebMenuModel.m
//  ASVirtualHardDisk
//
//  Created by 殿章 刘 on 11-11-22.
//  Copyright (c) 2011年 AlphaStudio. All rights reserved.
//

#import "ASWebMenuModel.h"

#import "ASMenu.h"

@implementation ASWebMenuModel

static ASWebMenuModel *webMenuModel;

//------------------------------------------------------------------------------
// - (void) configModel
//------------------------------------------------------------------------------
- (void) configModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"webMenu"
                                                     ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSString *bgImage = [dic objectForKey:@"backgroundImage"];
    backgroundImage = [[UIImage imageNamed:bgImage] retain];
    
    NSString *arImage = [dic objectForKey:@"arrowImage"];
    arrowImage = [[UIImage imageNamed:arImage] retain];
    
    item = [[dic objectForKey:@"item"] retain];
    
    itemIcon = [[dic objectForKey:@"itemIcon"] retain];
    
    [dic release];
}

#pragma mark -
//------------------------------------------------------------------------------
// + (id) sharedASRightMenuModel
//------------------------------------------------------------------------------
+ (id) sharedASRightMenuModel
{
    if(nil == webMenuModel)
    {
        webMenuModel = [[ASWebMenuModel alloc] init];
        [webMenuModel configModel];
    }
    
    return webMenuModel;
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
    
    webMenuModel = nil;
    
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

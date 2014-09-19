//
//  ASRotateMenuModel.m
//  ASVirtualHardDisk
//
//  Created by xieyajie on 11-12-9.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASRotateMenuModel.h"
#import "ASMenu.h"

@implementation ASRotateMenuModel

static  ASRotateMenuModel *rotateMenuModel;

//------------------------------------------------------------------------------
// - (void) configModel
//------------------------------------------------------------------------------
- (void)configModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"scanRotateMenu"
                                                     ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSString *bgImage = [dic objectForKey:@"backgroundImage"];
    backgroundImage = [[UIImage imageNamed:bgImage] retain];
    NSString *arImage = [dic objectForKey:@"arrowImage"];
    arrowImage = [[UIImage imageNamed:arImage]retain];
    
    item = [[dic objectForKey:@"item"] retain];
    
    itemIcon = [[dic objectForKey:@"itemIcon"] retain];   
    [dic release];
    
}
#pragma mark -

+ (id)sharedRotateMenuModel
{
    if(nil == rotateMenuModel)
    {
        rotateMenuModel = [[ASRotateMenuModel alloc] init];
        [rotateMenuModel configModel];
    }
    
    return rotateMenuModel;
}

- (void)dealloc
{
    [item release];
    [itemIcon release];
    [arrowImage release];
    [backgroundImage release];
    
    rotateMenuModel = nil;
    
    [super dealloc];
}

#pragma mark -
#pragma mark ASMenuDataSource Delegate
//------------------------------------------------------------------------------
// - (int) numberOfItems:(ASMenu *)menu
//------------------------------------------------------------------------------
- (int)numberOfItems:(ASMenu *)menu
{
    return [item count];
}

//------------------------------------------------------------------------------
// - (NSArray *) itemsForMenu:(ASMenu *)menu
//------------------------------------------------------------------------------
- (NSArray *)itemsForMenu:(ASMenu *)menu
{
    return item;
}

//------------------------------------------------------------------------------
// - (NSArray *) iconsForMenu:(ASMenu *)menu
//------------------------------------------------------------------------------
- (NSArray *)iconsForMenu:(ASMenu *)menu
{
    return itemIcon;
}
//------------------------------------------------------------------------------
// - (UIImage *) backgroundForMenu:(ASMenu *)menu
//------------------------------------------------------------------------------
- (UIImage *)backgroundForMenu:(ASMenu *)menu
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

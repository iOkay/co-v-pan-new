//
//  ASScanMenuModel.m
//  ASVirtualHardDisk
//
//  Created by xieyajie on 11-12-7.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASScanMenuModel.h"
#import "ASMenu.h"

@implementation ASScanMenuModel

static  ASScanMenuModel *scanMenuModel;

//------------------------------------------------------------------------------
// - (void) configModel
//------------------------------------------------------------------------------
- (void) configModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"scanMenu"
                                                     ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSString *bgImage = [dic objectForKey:@"backgroundImage"];
    backgroundImage = [UIImage imageNamed:bgImage];
    NSString *arImage = [dic objectForKey:@"arrowImage"];
    arrowImage = [UIImage imageNamed:arImage];
    
    item = [[dic objectForKey:@"item"] retain];
    
    itemIcon = [[dic objectForKey:@"itemIcon"] retain];   
    [dic release];
    
}


#pragma mark -
//------------------------------------------------------------------------------
// + (id) sharedASScanMenuModel
//------------------------------------------------------------------------------
+ (id)sharedASScanMenuModel
{
    if(!scanMenuModel) {
        scanMenuModel = [[ASScanMenuModel alloc] init];
        [scanMenuModel configModel];
    }
    
    return scanMenuModel;
}

//------------------------------------------------------------------------------
// - (void) dealloc
//------------------------------------------------------------------------------
- (void) dealloc
{
    [item release];
    [itemIcon release];
    
    scanMenuModel = nil;
    
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
- (UIImage *)arrowImageForMenu:(ASMenu *)menu
{
    return arrowImage;
}

@end

//
//  ASSortMenuModel.m
//  ASVirtualHardDisk
//
//  Created by Liu Dong on 11-12-7.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import "ASSortMenuModel.h"
#import "ASMenu.h"

@implementation ASSortMenuModel

static ASSortMenuModel *sortMenuModel;

-(void) configModel
{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"sortMenu" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSString *bgImage = [dic objectForKey:@"backgroundImage"];
    backgroundImage = [[UIImage imageNamed:bgImage] retain];
    
    NSString *arImage = [dic objectForKey:@"arrowImage"];
    arrowImage = [[UIImage imageNamed:arImage] retain];
    
    item = [[dic objectForKey:@"item"] retain];
    
    itemIcon = [[dic objectForKey:@"itemIcon"] retain];
    
    [dic release];
	
	NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *directory = [pathArr objectAtIndex:0];
	NSString *Path = [directory stringByAppendingPathComponent:@"selectedCell"];
	NSArray *array = [[NSArray alloc] initWithContentsOfFile:Path];
	
	NSString *type = [array objectAtIndex:0];
	sortType = [type intValue];
	
	NSString *flag = [array objectAtIndex:1];
	sortFlag = [flag intValue];
	
	[array release];
}

+(id) singletonASSortMenuModel
{
	if(nil == sortMenuModel)
    {
        sortMenuModel = [[ASSortMenuModel alloc] init];
        [sortMenuModel configModel];
    }
    
    return sortMenuModel;
}

-(void) dealloc
{
	[item release];
    [itemIcon release];
    [arrowImage release];
    [backgroundImage release];
    
    sortMenuModel = nil;
    
    [super dealloc];
}

-(void)saveSortInfo
{
	NSString *type = [NSString stringWithFormat:@"%d",sortType];
	NSString *flag = [NSString stringWithFormat:@"%d",sortFlag];	
	NSArray *array = [[NSArray alloc] initWithObjects:type,flag,nil];
	
	NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *directory = [pathArr objectAtIndex:0];
	NSString *path = [directory stringByAppendingPathComponent:@"selectedCell"];
	[array writeToFile:path atomically:YES];
	
	[array release];
}

-(int) getSortType
{	
	return sortType;
}

-(int) getSortFlag
{
	return sortFlag;
}

-(void) resignSortType:(int)aType andFlag:(int)aFlag
{
	sortType = aType;
	sortFlag = aFlag;
}

#pragma mark -
#pragma mark ASMenuDataSource Delegate

-(int) numberOfItems:(ASMenu *)menu
{
    return [item count];
}

-(NSArray *) itemsForMenu:(ASMenu *)menu
{
    return item;
}

-(NSArray *) iconsForMenu:(ASMenu *)menu
{
    return itemIcon;
}

-(UIImage *) backgroundForMenu:(ASMenu *)menu
{
    return backgroundImage;
}

-(UIImage *) arrowImageForMenu:(ASMenu *)menu
{
    return arrowImage;
}

@end

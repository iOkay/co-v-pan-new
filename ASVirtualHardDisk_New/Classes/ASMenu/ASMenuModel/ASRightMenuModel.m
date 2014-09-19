//
//  ASRightMenuModel.m
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-22.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASRightMenuModel.h"
#import "ASMenu.h"

@implementation ASRightMenuModel

//for right menu
static const CGFloat kRightButtonX = 160.0f;
static const CGFloat kRightButtonTop = 35.0f;
static CGFloat kRightButtonBottom = 465.0f;

static const CGFloat kMissDistance =  50.0f;
//size of the rightMenu 
static const CGFloat kBackgroundImageWidth = 106.0f;
static const CGFloat kBackgroundImageHeight = 182.0f;
//size of the arrow in rightMenu
static const CGFloat kArrowImageWidth = 22.2f;
static const CGFloat kArrowImageHeight = 28.0f;

static ASRightMenuModel *rightMenuModel;

//------------------------------------------------------------------------------
// - (void) configModel
//------------------------------------------------------------------------------
- (void) configModel
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index"
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
    if(!rightMenuModel) {
        rightMenuModel = [[ASRightMenuModel alloc] init];
        [rightMenuModel configModel];
    }
    
    return rightMenuModel;
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
    
    rightMenuModel = nil;
    
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

#pragma mark -
#pragma mark Assist Method
//------------------------------------------------------------------------------
// + (CGFloat) ordinateForMenu:(CGPoint)aPoint
//------------------------------------------------------------------------------
+ (CGFloat)ordinateForMenuOfPortrait:(CGPoint)aPoint
{
    CGFloat buttonY;
    if (aPoint.y - kMissDistance + kBackgroundImageHeight > 
        kRightButtonBottom)
    {
		buttonY = kRightButtonBottom - kBackgroundImageHeight;
	}
	else if(aPoint.y - kMissDistance < kRightButtonTop)
	{
		buttonY = kRightButtonTop;
	}
	else {
		buttonY = aPoint.y - kMissDistance;
	}
    
    return buttonY;
}
+ (CGFloat) ordinateForMenuOfUpsideDown:(CGPoint)aPoint
{
    CGFloat buttonY;
    if (aPoint.y - kMissDistance + kBackgroundImageHeight > 
        445)
    {
		buttonY = 445 - kBackgroundImageHeight;
	}
	else if(aPoint.y - kMissDistance < 15)
	{
		buttonY = 15;
	}
	else {
		buttonY = aPoint.y - kMissDistance;
	}
    
    return buttonY;
}
+ (CGFloat) ordinateForMenuOfLandscapeLeft:(CGPoint)aPoint
{
    return aPoint.y - kMissDistance;
}
+ (CGFloat) ordinateForMenuOfLandscapeRight:(CGPoint)aPoint
{
    return aPoint.y - kMissDistance;
}
//------------------------------------------------------------------------------
// + (CGPoint) pointForMenu:(CGPoint)aPoint
//------------------------------------------------------------------------------
+ (CGPoint) pointForMenuOfPortrait:(CGPoint)aPoint
{
    CGFloat buttonY = [self ordinateForMenuOfPortrait:aPoint];
    CGFloat button = aPoint.x;
        return CGPointMake(button, buttonY);
}
+ (CGPoint) pointForMenuOfUpsideDown:(CGPoint)aPoint
{
    CGFloat buttonY = [self ordinateForMenuOfUpsideDown:aPoint];
    CGFloat button = aPoint.x;
    return CGPointMake(button, buttonY);
}
+ (CGPoint) pointForMenuOfLandscapeLeft:(CGPoint)aPoint
{
    CGFloat buttonY = [self ordinateForMenuOfLandscapeLeft:aPoint];
    if (aPoint.x > 145)
    {
		aPoint.x = 145;
	}
	else if(aPoint.x < 50)
	{
		aPoint.x = 50;
	}
    return CGPointMake(aPoint.x, buttonY);
}
+ (CGPoint) pointForMenuOfLandscapeRight:(CGPoint)aPoint
{
    CGFloat buttonY = [self ordinateForMenuOfLandscapeRight:aPoint];
    if (aPoint.x > 130)
    {
		aPoint.x = 130;
	}
	else if(aPoint.x < 40)
	{
		aPoint.x = 40;
	}
    return CGPointMake(aPoint.x, buttonY);
}

//------------------------------------------------------------------------------
// + (CGPoint) pointForArrow:(CGPoint)aPoint
//------------------------------------------------------------------------------
+ (CGPoint) pointForArrowOfPortrait:(CGPoint)aPoint
{
    CGFloat buttonY = [self ordinateForMenuOfPortrait:aPoint];
    
    CGFloat arrowsY = aPoint.y - buttonY - kArrowImageHeight/2;
    
    return CGPointMake(-kArrowImageWidth, arrowsY);
}
+ (CGPoint) pointForArrowOfUpsideDown:(CGPoint)aPoint
{
    CGFloat buttonY = [self ordinateForMenuOfUpsideDown:aPoint];
    
    CGFloat arrowsY = (aPoint.y - buttonY - kArrowImageHeight/2);
    
    return CGPointMake(-kArrowImageWidth, arrowsY);
}
+ (CGPoint) pointForArrowOfLandscapeLeft:(CGPoint)aPoint
{
    CGFloat buttonY = [self ordinateForMenuOfLandscapeLeft:aPoint];
    
    CGFloat arrowsY = aPoint.y - buttonY - kArrowImageHeight/2;

    if (aPoint.x > 130)
    {
		arrowsY = -110+aPoint.x;
	}
	else if(aPoint.x < 40)
	{
		arrowsY = 65-aPoint.x;
	}
    return CGPointMake(-kArrowImageWidth, arrowsY);
}
+ (CGPoint) pointForArrowOfLandscapeRight:(CGPoint)aPoint
{
     
    CGFloat buttonY = [self ordinateForMenuOfLandscapeRight:aPoint];
    
    CGFloat arrowsY = aPoint.y - buttonY - kArrowImageHeight/2;
    if (aPoint.x > 130)
    {
		arrowsY = -110+aPoint.x;
	}
	else if(aPoint.x < 40)
	{
		arrowsY = 85-aPoint.x;
	}
    return CGPointMake(-kArrowImageWidth, arrowsY);

}

@end

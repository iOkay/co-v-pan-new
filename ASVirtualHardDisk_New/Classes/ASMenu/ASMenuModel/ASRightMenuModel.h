//
//  ASRightMenuModel.h
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-22.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASMenuDataSource.h"
#import <UIKit/UIKit.h>
@interface ASRightMenuModel : UIViewController <ASMenuDataSource>
{
@private
    UIImage *backgroundImage;
    UIImage *arrowImage;
    NSArray *item;
    NSArray *itemIcon;
}

/*
    @function   sharedASRightMenuModel
    @abstract   init a model instance
    @param      none
    @result     id - return a single instance of ASRightMenuModel
*/
+ (id) sharedASRightMenuModel;

- (void) dealloc;

+ (CGFloat) ordinateForMenuOfPortrait:(CGPoint)aPoint;
+ (CGFloat) ordinateForMenuOfUpsideDown:(CGPoint)aPoint;
+ (CGFloat) ordinateForMenuOfLandscapeLeft:(CGPoint)aPoint;
+ (CGFloat) ordinateForMenuOfLandscapeRight:(CGPoint)aPoint;

+ (CGPoint) pointForMenuOfPortrait:(CGPoint)aPoint;
+ (CGPoint) pointForMenuOfUpsideDown:(CGPoint)aPoint;
+ (CGPoint) pointForMenuOfLandscapeLeft:(CGPoint)aPoint;
+ (CGPoint) pointForMenuOfLandscapeRight:(CGPoint)aPoint;

+ (CGPoint) pointForArrowOfPortrait:(CGPoint)aPoint;
+ (CGPoint) pointForArrowOfUpsideDown:(CGPoint)aPoint;
+ (CGPoint) pointForArrowOfLandscapeLeft:(CGPoint)aPoint;
+ (CGPoint) pointForArrowOfLandscapeRight:(CGPoint)aPoint;
@end

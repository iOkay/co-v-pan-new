//
//  ASPictureViewController.h
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-9-16.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASScrollViewDelegate.h"
#import "ASScanViewController.h"

//frame size for portrait
#define KFrame_Size_Width     320.0f
#define KFrame_Size_Height    480.0f

//frame size for landscape
#define KFrame_Landspace_Size_Width    480.0f
#define KFrame_Landspace_Size_Height   320.0f

#define KPicture_Offset 0
#define KLabel_Offset 0
#define KLabel_Position_Y 0
#define KLabel_Size_Width 0
#define KLabel_Size_Height 0
#define KLabel_Landspace_Position_Y 0
#define KLabel_Landspace_Size_Width 0
#define KLabel_Landspace_Size_Height 0

//picture size for portrait
#define KPicture_Size_Width   300.0f
#define KPicture_Size_Height  460.0f

//picture size for landspace
#define KPicture_Landspace_Size_Width   460.0f
#define KPicture_Landspace_Size_Height  300.0f


@interface ASPictureViewController : ASScanViewController 
    <UIScrollViewDelegate,UIPrintInteractionControllerDelegate>
{    
	UIScrollView *sv;
    UIImageView *mImgView; //显示当前页图片的主imageView
    NSMutableArray *imgViewArray; //存储所有imageview的数组
    NSMutableArray *pictureToDisplay;
    int startIndex;
    int totalPages_; //总图片数量
	UIImageView *rotateView;
	BOOL isRotated;
}

@property (nonatomic, retain) UIScrollView *sv;
@property (nonatomic, retain) NSMutableArray *pictureToDisplay;
@property (nonatomic, retain) NSMutableArray *imgViewArray;
@property (nonatomic, retain) UIImageView *mImgView;
@property (nonatomic) int startIndex;
@property (nonatomic) int totalPages;
@property (nonatomic, retain) UIImageView *rotateView;
@property (nonatomic) BOOL isRotated;

+ (id) getPictureControlSingleObject;
-(CGSize)setImgViewLocation:(UIImageView *)aImgView;
- (void) showPictureInView;
- (void) showPictureInLandspaceView;

-(void) loadFile: (NSString*)aPath;
-(void) printPressed:(id)sender;

@end

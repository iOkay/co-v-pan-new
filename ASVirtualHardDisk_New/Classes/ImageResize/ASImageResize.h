//------------------------------------------------------------------------------
// Copyright (c)2011, IOS Team
// FileName:        ASImageResize.h
// Description:     
// Author:          Bob Shan
// Date:            11-3-19
// Version:         1.0
//------------------------------------------------------------------------------
// 

@interface UIImage (Resize)

/*
	@method	croppedImage:
*/
- (UIImage *)croppedImage : (CGRect)bounds;

/*
	@method	thumbnailImage:transparentBorder:cornerRadius:interpolationQuality:
*/
- (UIImage *)thumbnailImage : (NSInteger)thumbnailSize
          transparentBorder : (NSUInteger)borderSize
               cornerRadius : (NSUInteger)cornerRadius
       interpolationQuality : (CGInterpolationQuality)quality;

/*
	@method resizedImage:interpolationQuality:
*/
- (UIImage *)resizedImage : (CGSize)newSize
     interpolationQuality : (CGInterpolationQuality)quality;

/*
	@method resizedImageWithContentMode:bounds:interpolationQuality:
*/
- (UIImage *)resizedImageWithContentMode : (UIViewContentMode)contentMode
                                  bounds : (CGSize)bounds
                    interpolationQuality : (CGInterpolationQuality)quality;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end

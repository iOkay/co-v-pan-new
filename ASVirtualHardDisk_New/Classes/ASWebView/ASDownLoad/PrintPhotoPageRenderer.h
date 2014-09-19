

#import <UIKit/UIKit.h>


@interface PrintPhotoPageRenderer : UIPrintPageRenderer {
  UIImage *imageToPrint;
}

@property (readwrite, retain) UIImage *imageToPrint;

@end

//------------------------------------------------------------------------------
// Filename:        ASCanNotOpenViewController.h
// Project:         ASVirtualHardDisk
// Author:          wangqiushuang
// Date:            11-11-15
// Version:         
// Copyright 2011 AlphaStudio. All rights reserved. 
//------------------------------------------------------------------------------
// Quote the standard library header files. 
#import <UIKit/UIKit.h>


@interface ASCanNotOpenViewController : UIViewController 
{
    @private
    UILabel *text;
}
@property (nonatomic, retain) IBOutlet UILabel *text;
@end

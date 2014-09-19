//------------------------------------------------------------------------------
// Filename:        ASTextViewController.h
// Project:         moveNav
// Author:          wangqiushuang
// Date:            11-9-15
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------
// Quote the standard library header files. 
#import <UIKit/UIKit.h>
#import "ASScanViewController.h"

@class ASFileEx;

@interface ASTextViewController : ASScanViewController 
    <UIAlertViewDelegate>
{
@private
	UITextView *textView;
	NSString *textPath;
	NSStringEncoding encoding;
    BOOL textFieldDidChanged;
    
    ASFileEx *file;
	//NSFileHandle *textFile;
}
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, copy) IBOutlet NSString *textPath;

@property (nonatomic, retain) ASFileEx *file;

-(void) printPressed:(id)sender;
@end

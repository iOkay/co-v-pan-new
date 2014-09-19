//
//  ASReaderViewController.h
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-9-15.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASScanViewController.h"
#import "ASScanViewDelegate.h"

@class ASFileEx;
@interface ASReaderViewController : ASScanViewController
<UIWebViewDelegate, UIGestureRecognizerDelegate>
{
@private    
    //webView for content display
    UIWebView *displayView;
    
    //file path
    //NSString *filePath;
	ASFileEx *file;
    
    //
    UIButton *button;
}

@property (nonatomic, retain) IBOutlet UIButton *button;
@property (nonatomic, retain) IBOutlet UIWebView *displayView;
@property (nonatomic, retain) ASFileEx *file;//NSString *filePath;

//- (IBAction) buttonTapped:(id)sender;

-(void)loadFile: (NSString*)aPath;
-(void) printPressed:(id)sender;

@end

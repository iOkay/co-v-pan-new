//
//  ASHelpViewController.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-19.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASServerInfo;

@interface ASHelpViewController : UIViewController <UIWebViewDelegate>
{
@private


    UIWebView * webView;
}

@property (nonatomic, retain) IBOutlet UIWebView * webView;

- (void) loadHtmlFile;
@end

//------------------------------------------------------------------------------
//  Filename:       ASWebViewController.h
//  Project:        NSWebView
//  Author:         xiu
//  Date:           11-10-24 : last edited by xiu
//  Version:        1.0
//  Copyright       2011年 __AlphaStudio__. All rights reserved.
//------1-----------------------------------------------------------------------
//  Quote the standard library header files.

#import <UIKit/UIKit.h>
#include "ASBookmarkViewController.h"
#include "ASDownLoadViewController.h"
#import "ASIWebPageRequest.h"
#import "ASIDownloadCache.h"
#import "ASWebView.h"

@interface ASWebViewController : UIViewController
<UIWebViewDelegate,UIActionSheetDelegate,
UIWebViewDelegate,ASBookmarkDelegate,
ASIHTTPRequestDelegate,ASIProgressDelegate,
ASWebViewDelegate>
{
@private
    IBOutlet ASWebView* webView;
    IBOutlet UITextField* textField;
//    IBOutlet UIToolbar* toolbar;
    IBOutlet UIToolbar* topToolBar;
    IBOutlet UIBarButtonItem* goBackBarButton;
    IBOutlet UIBarButtonItem* goForwardBarButton;
    IBOutlet UIWindow* window;
    ASBookmarkViewController* bookmarkController;
    UITapGestureRecognizer* tap;
    
    /*
    ASIWebPageRequest *webPageRequest;
    NSMutableArray *requestInProgress;
     */
    UIView *progressView;
    float progress;
}

@property (nonatomic, retain) ASWebView* webView;
@property (nonatomic) float progress;
/*
@property (nonatomic, retain) ASIWebPageRequest* webPageRequest;
@property (nonatomic, retain) NSMutableArray* requestInProgress;
 */

-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)addBookMarkButtonClick:(id)sender;
-(IBAction)mainPageButtonClick:(id)sender;
-(IBAction)downLoadListButtonClick:(id)sender;

@end

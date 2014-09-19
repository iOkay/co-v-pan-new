        //------------------------------------------------------------------------------
//  Filename:          ASWebViewController.m
//  Project:           NSWebView
//  Author:            xiu
//  Date:              11-10-24 : last edited by xiu
//  Version:           1.0
//  Copyright:         2011年 __AlphaStudio__. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).


#import <QuartzCore/QuartzCore.h>
#import "ASWebViewController.h"
#import "ASLocalDefine.h"
#import "ASWebViewModel.h"
#import "ASBookmark.h"
#import "WebViewAdditions.h"
#import "ASPathManager.h"
#import "PrintPhotoPageRenderer.h"


@interface ASWebViewController(hidden)

-(void)leftButtonClick:(id)sender;
-(void)rightButtonClick:(id)sender;
-(void)addBookMark:(id)sender;
-(void)saveCurrentPage:(id)sender;
-(void)print:(id)sender;
-(void)selectedBookmark:(NSString*)notification;
-(void)webViewLoadData:(NSURL*)aUrl;
-(void)wantDownLoad:(id)sender;
-(void)contextualMenuAction:(NSNotification*)notification;
-(NSString *)dataFilePath;
@end


@implementation ASWebViewController

@synthesize webView;
@synthesize progress;
/*
@synthesize webPageRequest;
@synthesize requestInProgress;
 */

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)dealloc
{
    [goBackBarButton release];
    [goForwardBarButton release];
    
    [super dealloc];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - View lifecycle

- (void) formatToolBarOfWebView
{
    [self.navigationController setToolbarHidden:NO];
    
    UIButton *btnBookMark = [[UIButton alloc] init];
    [btnBookMark setImage:[UIImage imageNamed:@"addBookMark.png"]
                 forState:UIControlStateNormal];
    [btnBookMark addTarget:self action:@selector(addBookMarkButtonClick:) 
          forControlEvents:UIControlEventTouchUpInside];
    [btnBookMark setFrame:CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *addBookMark = [[UIBarButtonItem alloc] 
                                    initWithCustomView:btnBookMark];
    
    UIButton *btnTransfers = [[UIButton alloc] init];
    [btnTransfers setImage:[UIImage imageNamed:@"transfers.png"]
                  forState:UIControlStateNormal];
    [btnTransfers addTarget:self action:@selector(downLoadListButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnTransfers setFrame:CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *transfers = [[UIBarButtonItem alloc] 
                                  initWithCustomView:btnTransfers];
    
    UIButton *btnGoBack = [[UIButton alloc] init];
    [btnGoBack setImage:[UIImage imageNamed:@"goBack.png"]
               forState:UIControlStateNormal];
    [btnGoBack addTarget:self.webView action:@selector(goBack)
        forControlEvents:UIControlEventTouchUpInside];
    [btnGoBack setFrame:CGRectMake(0, 0, 30, 30)];
    goBackBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnGoBack];
    
    UIButton *btnGoForward = [[UIButton alloc] init];
    [btnGoForward setImage:[UIImage imageNamed:@"goForward.png"]
                  forState:UIControlStateNormal];
    [btnGoForward addTarget:self.webView action:@selector(goForward)
           forControlEvents:UIControlEventTouchUpInside];
    [btnGoForward setFrame:CGRectMake(0, 0, 30, 30)];
    goForwardBarButton = [[UIBarButtonItem alloc] initWithCustomView:btnGoForward];
    
    UIButton *btnHome = [[UIButton alloc] init];
    [btnHome setImage:[UIImage imageNamed:@"home.png"]
             forState:UIControlStateNormal];
    [btnHome addTarget:self action:@selector(mainPageButtonClick:)
      forControlEvents:UIControlEventTouchUpInside];
    [btnHome setFrame:CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *home = [[UIBarButtonItem alloc] 
                             initWithCustomView:btnHome];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:addBookMark];
    [array addObject:space];
    [array addObject:transfers];
    [array addObject:space];
    [array addObject:goBackBarButton];
    [array addObject:space];
    [array addObject:goForwardBarButton];
    [array addObject:space];
    [array addObject:home];
    
    [self setToolbarItems:array animated:YES];
    
    [btnBookMark release];
    [btnTransfers release];
    [btnGoForward release];
    [btnGoBack release];
    [btnHome release];
    
    [addBookMark release];
    [transfers release];
    [home release];
    [space release];
    
    [array release];
    
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    localChose = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.title = KWEBVIEWTITTLE;
    
    //[window makeKeyAndVisible];
//    if (self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
//    {
//        toolbar.frame = CGRectMake(0, 372, 320, 44);
//    }
//    else
//    {
//        toolbar.frame = CGRectMake(0, 236, 480, 32);
//        
//    }
//    toolbar.tintColor = [UIColor blackColor];
    topToolBar.tintColor = [UIColor blackColor];
    
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    NSURL* baidu = [[NSURL alloc]initWithString:@"http://www.apple.com"];
    [self webViewLoadData:baidu];
    [baidu release];
    
    
    UIButton* bookMarkBtn = [[UIButton alloc]init];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    textField.leftView = bookMarkBtn;
    bookMarkBtn.frame = CGRectMake(0, 0, 30, 30);
    UIImage* image = [UIImage imageNamed:@"bookmark.png"];
    [bookMarkBtn setBackgroundImage:image forState:UIControlStateNormal];
    [bookMarkBtn addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bookMarkBtn release];
    
    
    
    UIButton* refreshBtn = [[UIButton alloc]init];
    refreshBtn.frame = CGRectMake(0, 0, 30, 30);
    UIImage* rightImage = [UIImage imageNamed:@"reloadWeb.png"];
    [refreshBtn setBackgroundImage:rightImage forState:UIControlStateNormal];
    [refreshBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    textField.rightViewMode = UITextFieldViewModeUnlessEditing;
    textField.rightView = refreshBtn;
    [refreshBtn release];
    
    
    progressView = [[UIView alloc] init];
    progressView.frame = CGRectMake(textField.frame.origin.x,
                                textField.frame.origin.y,
                                0, textField.frame.size.height);
    progressView.backgroundColor = [UIColor greenColor];
    progressView.alpha = 0.3;
    progressView.userInteractionEnabled = NO;
    progressView.hidden = YES;
    [self.view addSubview: progressView];
    [self.view bringSubviewToFront: progressView];
    
    webView.ASDelegate = self;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)viewDidUnload
{
    [bookmarkController release];
    bookmarkController = nil;
    [tap release];
    tap = nil;
    [super viewDidUnload];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self 
                                            selector:@selector(contextualMenuAction:) 
                                                name:@"TapAndHoldNotification" 
                                              object:nil];
   /* if (self.interfaceOrientation==UIInterfaceOrientationPortrait||
        self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {
        if (localChose) 
            toolbar.frame = CGRectMake(0, 416, 320, 44);
        else
            toolbar.frame = CGRectMake(0, 372, 320, 44);
    }
    else
    {
        if (localChose) 
            toolbar.frame = CGRectMake(0, 268, 480, 32);
        else
            toolbar.frame = CGRectMake(0, 236, 480, 32);
        
        
    }*/
    [self formatToolBarOfWebView];
    localChose = YES;
    progress = 0;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated
{
//    self.navigationController.navigationBarHidden = NO;
    [super viewDidDisappear:animated];
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------s
-(void)leftButtonClick:(id)sender
{
//    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"hello" message:@"left 被点击！！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [alert show];
//    [alert release];
    
    if (bookmarkController == nil) 
    {
        bookmarkController = [[ASBookmarkViewController alloc]init];
        bookmarkController.delegate = self;
    }
    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 1.0;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//    transition.type =@"";
//    //    ////@"cube" @"moveIn" @"reveal" @"fade"(default) @"pageCurl" @"pageUnCurl" @"suckEffect" @"rippleEffect" @"oglFlip" @“twist”
//    //transition.subtype = kCATransitionFromBottom;
//    transition.delegate = self;
    
    
       // [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    [self.navigationController pushViewController:bookmarkController animated:YES];
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)rightButtonClick:(id)sender
{
    [webView reload];
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
    
    if (textField.text != @"") 
    {
        NSString* urlString = [NSString stringWithString:textField.text];
        NSRange range = [urlString rangeOfString:@"http://"];
        
        NSURL* url;
        if (range.location == NSNotFound) 
        {
           url = [[NSURL alloc]initWithString:[@"http://" stringByAppendingString:urlString]];
        }
        else
        {
            url = [[NSURL alloc]initWithString:urlString];
        }
        [self webViewLoadData:url];
        [url release];
    }
}


#pragma mark -
#pragma mark toolbar button function
//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(IBAction)addBookMarkButtonClick:(id)sender
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"" 
        delegate:self cancelButtonTitle:KACTIONSHEETCANCELTITLE
        destructiveButtonTitle:nil
        otherButtonTitles:KACTIONSHEETADDBOOKMARKTITLE ,KACTIONSHEETSAVECURRETPAGETITLE ,KACTIONSHEETPRINTTITLE, nil];
    [actionSheet showFromToolbar:self.navigationController.toolbar];
    [actionSheet release];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(IBAction)mainPageButtonClick:(id)sender
{
//    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"hello"
//        message:@"返回主界面的按钮被点击！！" delegate:self
//        cancelButtonTitle:@"OK" 
//        otherButtonTitles:nil];
//    [alert show];
//    [alert release];
    [webView stopLoading];
    [self.navigationController popViewControllerAnimated:YES];
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(IBAction)downLoadListButtonClick:(id)sender
{
   
    ASDownLoadViewController* downLoadViewController = [[ASDownLoadViewController alloc]initWithNibName:@"ASDownLoadViewController" bundle:nil];
    [self.navigationController pushViewController:downLoadViewController animated:YES];
    [downLoadViewController release];
    
}



#pragma mark -
#pragma actionSheet delegate
//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* tittle = [actionSheet buttonTitleAtIndex:0];
    if ([tittle isEqualToString:KACTIONSHEETADDBOOKMARKTITLE]) {
        switch (buttonIndex) 
        {
            case 0:
                [self performSelector:@selector(addBookMark:)];
                break;
            case 1:
                [self performSelector:@selector(saveCurrentPage:)];
                break;
            case 2:
                [self performSelector:@selector(print:)];
                break;
            default:
                break;
        }
    }
    else
    {
        NSString* buttonTittle = [actionSheet buttonTitleAtIndex:buttonIndex];
        if ([buttonTittle isEqualToString:KWEBSHEETSAVEPICTURE] || [buttonTittle isEqualToString:KWEBSHEETDOWNLOADLINK]) {
            
    
            ASDownLoadViewController* downLoadViewController = [[ASDownLoadViewController alloc]initWithNibName:@"ASDownLoadViewController" bundle:nil];
            NSURL* url = [[NSURL alloc]initWithString:actionSheet.title];
            [self.navigationController pushViewController:downLoadViewController animated:YES];
            [downLoadViewController addTestUrl:url]; 
            [url release];
            [downLoadViewController release];
        }
        else if([buttonTittle isEqualToString:KWEBSHEETOPENLINK])
        {
            NSURL* url = [[NSURL alloc]initWithString:actionSheet.title];
            NSURLRequest* request = [[NSURLRequest alloc]initWithURL:url];
            [webView loadRequest:request];
            [url release];
            [request release];
            
        }
        else if([buttonTittle isEqualToString:KWEBSHEETSAVEBOOKMARK])
        {
            [self performSelector:@selector(addBookMark:)];   
        }
    }
    
    
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)addBookMark:(id)sender
{
    ASWebViewModel* model = (ASWebViewModel*)[ASWebViewModel single];
    ASBookmark* aBookmark = [[ASBookmark alloc]init];
    aBookmark.name = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    aBookmark.urlString = [webView.request URL].absoluteString;
    NSLog(@"%@",[webView.request URL].absoluteString);
    
    
    [model addBookmark:aBookmark];
    [aBookmark release];
    [model saveToFile];

}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)saveMentionShow:(NSString *)mentionString
{
	UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:mentionString message:nil  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
    [alterview release];
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)saveCurrentPage:(id)sender
{
//    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"hello" 
//                                                   message:@"保存界面被点击！！" delegate:self cancelButtonTitle:@"OK" 
//                                         otherButtonTitles:nil];
//    [alert show];
//    [alert release];
    
    NSURL *url = [webView.request URL];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request startSynchronous];
	NSData *response = [request responseData];
	NSLog(@"%@",response);
	//get data from plist;
	
	NSFileManager *fm = [NSFileManager defaultManager];

    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	NSString *str = [[[ASPathManager single]webDocumentPath]stringByAppendingPathComponent:theTitle];
    NSMutableString *str1 = [[NSMutableString alloc]init];
    [str1 appendString:str];
    [str1 appendString:@".html"];
   // NSString *savePath = [[NSString alloc] initWithFormat:@"%@.html",str];
    
    //    if()
    //    {
    if([fm createFileAtPath:str1 contents:response attributes:nil])
    {
        [self saveMentionShow:@"Save successfully!"];
    }
    else {
        [self saveMentionShow:@"Save Unsuccessfully!"];
    }
    
    [str1 release];
    //   }

    
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)print:(id)sender
{
    UIPrintInteractionController *controller = [UIPrintInteractionController
                                                sharedPrintController]; 
    if(!controller){
        NSLog(@"Couldn't get shared UIPrintInteractionController!"); 
        return;
    } 
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error){
            if(!completed && error){
                NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
            }
    };
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = [textField text];
    printInfo.duplex = UIPrintInfoDuplexLongEdge; 
    controller.printInfo = printInfo; 
    controller.showsPageRange = YES;
    
    UIViewPrintFormatter *viewFormatter = [self.webView viewPrintFormatter];
    viewFormatter.startPage = 0; 
    controller.printFormatter = viewFormatter;
    
    [controller presentAnimated:YES completionHandler:completionHandler];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)selectedBookmark:(NSString*)urlString
{
    NSURL* url = [[NSURL alloc]initWithString:urlString];
    [self webViewLoadData:url];
    [url release];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)webViewLoadData:(NSURL*)aUrl
{
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:aUrl];
    [webView loadRequest:request];
    [request release];
}

/*
#pragma mark -
#pragma mark WebPage
-(void)fetchURL: (NSURL*)url
{
    self.requestInProgress = [NSMutableArray array];
    
    webPageRequest.delegate = nil;
    [webPageRequest cancel];
    self.webPageRequest = [ASIWebPageRequest requestWithURL: url];
    
    [webPageRequest setDidFailSelector: @selector(webPageFetchFailed:)];
    [webPageRequest setDidFinishSelector: @selector(webPageFetchSucceeded:)];
    webPageRequest.delegate = self;
    webPageRequest.downloadProgressDelegate = self;
    webPageRequest.urlReplacementMode = ASIReplaceExternalResourcesWithData;
    
    webPageRequest.downloadCache = [ASIDownloadCache sharedCache];
    webPageRequest.cachePolicy = ASIOnlyLoadIfNotCachedCachePolicy;
    
    webPageRequest.downloadDestinationPath = 
    [[ASIDownloadCache sharedCache] 
     pathToStoreCachedResponseDataForRequest: webPageRequest];
    [[ASIDownloadCache sharedCache] setShouldRespectCacheControlHeaders: NO];
    
    [webPageRequest startAsynchronous];
}

-(void)webPageFetchFailed: (ASIHTTPRequest*)theRequest
{
    //?
    NSString *title = kMessage;
    NSString *cancel = kCancel;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: 
                          [NSString stringWithFormat: @"%@", theRequest.error]
                                                   delegate: nil
                                          cancelButtonTitle: cancel
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}

-(void)webPageFetchSucceeded: (ASIHTTPRequest*)theRequest
{
    NSURL *baseURL = [theRequest url];
    
	if ([theRequest downloadDestinationPath]) {
		NSString *response = [NSString stringWithContentsOfFile:[theRequest downloadDestinationPath] encoding:[theRequest responseEncoding] error:nil];
		[webView loadHTMLString:response baseURL:baseURL];
	} else {
		[webView loadHTMLString:[theRequest responseString] baseURL:baseURL];
	}
}
 
#pragma mark -
#pragma mark ASIHttpRequestDelegate and ASIProgressDelegate Methods
- (void)requestStarted:(ASIWebPageRequest *)theRequest
{
	[self.requestInProgress addObject:theRequest];
    progressView.hidden = NO;
}

- (void)requestFinished:(ASIWebPageRequest *)theRequest
{
	if (![self.requestInProgress containsObject:theRequest])
    {
		[self.requestInProgress addObject:theRequest];
	}
}

- (void)request:(ASIHTTPRequest *)theRequest didReceiveBytes:(long long)newLength
{
    long long webMaxSize = 0;
    long long webDownloadSize = 0;
    for (ASIHTTPRequest *obj in self.requestInProgress)
    {
        webMaxSize += [obj contentLength]+[obj partialDownloadSize];
        webDownloadSize += [obj totalBytesRead];
    }
    float progress = webDownloadSize*1.0/webMaxSize*1.0;
    
    progressView.frame = CGRectMake(textField.frame.origin.x,
                                    textField.frame.origin.y,
                                    textField.frame.size.width*progress,
                                    textField.frame.size.height);
}

- (void)request:(ASIHTTPRequest *)theRequest incrementDownloadSizeBy:(long long)newLength
{
	[self request:theRequest didReceiveBytes:0];
}
*/
 
#pragma mark -
#pragma mark webView delegate
//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)webViewDidStartLoad:(UIWebView *)aWebView
{
    progressView.hidden = NO;
    goForwardBarButton.enabled = aWebView.canGoForward;
    goBackBarButton.enabled = aWebView.canGoBack;
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    NSURL* url = [[aWebView request] URL];
    textField.text = [url absoluteString];
    progressView.hidden = YES;
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
    goForwardBarButton.enabled = aWebView.canGoForward;
    goBackBarButton.enabled = aWebView.canGoBack;
}




//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL* url = [request URL];
    if (![[url absoluteString] hasPrefix: @"about"])
    {
        textField.text = [url absoluteString];
    }
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked || UIWebViewNavigationTypeOther == navigationType) 
    {
        progressView.hidden = NO;
        progressView.layer.cornerRadius = 7;
        progressView.layer.masksToBounds = YES;
		progressView.frame = CGRectMake(textField.frame.origin.x,
                                        textField.frame.origin.y,
                                        textField.frame.size.width*0.1,
                                        textField.frame.size.height);
	}
     
    
    return  YES;
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)webView:(UIWebView *)theWebView didFailLoadWithError:(NSError *)error
{
    //NSErrorFailingURLKey 
    //NSErrorFailingURLStringKey 
    // code = 102;
    
    progressView.hidden = YES;
    
    if ([error code] == 102)
    {
        
        /*
         *弹出列表确定是否下载
         *
         *
         */
        
        UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:[[error userInfo] valueForKey:@"NSErrorFailingURLStringKey" ] 
                                                          delegate:self
                                                 cancelButtonTitle:KWEBSHEETCENCELTITTLE
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles: KWEBSHEETDOWNLOADLINK,nil];
        [sheet showInView:webView];
        [sheet release];
        
    }
    
    
    NSLog(@"%@",[error userInfo] );

}


////------------------------------------------------------------------------
////------------------------------------------------------------------------
//-(void)handTap:(UITapGestureRecognizer *)sender
//{
//    int scrollPositionY = [[webView stringByEvaluatingJavaScriptFromString:@"window.pageYOffset"] intValue];  
//    int scrollPositionX = [[webView stringByEvaluatingJavaScriptFromString:@"window.pageXOffset"] intValue];  
//    
//    int displayWidth = [[webView stringByEvaluatingJavaScriptFromString:@"window.outerWidth"] intValue];  
//    CGFloat scale = webView.frame.size.width / displayWidth;  
//    
//    CGPoint pt = [sender locationInView:webView];  
//    pt.x *= scale;  
//    pt.y *= scale;  
//    pt.x += scrollPositionX;  
//    pt.y += scrollPositionY;  
//    
//    NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", pt.x, pt.y];  
//    NSString * tagName = [webView stringByEvaluatingJavaScriptFromString:js];  
//    if ([tagName isEqualToString:@"IMG"]) 
//    {  
//        NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];  
//        NSString *urlToSave = [webView stringByEvaluatingJavaScriptFromString:imgURL];  
//        if (downLoadViewController == nil) 
//        {
//            downLoadViewController = [[ASDownLoadViewController alloc]initWithNibName:@"ASDownLoadViewController" bundle:nil];
//            
//        }
//        
//        
//        NSURL* url = [[NSURL alloc]initWithString:urlToSave];
//        [self.navigationController pushViewController:downLoadViewController animated:YES];
//        [downLoadViewController addTestUrl:url]; 
//        [url release];
//    } 
//}


#pragma mark -
#pragma mark uiwindow  notification
//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)openContextualMenuAt:(CGPoint)pt
{
	// Load the JavaScript code from the Resources and inject it into the web page

	
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JSTools" ofType:@"js"];
	NSLog(@"%@",path);
	
	NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
	NSLog(@"%@!!",jsCode);
	[webView stringByEvaluatingJavaScriptFromString: jsCode];
	
	
	
	
	// get the Tags at the touch location
	NSString *tags = [NSString stringWithString:[webView stringByEvaluatingJavaScriptFromString:
                                                 [NSString stringWithFormat:@"MyAppGetHTMLElementsAtPoint(%i,%i);",(NSInteger)pt.x,(NSInteger)pt.y]]];
	
	
	NSLog(@"%@,%d,%d~~~~~~~~",tags,(NSInteger)pt.x,(NSInteger)pt.y);
	
	// create the UIActionSheet and populate it with buttons related to the tags
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Contextual Menu"
													   delegate:self cancelButtonTitle:KWEBSHEETCENCELTITTLE
										 destructiveButtonTitle:nil otherButtonTitles:nil];
	
	// If a link was touched, add link-related buttons
	if ([tags rangeOfString:@",A,"].location != NSNotFound) {
		[sheet addButtonWithTitle:KWEBSHEETOPENLINK];
		[sheet addButtonWithTitle:KWEBSHEETDOWNLOADLINK];
        NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).href", pt.x, pt.y];  
        NSString *urlToSave = [webView stringByEvaluatingJavaScriptFromString:imgURL];
        NSArray* array =  [urlToSave componentsSeparatedByString:@"http://"];
        NSString* fileUrl = [ @"http://" stringByAppendingString:[array lastObject]];
        sheet.title  = fileUrl;
	}
	// If an image was touched, add image-related buttons
	if ([tags rangeOfString:@",IMG,"].location != NSNotFound || [tags rangeOfString:@",img,"].location != NSNotFound) {
		[sheet addButtonWithTitle:KWEBSHEETSAVEPICTURE];
        NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];  
        NSString *urlToSave = [webView stringByEvaluatingJavaScriptFromString:imgURL];
        NSArray* array =  [urlToSave componentsSeparatedByString:@"http://"];
        NSString* fileUrl = [ @"http://" stringByAppendingString:[array lastObject]];
        sheet.title  = fileUrl;
	}
	// Add buttons which should be always available
	[sheet addButtonWithTitle:KWEBSHEETSAVEBOOKMARK];
	
	[sheet showInView:webView];
	[sheet release];
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)contextualMenuAction:(NSNotification*)notification
{
	CGPoint pt;
	NSDictionary *coord = [notification object];
	pt.x = [[coord objectForKey:@"x"] floatValue];
	pt.y = [[coord objectForKey:@"y"] floatValue];
	
	// convert point from window to view coordinate system
	pt = [webView convertPoint:pt fromView:nil];
	
	// convert point from view to HTML coordinate system
	CGPoint offset  = [webView scrollOffset];
	CGSize viewSize = [webView frame].size;
	CGSize windowSize = [webView windowSize];
	
	CGFloat f = windowSize.width / viewSize.width;
	pt.x = pt.x * f + offset.x;
	pt.y = pt.y * f + offset.y;
	
	[self openContextualMenuAt:pt];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory ;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
   /* if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {
        toolbar.frame = CGRectMake(0, 416, 320, 44);
    }
    else
    {
        toolbar.frame = CGRectMake(0, 268, 480, 32);
        
    }*/
    self.navigationController.navigationBar.hidden = YES;
    
    progressView.frame = CGRectMake(textField.frame.origin.x,
                                    textField.frame.origin.y,
                                    textField.frame.size.width*progress,
                                    textField.frame.size.height);
}

#pragma mark -
#pragma mark ASWebViewDelegate
- (void)webView:(ASWebView *)webView updateStatus:(NSInteger)totalRequest requestLoaded:(NSInteger)loadedRequest startLoadTime:(NSTimeInterval)startTime
{
    if(totalRequest*loadedRequest != 0)
    {
        progress = loadedRequest*1.0/totalRequest;
        if (1 >= progress)
        {
            progressView.frame = CGRectMake(textField.frame.origin.x,
                                            textField.frame.origin.y,
                                            textField.frame.size.width*progress,
                                            textField.frame.size.height);
        }
    }
}

@end
//
//  ASEmbedReaderViewController.m
//  ASVirtualHardDisk
//
//  Created by 刘 殿章 on 11-11-25.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASEmbedReaderViewController.h"
#import "ASWebViewController.h"
#import "ASLocalDefine.h"
#import "ASDownLoadViewController.h"

@implementation ASEmbedReaderViewController

@synthesize readerView, resultText,gotoButton;


-(IBAction)gotoTheAddress:(id)sender
{
    
    NSURL* address = [[NSURL alloc]initWithString:resultText.text];
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:address];
    
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:address];
    [req startSynchronous];
    NSString *contentType = [[req responseHeaders] objectForKey:@"content-type"];
    NSArray *contentTypeArray = [contentType componentsSeparatedByString:@";"];
    NSString *contentTypeString = [contentTypeArray objectAtIndex:0];
    if (([contentTypeString isEqualToString:@"text/html"]==YES)||([contentTypeString isEqualToString:@"text/css"]==YES)) {
        ASWebViewController *webViewController = [[ASWebViewController alloc]initWithNibName:@"ASWebViewController" bundle:nil];
        [self.navigationController pushViewController:webViewController animated:YES];
        [webViewController.webView loadRequest:request];
        [webViewController release];
    }
    else
    {
        ASDownLoadViewController *downLoadViewController = [[ASDownLoadViewController alloc]initWithNibName:@"ASDownLoadViewController" bundle:nil];
        [downLoadViewController addTestUrl:address];
        [self.navigationController pushViewController:downLoadViewController animated:YES];
        [downLoadViewController release];
    }
    
  
    
    [address release];
    [request release];
    
}

- (void) cleanup
{
    [cameraSim release];
    cameraSim = nil;
    readerView.readerDelegate = nil;
    [readerView release];
    readerView = nil;
    [resultText release];
    resultText = nil;
}

- (void) dealloc
{
    [self cleanup];
    [super dealloc];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    // the delegate receives decode results
    readerView.readerDelegate = self;
    resultText.text = NSLocalizedString(KResultText,nil);
    // you can use this to support the simulator
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        cameraSim.readerView = readerView;
    }
    [gotoButton setTitle:NSLocalizedString(KGotoButton,nil) forState:UIControlStateNormal];
    gotoButton.hidden = YES;
}

- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    // auto-rotation is supported
    return(YES);
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // compensate for view rotation so camera preview is not rotated
    [readerView willRotateToInterfaceOrientation: orient
                                        duration: duration];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    
    [readerView willRotateToInterfaceOrientation:self.interfaceOrientation
                                        duration:0.1f];
}

- (void) viewDidAppear: (BOOL) animated
{
    // run the reader when the view is visible
    [readerView start];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [readerView stop];
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        resultText.text = sym.data;
        break;
    }
    const char *first = [resultText.text UTF8String];
    if ((48<= *first)&&(*first<=57)) {
        gotoButton.hidden = YES;
    }
    else
    {
        gotoButton.hidden = NO;
    }
}

@end


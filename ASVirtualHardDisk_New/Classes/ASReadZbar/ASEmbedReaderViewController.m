//
//  ASEmbedReaderViewController.m
//  ASVirtualHardDisk
//
//  Created by 刘 殿章 on 11-11-25.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASEmbedReaderViewController.h"
#import "ASWebViewController.h"
#import "ASDeclare.h"
#import "ASDownLoadViewController.h"
#import "ASLocalDefine.h"

@implementation ASEmbedReaderViewController

@synthesize readerView, resultText;

-(IBAction)gotoTheAddress:(id)sender
{
    
    NSURL* address = [[NSURL alloc]initWithString:resultText.text];
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:address];
    NSLog(@"URL -- %@",address);
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:address];
    [req startSynchronous];
    req.delegate = self;
    NSLog(@"responderHeader -- %@",[req responseHeaders]);
    NSString *contentType = [[req responseHeaders] objectForKey:@"Content-Type"];
    NSArray *contentTypeArray = [contentType componentsSeparatedByString:@";"];
    NSString *contentTypeString = [contentTypeArray objectAtIndex:0];
    if ([contentTypeString isEqualToString:@"text/html"]==YES||
        [contentTypeString isEqualToString:@"text/plain"]==YES||
        [contentTypeString isEqualToString:@"text/richtext"]==YES||
        [contentTypeString isEqualToString:@"text/x-setext"]==YES||
        [contentTypeString isEqualToString:@"text/enriched"]==YES||
        [contentTypeString isEqualToString:@"text/tab-separated-values"]==YES||
        [contentTypeString isEqualToString:@"text/sgml"]==YES||
        [contentTypeString isEqualToString:@"text/x-speech"]==YES||
        [contentTypeString isEqualToString:@"text/css"]==YES||
        [contentTypeString isEqualToString:@"application/dsssl"]==YES) {
        ASWebViewController *webViewController = [[ASWebViewController alloc]initWithNibName:@"ASWebViewController" bundle:nil];
        [self.navigationController pushViewController:webViewController animated:YES];
        [webViewController.webView loadRequest:request];
        [webViewController release];
    } else {
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
    
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        cameraSim.readerView = readerView;
    }
}

- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return NO;
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    [readerView willRotateToInterfaceOrientation: orient
                                        duration: duration];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    readerView.readerDelegate = self;
    resultText.text = [[ASDeclare singletonASDeclare] zbarResult];
    [self.navigationController setToolbarHidden:YES];
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
    printf("first -- %s\n",first);
    printf("*first -- %c\n",*first);
    NSString *str = [[[resultText.text componentsSeparatedByString:@"/"] 
                      objectAtIndex:0] lowercaseString];        
    
    if([str isEqualToString:@"http:"] ||
       [str isEqualToString:@"https:"] ||
       [str isEqualToString:@"file:"] ||
       [str isEqualToString:@"ftp:"])
    {
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(KGotoButton,nil) style: UIBarButtonItemStyleBordered target:self action:@selector(gotoTheAddress:)];
        [self.navigationItem setRightBarButtonItem: doneItem];
        [doneItem release];
    }
    else
    {
        [self.navigationItem setRightBarButtonItem: nil];
    }
}

@end


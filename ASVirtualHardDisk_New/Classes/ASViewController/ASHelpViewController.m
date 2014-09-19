//
//  ASHelpViewController.m
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-19.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import "ASHelpViewController.h"
#import "NetworkController.h"
#import "ASLocalDefine.h"
#import "ASServerInfo.h"
#import "ASNetWorkCheck.h"

@implementation ASHelpViewController

@synthesize webView;

//------------------------------------------------------------------------------
// - (void)loadHtmlFile
//------------------------------------------------------------------------------
- (void)loadHtmlFile
{
    NSString *Path = nil;
    
    if (chose == 0) {
        Path = [[NSBundle mainBundle] pathForResource:NSLocalizedString(@"IntroductionText", nil) ofType:nil];           
    }
    else if(chose == 1)
    {
        Path = [[NSBundle mainBundle] pathForResource:NSLocalizedString(@"TipsText", nil) ofType:nil];
    }
    else if(chose == 2)
    {
        Path = [[NSBundle mainBundle] pathForResource:NSLocalizedString(@"ConnectingText", nil) ofType:nil];
    }
    else if(chose == 3)
    {
        Path = [[NSBundle mainBundle] pathForResource:NSLocalizedString(@"MacText", nil) ofType:nil];
    }
    else
    {
        Path = [[NSBundle mainBundle] pathForResource:NSLocalizedString(@"WindowsText", nil) ofType:nil];
    }
    NSURL* address = [[NSURL alloc] initFileURLWithPath:Path];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:address];
   
    [webView loadRequest:request]; 
    

    [address release];
    [request release];
}

//------------------------------------------------------------------------------
// - (void)viewDidLoad 
//------------------------------------------------------------------------------
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationController.navigationBar.hidden = NO;
    webView.delegate = self;
    
    [self loadHtmlFile];
}

//------------------------------------------------------------------------------
// - (void) viewWillAppear:(BOOL)animated
//------------------------------------------------------------------------------
- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 0.9;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.opaque = NO;
    self.navigationController.navigationBar.translucent = NO;
}

//------------------------------------------------------------------------------
// - (void)didReceiveMemoryWarning
//------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];

}

//------------------------------------------------------------------------------
// - (void)viewDidUnload 
//------------------------------------------------------------------------------
- (void)viewDidUnload 
{
    self.webView = nil;
    [super viewDidUnload];
}

//------------------------------------------------------------------------------
// - (void)dealloc
//------------------------------------------------------------------------------
- (void)dealloc 
{
    [webView release];

    [super dealloc];
}

//------------------------------------------------------------------------------
// - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown||
            interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
            interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


@end

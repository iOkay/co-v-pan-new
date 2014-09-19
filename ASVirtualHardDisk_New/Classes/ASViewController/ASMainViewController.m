//
//  ASMainViewController.m
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-17.
//  Modify by dhc on 11-12-07
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ASMainViewController.h"
#import "NetworkController.h"
#import "FtpServer.h"
#import "ASNetWorkCheck.h"
#import "ASDeclare.h"
#import "ASLocalDefine.h"
#import "ASHelpViewController.h"
#import "ASFileListViewController.h"
#import "ASServerInfo.h"
#import "ASDataObject.h"
#import "ASDataObjectManager.h"
#import "ASDirectoryEx.h"
#import "ASFileEx.h"
#import "ASSectionViewController.h"
#import "ASPreferencesViewController.h"
#import "ASSettingViewController.h"
#import "ASImageResize.h"

static const CGFloat kRightButtonX = 120.0f;

@interface ASMainViewController (private)

/*
    @function   - (void) backButtonTapped
    @abstract   method when back button tapped
                if password is equal to nil, no encrypt is needed
                else encrypt the local files
    @param      no
    @result     void
*/
- (void) backButtonTapped;

@end


@implementation ASMainViewController

@synthesize statusLabel;
@synthesize httpAddressLabel;
@synthesize ftpAddressLabel;
@synthesize touchLabel;
@synthesize settingImage;
@synthesize toOpenServer;
@synthesize contentFTPLabel;
@synthesize contentHTTPLabel;
@synthesize serverLabel;
@synthesize wifiButtonItem;
@synthesize serverView;
@synthesize tapGestureRecognizer;


//------------------------------------------------------------------------------
// - (void) Cartoon
//------------------------------------------------------------------------------
-(void)Cartoon
{
    CATransition *animation = [CATransition  animation]; 
	
    animation.delegate =self; 
	
    animation.duration =0.50f; 
	
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; 
	
    animation.fillMode =kCAFillModeBoth; 
	
    animation.type =kCATransitionFade; 
	
    animation.subtype =kCATransitionFromRight;
	
    [self.view.superview.layer addAnimation:animation forKey:@"animation"]; 
}
#pragma mark -
#pragma viewlifecycle

- (void) fromatToolBar
{
    UIButton *helpButton = [[UIButton alloc] init];
    helpButton.showsTouchWhenHighlighted = YES;
    [helpButton setImage: [UIImage imageNamed: @"help.png"] forState: UIControlStateNormal];
    [helpButton addTarget: self action: @selector(switchToHelp) forControlEvents:UIControlEventTouchUpInside];
    [helpButton setFrame: CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *helpItem = [[UIBarButtonItem alloc] initWithCustomView: helpButton];
    [helpButton release];
    
    UIButton *wifiButton = [[UIButton alloc] init];
    wifiButton.showsTouchWhenHighlighted = YES;
    [wifiButton setImage: [UIImage imageNamed: @"wireless.png"] forState: UIControlStateNormal];
    [wifiButton addTarget: self action: @selector(serverStatus:) forControlEvents:UIControlEventTouchUpInside];

    [wifiButton setFrame: CGRectMake(0, 0, 30, 30)];
    wifiButtonItem = [[UIBarButtonItem alloc] initWithCustomView: wifiButton];
    [wifiButton release];
    
    UIButton *browerButton = [[UIButton alloc] init];
    browerButton.showsTouchWhenHighlighted = YES;
    [browerButton setImage: [UIImage imageNamed: @"explorer.png"] forState: UIControlStateNormal];
    [browerButton addTarget: self action: @selector(showWebMenu:) forControlEvents:UIControlEventTouchUpInside];
    [browerButton setFrame: CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *browerItem = [[UIBarButtonItem alloc] initWithCustomView: browerButton];
    [browerButton release];
    
    UIButton *downloadButton = [[UIButton alloc] init];
    downloadButton.showsTouchWhenHighlighted = YES;
    [downloadButton setImage: [UIImage imageNamed: @"transfers.png"] forState: UIControlStateNormal];
    [downloadButton addTarget: self action: @selector(showDownloadView:) forControlEvents:UIControlEventTouchUpInside];
    [downloadButton setFrame: CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *downloadItem = [[UIBarButtonItem alloc] initWithCustomView: downloadButton];
    [downloadButton release];
    
    UIButton *settingButton = [[UIButton alloc] init];
    settingButton.showsTouchWhenHighlighted = YES;
    [settingButton setImage: [UIImage imageNamed: @"settingIcon.png"] forState: UIControlStateNormal];
    [settingButton addTarget: self action: @selector(showSettingView:) forControlEvents:UIControlEventTouchUpInside];
    [settingButton setFrame: CGRectMake(0, 0, 30, 30)];
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView: settingButton];
    [settingButton release];
    
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:@selector(closeserver:)];
    
 
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject: helpItem];
    [array addObject: space];
    [array addObject: wifiButtonItem];
    [array addObject: space];
    [array addObject: browerItem];
    [array addObject: space];
    [array addObject: downloadItem];
    [array addObject: space];
    [array addObject: settingItem];
    
    [space release];
    
    
    
    [self.navigationController setToolbarHidden:NO];
    [self setToolbarItems:array animated:YES];
    self.navigationController.toolbar.hidden = NO;
    self.navigationController.toolbar.tintColor = [UIColor blackColor];
    self.navigationController.toolbar.alpha = 1.0;
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.opaque = YES;
    self.navigationController.toolbar.translucent = NO;
    
    [helpItem release];
    [browerItem release];
    [downloadItem release];
    [settingItem release];
    [array release];
}

//------------------------------------------------------------------------------
// - (void) addTapGesture
//------------------------------------------------------------------------------
- (void) addTapGesture
{
    if(nil != tapGestureRecognizer)
    {
        [tapGestureRecognizer release];
        tapGestureRecognizer = nil;
    }
    
	tapGestureRecognizer = [[UITapGestureRecognizer alloc] 
                            initWithTarget:self action:@selector(closeserver:)];
    
    
	tapGestureRecognizer.cancelsTouchesInView = NO;
    
    [[[UIApplication sharedApplication] keyWindow]addGestureRecognizer:tapGestureRecognizer];
    
}

//------------------------------------------------------------------------------
// - (void) viewWillAppear:(BOOL)animated;
//------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [tableViewDoc reloadData];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 0.9;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.opaque = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    statusLabel.text = localeString(KStatus);
    httpAddressLabel.text = localeString(kHttpAddress);
    ftpAddressLabel.text = localeString(kFtpAddress);
    touchLabel.text = localeString(kTouch);
    toOpenServer.text = localeString(kToOpenServer);

    [self fromatToolBar];
    [self addTapGesture];
    if(serverInfo.isServerStart == YES)
    {
        //tagLabel.hidden = NO;
        self.serverLabel.text = kServerOn;
        httpAddressLabel.hidden = NO;
        ftpAddressLabel.hidden = NO;
        contentHTTPLabel.hidden = NO;
        contentFTPLabel.hidden = NO;
        touchLabel.hidden = YES;
        settingImage.hidden = YES;
        toOpenServer.hidden = YES;
        NSString *addr = [NetworkController localWifiIPAddress];
        if(![addr isEqualToString:@"error"])
        {
            contentFTPLabel.text = [NSString stringWithFormat:@"ftp://%@:20000", 
                                    addr];
            contentHTTPLabel.text = [NSString stringWithFormat:@"http://%@", 
                                     addr];
        }
        else
        {
            ftpAddressLabel.hidden = YES;
            contentFTPLabel.hidden = YES;
            httpAddressLabel.text = kNoWifi;
            contentHTTPLabel.text = kCheckOut;
        }
        [(UIButton*)(wifiButtonItem.customView) setImage: [UIImage imageNamed:@"wireless.png"] forState: UIControlStateNormal];
    }
    else
    {
        //tagLabel.hidden = YES;
        self.serverLabel.text = kServerOff;
        httpAddressLabel.hidden = YES;
        ftpAddressLabel.hidden = YES;
        contentHTTPLabel.hidden = YES;
        contentFTPLabel.hidden = YES;
        touchLabel.hidden = NO;
        settingImage.hidden = NO;
        toOpenServer.hidden = NO;
        [(UIButton*)(wifiButtonItem.customView) setImage: [UIImage imageNamed:@"wireless_off.png"] forState: UIControlStateNormal];
    }
    
    if([[[UIDevice currentDevice] systemVersion] intValue] < 5)
    {
        if (self.interfaceOrientation==UIInterfaceOrientationPortrait||
            self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
        {
            tableViewDoc.frame = CGRectMake(0, 0, 320, 372);
        }
        else
        {
            tableViewDoc.frame = CGRectMake(0, 0, 480, 236);

        } 
        localChose = NO;
    }
    
}

//------------------------------------------------------------------------------
// - (void) viewDidDisappear:(BOOL)animated;
//------------------------------------------------------------------------------
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

//------------------------------------------------------------------------------
// - (void) didReceiveMemoryWarning;
//------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning 
{
    NSLog(@"%s",__func__);
    [super didReceiveMemoryWarning];
}

//------------------------------------------------------------------------------
// - (void) viewDidUnload;
//------------------------------------------------------------------------------
- (void)viewDidUnload 
{
    //    verifyView = nil;
    self.statusLabel = nil;
    self.httpAddressLabel = nil;
    self.ftpAddressLabel = nil;
    self.contentFTPLabel = nil;
    self.contentHTTPLabel = nil;
    [mainControl release];
    mainControl = nil;
    self.serverLabel = nil;
    [tableViewDoc release];
    tableViewDoc = nil;
    [serverStatusView release];
    serverStatusView = nil;
    [popmenu release];
    popmenu = nil;
    self.wifiButtonItem = nil;
    [serverView release];
    serverView = nil;
    
    [super viewDidUnload];
}

//------------------------------------------------------------------------------
// - (void) viewDidLoad
//------------------------------------------------------------------------------
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
	declare = [ASDeclare singletonASDeclare];
	serverInfo = [ASServerInfo sharedASServerInfo];
    
    self.navigationItem.title = kMainTitle;
    
    serverStatusView.hidden = YES;
    
    canShowServerInfo = YES;
    
    //[self switchToNext];

}

//------------------------------------------------------------------------------
// - (IBAction) switchToNext;
//------------------------------------------------------------------------------
- (IBAction) switchToNext
{//show file list view
	
	NSMutableString *path = [[NSMutableString alloc] 
                             initWithString:NSHomeDirectory()];
    [path appendString:@"/Documents/"];
	
	ASFileListViewController *childController = 
    [[ASFileListViewController alloc] 
     initWithNibName:@"ASFileListViewController"
     bundle:nil];
	
    ASServerInfo *server = [ASServerInfo sharedASServerInfo];
    if ([server.serverName isEqualToString: @""])
    {
        childController.title = kRoot;
    }
    else
    {
        childController.title = server.serverName;
	}
    //	childController.currentPath = path;
    ASDirectoryEx *tmpDirectory = [[ASDirectoryEx alloc] initWithFullPath:@"/"];
    childController.currentDirectory = tmpDirectory;
    [tmpDirectory release];    
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								   initWithTitle: localeString(KDashboard)
								   style:UIBarButtonItemStylePlain
								   target:self
								   action:nil];
	[self.navigationController pushViewController:childController animated:YES];
	self.navigationItem.backBarButtonItem = backButton;
    
    [backButton release];
    [childController release];
	[path release];
}




#pragma mark -
#pragma BottomToolbarItem
//------------------------------------------------------------------------------
// - (IBAction) switchToHelp
//------------------------------------------------------------------------------
- (IBAction) switchToHelp
{
	ASSectionViewController *helpView = [[ASSectionViewController alloc] 
                                      initWithNibName:@"ASSectionViewController"
                                               bundle:nil];
    
    helpView.title = kHelpTitle;
    
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                     initWithTitle: localeString(KDashboard)
                                             style:UIBarButtonItemStylePlain
                                            target:self
                                            action:nil];
	self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:helpView animated:YES];
    [backButton release];
	[helpView release];
}

-(IBAction)closeserver:(id)sender
{

    [self Cartoon];
    
    canShowServerInfo = YES;
    
    if (serverStatusView.hidden == NO)
    {
        [serverStatusView removeFromSuperview];
        serverView.hidden = YES;
        serverStatusView.hidden = YES;
        
        canShowServerInfo = NO;
    }
}


-(IBAction)serverStatus: (id)sender
{
    [self Cartoon];
    
    if (canShowServerInfo == NO)
    {
        canShowServerInfo = YES;
        return;
    }

    if(serverStatusView.hidden == YES)
    {
        [self.view addSubview: serverStatusView];
        [serverStatusView setFrame: CGRectMake(30, 50, 260, 204)];
        serverStatusView.center = CGPointMake(self.view.center.x, self.view.center.y-20);
        //[mainControl setAlpha: 0.05];
        //[mainControl setHidden: NO];
        serverView.hidden = NO;
        serverStatusView.hidden = NO;
        [self.view bringSubviewToFront: serverStatusView];
        [self.view bringSubviewToFront: mainControl];
    }
    else if ([serverStatusView superview])
    {
        [serverStatusView removeFromSuperview];
        serverView.hidden = YES;
        serverStatusView.hidden = YES;
    }
}

-(IBAction)backButtonTapped: (id)sender
{
    if ([serverStatusView superview])
    {
        [serverStatusView removeFromSuperview];
        [mainControl setHidden: YES];
    }
}

-(IBAction)showDownloadView: (id)sender
{
    ASDownLoadViewController* down =  [[ASDownLoadViewController alloc]initWithNibName:@"ASDownLoadViewController" bundle:nil];
    NSString *back = localeString(KDashboard);
    UIBarButtonItem * backButton= [[UIBarButtonItem alloc]initWithTitle:back style:UIBarButtonItemStylePlain
                                                                 target:nil action:nil];
    down.title = localeString(KDownLoadList);
    self.navigationItem.backBarButtonItem = backButton;
    [backButton release];
    [self.navigationController pushViewController:down animated:YES];
    [down release];
}

-(IBAction)showSettingView: (id)sender
{
    //?
    ASSettingViewController* setting =  [[ASSettingViewController alloc]initWithNibName:@"ASSettingViewController" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
    setting.title = localeString(KSetting);
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle: localeString(KCancel) style: UIBarButtonItemStyleBordered target: nil action: nil];
    [self.navigationItem setBackBarButtonItem: backButtonItem];
    [backButtonItem release];

    [setting release];
}

//------------------------------------------------------------------------------
//-(IBAction)showWebMenu:(id)sender
//------------------------------------------------------------------------------
-(IBAction)showWebMenu:(id)sender
{
    if(popmenu)
    {
        [popmenu release];
        popmenu = nil;
    }
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            popmenu = [[ASMenu alloc] initWithPoint:CGPointMake(94,349)
                                      andArrowPoint:CGPointMake(52,75)                      
                                      andDataSource:
                       [ASWebMenuModel sharedASRightMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(0));
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            popmenu = [[ASMenu alloc] initWithPoint:CGPointMake(83,56)
                                      andArrowPoint:CGPointMake(52,75)                                           
                                      andDataSource:
                       [ASWebMenuModel sharedASRightMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
            break;
        case UIInterfaceOrientationLandscapeLeft:
            popmenu = [[ASMenu alloc] initWithPoint:CGPointMake(167,198)
                                      andArrowPoint:CGPointMake(52,75)                                           
                                      andDataSource:
                       [ASWebMenuModel sharedASRightMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
            break;
        case UIInterfaceOrientationLandscapeRight:
            popmenu = [[ASMenu alloc] initWithPoint:CGPointMake(14,205)
                                      andArrowPoint:CGPointMake(52,75)                                           
                                      andDataSource:
                       [ASWebMenuModel sharedASRightMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(90));
            break;
        default:
            break;
    }
    popmenu.delegate = self;
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:popmenu];
    
}

#pragma mark -
#pragma popmenu delegate
- (void) menu:(ASMenu *)menu clickedAtIndex:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [menu.menuView cellForRowAtIndexPath:indexPath];
    NSString *command = cell.textLabel.text;
    NSString *path;
    
    path = [[NSBundle mainBundle] 
            pathForResource:@"ASMainRightMenu" ofType:@"plist"];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSDictionary *commands = [dic objectForKey:@"selectors"];
    NSString *commandSelector = [commands objectForKey:command];
    
    if(commandSelector)
    {
        SEL action = NSSelectorFromString(commandSelector);
        if([self respondsToSelector:action])
        {
            [self performSelector:action withObject:self];
        }
        else
        {
            NSLog(@"DONT UNDERSTAND");
        }
    }
    else
    {
        NSLog(@"DONT UNDERSTAND");
    }
    
    [dic release];
}

-(void)showWebView
{
    ASWebViewController *webView = [[ASWebViewController alloc]
                                    initWithNibName:@"ASWebViewController"
                                    bundle:nil];
    [self.navigationController pushViewController:webView animated:YES];
    [webView release];
}

- (void) scanButtonTapped
{
    
    ASEmbedReaderViewController *results = [[ASEmbedReaderViewController alloc]
        initWithNibName:@"ASEmbedReaderViewController" bundle:nil];
    NSString *back = kNavBack;
    UIBarButtonItem * backButton= [[UIBarButtonItem alloc]
                                   initWithTitle:back 
                                   style:UIBarButtonItemStylePlain
                                   target:self 
                                   action:nil];
    
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController setToolbarHidden:YES];
    [self.navigationController pushViewController:results animated:YES];
    
    [backButton release];
    [results release];
}

//------------------------------------------------------------------------------
// - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


//------------------------------------------------------------------------------
// -(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//------------------------------------------------------------------------------
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	serverStatusView.center = CGPointMake(self.view.center.x, self.view.center.y-20);
    [popmenu removeFromSuperview];
    
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait||
        self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {
        tableViewDoc.frame = CGRectMake(0, 0, 320, 372);
    }
    else
    {
        tableViewDoc.frame = CGRectMake(0, 0, 480, 236);
    }
}

//------------------------------------------------------------------------------
// - (void) dealloc
//------------------------------------------------------------------------------
- (void)dealloc 
{
    [statusLabel release];
    [httpAddressLabel release];
    [ftpAddressLabel release];
    [contentFTPLabel release];
    [contentHTTPLabel release];
    [mainControl release];
    [serverLabel release];
    [tableViewDoc release];
    [serverStatusView release];
    [popmenu release];
    [wifiButtonItem release];
    [serverView release];
    
    [super dealloc];
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    UITableViewCell	*cell = (UITableViewCell *)recognizer.view;
    UIView *selectedView = cell.selectedBackgroundView;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:selectedView cache:YES];
    [selectedView setAlpha:1.0f];
    [selectedView setAlpha:0.3f];
    [selectedView setAlpha:1.0f];
    [UIView commitAnimations];
    
    CGPoint touch = [recognizer locationOfTouch:0 inView:self.view];
    
    //这个坐标要求是相对于window的，上面获取的frame是相对于self.view的，所以加了64
    ASMenu *aPopmenu;
//    ASMenu *aPopmenu = [[ASMenu alloc] initWithPoint:
//                       [ASMainRightMenu pointForMenu:
//                        CGPointMake(kRightButtonX, touch.y+64.0f)] 
//                                      andArrowPoint:
//                       [ASMainRightMenu pointForArrow:CGPointMake(kRightButtonX, touch.y+64.0f)]
//                                      andDataSource:
//                       [ASMainRightMenu sharedASMainRightMenu]];
    
    
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            aPopmenu = [[ASMenu alloc] initWithPoint:
                         [ASMainRightMenu pointForMenuOfPortrait:
                          CGPointMake(kRightButtonX, touch.y+64.0f)] 
                                        andArrowPoint:
                         [ASMainRightMenu pointForArrowOfPortrait:CGPointMake(kRightButtonX, touch.y+64.0f)]
                                        andDataSource:
                         [ASMainRightMenu sharedASMainRightMenu]];
            aPopmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(0));
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            aPopmenu = [[ASMenu alloc] initWithPoint:
                        [ASMainRightMenu pointForMenuOfUpsideDown:
                         CGPointMake(30, 395.0f)] 
                                       andArrowPoint:
                        [ASMainRightMenu pointForArrowOfUpsideDown:CGPointMake(kRightButtonX, touch.y+64.0f)]
                                       andDataSource:
                        [ASMainRightMenu sharedASMainRightMenu]];
            aPopmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
            break;
        case UIInterfaceOrientationLandscapeLeft:
            aPopmenu = [[ASMenu alloc] initWithPoint:
                        [ASMainRightMenu pointForMenuOfLandscapeLeft:
                         CGPointMake(10, 200)] 
                                       andArrowPoint:
                        [ASMainRightMenu pointForArrowOfLandscapeLeft:CGPointMake(kRightButtonX, touch.y+64.0f)]
                                       andDataSource:
                        [ASMainRightMenu sharedASMainRightMenu]];
            aPopmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
            break;
        case UIInterfaceOrientationLandscapeRight:
            aPopmenu = [[ASMenu alloc] initWithPoint:
                        [ASMainRightMenu pointForMenuOfLandscapeRight:
                         CGPointMake(0, 300)] 
                                       andArrowPoint:
                        [ASMainRightMenu pointForArrowOfLandscapeRight:CGPointMake(kRightButtonX, touch.y+64.0f)]
                                       andDataSource:
                        [ASMainRightMenu sharedASMainRightMenu]];
            aPopmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(90));
            break;
        default:
            break;
    }
    aPopmenu.delegate = self;
    popmenu = aPopmenu;
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:aPopmenu];
    //[aPopmenu release];
}

-(void)showPreferencesView
{
    NSLog(@"PreferencesView");
    ASPreferencesViewController *preferencesView = [[ASPreferencesViewController alloc] 
                                         initWithNibName:@"ASPreferencesViewController"
                                         bundle:nil];
    
    preferencesView.title = localeString(KPreferences);
    
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: localeString(KDashboard)
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:nil];
	self.navigationItem.backBarButtonItem = backButton;
	
    [self.navigationController pushViewController:preferencesView animated:YES];
    [self viewDidDisappear:YES];
    [preferencesView viewWillAppear:YES];
    [backButton release];
	[preferencesView release];
}

#pragma mark -
#pragma mark UITableViewDelegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *cellIdentifier = @"DashboardCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier] autorelease];
        UIGestureRecognizer *recognizer;
		recognizer = [[UISwipeGestureRecognizer alloc] 
                      initWithTarget:self 
                      action:@selector(handleSwipeFrom:)];
		[cell addGestureRecognizer:recognizer];
		[recognizer release];
        
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 60.0f)];
        selectedView.alpha = 0.8f;
        selectedView.backgroundColor = [UIColor grayColor];
        cell.selectedBackgroundView = selectedView;
        [selectedView release];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.imageView.image = [UIImage imageNamed:@"home_image.png"];
    
    cell.textLabel.text = [[ASServerInfo sharedASServerInfo] serverName];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    cell.textLabel.textColor = [UIColor blackColor];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if(0 == [indexPath row])
    {
        [self switchToNext];
    }
    
    return ;
}

@end


//
//  ASSettingViewController.m
//  ASVirtualHardDisk
//
//  Created by dhc on 11-12-8.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/NSNotification.h>
#import "ASSettingViewController.h"
#import "ASLocalDefine.h"
#import "ASServerInfo.h"


@implementation ASSettingViewController

@synthesize serverInfo;
@synthesize httpAddress;
@synthesize ftpAddress;
@synthesize contentFTPLabel;
@synthesize contentHTTPLabel;
@synthesize serverLabel;
@synthesize realImgLabel;
@synthesize serverSwitch;
@synthesize realImgSwitch;
@synthesize helpLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    serverInfo = [ASServerInfo sharedASServerInfo];
    serverLabel.text = localeString(KServer);
    realImgLabel.text = localeString(KRealImage);
    httpAddress.text = localeString(kHttpAddress);
    ftpAddress.text = localeString(kFtpAddress);
    
    serverSwitch.on = serverInfo.isServerStart;
    realImgSwitch.on = serverInfo.isRealImage;
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:localeString(kFileListViewDone) style: UIBarButtonItemStyleBordered target:self action:@selector(done:)];
    [self.navigationItem setRightBarButtonItem: doneItem];
    [doneItem release];
}

-(void)reloadServerStatus: (BOOL)isOn
{
    httpAddress.hidden = NO;
    contentFTPLabel.hidden = NO;
    contentHTTPLabel.hidden = NO;
    ftpAddress.hidden = NO;
    if(isOn == YES)
    {
        NSString *addr = [NetworkController localWifiIPAddress];
        if(![addr isEqualToString:@"error"])
        {
            contentFTPLabel.text = [NSString stringWithFormat:@"ftp://%@:20000", 
                                    addr];
            contentHTTPLabel.text = [NSString stringWithFormat:@"http://%@", 
                                     addr];
            [serverSwitch setOn: YES];
        }
        else
        {
            httpAddress.hidden = YES;
            contentFTPLabel.hidden = YES;
            contentHTTPLabel.text = kNoWifi;
            ftpAddress.text = kCheckOut;
        }
    }
    else
    {
        contentFTPLabel.text = kServerOff;
        contentHTTPLabel.text = kServerOff;
        [serverSwitch setOn: NO];
    }
}

-(void)viewWillAppear:(BOOL)animated
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
    
    NSString *settingHelp = kSettingHelp;
    helpLabel.text = settingHelp;
    [helpLabel sizeToFit];
    
    [((UIScrollView*)self.view) 
     setContentInset: UIEdgeInsetsMake(0, 0,
                                       self.helpLabel.frame.origin.y+self.helpLabel.frame.size.height, 0)];
    
    [realImgSwitch setOn:serverInfo.isRealImage];
    [self reloadServerStatus:serverInfo.isServerStart];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction) operateFTPServer:(id)sender
{
    UISwitch *_switch = (UISwitch *)sender;
	
	BOOL setting = _switch.isOn;
    
    serverInfo.isServerStart = setting;
    
    if(YES == setting)
    {
        [serverInfo startFtpServer];
        [serverInfo startWebServer];
    }
    else
    {
        [serverInfo stopFtpServer];
        [serverInfo stopWebServer];
    }
        
    [self reloadServerStatus: setting];
}

- (IBAction)switchRealImg: (id)sender
{
    //UISwitch *switch_ = (UISwitch *)sender;
    //serverInfo.isRealImage = switch_.isOn;
}

-(void)done: (id)sender
{    
    serverInfo.isServerStart = serverSwitch.isOn;
    serverInfo.isRealImage = realImgSwitch.isOn;
    [serverInfo recordStatusOfServer];
    [self.navigationController popViewControllerAnimated: YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss" 
                                                        object:nil];
}

@end

//
//  ASBluetoothViewController.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-3-31.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ASBluetoothViewController.h"
#import "ASVirtualHardDiskAppDelegate.h"
#import "ASFileListViewController.h"

#define SESSION_ID @"bluetoothSendFile"

static ASBluetoothViewController *theSharedManager = nil;

@interface ASBluetoothViewController()

@end

@implementation ASBluetoothViewController

@synthesize backgroundView;
@synthesize mainView;
@synthesize positiveButton;
@synthesize negativeButton;
@synthesize label;
@synthesize progressView;
@synthesize peerTableView;
@synthesize currentConfPeerID;
@synthesize filePathArray;
@synthesize statusManager;
@synthesize theSession;
@synthesize currentDirectory;

#pragma mark - GKSessionDelegate Methods and Helpers

// Received an invitation.  If we aren't already connected to someone, open the invitation dialog.
- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
    self.currentConfPeerID = peerID;
    [statusManager.status didReceiveConnectionRequestFromPeer:peerID];
}

// Unable to connect to a session with the peer, due to rejection or exiting the app
- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
    //[statusManager.status connectionWithPeerFailed:peerID withError:error];
    [statusManager changeToDisconnectedStatus];
}

// The running session ended, potentially due to network failure.
- (void)session:(GKSession *)session didFailWithError:(NSError*)error
{
    //[statusManager.status didFailWithError:error];
    if (([[error domain] isEqual:GKSessionErrorDomain])&&([error code]==GKSessionCannotEnableError) ) 
    {
        [statusManager changeToUnavailableStatus];
    }
    else
    {
        [statusManager changeToDisconnectedStatus];
    }
}

// React to some activity from other peers on the network.
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
    switch (state) { 
		case GKPeerStateAvailable:
            // A peer became available by starting app, exiting settings, or ending a call.
            if (![peersList containsObject:peerID]) {
				[peersList addObject:peerID]; 
			}
            [peerTableView reloadData];
            [statusManager changeToDisconnectedStatus];
			break;
		case GKPeerStateUnavailable:
            // Peer unavailable due to joining a call, leaving app, or entering settings.
            [peersList removeObject:peerID];
            [peerTableView reloadData];
			break;
		case GKPeerStateConnected:
            // Connection was accepted.
            [statusManager.status connectionWasAccepted];
            theSession.available = NO;
			break;				
		case GKPeerStateDisconnected:
            // The call ended either manually or due to failure somewhere.
//            [peersList removeObject:peerID];
//            [peerTableView reloadData];
            [statusManager changeToDisconnectedStatus];
            theSession.available = YES;
			break;
        case GKPeerStateConnecting:
            // Peer is attempting to connect to the session.
            break;
		default:
			break;
	}
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context
{
    [statusManager.status handleTheData:data];
}
#pragma mark session
- (void) sendData:(NSData *)data
{
    [theSession sendDataToAllPeers:data withDataMode:GKSendDataReliable error:nil];
}


#pragma mark - IBAction
- (IBAction) positiveButtonPressed:(id)sender
{
    [statusManager.status positiveButtonPressed];
}
- (IBAction) negativeButtonPressed:(id)sender
{
    [statusManager.status negativeButtonPressed];
}
- (IBAction) dismiss:(id)sender
{
    [self hiddenAllSubdvew];
    
    [statusManager changeToDisconnectedStatus];
    
    [self.view removeFromSuperview];
    
    ASFileListViewController *fileListViewController = 
    (ASFileListViewController *)[((ASVirtualHardDiskAppDelegate *)[UIApplication sharedApplication].delegate).navigationController topViewController];
    [fileListViewController refreshDocuementsWithoutAnimation];
    [fileListViewController formatToolBar];
}
- (void) hiddenAllSubdvew
{
    label.hidden = YES;
    positiveButton.hidden = YES;
    negativeButton.hidden = YES;
    peerTableView.hidden = YES;
    progressView.hidden = YES;
    progressView.progress = 0.0;
    label.text = @"";
    label.clearsContextBeforeDrawing = YES;
}
#pragma mark - show view
- (void)show
{
//    [((ASVirtualHardDiskAppDelegate *)[UIApplication sharedApplication].delegate).window addSubview:self.view];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.view];
    [statusManager.status configView];
}

- (void) moveView:(UIView *)view to:(CGRect)frame during:(float)time
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; 
	[UIView setAnimationDuration:time];
	view.frame = frame;
	[UIView commitAnimations];
}


#pragma mark - single
+ (id) sharedManager
{
    if (nil == theSharedManager) {
        theSharedManager = [[ASBluetoothViewController alloc] initWithNibName:@"ASBluetoothViewController" bundle:nil];
    }
    return theSharedManager;
}

#pragma mark - application hiding/terminating

// Called when notified the application is exiting or becoming inactive.
- (void)willTerminate:(NSNotification *)notification
{
    //destroySession
    [statusManager changeToDisconnectedStatus];
	theSession.delegate = nil;
	[theSession setDataReceiveHandler:nil withContext:nil];
	[theSession release];
    [peersList removeAllObjects];

}

// Called after the app comes back from being hidden by something like a phone call.
- (void)willResume:(NSNotification *)notification
{
    //setUpTheSession
    theSession = [[GKSession alloc] 
                  initWithSessionID:sessionID
                  displayName:nil
                  sessionMode:GKSessionModePeer];
    [theSession setWifiEnabled:NO];
    theSession.delegate = self;
    [theSession setDataReceiveHandler:self withContext:nil];
    theSession.available = YES;
    [statusManager changeToDisconnectedStatus];
}

#pragma mark - tableView DataSoure Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *peer = [peersList objectAtIndex:[indexPath row]];
    [theSession connectToPeer:peer withTimeout:10.0];
    self.currentConfPeerID = peer;
    
    [statusManager changeToConnectingStatus];
    //[statusManager changeToRequestSendFileStatus];
    //[statusManager.status configView];
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [peersList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [theSession displayNameForPeer:
                           [peersList objectAtIndex:
                            [indexPath row]]];

    return cell;
}

#pragma mark - memory controll

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        sessionID = SESSION_ID;
        peersList = [[NSMutableArray alloc] init];
        statusManager = [[ASBluetoothStatusManager alloc] init];
       // Set up starting/stopping session on application hiding/terminating
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willTerminate:)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willTerminate:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willResume:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didRotate:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [backgroundView release];
    [mainView release];
    [positiveButton release];
    [negativeButton release];
    [label release];
    [progressView release];
    [peerTableView release];
    [currentConfPeerID release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.filePathArray = nil;
	theSession = nil;
	sessionID = nil; 
	[peersList release]; 
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
    self.mainView.layer.cornerRadius = 8;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%i",self.interfaceOrientation);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.backgroundView = nil;
    self.mainView = nil;
    self.positiveButton = nil;
    self.negativeButton = nil;
    self.label = nil;
    self.progressView = nil;
    self.peerTableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) didRotate:(NSNotification *)notification
{
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];

    if(interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.backgroundView.transform = CGAffineTransformIdentity;
        self.backgroundView.transform = CGAffineTransformMakeRotation(M_PI);
    }
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
    {
        self.backgroundView.transform = CGAffineTransformIdentity;
        self.backgroundView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    }
    if(interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.backgroundView.transform = CGAffineTransformIdentity;
        self.backgroundView.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    if(interfaceOrientation == UIInterfaceOrientationPortrait)
    {
        self.backgroundView.transform = CGAffineTransformIdentity;
    }
}
@end

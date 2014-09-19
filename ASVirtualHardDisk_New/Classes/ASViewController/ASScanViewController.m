//
//  ASScanViewController.m
//  ASVirtualHardDisk
//
//  Created by xieyajie on 11-12-7.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASDeclare.h"
#import "ASDataObjectManager.h"
#import "ASFileType.h"
#import "ASMenu.h"
#import "ASRotateMenuModel.h"
#import "ASScanViewController.h"
#import "ASScanMenuModel.h"
#import "ASStatusManager.h"
#import "ASZipEx.h"
#import "ASLocalDefine.h"
#import "ASPictureViewController.h"
#import "ASImageResize.h"
#import "ASReaderViewController.h"
#import "ASTextViewController.h"

@implementation ASScanViewController

@synthesize scanMenu; 
//@synthesize scanbar;
@synthesize operate;
@synthesize isAppear;
//@synthesize isNextLevel;
@synthesize docController;
@synthesize myPDFData;
@synthesize readViewController;


- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.isAppear = NO;
    }
    return self;
}

#pragma mark -
#pragma mark ScanMenueDelegate
//------------------------------------------------------------------------------
// - (void) menu:(ASMenu *)menu clickedAtIndex:(NSIndexPath *)indexPath
//------------------------------------------------------------------------------
- (void) menu:(ASMenu *)menu clickedAtIndex:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [menu.menuView cellForRowAtIndexPath:indexPath];
    NSString *command = cell.textLabel.text;
    NSString *path;
    
    path = [[NSBundle mainBundle] 
            pathForResource:@"scanMenu" ofType:@"plist"];
    
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

//------------------------------------------------------------------------------
// - (IBAction) operatePressed:(id)sender
//------------------------------------------------------------------------------
-(IBAction) operatePressed: (id)sender
{    
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            scanMenu = [[ASMenu alloc] initWithPoint:CGPointMake(7,288)
                                       andArrowPoint:CGPointMake(5,136)                      
                                       andDataSource:
                        [ASScanMenuModel sharedASScanMenuModel]];
            scanMenu.transform = CGAffineTransformMakeRotation(degreesToRadian(0));
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            scanMenu = [[ASMenu alloc] initWithPoint:CGPointMake(165,60)
                                       andArrowPoint:CGPointMake(5,136)                      
                                       andDataSource:
                        [ASScanMenuModel sharedASScanMenuModel]];
            scanMenu.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
            break;
        case UIInterfaceOrientationLandscapeLeft:
            scanMenu = [[ASMenu alloc] initWithPoint:CGPointMake(135,330)
                                       andArrowPoint:CGPointMake(5,136)                       
                                       andDataSource:
                        [ASScanMenuModel sharedASScanMenuModel]];
            scanMenu.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
            break;
        case UIInterfaceOrientationLandscapeRight:
            scanMenu = [[ASMenu alloc] initWithPoint:CGPointMake(40,15)
                                       andArrowPoint:CGPointMake(5,136)                       
                                       andDataSource:
                        [ASScanMenuModel sharedASScanMenuModel]];
            scanMenu.transform = CGAffineTransformMakeRotation(degreesToRadian(90));
            break;
        default:
            break;
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:scanMenu];
    scanMenu.delegate = self;
}

-(void) emailPressed
{
    [self emailFiles];
}

-(void) openInPressed
{
    NSLog(@"%@",[currentDirectory getFullItemName]);
    NSMutableString *path = [[NSMutableString alloc] initWithString:NSHomeDirectory()];
    [path appendString: @"/Documents"];
    [path appendString: [currentDirectory getFullItemName]];
    
    CGRect rect = CGRectMake(0, 0, 320, 480);
    
    self.docController = 
    [UIDocumentInteractionController interactionControllerWithURL:
        [NSURL fileURLWithPath: path]];
    docController.delegate = self;
    myPDFData = [[NSData alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    BOOL result =[docController presentOpenInMenuFromRect: rect 
                                       inView: self.view 
                                     animated: YES];
    if (NO == result) 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: kMessage
                                                        message: kNoApp
                                                       delegate: nil
                                              cancelButtonTitle: kResultAlertSure
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
    [path release];
}

#pragma mark -
#pragma mark UIDocumentInteractionController Delegate
-(void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller
{
    [controller release];
}

-(void) rotatePressed
{
    scanMenu = [[ASMenu alloc] initWithPoint:CGPointMake(5,235)
                               andArrowPoint:CGPointMake(14,196)                      
                               andDataSource:
                [ASRotateMenuModel sharedRotateMenuModel]];
    [[[UIApplication sharedApplication] keyWindow] addSubview:scanMenu];
    scanMenu.delegate = self;
}

//-(void) printPressed:(id)sender
//{
//    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController]; 
//    if (pic && [UIPrintInteractionController canPrintData: self.myPDFData] )
//    {
//        pic.delegate = self;
//        UIPrintInfo *printInfo = [UIPrintInfo printInfo]; 
//        printInfo.outputType = UIPrintInfoOutputGeneral; 
//        printInfo.jobName = @"pdf";//[self.path lastPathComponent]; 
//        printInfo.duplex = UIPrintInfoDuplexLongEdge; 
//        pic.printInfo = printInfo;
//        pic.showsPageRange = YES;
//        pic.printingItem = self.myPDFData;
//        
//        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *pic, BOOL completed, NSError *error)
//        {                     
//            //self.content = nil;
//            if (!completed && error)
//                NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
//        }; 
//        [pic presentAnimated:YES completionHandler:completionHandler];
//    }
//    if (picOrPDF == 1) {
//    
//    }
//}

-(void) deletePressed
{
    [self deleteFile];
}

-(void) quarterCWPressed
{
    NSLog(@"%@",KQuarterCW);
}

-(void) quarterCCWPressed
{
    NSLog(@"%@",KQuarterCCW);
}

-(void) halfPressed
{
    NSLog(@"%@",KHalfPressd);
}


//------------------------------------------------------------------------------
// - (void) deleteFile
//------------------------------------------------------------------------------
- (void) deleteFile
{
    //show the delete warning
    
    UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:declare.deleteFileAlertTitle
                          message:declare.deleteFileAlertMessage
                          delegate:self
                          cancelButtonTitle:declare.deleteFileAlertSure
                          otherButtonTitles:declare.deleteFileAlertCancel,nil];
    
    alert.tag = KTAGOFDELETEALERT;
    
    [alert show];
    
    [alert release];
	
    
}

#pragma mark -
#pragma mark Alert Delegate Method
//------------------------------------------------------------------------------
//   - (void)alertView:(UIAlertView *)alertView 
//clickedButtonAtIndex:(NSInteger)buttonIndex
//------------------------------------------------------------------------------
- (void)alertView:(UIAlertView *)alertView 
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(KTAGOFDELETEALERT == alertView.tag)
    {
        //delete file finally
        if(0 == buttonIndex)
        {
            
            id<ASDataObject> dataObj = currentDirectory;
            
            //if the dataObj is a picture,then display the next one
            if (kPNG == [dataObj getFileType] || kPicture == [dataObj getFileType]) 
            {
                
            }
            //if the dataObj is not a picture,then the navigationController will pop
            else
            {
                [dataObj remove];
                [self.navigationController popViewControllerAnimated:YES];
            }            
        }
        else if(1 == buttonIndex)
        {
            ;
        }
    }
    
}





#pragma mark - 
#pragma mark HUD Delegate Method
//------------------------------------------------------------------------------
// - (void)hudWasHidden:(MBProgressHUD *)hud
//------------------------------------------------------------------------------
- (void)hudWasHidden:(MBProgressHUD *)hud 
{
    // Remove HUD from screen when the HUD was hidded
	if (kTAGOFMAIL == hud.tag) 
    {
		
		MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
		mcvc.mailComposeDelegate = self;
		[mcvc setSubject:@"From iSharp"];
//		NSString *body = @"<h1>hello</h1>";
//		[mcvc setMessageBody:body isHTML:YES];
        NSString *body = @"";
        [mcvc setMessageBody:body isHTML:NO];
		
        ASDataObjectManager *dataManager = [ASDataObjectManager sharedDataManager];
        NSMutableString *currentPath_ = [[NSMutableString alloc] initWithString:[dataManager getRootPath]];
        [currentPath_ appendString:[currentDirectory getFullItemName]];
        
		NSData *data =[[NSData alloc] initWithContentsOfFile:[currentPath_ stringByAppendingPathComponent:@"fromiSharp.zip"] options:NSDataReadingMapped error:nil];
		[currentPath_ release];
        
		[mcvc addAttachmentData:data mimeType:@"application/zip" fileName:@"fromiSharp.zip"];
		
		[self presentModalViewController:mcvc animated:YES];
		[data release];
	}
    
    [HUD removeFromSuperview];
    [HUD release];
    HUD = nil;
}


//------------------------------------------------------------------------------
// - (void) showWarning:(NSString *)warning
//------------------------------------------------------------------------------
- (void) showWarning:(NSString *)warning
{
	UIAlertView *alert = [[UIAlertView alloc] 
                          initWithTitle:declare.fileListViewAlertTitle
                          message:warning
                          delegate:nil
                          cancelButtonTitle:declare.fileListViewAlertSure
                          otherButtonTitles:nil];
	[alert show];
	
	[alert release];
}



//------------------------------------------------------------------------------
// - (void) emailFiles
//------------------------------------------------------------------------------
- (void) emailFiles
{
	//1判断是否能发邮件（不能提示没有网络）2压缩文件，同时显示waiting 3waiting消失，显示发送邮件的界面 4界面消失，删除文件
	if ([MFMailComposeViewController canSendMail]) {
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.tag = kTAGOFMAIL;
        HUD.delegate = self;
        HUD.labelText = KWait;
        
        [HUD showWhileExecuting:@selector(email) onTarget:self withObject:nil animated:YES];
        
		
	}
	else {
		[self showWarning:declare.canNotSendMail];
	}
    
}
- (void) email
{
	NSMutableString *path = [[NSMutableString alloc] initWithString:NSHomeDirectory()];
    [path appendString:@"/Documents"];
    
	ASZipEx *aszip = [ASZipEx sharedASZipEx];
    ASDataObjectManager *dataObjectManager = [ASDataObjectManager sharedDataManager];
    NSMutableString *zipPath = [[NSMutableString alloc] initWithString:[dataObjectManager getRootPath]];
    [zipPath appendString:[currentDirectory getFullItemName]];
    [zipPath appendString:@"/fromiSharp.zip"];
    [aszip zipFiles:[currentDirectory getFileList:YES] toZip:zipPath currentDirectory:currentDirectory];
	[zipPath release];
    
    [path release];
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate Method
//------------------------------------------------------------------------------
// - (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
//------------------------------------------------------------------------------
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    ASFileEx *zip = (ASFileEx*)[[ASDataObjectManager sharedDataManager] getFileObject:@"fromiSharp.zip" And:currentDirectory];
    [zip remove];
    
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark public method

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	UIButton *btn = [[UIButton alloc] init];
	[btn setImage:[UIImage imageNamed:@"operate.png"] 
		 forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(operatePressed:) 
              forControlEvents:UIControlEventTouchUpInside];
	btn.frame = CGRectMake(36, 0, 30, 30);
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    item.customView.opaque = YES;
    
	UIButton *btnLeft = [[UIButton alloc] init];
	[btnLeft setImage:[UIImage imageNamed:@"ccw.png"] 
		 forState:UIControlStateNormal];
	[btnLeft addTarget:self action:@selector(quarterCCWPressed) 
              forControlEvents:UIControlEventTouchUpInside];
	btnLeft.frame = CGRectMake(142, 0, 30, 30);
	btnLeft.hidden = YES;
	UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    
	UIButton *btnRight = [[UIButton alloc] init];
	[btnRight setImage:[UIImage imageNamed:@"cw.png"] 
			 forState:UIControlStateNormal];
	[btnRight addTarget:self action:@selector(quarterCWPressed) 
              forControlEvents:UIControlEventTouchUpInside];
	btnRight.frame = CGRectMake(248, 0, 30, 30);
	btnRight.hidden = YES;
	UIBarButtonItem *itemRight = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
	
	UIBarButtonItem *space = [[UIBarButtonItem alloc] 
							  initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace 
							  target:nil action:nil];
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
//    [array addObject:space];
	[array addObject:item];
	[array addObject:space];
	[array addObject:itemLeft];
	[array addObject:space];
	[array addObject:itemRight];
//    [array addObject:space];

	[btn release];
	[btnLeft release];
	[btnRight release];
	[item release];
	[itemLeft release];
	[itemRight release];
	[space release];
    self.toolbarItems = array;
	[array release];
      
    declare = [ASDeclare singletonASDeclare];
    
    UITapGestureRecognizer *singleTap = 
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    [singleTap release];
    
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.alpha = 0.7;
    
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.tintColor = [UIColor clearColor];
    self.navigationController.toolbar.translucent = YES;
    self.navigationController.toolbar.alpha = 0.7f;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self setWantsFullScreenLayout:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent
                                                animated:NO];

    [self.navigationController setToolbarHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.isAppear = NO;

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void) handleSingleTap: (UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];
    if (point.y >= (self.view.bounds.size.height - 44)) {
        return ;
    }
    
    if(YES == isAppear)
	{
        isAppear = NO;
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
	    self.navigationController.navigationBar.hidden = NO;
        [self.navigationController setToolbarHidden:NO];
	}
	else
	{
        isAppear = YES;
		self.navigationController.navigationBar.hidden = YES;
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self.navigationController setToolbarHidden:YES];
	}
    
}


- (void)viewDidUnload
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 0.9;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.tintColor = [UIColor blackColor];
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.toolbar.alpha = 1.0f;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}
- (void) setNavigationUnHidden
{
    self.navigationController.navigationBarHidden = NO;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(YES == isAppear)
    {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    [super willRotateToInterfaceOrientation:toInterfaceOrientation
                                   duration:duration];
}

//------------------------------------------------------------------------------
// -(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//------------------------------------------------------------------------------
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent
                                                animated:NO];

    [self.navigationController setToolbarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBar.hidden = NO;
    self.isAppear = NO;
    [scanMenu removeFromSuperview];
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation
                                            duration:duration];

}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate methods

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}


@end

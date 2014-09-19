//
//  ASFileListViewController.m
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-24.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <sys/utsname.h>

#import "ASFileOperateViewController.h"
#import "ASFileListViewController.h"
#import "ASNewFileName.h"
#import "ASTableViewCell.h"
#import "ASTextViewController.h"
#import "ASLocalDefine.h"
#import "ASDeclare.h"
#import "ASMenu.h"
#import "ASRightMenuModel.h"
#import "ASStatusManager.h"
#import "ASFileType.h"
#import "ASDataObjectManager.h"
#import "ASDirectoryEx.h"
#import "ASZipEx.h"
#import "ASBottomMenuModel.h"
#import "ASMusicPlayer.h"
#import "ZBarReaderViewController.h"
#import "ASDirectoryFirstSort.h"
#import "ASSortMenuModel.h"
#import "ASSortMenu.h"
#import "ASBadgeView.h"
#import "HJMOFileCache.h"
#import "ASBluetoothViewController.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
@interface ASFileListViewController (private)

/*
    @function   - (void) searchDocuments
    @abstract   search files contained in the current path
                and add the files to arrayDoc 
    @param      none
    @result     void
*/
- (void) searchDocuments;

/*
    @function   - (void) addEdtingButton
    @abstract   add the edit button to the navigation
    @param      none
    @result     void
*/
- (void) addEdtingButton;

/*
    @function   - (IBAction) togglEdting:(id)sender
    @abstract   control the status of the table views
    @param      (id)sender - the editing button
    @result     IBAction
*/
- (IBAction) togglEdting:(id)sender;

/*
    @function   - (IBAction) textFieldDidEndEditing:(id)sender
    @abstract   respond to the textFieldDidEndEditing Event
    @param      (id) sender
    @result     IBAction
*/
- (IBAction) textFieldDidEndEditing:(id)sender;

/*
    @function   - (void) deleteFile
    @abstract   used to delete files,
                show alert warning when to delete files,
                and dispose in the alert delegate method
    @param      none
    @result     void
*/
- (void) deleteFile;

/*
    @function   - (void) copyFiles
    @abstract   copy files 
    @param      none
    @result     void
*/
- (void) copyFiles;

/*
    @function   - (void) moveFiles
    @abstract   move files
    @param      none
    @result     void
*/
- (void) moveFiles;
- (void) zipFiles;
- (void) emailFiles;
- (void)shareFiles;
/*
    @function   - (void) setTextFiledFirstResponder:(NSIndexPath *)aIndex
    @abstract   set textField first responder
    @param      none
    @result     void
*/
- (void) setTextFiledFirstResponder:(NSIndexPath *)aIndex;

/*
 @function   - (void) hideKeyboard
 @abstract   set textField resignFirstResponder
 @param      none
 @result     void
 */
- (void) hideKeyboard:(UISwipeGestureRecognizer *)recognizer;

-(IBAction)toggleEdting:(id)sender;

- (void) readyForSearchView;
- (void) readyForFileList;

- (void) addBadgeViewForRecorde;

- (void) selectedAll:(id)sender;

- (void) reloadDataSourceBySort;

- (void) reloadDataForTableView;

@end

//for right menu
static const CGFloat kRightButtonX = 200.0f;
static const CGFloat kRightButtonTop = 50.0f;
static const CGFloat kRightButtonBottom = 450.0f;
static const CGFloat kMissDistance =  50.0f;
//size of the rightMenu 
static const CGFloat kBackgroundImageWidth = 106.0f;
static const CGFloat kBackgroundImageHeight = 301.0f;
//size of the arrow in rightMenu
static const CGFloat kArrowImageWidth = 19.0f;
static const CGFloat kArrowImageHeight = 28.0f;
static const NSInteger kPositionDown = 1;
static const NSInteger kPositionCell = 0;

//position of numButton
static const CGFloat k_Portrait_X = 3.0f;
static const CGFloat k_Portrait_Y = -11.0f;

static const CGFloat k_LandscapeLeft_X = 3.0f;//3.0f;
static const CGFloat k_LandscapeLeft_Y = -11.0f;//225.0f;

static const CGFloat k_LandscapeRight_X = 3.0f;
static const CGFloat k_LandscapeRight_Y = -11.0f;

static const CGFloat kSizeOfNumButton = 26.0f;

@implementation ASFileListViewController

//@synthesize docWatcher;
@synthesize documentTableView;
@synthesize isEdting;
@synthesize selectedFiles;
@synthesize isNeedDelete;
@synthesize activityView;
@synthesize numButton;
@synthesize addDirectory;
@synthesize indexPath;
@synthesize pointOfCell;
@synthesize tapGestureRecognizer;
@synthesize statusManager;
@synthesize filesInCurrentDocument;
@synthesize currentDirectory;
@synthesize searchBar;
@synthesize isForSearch;
@synthesize searchString;
@synthesize pause;
@synthesize play;
@synthesize moviePlayViewController;
@synthesize moviePlayerController;
@synthesize popmenu;
@synthesize progress;

#pragma mark -
#pragma mark add by Liu Dong
-(IBAction) showSortMenu:(id)sender
{
    if(popmenu) {
        [popmenu release];
        popmenu = nil;
    }
    switch (self.interfaceOrientation) 
    {
        case UIInterfaceOrientationPortrait:
            popmenu = [[ASSortMenu alloc] initWithPoint:CGPointMake(67,225)
                                          andArrowPoint:CGPointMake(120,198)                      
                                          andDataSource:[ASSortMenuModel singletonASSortMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(0));
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            popmenu = [[ASSortMenu alloc] initWithPoint:CGPointMake(75,60)
                                      andArrowPoint:CGPointMake(120,198)                     
                                      andDataSource:
                       [ASSortMenuModel singletonASSortMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
            break;
        case UIInterfaceOrientationLandscapeLeft:
            popmenu = [[ASSortMenu alloc] initWithPoint:CGPointMake(85,117)
                                      andArrowPoint:CGPointMake(120,198)                     
                                      andDataSource:
                       [ASSortMenuModel singletonASSortMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
            break;
        case UIInterfaceOrientationLandscapeRight:
            popmenu = [[ASSortMenu alloc] initWithPoint:CGPointMake(57,165)
                                      andArrowPoint:CGPointMake(120,198)                      
                                      andDataSource:
                       [ASSortMenuModel singletonASSortMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(90));
            break;
        default:
            break;
    }
	
    popmenu.delegate = self;    
    [[[UIApplication sharedApplication] keyWindow] addSubview:popmenu];

    [statusManager changeToNormalWithMenuStatus];
}

-(void) selectedAll:(id)sender
{
	if ([filesInCurrentDocument count]) {
        
		id<ASStatus> obj = self.statusManager.status;
		NSArray *array = [selectedFiles allKeys];
		if ([selectedFiles count] < [filesInCurrentDocument count]) {
            
			for (int i = 0; i < [filesInCurrentDocument count]; i++) {
                
				NSIndexPath *inDex = [NSIndexPath indexPathForRow:i inSection:0];
				[obj handleDidSelectRowAtIndexPath:inDex];
				[documentTableView selectRowAtIndexPath:inDex animated:NO 
									scrollPosition:UITableViewScrollPositionNone];
			}
		} else {
			for (int i = 0; i < [array count]; i++) {
                
				NSIndexPath *inDex = [array objectAtIndex:i]; 
				[obj handleDidDeselectRowAtIndexPath:inDex];
				[documentTableView deselectRowAtIndexPath:inDex animated:NO];
			}
		}
		
	}
}

//------------------------------------------------------------------------------
// - (void) addBadgeViewForRecorde
//------------------------------------------------------------------------------
- (void) addBadgeViewForRecorde
{
    CGRect rect = CGRectMake(k_Portrait_X,
                             k_Portrait_Y, 
                             30.0f,
                             30.0f);
    numButton = [[ASBadgeView alloc] initWithFrame:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [numButton drawRoundedRect:rect inContext:context withRadius:0.0f];
    numButton.shadowEnabled = YES;
    numButton.hidden = YES;
    [numButton setBadgeString:@""];
    [self.navigationController.toolbar addSubview:numButton];
}

#pragma mark -
#pragma mark POPMenueDelegate
//------------------------------------------------------------------------------
// - (void) menu:(ASMenu *)menu clickedAtIndex:(NSIndexPath *)indexPath
//------------------------------------------------------------------------------
- (void) menu:(ASMenu *)menu clickedAtIndex:(NSIndexPath *)aIndexPath
{
    [statusManager changeToNormalWithoutMenuStatus];
    UITableViewCell *cell = [menu.menuView cellForRowAtIndexPath:aIndexPath];
    NSString *command = cell.textLabel.text;
    NSString *path;
    
    path = [[NSBundle mainBundle] 
            pathForResource:@"bottomMenu" ofType:@"plist"];
    
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

-(void)reloadDataForTableView
{
	NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
	[documentTableView reloadSections:indexSet 
        withRowAnimation:UITableViewRowAnimationFade];
}

- (void)beginSortWithType:(int)aType andFlag:(BOOL)aFlag
{
	[statusManager changeToNormalWithoutMenuStatus];
	ASDirectoryFirstSort *sort = [ASDirectoryFirstSort singleASDirectoryFirstSort];
	[self searchDocuments];
	[sort directoryFirstSort:filesInCurrentDocument compareType:aType isAsc:aFlag];
    progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:progressHUD];
    
    progressHUD.delegate = self;
    
    if(!isForSearch) {
        [progressHUD showWhileExecuting:@selector(reloadDataForTableView)
                       onTarget:self withObject:nil animated:YES];
    } else {
        [self readyForSearchView];
        [progressHUD showWhileExecuting:@selector(reloadDataForSearchView)
                       onTarget:self withObject:nil animated:YES];
        UIBarButtonItem *leftButton = 
            [[UIBarButtonItem alloc] initWithTitle: KHome 
                                             style: UIBarButtonItemStyleBordered 
                                            target: self 
                                            action: @selector(backToHome)];
        self.navigationItem.leftBarButtonItem = leftButton;
        [leftButton release];
    }
}

#pragma mark -
#pragma mark right menu Command
-(void)doMove
{
	[self moveFiles];
}
-(void)doCopy
{
	[self copyFiles];
}
-(void)doZip
{
	[self zipFiles];
}
-(void)doMail
{
	[self emailFiles];
}
-(void)doShare
{
    [self shareFiles];
}
-(void)doRename
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.documentTableView.userInteractionEnabled = NO;
	[self setTextFiledFirstResponder:indexPath];
}
-(void)doDelete
{
	[self deleteFile];
}

#pragma mark -
#pragma mark POPMenue
//------------------------------------------------------------------------------
// - (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
//------------------------------------------------------------------------------
- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{	
    [statusManager handleSwipeFrom:recognizer];
}

#pragma mark - 
#pragma mark progressHUD Delegate Method
//------------------------------------------------------------------------------
// - (void)hudWasHidden:(MBProgressHUD *)HUD
//------------------------------------------------------------------------------
- (void)hudWasHidden:(MBProgressHUD *)HUD 
{
    // Remove progressHUD from screen when the progressHUD was hidded
	if (kTAGOFMAIL == HUD.tag) 
    {
		
		MFMailComposeViewController *mcvc = [[[MFMailComposeViewController alloc] init] autorelease];
		mcvc.mailComposeDelegate = self;
		[mcvc setSubject:@"From iSharp"];
		
        ASDataObjectManager *dataManager = [ASDataObjectManager sharedDataManager];
        NSMutableString *currentPath_ = [[NSMutableString alloc] initWithString:[dataManager getRootPath]];
        [currentPath_ appendString:[currentDirectory getFullItemName]];
        
		NSData *data =[[NSData alloc] initWithContentsOfFile:[currentPath_ stringByAppendingPathComponent:@"fromiSharp.zip"] options:NSDataReadingMapped error:nil];
		[currentPath_ release];
        
		[mcvc addAttachmentData:data mimeType:@"application/zip" fileName:@"fromiSharp.zip"];
        
        NSString *body = @"";
        [mcvc setMessageBody:body isHTML:NO];
		if(mcvc)
            [self presentModalViewController:mcvc animated:YES];
		[data release];
	}
    
    [HUD removeFromSuperview];
    HUD.delegate = nil;
    [HUD release];
    HUD = nil;
}

#pragma mark -
#pragma mark private method

- (void) tapGestureRecognizer:(UITapGestureRecognizer *) gestureRecognizer
{
    [statusManager handleTapGesture:gestureRecognizer];

}

//------------------------------------------------------------------------------
// - (void) refreshDocuementsWithAnimation
//------------------------------------------------------------------------------
- (void) refreshDocuementsWithAnimation
{
	[self searchDocuments];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.documentTableView reloadSections:indexSet
                     withRowAnimation:UITableViewRowAnimationFade];
}

//------------------------------------------------------------------------------
// - (void) refreshDocuementsWithoutAnimation
//------------------------------------------------------------------------------
- (void) refreshDocuementsWithoutAnimation
{
	[self searchDocuments];
	[self reloadDataSourceBySort];
    [self.documentTableView reloadData];
}

//------------------------------------------------------------------------------
// - (void) showView
// show the activity view and start animating
//------------------------------------------------------------------------------
- (void) showView
{
	self.activityView.hidden = NO;
	[self.activityView startAnimating];
	
	[self performSelector:@selector(hideView) withObject:nil afterDelay:0.5];
}

//------------------------------------------------------------------------------
// - (void) hideView
// hide the activity view and stop animating
//------------------------------------------------------------------------------
- (void) hideView
{
	[self.activityView stopAnimating];
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
// - (IBAction) searchFiles:(id)sender
//------------------------------------------------------------------------------
- (IBAction) searchFiles:(id)sender
{	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

	[self.view addSubview:searchBar];
    searchBar.delegate = self;
    searchBar.barStyle = UIBarStyleBlack;

    searchBar.tintColor = [UIColor blackColor];
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait||
        self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        searchBar.frame = CGRectMake(0.0f, 460.0f, 320.0f, 44.0f);
    else
        searchBar.frame = CGRectMake(0.0f, 460.0f, 480.0f, 44.0f);

	[searchBar becomeFirstResponder];
    
}

//------------------------------------------------------------------------------
// - (void) searchDocuments
//------------------------------------------------------------------------------
-(void)searchDocuments
{
    
    if([filesInCurrentDocument count]) {
        [filesInCurrentDocument removeAllObjects];
    }
	NSArray *array = [currentDirectory getFileList:NO];
    
    for(int i = 0; i  < [array count]; i++) {
        [filesInCurrentDocument addObject:[array objectAtIndex:i]];
    }
    [self reloadDataSourceBySort];
}

-(void)reloadDataSourceBySort
{
	ASSortMenuModel *model = [ASSortMenuModel singletonASSortMenuModel];
	int iType = [model getSortType];
	int iFlag = [model getSortFlag];
	
    ASDirectoryFirstSort *sort = [ASDirectoryFirstSort singleASDirectoryFirstSort];
	if (0 == iType && 4 == iFlag) 
	{
		[sort directoryFirstSort:filesInCurrentDocument compareType:1 isAsc:YES];
		return;
	}
	if (0 == iType && 5 == iFlag) 
	{
		[sort directoryFirstSort:filesInCurrentDocument compareType:1 isAsc:NO];
		return;
	}
	if (1 == iType && 4 == iFlag) 
	{
		[sort directoryFirstSort:filesInCurrentDocument compareType:2 isAsc:YES];
		return;
	}
	if (1 == iType && 5 == iFlag) 
	{
		[sort directoryFirstSort:filesInCurrentDocument compareType:2 isAsc:NO];
		return;
	}
	if (2 == iType && 4 == iFlag) 
	{
		[sort directoryFirstSort:filesInCurrentDocument compareType:3 isAsc:YES];
		return;
	}
	if (2 == iType && 5 == iFlag) 
	{
		[sort directoryFirstSort:filesInCurrentDocument compareType:3 isAsc:NO];
		return;
	}
	if (3 == iType && 4 == iFlag) 
	{
		[sort directoryFirstSort:filesInCurrentDocument compareType:4 isAsc:YES];
		return;
	}
	if (3 == iType && 5 == iFlag) 
	{
		[sort directoryFirstSort:filesInCurrentDocument compareType:4 isAsc:NO];
		return;
	}
}

//------------------------------------------------------------------------------
//- (void) setTextFiledFirstResponder
//------------------------------------------------------------------------------
- (void) setTextFiledFirstResponder:(NSIndexPath *)aIndex
{
	
	ASTableViewCell *cell = (ASTableViewCell *)
    [self.documentTableView cellForRowAtIndexPath:aIndex];
	
	cell.mainText.enabled = YES;
	[cell.mainText becomeFirstResponder];
    [statusManager changeToRenameStatus];
    
}

//------------------------------------------------------------------------------
// - (void)addFolder
//------------------------------------------------------------------------------
- (void)addFolder
{	
//    [docWatcher invalidate];
	if([filesInCurrentDocument count] != 0)
    {//scroll the table view to the top
		[documentTableView scrollToRowAtIndexPath:[NSIndexPath 
                                              indexPathForRow:0 
                                              inSection:0]
                            atScrollPosition:UITableViewScrollPositionNone
                                    animated:YES];
	}
    
    
    //add new directory
	ASDirectoryEx *directory = 
    [[ASDataObjectManager sharedDataManager] 
     getDirectoryObject:
     [ASNewFileName nameOfNewFile:@"Untitled" toDirectory:currentDirectory]
     And:currentDirectory];
    [(ASDirectoryEx *)currentDirectory addNewItem:directory];
    
    //add to the tableView dataSource
	[filesInCurrentDocument insertObject:directory atIndex:0];
    
    //insert tableViewCell to the tableView
	NSArray *insertIndexPaths = [NSArray arrayWithObjects:
								 [NSIndexPath indexPathForRow:0 inSection:0],
								 nil];
	
	UITableView *tableView = (UITableView *)documentTableView;
	
	[tableView beginUpdates];
	[tableView insertRowsAtIndexPaths:insertIndexPaths 
					 withRowAnimation:UITableViewRowAnimationRight];
    [tableView endUpdates];
    addDirectory.enabled = NO;
	self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	
    //perfrom the setTextFiledFirstResponder Method after 0.3s
	[self performSelector:@selector(setTextFiledFirstResponder:) 
               withObject:indexPath
               afterDelay:0.3];
}

- (void)addTXT
{
    NSString *fileName = 
       [ASNewFileName nameOfNewFile:@"Text.txt" toDirectory:currentDirectory];
    NSMutableString *path = 
    [[NSMutableString alloc] initWithString:NSHomeDirectory()];
    [path appendString: @"/Documents/"];
    [path appendString: [currentDirectory getFullItemName]];
    [path appendFormat: @"/%@", fileName];
    
    ASFileEx *file_ = 
        [[ASDataObjectManager sharedDataManager] 
         getFileObject:fileName
         And:currentDirectory];
    [(ASDirectoryEx *)currentDirectory addNewItem:file_];
    
    ASTextViewController *txtViewController = [[ASTextViewController alloc] init];
    txtViewController.textPath = path;
    txtViewController.file = file_;
    [self.navigationController pushViewController: txtViewController 
                                         animated: YES];
    [txtViewController release];
    
    [path release];
}

//------------------------------------------------------------------------------
// - (IBAction) showMenu:(id)sender
//------------------------------------------------------------------------------
static int i = 1;
-(IBAction)showMenu:(id)sender
{
    if(popmenu)
    {
        [popmenu release];
        popmenu = nil;
    }
    switch (self.interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            popmenu = [[ASMenu alloc] initWithPoint:CGPointMake(7,230)
                                      andArrowPoint:CGPointMake(4,192)                      
                                      andDataSource:
                       [ASBottomMenuModel singletonASBottomMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(0));
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            popmenu = [[ASMenu alloc] initWithPoint:CGPointMake(126,50)
                                      andArrowPoint:CGPointMake(4,192)                                           
                                      andDataSource:
                       [ASBottomMenuModel singletonASBottomMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
            break;
        case UIInterfaceOrientationLandscapeLeft:
            popmenu = [[ASMenu alloc] initWithPoint:CGPointMake(83,283)
                                      andArrowPoint:CGPointMake(4,192)                                             
                                      andDataSource:
                       [ASBottomMenuModel singletonASBottomMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
            break;
        case UIInterfaceOrientationLandscapeRight:
            popmenu = [[ASMenu alloc] initWithPoint:CGPointMake(50,-1)
                                      andArrowPoint:CGPointMake(4,192)                                             
                                      andDataSource:
                       [ASBottomMenuModel singletonASBottomMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(90));
            break;
        default:
        break;
    }
    
    popmenu.delegate = self;
    [[[UIApplication sharedApplication] keyWindow] addSubview:popmenu];
    
    //change status to normalWithMenuStatus
    [statusManager changeToNormalWithMenuStatus];
    [UIView beginAnimations:@"image animation" context:nil];
    [UIView setAnimationDuration: 0.25];    
    CGAffineTransform  rotation = CGAffineTransformMakeRotation(-M_PI*(1.5)*i++);
    [self.addDirectory.imageView setTransform:rotation];
    [UIView commitAnimations];    
}

//------------------------------------------------------------------------------
// - (IBAction)refreshDirectory:(id)sender
//------------------------------------------------------------------------------
- (IBAction) refreshDirectory:(id)sender
{	
	[self showView];
	[self searchDocuments];
	[self reloadDataSourceBySort];
	[documentTableView reloadData];
    
}

//------------------------------------------------------------------------------
// - (void) copyFiles
//------------------------------------------------------------------------------
- (void) copyFiles
{
    //the files wanted to copy should not be none
	if([selectedFiles count] != 0)
    {
        ASFileOperateViewController *fileOperation = 
        [[ASFileOperateViewController alloc] init];
        
        NSMutableString *path = [[NSMutableString alloc] 
                                 initWithString:NSHomeDirectory()];
        [path appendString:@"/Documents/"];
        
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        fileOperation.arrayToOperate = tmpArray;
        [tmpArray release];
        for (id key in selectedFiles) 
        {
            [fileOperation.arrayToOperate addObject:[selectedFiles 
                                                     objectForKey:key]];
            [[ASDataObjectManager sharedDataManager] copyInClipBoard:[selectedFiles objectForKey:key]];
            id<ASDataObject> obj=[selectedFiles objectForKey:key];
            NSLog(@"from copyFiles:%@",[obj getFullItemName]);
        }
        
        ASDirectoryEx *tmpDirectory = [[ASDirectoryEx alloc] initWithFullPath:@"/"];
        fileOperation.currentItem = tmpDirectory;
        [tmpDirectory release];
        fileOperation.operation = YES;
        fileOperation.title = kMainDirctory;
        fileOperation.root = self;
        
        [self.navigationController pushViewController:fileOperation 
                                             animated:NO];
		
        [fileOperation release];
        [path release];
		//[self removeSelectedMark];
	}
    else 
    {
		[self showWarning:declare.selectedFilesEmpty];
	}
    
}

//------------------------------------------------------------------------------
// - (void) moveFiles
//------------------------------------------------------------------------------
- (void) moveFiles
{
    //the files wanted to move should not be none
	if (0 != [selectedFiles count]) 
    {
        indexPath = nil;
        ASFileOperateViewController *fileOperation = 
        [[ASFileOperateViewController alloc] init];
        NSMutableString *path = [[NSMutableString alloc] 
                                 initWithString:NSHomeDirectory()];
        [path appendString:@"/Documents/"];
        NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
        fileOperation.arrayToOperate = tmpArray;
        [tmpArray release];
        for (id key in selectedFiles) 
        {
            [fileOperation.arrayToOperate addObject:[selectedFiles 
                                                     objectForKey:key]];
            [[ASDataObjectManager sharedDataManager] moveInClipBoard:[selectedFiles objectForKey:key]];
        }
        
        ASDirectoryEx *tmpDirectory = [[ASDirectoryEx alloc] initWithFullPath:@"/"];
        fileOperation.currentItem = tmpDirectory;
        [tmpDirectory release];
        fileOperation.operation = NO;
        fileOperation.title = kMainDirctory;
        fileOperation.root = self;
        
        [self.navigationController pushViewController:fileOperation 
                                             animated:NO];
		[fileOperation release];
        [path release];
		//[self removeSelectedMark];
	}
    else
    {
		[self showWarning:declare.selectedFilesEmpty];
	}
}

//------------------------------------------------------------------------------
// - (void) deleteFile
//------------------------------------------------------------------------------
- (void) deleteFile
{
    //show the delete warning
	if ([self.selectedFiles count] != 0)
    {
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
    else 
    {
		[self showWarning:declare.selectedFilesEmpty];
	}
    
}

//------------------------------------------------------------------------------
// - (void) zipFiles
//------------------------------------------------------------------------------
- (void) zipFiles
{
    
	if (0 == [self.selectedFiles count]) 
    {
		[self showWarning:declare.selectedFilesEmpty];
	}
	else 
    {
		progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
		[self.navigationController.view addSubview:progressHUD];
		
		progressHUD.tag = kTAGOFZIP;
		progressHUD.delegate = self;
//		progressHUD.labelText = @"Waiting";
		
		[progressHUD showWhileExecuting:@selector(zip) onTarget:self withObject:nil animated:YES];
        
	}
}

//------------------------------------------------------------------------------
// - (NSString *)dataFilePath:(NSString *)fileName
//------------------------------------------------------------------------------
- (NSString *)dataFilePath:(NSString *)fileName
{
    NSMutableString *zipPath = [[[NSMutableString alloc] 
                                 initWithString:[[ASDataObjectManager sharedDataManager] 
                                                 getRootPath]] autorelease];

    [zipPath appendString:fileName];
    return zipPath;
}

//------------------------------------------------------------------------------
// - (void) didDeselected
//------------------------------------------------------------------------------
- (void) didDeselected
{
    if(nil != self.indexPath)
    {
        UITableViewCell *cell = [[self documentTableView]cellForRowAtIndexPath:self.indexPath];
        cell.selected = NO;
        
        id<ASDataObject> dataObj = [[self filesInCurrentDocument] objectAtIndex:[self.indexPath row]];
        if(kZip == [dataObj getFileType])
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [button addTarget:self
                       action:@selector(buttonTapped:event:) 
             forControlEvents:UIControlEventTouchUpInside];
            
            cell.accessoryView = button;
            cell.selected = NO;
        }
    }
    
}

//------------------------------------------------------------------------------
// - (void) zip
//------------------------------------------------------------------------------
- (void) zip
{
    
    BOOL isLargeFile = NO;
	NSString *zipName;
	NSArray *fileArray = [selectedFiles allValues];
   
    for(int i = 0; i < [fileArray count]; i++)
    {
        id<ASDataObject> dataObj = (id<ASDataObject>)[fileArray objectAtIndex:i];
        NSDictionary *dic = [dataObj getItemAttr];
        NSNumber *fileSize_ = (NSNumber *)[dic objectForKey:NSFileSize];
        if([fileSize_ intValue] > 100 * 1024 * 1024)
        {
            isLargeFile = YES;
        }
        else
        {
            isLargeFile = NO;
        }
    }
    
    if(NO == isLargeFile)
    {
    id<ASDataObject> dataObj = (id<ASDataObject>)[fileArray objectAtIndex:0];
    NSString *directoryPath = [[dataObj getFullItemName] stringByDeletingLastPathComponent];
    ASDirectoryEx *desDirectory = [[ASDirectoryEx alloc] initWithFullPath:directoryPath];
	
	if (1 == [fileArray count]) 
    {
		NSString *tempZipName = [[(id<ASDataObject> )[fileArray objectAtIndex:0] getItemName] stringByDeletingPathExtension];
        NSString *tempZipName2 = [tempZipName stringByAppendingPathExtension:@"zip"];
        zipName = [ASNewFileName nameOfNewFile:tempZipName2 toDirectory:desDirectory];
	}
	else 
    {
        zipName = [ASNewFileName nameOfNewFile:@"Archive.zip" toDirectory:desDirectory];
	}
	
    NSString *zipFullPath = [directoryPath stringByAppendingPathComponent:zipName];
    
    ASZipEx *aszip = [ASZipEx sharedASZipEx];
    [aszip zipFiles:fileArray toZip:[self dataFilePath:zipFullPath]
                   currentDirectory:desDirectory];
    
    [desDirectory release];
	
	ASFileEx *file = [[ASDataObjectManager sharedDataManager] 
					  getFileObject:zipName And:currentDirectory];
	ASDirectoryFirstSort *sort = [ASDirectoryFirstSort singleASDirectoryFirstSort];
	int i = [sort insertFile:file inToArray:filesInCurrentDocument];
    
	NSArray *insertIndexPaths = [NSArray arrayWithObjects:
								 [NSIndexPath indexPathForRow:i inSection:0],nil];
	UITableView *tableView = (UITableView*)documentTableView;
	[tableView beginUpdates];
	[tableView insertRowsAtIndexPaths:insertIndexPaths 
					 withRowAnimation:UITableViewRowAnimationRight];
    [tableView endUpdates];
    
    if(i <= [indexPath row])
    {
        self.indexPath = [NSIndexPath indexPathForRow:([indexPath row]+1) inSection:0];
    }
    
    if([selectedFiles count] != 0)
	{
		[selectedFiles removeAllObjects];
	}
	[self didDeselected];

//	[self.documentTableView setEditing:YES animated:NO];
    
    //return to unediting status
    if(YES == self.documentTableView.editing)
        [self toggleEdting:nil];
    }
    else
    {
        //show alert
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:declare.alertWarning
                                                            message:declare.fileTooLarge 
                                                           delegate:nil 
                                                  cancelButtonTitle:declare.fileIKnow 
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

//------------------------------------------------------------------------------
// - (void) emailFiles
//------------------------------------------------------------------------------
- (void) emailFiles
{
	//1判断是否能发邮件（不能提示没有网络）2判断是否有选中的文件（没有提示）3压缩文件，同时显示waiting 4waiting消失，显示发送邮件的界面 5界面消失，删除文件
	if ([MFMailComposeViewController canSendMail]) {
		if (0 == [self.selectedFiles count]) {
			[self showWarning:declare.selectedFilesEmpty];
		}
		else {
			progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
			[self.navigationController.view addSubview:progressHUD];
            
			progressHUD.tag = kTAGOFMAIL;
			progressHUD.delegate = self;
//			progressHUD.labelText = @"Waiting";
            
			[progressHUD showWhileExecuting:@selector(email) onTarget:self withObject:nil animated:YES];
            
		}
	}
	else {
		[self showWarning:declare.canNotSendMail];
	}
    
}

- (void) email
{
	NSArray *fileArray = [selectedFiles allValues];
    
    BOOL isLarge = NO;
    int fileSize = 0;
    for(ASFileEx *file in fileArray)
    {
        NSDictionary *dic = [file getItemAttr];
        NSNumber *size = [dic valueForKey:NSFileSize];
        fileSize += [size intValue];
    }
    if((fileSize/1024/1024)>30)
    {
        isLarge = YES;
    }
    if(NO == isLarge)
    {
        ASZipEx *aszip = [ASZipEx sharedASZipEx];
        ASDataObjectManager *dataObjectManager = [ASDataObjectManager sharedDataManager];
        NSMutableString *zipPath = [[NSMutableString alloc] initWithString:[dataObjectManager getRootPath]];
        [zipPath appendString:[currentDirectory getFullItemName]];
        [zipPath appendString:@"/fromiSharp.zip"];
        [aszip zipFiles:fileArray toZip:zipPath currentDirectory:currentDirectory];
        [zipPath release];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:declare.alertWarning
                                                        message:declare.fileTooLarge
                                                       delegate:nil
                                              cancelButtonTitle:declare.fileIKnow
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    
	if([selectedFiles count] != 0)
	{
		[selectedFiles removeAllObjects];
	}
}

//------------------------------------------------------------------------------
// - (void) shareFiles
//------------------------------------------------------------------------------
- (void)shareFiles
{
// 1.判断文件是否过大，过大提示“文件太大不可共享”。2不过大显示蓝牙的界面。
    if (0 == [self.selectedFiles count]) {
        [self showWarning:declare.selectedFilesEmpty];
    }
    else {
        NSArray *fileArray = [selectedFiles allValues];

        BOOL isLarge = NO;
        int fileSize = 0;
        for(ASFileEx *file in fileArray)
        {
            NSDictionary *dic = [file getItemAttr];
            NSNumber *size = [dic valueForKey:NSFileSize];
            fileSize += [size intValue];
        }
        if((fileSize/1024/1024)>30)
        {
            isLarge = YES;
        }
        if(NO == isLarge)
        {
            ASBluetoothViewController *bluetoothViewController = [ASBluetoothViewController sharedManager];
            bluetoothViewController.filePathArray = fileArray;
            bluetoothViewController.currentDirectory = currentDirectory;
            [bluetoothViewController show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:declare.alertWarning
                                                            message:declare.fileTooLarge
                                                           delegate:nil
                                                  cancelButtonTitle:declare.fileIKnow
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
        if([selectedFiles count] != 0)
        {
            [selectedFiles removeAllObjects];
        }
    }
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

//------------------------------------------------------------------------------
// - (void) formatToolBar
//------------------------------------------------------------------------------
- (void) formatToolBar 
{
    [statusManager handleForToolBar];
}

//------------------------------------------------------------------------------
// - (void) addEdtingButton
//------------------------------------------------------------------------------
- (void) addEdtingButton
{
    //the editing button is the navigation's rightBarButonItem
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:declare.fileListViewEdit
                                   style:UIBarButtonItemStyleBordered
                                   target:self 
                                   action:@selector(toggleEdting:)];
	self.navigationItem.rightBarButtonItem = editButton;
    
	[editButton release];
}

//------------------------------------------------------------------------------
// - (IBAction)togglEdting:(id)sender
//------------------------------------------------------------------------------
-(IBAction)toggleEdting:(id)sender
{//change the tableViewEditing status
    [self didDeselected];
    [self searchBarCancelButtonClicked: self.searchBar];
	[self.documentTableView setEditing:!self.documentTableView.editing animated:YES];
	
	if([selectedFiles count] != 0)
    {
		[selectedFiles removeAllObjects];
    }
	
	if(self.documentTableView.editing)
	{
		[self.navigationItem.rightBarButtonItem setTitle:declare.navDone];
		UIBarButtonItem *selectBtn = [[UIBarButtonItem alloc] 
									  initWithTitle:declare.fileListSelectedAll 
									  style:UIBarButtonItemStyleBordered 
									  target:self 
									  action:@selector(selectedAll:)];
		self.navigationItem.hidesBackButton = YES;
		self.navigationItem.leftBarButtonItem = selectBtn;
		[selectBtn release];
		
        [statusManager changeToEdtingStatus];
	}
    else 
    {
        [self hideKeyboard: nil];
		[self.navigationItem.rightBarButtonItem setTitle:declare.navEdit];
		self.navigationItem.leftBarButtonItem = nil;
		self.navigationItem.hidesBackButton = NO;
        if (self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown||
            self.interfaceOrientation == UIInterfaceOrientationPortrait) 
        {
            CGRect ret = [[UIApplication sharedApplication] statusBarFrame];
            CGFloat h = ret.size.height;
            self.view.center = CGPointMake(160, (394-h)/2);//186
            self.searchBar.frame = CGRectMake(0.0f, 460.0f, 320.0f, 44.0f);
        }
        else
        {
            self.view.center = CGPointMake(240, 118);//118 (256-h)/2
            self.searchBar.frame = CGRectMake(0.0f, 460.0f, 480.0f, 44.0f);
        }
        
        [statusManager changeToNormalWithoutMenuStatus];	
	}
    self.indexPath = nil;
    
    [self formatToolBar];
    
    numButton.hidden = YES;
}

//------------------------------------------------------------------------------
// - (void) hideKeyboard:(UISwipeGestureRecognizer *)recognizer
//------------------------------------------------------------------------------
- (void) hideKeyboard:(UISwipeGestureRecognizer *)recognizer
{
	//documentTableView.allowsSelection = YES;
	if ([filesInCurrentDocument count] > [indexPath row]) 
    {
		ASTableViewCell *cell = (ASTableViewCell *)[documentTableView 
													cellForRowAtIndexPath:indexPath];
		id<ASDataObject> dataObj = [filesInCurrentDocument objectAtIndex:[indexPath row]];
		if (0 != [[dataObj getItemName] length]) 
        {
			cell.mainText.text = [[dataObj getItemName] stringByDeletingPathExtension];
		}
		else 
        {
			cell.mainText.text = [dataObj getItemName];
		}
		
        if (self.indexPath != nil)
        {
            [documentTableView setContentOffset: pointOfCell animated: YES];
        }
        
		[cell.mainText resignFirstResponder];
		cell.mainText.enabled = NO;
		addDirectory.enabled = YES;
        if(YES == self.documentTableView.editing)
            [statusManager changeToEdtingStatus];
        else
            [statusManager changeToNormalWithoutMenuStatus];
	}
}

//------------------------------------------------------------------------------
// - (IBAction) textFieldDidEndEditing:(id)sender
//------------------------------------------------------------------------------
- (IBAction) textFieldDidEndEditing:(id)sender
{
    self.documentTableView.userInteractionEnabled = YES;
    NSString *fileName;
    NSString *postfix;
    BOOL isExist;
    
    //recover the view center and resignFirstResponder
    UITextField *textField = (UITextField *)sender;
	[textField resignFirstResponder];
	
    //get the tableViewCell the textField in
	UIView *contentView = (UIView *) textField.superview;
	ASTableViewCell *cell = (ASTableViewCell *) contentView.superview;
	NSIndexPath *indexpath = [documentTableView indexPathForCell:cell];
	NSInteger row = [indexpath row];
    
    id<ASDataObject> dataObj = [filesInCurrentDocument objectAtIndex:row];
    fileName = [dataObj getFullItemName];
    postfix = [dataObj getFileTypeExtension]; // get file postfix
    id<ASDataObject> tmpObj = nil;
    
    //rename
    if(0 != [textField.text length])
    {

        NSMutableString *newFileName = [[NSMutableString alloc] 
                                        initWithString:textField.text];        
        
        if(kDirectory == [dataObj getFileType] /*|| kUnknow == [dataObj getFileType]*/)//check if directory
        {
            [newFileName appendString:@""];
        }
        if([postfix isEqualToString:@""])
        {
            [newFileName appendString:postfix];
        }
        else 
        {
            [newFileName appendString:@"."];
            
            [newFileName appendString:postfix];
        }
        
        if ([currentDirectory isMemberOfClass: [ASDirectoryEx class]])
        {
            tmpObj = [[ASDataObjectManager sharedDataManager] getDirectoryObject:newFileName And:currentDirectory];
        }
        else
        {
            tmpObj = [[ASDataObjectManager sharedDataManager] getFileObject:newFileName And:currentDirectory];
        }
        isExist = [[ASDataObjectManager sharedDataManager] isItemExist:tmpObj];
        
        if(NO == isExist)
        {
            ASDataObjectManager *dataManager = [ASDataObjectManager sharedDataManager];
            [dataManager rename:fileName With:newFileName];
        }
        else
        {
            fileName=[fileName lastPathComponent];
			if(NSOrderedSame ==([textField.text compare:fileName])
               ||NSOrderedSame == ([textField.text compare:[fileName stringByDeletingPathExtension]]))
				//ignore click done without reame
			{
                [filesInCurrentDocument removeObjectAtIndex:row];
                ASDirectoryFirstSort *sort = [ASDirectoryFirstSort singleASDirectoryFirstSort];
                int i = [sort insertFile:tmpObj inToArray:filesInCurrentDocument];
                if (row != i) 
                {
                    NSIndexPath *delPath = [NSIndexPath indexPathForRow:row inSection:0];
                    NSIndexPath *addPath = [NSIndexPath indexPathForRow:i inSection:0];
                    UITableView *tableView = (UITableView*)documentTableView;
                    [tableView beginUpdates];
                    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:delPath] 
                                     withRowAnimation:UITableViewRowAnimationFade];
                    [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:addPath] 
                                     withRowAnimation:UITableViewRowAnimationRight];
                    [tableView endUpdates];
                }
			}
            else
            {
//                [self showWarning:declare.renameWarning];
                UIAlertView *alertView = [[UIAlertView alloc] 
                                          initWithTitle:declare.alertWarning
                                          message:declare.renameWarning 
                                          delegate:self 
                                          cancelButtonTitle:declare.fileListViewAlertSure 
                                          otherButtonTitles:nil];
                alertView.tag = KTAGOFSAMENAME;
                [alertView show];
            }
			if (0 != [[fileName pathExtension] length]) 
            {
				textField.text = [fileName stringByDeletingPathExtension];
			}
			else 
            {
				textField.text = fileName;
			}
        }
        
        [newFileName release];
        newFileName = nil;
    }
    else if(0 == [textField.text length])
    {
        textField.text = fileName;
    }
    
    addDirectory.enabled = YES;
    cell.mainText.enabled = NO;
    
    if(NO == isExist)
    {        
        [filesInCurrentDocument removeObjectAtIndex:row];
        ASDirectoryFirstSort *sort = [ASDirectoryFirstSort singleASDirectoryFirstSort];
        int i = [sort insertFile:tmpObj inToArray:filesInCurrentDocument];
        if (row != i) 
        {
            NSIndexPath *delPath = [NSIndexPath indexPathForRow:row inSection:0];
            NSIndexPath *addPath = [NSIndexPath indexPathForRow:i inSection:0];
            UITableView *tableView = (UITableView*)documentTableView;
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:delPath] 
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:addPath] 
                             withRowAnimation:UITableViewRowAnimationRight];
            [tableView endUpdates];
        }
    }
    
    if(YES == documentTableView.editing)
    {
        [statusManager changeToEdtingStatus];
    }
    else
    {
        [statusManager changeToNormalWithoutMenuStatus];
    }

        
//    [self addDirectoryWatcher];
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
                        
            [documentTableView beginUpdates];
            for (id key in selectedFiles) 
            {
                id<ASDataObject> dataObj = [selectedFiles objectForKey:key];
                [dataObj remove];
                
                [documentTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:key]
                                 withRowAnimation:UITableViewRowAnimationFade];
                
                [filesInCurrentDocument removeObject:dataObj];
            }
            [documentTableView endUpdates];
            [selectedFiles removeAllObjects];
            numButton.hidden = YES;
            
            if(NO == isForSearch)
            {
                [self formatToolBar];
//            	[self refreshDocuementsWithoutAnimation];
            }
            indexPath = nil;
        }
        else if(1 == buttonIndex)
        {
            ;
        }
    }
    else if(KTAGOFSEARCHALERT == alertView.tag)
    {
        if(0 == buttonIndex)
        {
            NSLog(@"NO Result");
            [self.navigationController popViewControllerAnimated:YES];
            isForSearch = NO;
        }
    }
    else if(KTAGOFSAMENAME == alertView.tag)
    {
        if(0 == buttonIndex)
        {
            [self doRename];
        }
    }
}


#pragma mark -
#pragma mark Method For search And Delegate Method
//------------------------------------------------------------------------------
// - (void)keyboardWillShow:(NSNotification *)notification
//------------------------------------------------------------------------------
- (void)keyboardWillShow:(NSNotification *)notification
{
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
	/*
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) 
    {
        [[NSNotificationCenter defaultCenter] 
          removeObserver: self 
                    name: UIKeyboardWillChangeFrameNotification 
                  object: nil];
    }
#endif
    */
    self.navigationItem.rightBarButtonItem.enabled = NO;
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	
    CGSize kbSize=[aValue CGRectValue].size;
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
//    CGRect keyboardRect = [aValue CGRectValue];
//    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
//    
//    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newSearchFrame = searchBar.bounds;
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait||self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        newSearchFrame.origin.y = self.view.frame.size.height - (kbSize.height + searchBar.bounds.size.height)+44;// - 87;
        
        if (pointOfCell.y > 416-kbSize.height) 
        {
            [self.documentTableView setContentOffset:
             CGPointMake(0, pointOfCell.y-(410-kbSize.height)) animated:YES];
        }
    }
    else{
        newSearchFrame.origin.y = self.view.frame.size.height - (kbSize.width + searchBar.bounds.size.height)+32;//-128;
        
        if(pointOfCell.y > 268-kbSize.width)
        {
            [self.documentTableView setContentOffset:
             CGPointMake(0, pointOfCell.y-(260-kbSize.width)) animated:YES];
        }
    }
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    searchBar.frame = newSearchFrame;
    [UIView commitAnimations];
    
    
}

//------------------------------------------------------------------------------
// - (void)keyboardWillHide:(NSNotification *)notification 
//------------------------------------------------------------------------------
- (void)keyboardWillHide:(NSNotification *)notification 
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
    NSDictionary* userInfo = [notification userInfo];
    
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = 
    [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait||self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        searchBar.frame = CGRectMake(-100, 460, 320, 44);
    else
        searchBar.frame = CGRectMake(-100.0f, 460.0f, 480.0f, 44.0f);
    //searchBar.frame = CGRectMake(0, 460, 320, 44);
    
    [UIView commitAnimations];
    
    if (self.documentTableView.editing)
    {
        [self hideKeyboard: nil];
    }
	
	[[NSNotificationCenter defaultCenter] 
     removeObserver: self 
     name: UIKeyboardWillShowNotification 
     object: nil];
    [[NSNotificationCenter defaultCenter] 
     removeObserver: self 
     name: UIKeyboardWillHideNotification 
     object: nil];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)aSearchBar
{
    aSearchBar.barStyle = UIBarStyleBlack;
    aSearchBar.tintColor = [UIColor blackColor];
    return YES;
}
//------------------------------------------------------------------------------
// - (void)searchBarTextDidBeginEditing:(UISearchBar *)aSearchBar
//------------------------------------------------------------------------------
- (void)searchBarTextDidBeginEditing:(UISearchBar *)aSearchBar 
{
    aSearchBar.barStyle = UIBarStyleBlack;
    aSearchBar.tintColor = [UIColor blackColor];
	aSearchBar.text = @"";
    [aSearchBar setShowsCancelButton:YES animated:YES];
    documentTableView.allowsSelection = NO;
    documentTableView.scrollEnabled = NO;
}

//------------------------------------------------------------------------------
// - (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar
//------------------------------------------------------------------------------
- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar
{
    aSearchBar.text=@"";
    
    [aSearchBar setShowsCancelButton:NO animated:YES];
    [aSearchBar resignFirstResponder];
    [aSearchBar removeFromSuperview];
    documentTableView.allowsSelection = YES;
    documentTableView.scrollEnabled = YES;

    isForSearch = NO;
//    [self refreshDocuements];
}

//------------------------------------------------------------------------------
// - (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
//------------------------------------------------------------------------------
- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar 
{
    
	[aSearchBar setShowsCancelButton:NO animated:YES];
	documentTableView.allowsSelection = YES;
    documentTableView.scrollEnabled = YES;
    
    ASFileListViewController *resultView = 
    [[ASFileListViewController alloc] initWithNibName:@"ASFileListViewController"
                                               bundle:nil];
    [resultView.documentTableView sizeToFit];
    resultView.title = kResultList;
    resultView.searchString = aSearchBar.text;
    resultView.isForSearch = YES;
    
    [aSearchBar resignFirstResponder];
    [aSearchBar removeFromSuperview];
    
    [self.navigationController pushViewController:resultView animated:YES];
    [resultView release];

}

#pragma mark -
#pragma mark Method For View Will Appear
//------------------------------------------------------------------------------
// - (void) readyForFileListView
//------------------------------------------------------------------------------
- (void) readyForFileList
{   
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.tintColor = [UIColor blackColor];
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.toolbar.alpha = 1.0f;

    [self.navigationController setToolbarHidden:NO];
    if(NO == self.documentTableView.editing)
        [statusManager changeToNormalWithoutMenuStatus];
    else
        [statusManager changeToEdtingStatus];
    [self formatToolBar];
    [self addEdtingButton];
    
    if(searchBar)
        [searchBar release];
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 460, 320, 44)];
    searchBar.barStyle = UIBarStyleBlack;
    searchBar.tintColor = [UIColor blackColor];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    if(YES == documentTableView.editing)
    {
        [self.navigationItem.rightBarButtonItem setTitle:declare.navDone];
    }
}

//------------------------------------------------------------------------------
// - (void) readyForSearchView
//------------------------------------------------------------------------------
- (void) readyForSearchView
{
    [self.navigationController setToolbarHidden:YES];    
}

- (void) reloadDateForFileList
{
    [self searchDocuments];
    [documentTableView reloadData];
}

- (void) reloadDataForSearchView
{
    if(nil != searchString)
    {
        id<ASDataObject> root = [[ASDirectoryEx alloc] initWithFullPath:@"/"];
        if(0 != [filesInCurrentDocument count])
        {
            [filesInCurrentDocument removeAllObjects];
        }
        
        ASSortMenuModel *model = [ASSortMenuModel singletonASSortMenuModel];
        int iType = [model getSortType];
        int iFlag = [model getSortFlag];
        
        [filesInCurrentDocument addObjectsFromArray:
            [[ASDataObjectManager sharedDataManager] 
            search:searchString From:root]];
        ASDirectoryFirstSort *directorySort = 
            [ASDirectoryFirstSort singleASDirectoryFirstSort];
        [directorySort directoryFirstSort:filesInCurrentDocument 
                              compareType:iType isAsc:iFlag];
        [root release];
        if(0 == [filesInCurrentDocument count])
        {//if none, show alert
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle:declare.resultAlertWarning
                                  message:declare.resultAlertMessage
                                  delegate:self
                                  cancelButtonTitle:declare.resultAlertSure
                                  otherButtonTitles:nil];
            alert.tag = KTAGOFSEARCHALERT;
            
            [alert show];            
            [alert release];
        }
    }
    
    [documentTableView reloadData];
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
                            initWithTarget:self action:@selector(tapGestureRecognizer:)];

	tapGestureRecognizer.cancelsTouchesInView = NO;

    [self.view addGestureRecognizer:tapGestureRecognizer];
}

//------------------------------------------------------------------------------
// - (void) cleanSelectedObjs
//------------------------------------------------------------------------------
- (void) cleanSelectedObjs
{
    if([selectedFiles count] != 0)
    {
        [selectedFiles removeAllObjects];
    }
    numButton.hidden = YES;
}

#pragma mark -
#pragma mark Music Player Delegate Method
//------------------------------------------------------------------------------
// -(void)changeCurrentTime
//------------------------------------------------------------------------------
- (void)changeCurrentTime
{
	NSArray *cellArray = [documentTableView visibleCells];
	for (ASTableViewCell *cell in cellArray) 
    {
		if (nil != cell.mp3Slider) 
        {
            id<ASDataObject> dataObj = [filesInCurrentDocument 
                objectAtIndex:[[documentTableView indexPathForCell:cell]row]];
            ASDataObjectManager *dataManager = 
            [ASDataObjectManager sharedDataManager];
            NSString *currentPath = 
                [[dataManager getRootPath] 
                stringByAppendingFormat:@"%@",[dataObj getFullItemName]];
            
			NSString *filePath = [currentPath 
                stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];			
			NSURL *url = [[NSURL alloc] initWithString:filePath];
            [cell.mp3Slider setValue:[ASMusicPlayer currentTime:url]];

			[url release];
		}
	}
}
//------------------------------------------------------------------------------
// -(void)playToTheEndOfMusic
//------------------------------------------------------------------------------
- (void)playToTheEndOfMusic
{
	NSArray *cellArray = [documentTableView visibleCells];
	for (ASTableViewCell *cell in cellArray) 
    {
		if (nil != cell.mp3Slider) 
        {
            id<ASDataObject> dataObj = [filesInCurrentDocument 
                                        objectAtIndex:[[documentTableView indexPathForCell:cell]row]];
            ASDataObjectManager *dataManager = 
            [ASDataObjectManager sharedDataManager];
            NSString *currentPath = 
            [[dataManager getRootPath] 
             stringByAppendingFormat:@"%@",[dataObj getFullItemName]];
			NSString *filePath = [currentPath 
                                  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];			
			NSURL *url = [[NSURL alloc] initWithString:filePath];
			if ([ASMusicPlayer isSameURL:url]) 
            {
				[((UIButton *)cell.accessoryView) 
                 setImage:play forState:UIControlStateNormal];
                [cell.mp3Slider setValue:0.0f];
			}
			[url release];
		}
	}
}

//------------------------------------------------------------------------------
// - (void)startOrStop:(id)sender
//------------------------------------------------------------------------------
-(void) startOrStop:(id)sender
{
	if (play == ((UIButton *)sender).currentImage) 
    {
		[((UIButton *)sender) setImage:pause forState:UIControlStateNormal];
	}
	else 
    {
		[((UIButton *)sender) setImage:play forState:UIControlStateNormal];
	}
	
	UITableViewCell *cell = (UITableViewCell *)[sender superview];
	NSIndexPath *cellIndex = [self.documentTableView indexPathForCell:cell];
    id<ASDataObject> dataObj = [filesInCurrentDocument 
        objectAtIndex:[cellIndex row]];
    ASDataObjectManager *dataManager = 
        [ASDataObjectManager sharedDataManager];
    NSString *currentPath = 
        [[dataManager getRootPath] 
        stringByAppendingFormat:@"%@",[dataObj getFullItemName]];
    NSString *filePath = [currentPath 
        stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];			
	NSURL *url = [[NSURL alloc] initWithString:filePath];
	[ASMusicPlayer stopOrPlay:url];
	[url release];
}

#pragma mark -
#pragma mark TableView Delegate Mehod
//------------------------------------------------------------------------------
// - (NSInteger)tableView:(UITableView *)tableView 
//  numberOfRowsInSection:(NSInteger) section
//------------------------------------------------------------------------------
- (NSInteger) tableView : (UITableView *) tableView
  numberOfRowsInSection : (NSInteger) section
{
	return [filesInCurrentDocument count];
}

//------------------------------------------------------------------------------
// - (UITableViewCell*)tableView:(UITableView*)tableView
//         cellForRowAtIndexPath:(NSIndexPath*)indexPath
//------------------------------------------------------------------------------
-(UITableViewCell*)tableView:(UITableView*)tableView
	   cellForRowAtIndexPath:(NSIndexPath*)aIndexPath
{
	static NSString* docCellIdentifier = @"docCellIdecntifier";
	
    ASTableViewCell *cell = (ASTableViewCell*)
    [tableView dequeueReusableCellWithIdentifier:docCellIdentifier];
	
	if(nil == cell)
    {
		cell = [[[ASTableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:docCellIdentifier] 
                autorelease];
		UIGestureRecognizer *recognizer;
		recognizer = [[UISwipeGestureRecognizer alloc] 
                      initWithTarget:self 
                      action:@selector(handleSwipeFrom:)];
		[cell addGestureRecognizer:recognizer];
		[recognizer release];
        
        cell.mainText.enabled = NO;
        [cell.mainText addTarget:self action:@selector(textFieldDidEndEditing:) 
                forControlEvents:UIControlEventEditingDidEndOnExit];
        
        UIButton *editingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editingButton.backgroundColor = [UIColor clearColor];
        editingButton.frame = CGRectMake(0, 0, 29, 29);
        [editingButton setBackgroundImage:[UIImage 
                                           imageNamed:@"rename.png"] 
                                 forState:UIControlStateNormal];
        
        [editingButton addTarget:self 
                          action:@selector(editingButtonTapped:event:) 
                forControlEvents:UIControlEventTouchUpInside];
        
        cell.editingAccessoryView = editingButton;
    }

	NSUInteger row = [aIndexPath row];
    
    id<ASDataObject> dataObj = [filesInCurrentDocument objectAtIndex:row];
	[cell confirmCell:dataObj];
    
    [imgManager performSelectorOnMainThread:@selector(manage:) 
                                 withObject:cell.iconView
                              waitUntilDone:YES];
    
    if ([dataObj getFileType] != kDirectory)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button addTarget:self 
                   action:@selector(buttonTapped:event:) 
         forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
    }
    else
    {
        cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	return cell;
}

#pragma mark -
#pragma mark Table View Delegate Method
//------------------------------------------------------------------------------
// - (void)buttonTapped:(id)sender event:(id)event
//------------------------------------------------------------------------------
- (void)buttonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.documentTableView];
	NSIndexPath *indexpath = [self.documentTableView 
                              indexPathForRowAtPoint: currentTouchPosition];
	if (indexpath != nil)
	{
		[self tableView: self.documentTableView 
            accessoryButtonTappedForRowWithIndexPath: indexpath];
	}
}
//------------------------------------------------------------------------------
// - (void) editingButtonTapped:(id)sender event:(id)event
//------------------------------------------------------------------------------
- (void) editingButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:self.documentTableView];
	NSIndexPath *indexpath = [self.documentTableView 
                              indexPathForRowAtPoint: currentTouchPosition];
	
	self.indexPath = indexpath;
    pointOfCell = documentTableView.contentOffset;
	if (currentTouchPosition.y > 200) {
		[self.documentTableView setContentOffset:
         CGPointMake(0, currentTouchPosition.y-170) 
                                   animated:YES];
	}
    
	if (indexPath) {
		[self tableView: self.documentTableView 
            accessoryButtonTappedForRowWithIndexPath: indexPath];
	}
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
}

//------------------------------------------------------------------------------
// - (void)tableView:(UITableView *)tableView 
//    didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
//------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)aIndexPath 
{
    [statusManager handleDidSelectRowAtIndexPath:aIndexPath];
    if (!documentTableView.editing) {
        [documentTableView deselectRowAtIndexPath: aIndexPath animated: YES];
    }
}

//------------------------------------------------------------------------------
// - (void)tableView:(UITableView *)tableView 
//didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView 
didDeselectRowAtIndexPath:(NSIndexPath *)aIndexPath 
{
    [statusManager handleDidDeselectRowAtIndexPath:aIndexPath];
}

//------------------------------------------------------------------------------
// - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView 
//            editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
//------------------------------------------------------------------------------
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView 
		   editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{ //set more optional
    return  UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
} 

//------------------------------------------------------------------------------
// - (void)tableView:(UITableView *)tableView
//accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
//------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView 
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)aIndexPath
{
    [statusManager handleAccessoryButtonTappedForRowWithIndexPath:aIndexPath];
}


#pragma mark -
#pragma mark add pictures or videos from Albums
//------------------------------------------------------------------------------
// - (void)addPicturesOrVideos
//------------------------------------------------------------------------------
//视频播放完成后事件
- (void) playbackDidFinish
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 0.9;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.opaque = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque
                                                animated:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    if (moviePlayViewController)
    {
        [self dismissMoviePlayerViewControllerAnimated];
        [moviePlayerController pause];
        [moviePlayViewController release];
        moviePlayViewController=nil;
        [timer invalidate];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}


- (void)playVideo
{
    [self presentMoviePlayerViewControllerAnimated:moviePlayViewController];
    self.moviePlayViewController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    self.moviePlayViewController.moviePlayer.fullscreen = NO;
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackDidFinish) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

- (void)addPicturesOrVideos
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]
        ) {
		UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
		imagePickerController.mediaTypes = [NSArray arrayWithObjects:(NSString*)kUTTypeImage,(NSString*)kUTTypeMovie,nil];
        imagePickerController.delegate = self;
		imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
		imagePickerController.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
		[self presentModalViewController:imagePickerController animated:YES];
        imagePickerController.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        imagePickerController.tabBarController.tabBar.backgroundColor = self.navigationController.navigationBar.tintColor;

        //[UIColor colorWithRed:0.5 green:0.5 blue:1 alpha:1];
		[imagePickerController release];
	}	
}

//------------------------------------------------------------------------------
// - (void)imagePickerController:(UIImagePickerController *)picker 
//   didFinishPickingMediaWithInfo:(NSDictionary *)info
// funtion:从相册选择视或图像频之后的操作
//------------------------------------------------------------------------------
- (void)imagePickerController:(UIImagePickerController *)picker 
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *caldate = [[now description] substringToIndex:19];
    NSString *path;
	if ([mediaType isEqualToString:@"public.movie"]){  
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
		NSString *tempFilePath = [videoURL path];
        if ([[currentDirectory getFullItemName] isEqualToString:@""] == YES) {
            path = [NSString stringWithFormat:@"%@/%@.mov",DOCUMENTS_FOLDER,caldate];
        }else{
            path = [NSString stringWithFormat:@"%@%@/%@.mov",DOCUMENTS_FOLDER,[currentDirectory getFullItemName],caldate];
        }
        [fm copyItemAtPath:tempFilePath toPath:path error:nil];
        
	}
    else if ([mediaType isEqualToString:@"public.image"]){  
        
        float rotate;
        UIImage *newImage;
        UIImage *tempImage =[info objectForKey:UIImagePickerControllerOriginalImage];
        
        if (tempImage.imageOrientation == UIImageOrientationRight ) {
            rotate = M_PI_2;
            UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,tempImage.size.height, tempImage.size.width)];
            rotatedViewBox.center = self.view.center;
            CGAffineTransform t = CGAffineTransformMakeRotation(rotate);
            rotatedViewBox.transform = t;
            CGSize rotatedSize = rotatedViewBox.frame.size;
            [rotatedViewBox release];
            
            UIGraphicsBeginImageContext(rotatedSize);
            CGContextRef bitmap = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(bitmap,rotatedSize.height/2, rotatedSize.width/2);
            CGContextRotateCTM(bitmap, rotate);
            CGContextScaleCTM(bitmap, 1, -1);
            CGContextDrawImage(bitmap, CGRectMake(-tempImage.size.width / 2, -tempImage.size.height / 2, tempImage.size.height, tempImage.size.width), [tempImage CGImage]);
            newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

        }else if(tempImage.imageOrientation == UIImageOrientationLeft ) {
            rotate = -M_PI_2;
            UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,tempImage.size.height, tempImage.size.width)];
            rotatedViewBox.center = self.view.center;
            CGAffineTransform t = CGAffineTransformMakeRotation(rotate);
            rotatedViewBox.transform = t;
            CGSize rotatedSize = rotatedViewBox.frame.size;
            [rotatedViewBox release];
            
            UIGraphicsBeginImageContext(rotatedSize);
            CGContextRef bitmap = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(bitmap,rotatedSize.width/2, rotatedSize.height/2);
            CGContextRotateCTM(bitmap, rotate);
            CGContextScaleCTM(bitmap, 1, -1);
            CGContextDrawImage(bitmap, CGRectMake(-tempImage.size.height / 2, -tempImage.size.width / 2, tempImage.size.height, tempImage.size.width), [tempImage CGImage]);
            newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

        }else if(tempImage.imageOrientation == UIImageOrientationDown ) {
            rotate = 2*M_PI_2;
            UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,tempImage.size.width, tempImage.size.height)];
            rotatedViewBox.center = self.view.center;
            CGAffineTransform t = CGAffineTransformMakeRotation(rotate);
            rotatedViewBox.transform = t;
            CGSize rotatedSize = rotatedViewBox.frame.size;
            [rotatedViewBox release];
            
            UIGraphicsBeginImageContext(rotatedSize);
            CGContextRef bitmap = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(bitmap,rotatedSize.width/2, rotatedSize.height/2);
            CGContextRotateCTM(bitmap, rotate);
            CGContextScaleCTM(bitmap, 1, -1);
            CGContextDrawImage(bitmap, CGRectMake(-tempImage.size.width / 2, -tempImage.size.height / 2, tempImage.size.width, tempImage.size.height), [tempImage CGImage]);
            newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

        }else{
            NSData *imagedata = UIImagePNGRepresentation(tempImage);
            if ([[currentDirectory getFullItemName] isEqualToString:@""] == YES) {
                path = [NSString stringWithFormat:@"%@/%@.png",DOCUMENTS_FOLDER,caldate];
            }else{
                path = [NSString stringWithFormat:@"%@%@/%@.png",DOCUMENTS_FOLDER,[currentDirectory getFullItemName],caldate];
            }
            [imagedata writeToFile:path atomically:YES];
            [picker dismissModalViewControllerAnimated:YES]; 
            return;
        }
        NSData *imagedata = UIImagePNGRepresentation(newImage);
        if ([[currentDirectory getFullItemName] isEqualToString:@""] == YES) {
            path = [NSString stringWithFormat:@"%@/%@.png",DOCUMENTS_FOLDER,caldate];
        }else{
            path = [NSString stringWithFormat:@"%@%@/%@.png",DOCUMENTS_FOLDER,[currentDirectory getFullItemName],caldate];
        }
        [imagedata writeToFile:path atomically:YES];
    }
     
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark methoeds of take picture and record video or audio
//------------------------------------------------------------------------------
// -(void)showCamera:(id)sender
// fuction:take picture interface
//------------------------------------------------------------------------------

-(void)showCamera
{
    UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
        imagePickerController.showsCameraControls = YES;
        imagePickerController.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;

        [self presentModalViewController:imagePickerController animated:YES];
    }
    [imagePickerController release];
}

//------------------------------------------------------------------------------
// -(void)showCamcorder:(id)sender
// fuction:record video interface
//------------------------------------------------------------------------------
-(void)showCamcorder
{
	NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
	if([mediaTypes containsObject:@"public.movie"]){
		UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
        imagePickerController.toolbar.tintColor= self.navigationController.navigationBar.tintColor;
		imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];
		imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
		imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
		imagePickerController.delegate = self;
		imagePickerController.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;

        [self presentModalViewController:imagePickerController animated:YES];
        [imagePickerController release];
	}
}

//------------------------------------------------------------------------------
// - (void)recordAudios
//------------------------------------------------------------------------------
- (void)recordAudios
{
    ASMediaPlayerViewController *mediaPlayerViewController = 
    [[ASMediaPlayerViewController alloc] initWithNibName:@"ASMediaPlayerViewController" bundle:nil]; 
    mediaPlayerViewController.currentDirectory = [self.currentDirectory getFullItemName];
    mediaPlayerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:mediaPlayerViewController animated:YES];
    [mediaPlayerViewController changeNavigationBarColorWithColor:self.navigationController.navigationBar.tintColor];
    
    [mediaPlayerViewController release];
    
}

//------------------------------------------------------------------------------
// - (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//------------------------------------------------------------------------------
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{    
	[picker dismissModalViewControllerAnimated:YES];
}

#pragma mark methoeds of add music

//------------------------------------------------------------------------------
// -(void) addMusic:(id)sender
// fuction:add music interface
//------------------------------------------------------------------------------
-(void)addMusic
{
    MPMediaPickerController *picker =
    [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
    picker.delegate					    = self;
    picker.allowsPickingMultipleItems	= NO;
    picker.prompt						= @"新增歌曲";
    picker.hidesBottomBarWhenPushed = YES;
    picker.tabBarController.view.backgroundColor = self.navigationController.navigationBar.tintColor;
    picker.navigationController.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, 49);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    UIColor *color = [[UIColor alloc] initWithRed:255.0
                                            green:255.0
                                             blue:255.0
                                            alpha:1.0];
    [view setBackgroundColor:color];
    [color release];
    [[[picker tabBarController] tabBar] insertSubview:view atIndex:0];
    [view release];
    [self presentModalViewController: picker animated: YES];
}

//------------------------------------------------------------------------------
// - (void) mediaPicker: (MPMediaPickerController *) mediaPicker 
//    didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
// fuction:choose a music and save to local directory
//------------------------------------------------------------------------------
- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection 
{
    [self dismissModalViewControllerAnimated: YES];
    [progress startAnimating];
    progress.center = self.view.center;
	NSFileManager *fm = [NSFileManager defaultManager];
    for(MPMediaItem *item in [mediaItemCollection items])
	{
        NSString *musicName;
        if ([[currentDirectory getFullItemName] isEqualToString:@""] == YES) {
            musicName = [[NSString alloc] initWithFormat:@"%@/%@.caf",DOCUMENTS_FOLDER,[item valueForProperty:MPMediaItemPropertyTitle]];
        }else{
            musicName = [[NSString alloc] initWithFormat:@"%@%@/%@.caf",DOCUMENTS_FOLDER,[currentDirectory getFullItemName],[item valueForProperty:MPMediaItemPropertyTitle]];
        }
        // set up an AVAssetReader to read from the iPod Library
        NSURL *assetURL = [item valueForProperty:MPMediaItemPropertyAssetURL];
        AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:assetURL options:nil];
        
        AVAssetReader *assetReader = [[AVAssetReader assetReaderWithAsset:songAsset error:nil]retain];
        AVAssetReaderOutput *assetReaderOutput = [[AVAssetReaderAudioMixOutput
            assetReaderAudioMixOutputWithAudioTracks:songAsset.tracks
            audioSettings: nil] retain];
        [assetReader addOutput: assetReaderOutput];
      
        if (YES == [fm fileExistsAtPath:musicName]) {
            [musicName release];
            [assetReaderOutput release];
            [assetReader release];
            [progress stopAnimating];
            continue;
        }
        NSURL *exportURL = [NSURL fileURLWithPath:musicName];
        AVAssetWriter *assetWriter = 
            [[AVAssetWriter assetWriterWithURL:exportURL
                                      fileType:AVFileTypeCoreAudioFormat//AVFileTypeMPEG4 
                                         error:nil] retain];
        AudioChannelLayout channelLayout;
        memset(&channelLayout, 0, sizeof(AudioChannelLayout));
        channelLayout.mChannelLayoutTag = kAudioChannelLayoutTag_Stereo;

        NSDictionary *outputSettings = 
        [NSDictionary dictionaryWithObjectsAndKeys:
         [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey, 
         [NSNumber numberWithFloat:22050.0], AVSampleRateKey,
         [NSNumber numberWithInt:2], AVNumberOfChannelsKey,
         [NSData dataWithBytes:&channelLayout length:sizeof(AudioChannelLayout)], AVChannelLayoutKey,
         [NSNumber numberWithInt:16], AVLinearPCMBitDepthKey,
         [NSNumber numberWithBool:NO], AVLinearPCMIsNonInterleaved,
         [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
         [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey,nil];

        AVAssetWriterInput *assetWriterInput = [[AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio 
                           outputSettings:outputSettings]retain];
        if ([assetWriter canAddInput:assetWriterInput]) {
            [assetWriter addInput:assetWriterInput];
        } else {
            [assetWriter release];
            [musicName release];
            [assetReader release];
            [assetReaderOutput release];
            [assetWriterInput release];
            return;
        }
        assetWriterInput.expectsMediaDataInRealTime = NO;
        [assetWriter startWriting];
        [assetReader startReading];
        AVAssetTrack *soundTrack = [songAsset.tracks objectAtIndex:0];
        CMTime startTime = CMTimeMake (0, soundTrack.naturalTimeScale);
        [assetWriter startSessionAtSourceTime: startTime];
        __block UInt64 convertedByteCount = 0;
        dispatch_queue_t mediaInputQueue = dispatch_queue_create("mediaInputQueue", NULL);
        [assetWriterInput requestMediaDataWhenReadyOnQueue:mediaInputQueue 
                                                usingBlock: ^ 
         {
             while (assetWriterInput.readyForMoreMediaData) {
                 CMSampleBufferRef nextBuffer = [assetReaderOutput copyNextSampleBuffer];
                 if (nextBuffer) {
                     // append buffer
                     [assetWriterInput appendSampleBuffer: nextBuffer];
                     convertedByteCount += CMSampleBufferGetTotalSampleSize (nextBuffer);
                 } else {
                     // done!
                     [assetWriterInput markAsFinished];
                     [assetWriter finishWriting];
                     [assetReader cancelReading];
                     NSDictionary *outputFileAttributes = [[NSFileManager defaultManager]
                                                           attributesOfItemAtPath:musicName
                                                           error:nil];
                     NSLog (@"done. file size is %llu MB",
                            [outputFileAttributes fileSize]/1024/1024);
                     
                     // release a lot of stuff
                     [progress stopAnimating];
                     [self refreshDocuementsWithoutAnimation];
                     [assetReader release];
                     [assetReaderOutput release];
                     [assetWriter release];
                     [assetWriterInput release];
                     break;
                 }
             }
             
         }];
    }
}

//------------------------------------------------------------------------------
// - (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
// fuction:add music interface
//------------------------------------------------------------------------------
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
	[self dismissModalViewControllerAnimated: YES];
}

//- (void) addDirectoryWatcher
//{
//    ASDataObjectManager *dataManager = [ASDataObjectManager sharedDataManager];
//    NSString *path = [[dataManager getRootPath] 
//                      stringByAppendingString:[currentDirectory getFullItemName]];
//    
//    self.docWatcher = [DirectoryWatcher watchFolderWithPath:path delegate:self];
//}
#pragma mark -
#pragma mark Directory Watcher Delegate Method
//- (void)directoryDidChange:(DirectoryWatcher *)folderWatcher
//{
//    [self refreshDocuements];
//}

#pragma mark -
#pragma mark public method
//------------------------------------------------------------------------------
// - (void) viewDidLoad
//------------------------------------------------------------------------------
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    imgManager = [[HJObjManager alloc] init];
    NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/imgtable/"] ;
	HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
	imgManager.fileCache = fileCache;
    
    self.activityView.hidden = YES;
	isNeedDelete = YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    statusManager = [[ASStatusManager alloc] initWithViewController:self];
    
    filesInCurrentDocument = [[NSMutableArray alloc] init];
    
	declare = [ASDeclare singletonASDeclare];
    
//    [self addDirectoryWatcher];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *pausePath = [bundle pathForResource:@"downLoadStop" ofType:@"png"];
    NSString *playPath = [bundle pathForResource:@"downLoadStart" ofType:@"png"];
    pause = [[UIImage alloc] initWithContentsOfFile:pausePath];
    play = [[UIImage alloc] initWithContentsOfFile:playPath];
    
	if(!selectedFiles)
    {
		selectedFiles = [[NSMutableDictionary alloc] init];
    }
    
	[documentTableView setRowHeight:50.0];
	[documentTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
	[documentTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
    
    self.navigationController.toolbar.tintColor = [UIColor blackColor];
    self.navigationController.toolbar.barStyle = UIBarStyleBlackOpaque;
	progress = [[UIActivityIndicatorView alloc] 
        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:progress];

    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 460, 320, 44)];

     playCount = 0;
	
}

//------------------------------------------------------------------------------
// - (void) viewWillAppear:(BOOL)animated
//------------------------------------------------------------------------------
- (void) viewWillAppear:(BOOL)animated
{
	[searchBar removeFromSuperview];
    i = 1;
	self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 0.9;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    [self cleanSelectedObjs];
    
    //add gesture to hide keyboard
    [self addTapGesture];
    
    
//    progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
//    [self.navigationController.view addSubview:progressHUD];
    
//    progressHUD.delegate = self;
//    progressHUD.labelText = @"Waiting";
    
    if(NO == isForSearch)
    {
        [self readyForFileList];
        [self reloadDateForFileList];
//        [progressHUD showWhileExecuting:@selector(reloadDateForFileList)
//                       onTarget:self withObject:nil animated:YES];
    }
    else
    {
        [self readyForSearchView];
        [self reloadDataForSearchView];
//        [progressHUD showWhileExecuting:@selector(reloadDataForSearchView)
//                       onTarget:self withObject:nil animated:YES];
        UIBarButtonItem *leftButton = 
        [[UIBarButtonItem alloc] initWithTitle: KHome 
                                         style: UIBarButtonItemStyleBordered
                                        target: self 
                                        action: @selector(backToHome)];
        self.navigationItem.leftBarButtonItem = leftButton;
        [leftButton release];
    }
    
    [self addBadgeViewForRecorde];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
//    [self.navigationController setToolbarHidden:NO];
    
	[super viewWillAppear:animated];
}

//------------------------------------------------------------------------------
// - (void) didReceiveMemoryWarning
//------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning 
{
    self.indexPath = nil;
    self.activityView = nil;
    self.addDirectory = nil;
    self.searchString = nil;
	self.pause = nil;
    self.play = nil;

    [super didReceiveMemoryWarning];
}

//------------------------------------------------------------------------------
// - (void) viewDidUnload
//------------------------------------------------------------------------------
- (void)viewDidUnload 
{
	self.indexPath = nil;
    self.activityView = nil;
    self.selectedFiles = nil;
    self.addDirectory = nil;
    statusManager = nil;
    self.searchString = nil;
    self.searchBar = nil;
    self.filesInCurrentDocument = nil;
    self.pause = nil;
    self.play = nil;
    self.moviePlayViewController = nil;
    self.popmenu = nil;
    imgManager = nil;
    [super viewDidUnload];
}

//------------------------------------------------------------------------------
// - (void) dealloc
//------------------------------------------------------------------------------
- (void)dealloc 
{
    [filesInCurrentDocument release];
    [activityView release];
    [tapGestureRecognizer release];
    [statusManager release];
    [numButton release];
    [addDirectory release];
    [indexPath release];
    [selectedFiles release];
    [searchBar release];
    [searchString release];
    [pause release];
    [play release];  
    [moviePlayViewController release];
    [popmenu release];
    [progress release];
    [imgManager release];
    
    [super dealloc];
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
    [searchBar removeFromSuperview];
    if (interfaceOrientation==UIInterfaceOrientationPortrait||
        interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {
        searchBar.frame = CGRectMake(0.0f, 460.0f, 320.0f, 44.0f);
    }
    else
    {
        searchBar.frame = CGRectMake(0.0f, 460.0f, 480.0f, 44.0f);        
    }
    searchBar.delegate = self;
    searchBar.barStyle = UIBarStyleBlack;
    searchBar.tintColor = [UIColor blackColor];

    if(nil != indexPath)
    {
        ASTableViewCell *cell = (ASTableViewCell *)[documentTableView cellForRowAtIndexPath:indexPath];
        [self textFieldDidEndEditing:cell.mainText];
    }
    
    [popmenu removeFromSuperview];
    
    [searchBar resignFirstResponder];
    
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            [numButton setFrame:CGRectMake(k_Portrait_X,
                                           k_Portrait_Y, 
                                           26.0f,
                                           26.0f)];
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            [numButton setFrame:CGRectMake(k_Portrait_X,
                                           k_Portrait_Y,
                                           26.0f,
                                           26.0f)];
            break;
        case UIInterfaceOrientationLandscapeLeft:
            [numButton setFrame:CGRectMake(k_LandscapeLeft_X,
                                           k_LandscapeLeft_Y,
                                           26.0f,
                                           26.0f)];
            break;
        case UIInterfaceOrientationLandscapeRight:
            [numButton setFrame:CGRectMake(k_LandscapeRight_X,
                                           k_LandscapeRight_Y,
                                           26.0f,
                                           26.0f)];
            break;
        default:
            break;
    }
}

-(void)backToHome
{
    ASFileListViewController *homeViewController = 
    [[self.navigationController viewControllers] objectAtIndex: 1];
    [self.navigationController popToViewController: homeViewController animated: YES];
}

@end

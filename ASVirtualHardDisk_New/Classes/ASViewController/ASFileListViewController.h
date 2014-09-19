//
//  ASFileListViewController.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-24.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>

#import "ASDataObject.h"
#import "MBProgressHUD.h"
#import "ASMenuDelegate.h"
#import "ASMediaPlayerViewController.h"
#import "ASMenu.h"
#import "ASMusicPlayerDelegate.h"
#import "ZBarReaderController.h"
#import "ASFileEx.h"
//#import "DirectoryWatcher.h"
#import "HJObjManager.h"


#define KTOOLBARICONSIZE     24
#define kTAGOFZIP 1
#define kTAGOFMAIL 2

#define KTAGOFDELETEALERT    3
#define KTAGOFSEARCHALERT    4
#define KTAGOFSAMENAME       5

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@class ASBadgeView;
@class ASDeclare;
@class ASMenu;
@class ASStatusManager;

@interface ASFileListViewController : UIViewController 
    <MFMailComposeViewControllerDelegate, UIAlertViewDelegate, 
    MBProgressHUDDelegate, ASMenuDelegate, UISearchBarDelegate,
    UIImagePickerControllerDelegate,UINavigationControllerDelegate,
    UIVideoEditorControllerDelegate,ASMusicPlayerDelegate,
    MPMediaPickerControllerDelegate >//DirectoryWatcherDelegate>//,ZBarReaderDelegate> 
{
@private
    //directory watcher
//    DirectoryWatcher *docWatcher;
    
    //image manager
    HJObjManager *imgManager;
    
    NSMutableArray *filesInCurrentDocument;
	UITableView *documentTableView;
	ASDeclare *declare;
	BOOL isEdting;
	BOOL isNeedDelete;
	
	//used for more option
	NSMutableDictionary *selectedFiles;
	
	//recoder the count of selected files
    ASBadgeView *numButton;
    
    //add directory button
    UIButton *addDirectory;
    
	UIActivityIndicatorView *activityView;
	
	//record the indexPath for rename cell and new cell
	NSIndexPath *indexPath;
	
	//waiting
	MBProgressHUD *progressHUD;
	CGPoint pointOfCell;
    
    //status manager
    ASStatusManager *statusManager;
    
    //tap gesture
    UITapGestureRecognizer *tapGestureRecognizer;
    
    //current directory
    id<ASDataObject> currentDirectory;
    
    //search bar
    UISearchBar *searchBar;
    
    //if is search result view
    BOOL isForSearch;
    NSString *searchString;
    
    //image for music play
    UIImage *pause;
    UIImage *play;
    ASMenu *popmenu;
    MPMoviePlayerViewController *moviePlayViewController;
    UIActivityIndicatorView  *progress;
    NSTimer *timer;
    CGFloat playCount;
}

@property (nonatomic) BOOL isForSearch;
@property (nonatomic) BOOL isEdting;
@property (nonatomic) BOOL isNeedDelete;
//@property (nonatomic, retain) DirectoryWatcher *docWatcher;
@property (nonatomic, retain) NSMutableDictionary *selectedFiles;
@property (nonatomic, retain) IBOutlet UITableView *documentTableView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) ASBadgeView *numButton;
@property (nonatomic, retain) UIButton *addDirectory;
@property (nonatomic, retain) NSIndexPath *indexPath;
@property (nonatomic) CGPoint pointOfCell;
@property (nonatomic, readonly) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, readonly) ASStatusManager *statusManager;
@property (nonatomic, retain) NSMutableArray *filesInCurrentDocument;
@property (nonatomic, retain) id<ASDataObject> currentDirectory; 
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSString *searchString;
@property (nonatomic, retain) ASMenu *popmenu ;
@property (nonatomic, retain) UIImage *pause;
@property (nonatomic, retain) UIImage *play;
@property (nonatomic, retain) MPMoviePlayerViewController *moviePlayViewController;
@property (nonatomic, retain) MPMoviePlayerController *moviePlayerController;
@property (nonatomic, retain) UIActivityIndicatorView  *progress;

/*
 @function   formatToolBar
 @abstract   create the tool bar
 @param      none
 @result     void
 */
- (void) formatToolBar;

/*
    @function   - (IBAction) searchFiles:(id)sender
    @abstract   respond when search file button tapped
    @param      (id) sender - search buton
    @result     IBAction
*/
- (IBAction) searchFiles:(id)sender;

/*
    @function   - (void)addFolder
    @abstract   respond when add directory button tapped
    @param      (id) sender - add directory button
    @result     IBAciotn
*/
- (void)addFolder;

/*
    @function   - (IBAction) refreshDirectory:(id)sender
    @abstract   respond when refresh button tapped
    @param      (id) sender - refresh button
    @result     IBAction
*/
- (IBAction) refreshDirectory:(id)sender;

/*
    @function   - (void) dealloc
    @abstract   dealloc
    @param      none
    @result     void
*/
- (void) dealloc;

/*
    @function   - (void)tableView:(UITableView *)tableView 
                   accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
    @abstract   tableView delegate method
    @param      
    @result     
*/
- (void)tableView:(UITableView *)tableView 
    accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;


- (void)refreshDocuementsWithAnimation;

- (void)refreshDocuementsWithoutAnimation;

- (void)showCamera;
- (void)showCamcorder;
- (void)addMusic;
- (void)playVideo;
//- (IBAction)showWebMenu:(id)sender;

-(void) startOrStop:(id)sender;

//- (void) addDirectoryWatcher;

@end

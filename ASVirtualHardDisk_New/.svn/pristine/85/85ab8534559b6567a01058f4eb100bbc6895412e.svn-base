//
//  ASMainViewController.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-17.
//  Modify by dhc on 11-12-07
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASMenu.h"
#import "ASMainRightMenu.h"
#import "ASWebMenuModel.h"
#import "ASWebViewController.h"
#import "ASEmbedReaderViewController.h"

@class FtpServer;
@class ASDeclare;
@class ASServerInfo;

@interface ASMainViewController : UIViewController 
<UITableViewDataSource, UITableViewDelegate, ASMenuDelegate>
{
@private
	//logo view
	//UIView *modelView;
	
	//server label
    IBOutlet UILabel *statusLabel;
    IBOutlet UILabel *httpAddressLabel;
    IBOutlet UILabel *ftpAddressLabel;
    IBOutlet UILabel *touchLabel;
    IBOutlet UIImageView *settingImage;
    IBOutlet UILabel *toOpenServer;
    
	//UILabel *tagLabel;
	UILabel *contentFTPLabel;
    UILabel *contentHTTPLabel;
	
	ASServerInfo *serverInfo;
    IBOutlet UIControl *mainControl;
	
	ASDeclare *declare;
    
    UILabel *serverLabel;
    
    IBOutlet UITableView *tableViewDoc;
    IBOutlet UIView *serverStatusView;
    
    BOOL canShowServerInfo;
    
    //bottom toolBar
    ASMenu *popmenu;
    UIBarButtonItem * wifiButtonItem;
    UIView *serverView;

    //tap gesture
    UITapGestureRecognizer *tapGestureRecognizer;
    
}

@property (nonatomic, retain) UILabel* statusLabel;
@property (nonatomic, retain) UILabel* httpAddressLabel;
@property (nonatomic, retain) UILabel* ftpAddressLabel;
@property (nonatomic, retain) UILabel* touchLabel;
@property (nonatomic, retain) UIImageView* settingImage;
@property (nonatomic, retain) UILabel* toOpenServer;
@property (nonatomic, retain) IBOutlet UIView *serverView;
@property (nonatomic, retain) IBOutlet UILabel *contentFTPLabel;
@property (nonatomic, retain) IBOutlet UILabel *contentHTTPLabel;
@property (nonatomic, retain) IBOutlet UILabel *serverLabel;
@property (nonatomic, retain) UIBarButtonItem *wifiButtonItem;
@property (nonatomic, readonly) UITapGestureRecognizer *tapGestureRecognizer;



#pragma mark -
#pragma mark for view swtich

/*
    @function   - (IBAction) closeserver
    @abstract   close the open message of the server
    @param      no
    @result     IBAction
 */
- (IBAction) closeserver:(id)sender;
/*
    @function   - (IBAction) switchToNext
    @abstract   switch to the file list view
    @param      no
    @result     IBAction
*/
- (IBAction) switchToNext;
/*
    @function   - (IBAction) switchToHelp
    @abstract   show the help view
    @param      no
    @result     IBAction
*/
- (IBAction) switchToHelp;

@end

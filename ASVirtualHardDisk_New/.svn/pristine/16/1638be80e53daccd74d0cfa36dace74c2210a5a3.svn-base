//
//  ASFileOperateViewController.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-26.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ASDataObject.h"
#import "HJObjManager.h"

@class ASDeclare;
@class ASDirectoryEx;

@interface ASFileOperateViewController : UIViewController <UIAlertViewDelegate,
                                                           MBProgressHUDDelegate>
{
@private    
    //current directory
    id<ASDataObject> currentItem;
    
	//to show directorys
	UITableView *tableViewDirectory;
	
	//files to operate
	NSMutableArray *arrayToOperate;
	
	//directorys to show in tableview
	NSMutableArray *arrayDirectory;
	
	//YES to Copy || NO to Move
	BOOL operation;
	
	//YES to Copy or Move || NO to enter next directory
	BOOL isSelectButonTapped;
	
	//for go back 
	UIViewController *root;
	
	ASDeclare *declare;
    
    
    //waiting view
    MBProgressHUD *HUD;
    
    //to record the indexPath temporary
    NSIndexPath *indexPathOfSelected;
    
    ASDirectoryEx *destinationDirectory;
    
    //image manager
    HJObjManager *imgManager;
}

@property (nonatomic, retain) IBOutlet UITableView *tableViewDirectory;
@property (nonatomic, retain) NSMutableArray *arrayToOperate;
@property (nonatomic, retain) NSMutableArray *arrayDirectory;
@property (nonatomic, retain) UIViewController *root;
@property (nonatomic) BOOL isSelectButonTapped;
@property (nonatomic) BOOL operation;
@property (nonatomic, retain) NSIndexPath *indexPathOfSelected;
@property (nonatomic, retain) id<ASDataObject> currentItem;
@property (nonatomic, retain) HJObjManager *imgManager;
//@property (nonatomic, retain) ASDirectoryEx *destinationDirectory;

/*
 @function   - (void)tableView:(UITableView *)tableView 
     accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
 
 @abstract   tableView delegate method
 @param      
 @result     
 */
- (void)tableView:(UITableView *)tableView 
    accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;

@end

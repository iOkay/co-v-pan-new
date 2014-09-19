//
//  ASDownLoadViewController.h
//  NSWebView
//
//  Created by xiu on 11-10-31.
//  Copyright 2011年 __AlphaStudio__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDownLoadListDelegate.h"
#import "ASDownloadTableViewCellDelegate.h"


@class  ASDownLoadList;

@interface ASDownLoadViewController : UIViewController 
    <UITableViewDataSource,UITableViewDelegate,ASDownLoadListDelegate,ASDownloadTableViewCellDelegate>
{
@private    
    ASDownLoadList *downLoadList;
    IBOutlet UITableView* downLoadTable;
    IBOutlet UIBarButtonItem* cleanBtn;
    IBOutlet UIToolbar* bottomToolBar;
  
}

@property (nonatomic,retain) ASDownLoadList *downLoadList;
-(void)addTestUrl:(NSURL*)aUrl;
-(IBAction)cleanBtnClick:(id)sender;

@end

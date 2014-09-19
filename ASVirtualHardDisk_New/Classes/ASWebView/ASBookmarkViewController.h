//------------------------------------------------------------------------------
//  Filename:       ASBookmarkViewController.h
//  Project:        NSWebView
//  Author:         xiu
//  Date:           11-10-24 : last edited by xiu
//  Version:        1.0
//  Copyright       2011年 __AlphaStudio__. All rights reserved.
//------------------------------------------------------------------------------
//  Quote the standard library header files.

#import <UIKit/UIKit.h>
#import "ASWebViewModel.h"
#import "ASBookmark.h"


@protocol ASBookmarkDelegate <NSObject>

-(void)selectedBookmark:(NSString*)urlString;

@end



@interface ASBookmarkViewController : UIViewController
    <UITableViewDataSource,UITableViewDelegate> 
{
@private
    ASWebViewModel* model;
    UIBarButtonItem* bottomDone;
    IBOutlet UIToolbar* topToolBar;
    IBOutlet UIBarButtonItem* topDone;
    IBOutlet UIBarButtonItem* edit;
    IBOutlet UIBarButtonItem* fixedSpace;
    IBOutlet UITableView* tableView;
    IBOutlet UILabel* tittleLabel;
    id<ASBookmarkDelegate> delegate;
}
-(IBAction)doneButtonClick:(id)sender;
-(IBAction)editButtonClick:(id)sender;



@property (nonatomic,retain)ASWebViewModel* model;
@property (nonatomic,retain)id<ASBookmarkDelegate> delegate;



@end

//
//  ASDownLoadViewController.m
//  NSWebView
//
//  Created by xiu on 11-10-31.
//  Copyright 2011年 __AlphaStudio__. All rights reserved.
//

#import "ASDownLoadViewController.h"
#import "ASIHTTPRequest.h"
#import "ASDownLoadInfo.h"
#import "ASDownLoadStatueDefine.h"
#import "ASPathManager.h"
#import "ASDownLoadTableViewCell.h"
#import "ASDownLoadList.h"
#include "ASLocalDefine.h"
#import "ASFileStrategyManager.h"
#import "ASFileEx.h"
#import "ASDeclare.h"

@interface ASDownLoadViewController(hidden)
-(void)readFromFile;
-(void)writToFile;
-(void)applicationDidEnterBackground;
@end

@implementation ASDownLoadViewController
@synthesize downLoadList;

- (void) formatToolBarOfDownLoadView
{
    [self.navigationController setToolbarHidden:NO];
    self.navigationController.toolbar.translucent = NO;
    self.navigationController.toolbar.tintColor = [UIColor blackColor];
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.alpha = 1.0f;
    NSString *tmp = KDOWNLOADCLEANBUTTON;
  /*  UIButton *btnClean = [[UIButton alloc] 
                          initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    [btnClean setTitle:tmp forState:UIControlStateNormal];
    [btnClean addTarget:self action:@selector(cleanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cleanBtn = [[UIBarButtonItem alloc] initWithCustomView:btnClean];
    [cleanBtn setStyle:UIBarButtonItemStyleBordered];*/
    cleanBtn = [[UIBarButtonItem alloc] 
                initWithTitle:tmp 
                        style:UIBarButtonItemStyleBordered
                       target:self
                       action:@selector(cleanBtnClick:)];
    [self setToolbarItems:[NSArray arrayWithObject:cleanBtn] animated:YES];
    
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        downLoadList = [ASDownLoadList singel];
        downLoadList.delegate = self;
    }
    return self;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)dealloc
{
    if(downLoadList.delegate == self)
    downLoadList.delegate = nil;
    [cleanBtn release];
    [super dealloc];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController setToolbarHidden:YES];
    bottomToolBar.tintColor = [UIColor blackColor];

    self.title = [[ASDeclare singletonASDeclare] downloadTitle];
//    cleanBtn.title  = KDOWNLOADCLEANBUTTON;
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait||self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {
        
        bottomToolBar.frame = CGRectMake(0, 416, 320, 44);
    }
    else
    {
        bottomToolBar.frame = CGRectMake(0, 268, 480, 32);
        
    }
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)viewDidUnload
{
    [super viewDidUnload];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 0.9;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    [self formatToolBarOfDownLoadView];
    if (self.interfaceOrientation==UIInterfaceOrientationPortrait||
        self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {
        
        bottomToolBar.frame = CGRectMake(0, 372, 320, 44);
    }
    else
    {
        bottomToolBar.frame = CGRectMake(0, 236, 480, 32);
        
    }
    localChose = NO;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

#pragma mark -
#pragma mark tableView dataSource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [downLoadList.downLoadInfoList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* downLoadTableViewCell = @"downLoadTableViewCell";
    
    ASDownLoadTableViewCell* cell = (ASDownLoadTableViewCell*) [tableView dequeueReusableCellWithIdentifier:downLoadTableViewCell];
    if (cell == nil) 
    {

        NSArray* nib = [[NSBundle mainBundle]loadNibNamed:@"ASDownLoadTableCell" owner:self options:nil];
        for (id object in nib) 
        {
            if ([object isKindOfClass:[ASDownLoadTableViewCell class]]) {
                cell = (ASDownLoadTableViewCell*)object;
            }
        } 
    }
    
    UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
    selectedView.alpha = 0.8f;
    selectedView.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = selectedView;
    [selectedView release];
    
    NSInteger row = [indexPath row];
    ASDownLoadInfo* info = [downLoadList.downLoadInfoList objectAtIndex:row];
    NSLog(@"%@", downLoadList.downLoadInfoList);
    cell.delegate = self;
    cell.nameLabel.text  = info.name;
    cell.statu = info.statue;
    cell.progressView.progress = info.progress;
    [cell setDownloadFileSize: info.fileSize];
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASDownLoadInfo *info = [downLoadList.downLoadInfoList objectAtIndex: [indexPath row]];
    if(KDOWNLOADCOMPLETE == info.statue)
    {
        ASFileEx *dataObj = [[ASFileEx alloc] initWithFullPath: info.filePath];
        
        ASFileStrategyManager *fileStrategy = 
        [ASFileStrategyManager sharedASFileStrategyManager];
        
        [fileStrategy execOnState: Selected
                 inViewController: self 
                   withDataObject: dataObj];
        [tableView deselectRowAtIndexPath: indexPath animated: YES];
        [dataObj release];
    }
}

#pragma mark - 
#pragma mark download tableViewCell delegate


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)downLoad:(ASDownLoadTableViewCell*)tableCell cancelDownLoadAtIndexPath:(NSIndexPath *)path
{
    [downLoadList cancelRequestAtIndex:[path row]];
    
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)downLoad:(ASDownLoadTableViewCell*)tableCell cantinueDownLoadAtIndexPath:(NSIndexPath *)path
{
   
    [downLoadList cantinueRequestAtindex:[path row]];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)downLoad:(ASDownLoadTableViewCell*)tableCell stopDownLoadAtIndexPath:(NSIndexPath *)path
{
    [downLoadList stopRequestAtIndex:[path row]];
}




//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)downLoad:(ASDownLoadTableViewCell *)tableCell reloadDownLoadAtIndexPath:(NSIndexPath *)path
{
    [downLoadList reloadRequestAtIndex:[path row]];
}




#pragma mark - 
#pragma mark other function

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)addTestUrl:(NSURL *)aUrl
{
    NSUInteger index = [downLoadList addDownLoad:[aUrl absoluteString]];
    NSIndexPath* path = [NSIndexPath indexPathForRow:index inSection:0];
    
    NSArray* array = [[NSArray alloc]initWithObjects:path, nil];
    
    
    [downLoadTable beginUpdates];
    [downLoadTable insertRowsAtIndexPaths:array withRowAnimation:YES];
    [downLoadTable endUpdates];
    
    
    [array release];
}


#pragma mark - 
#pragma mark hidden function





-(IBAction)cleanBtnClick:(id)sender
{
    NSArray* arrayCellPath =  [downLoadList cleanDownLoad];
    
    [downLoadTable beginUpdates];
    
    [downLoadTable deleteRowsAtIndexPaths:arrayCellPath withRowAnimation:UITableViewRowAnimationFade];
    [downLoadTable endUpdates];
}



#pragma mark -
#pragma mark ASDownLoadListDelegate
-(void)downLoadList:(ASDownLoadList*)list statueChange:(NSUInteger)statue atIndex:(NSUInteger)index
{
    NSIndexPath* path = [NSIndexPath indexPathForRow:index inSection:0];
    ASDownLoadTableViewCell* cell = (ASDownLoadTableViewCell*)[downLoadTable cellForRowAtIndexPath:path];
    if (cell != nil) {
        cell.statu = statue;
    }
}


-(void)downLoadList:(ASDownLoadList*)list progrerssChange:(float)progress atIndex:(NSUInteger)index
{
    NSIndexPath* path = [NSIndexPath indexPathForRow:index inSection:0];
    ASDownLoadTableViewCell* cell = (ASDownLoadTableViewCell*)[downLoadTable cellForRowAtIndexPath:path];
    if (cell != nil) {
        [cell progressChange: progress];
    }

}

-(void)downLoadList:(ASDownLoadList *)list fileSize:(NSInteger)aFileSize atIndex:(NSUInteger)index
{
    NSIndexPath* path = [NSIndexPath indexPathForRow:index inSection:0];
    ASDownLoadTableViewCell* cell = (ASDownLoadTableViewCell*)[downLoadTable cellForRowAtIndexPath:path];
    if (cell != nil) {
        [cell setDownloadFileSize: aFileSize];
    }
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    if (interfaceOrientation==UIInterfaceOrientationPortrait||interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {

        bottomToolBar.frame = CGRectMake(0, 372, 320, 44);
    }
    else
    {
        bottomToolBar.frame = CGRectMake(0, 236, 480, 32);
        
    }
}
@end

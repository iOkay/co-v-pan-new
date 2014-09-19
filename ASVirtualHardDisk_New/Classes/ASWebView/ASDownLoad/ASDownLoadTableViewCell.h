//
//  ASDownLoadTableViewCell.h
//  NSWebView
//
//  Created by xiu on 11-11-4.
//  Copyright 2011年 __AlphaStudio__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDownloadTableViewCellDelegate.h"
#import "ASIHTTPRequestDelegate.h"
#import "ASDownLoadInfoDelegate.h"

#define kOneKB (1024.0)
#define kOneMB (1024.0*1024.0)
#define kOneGB (1024.0*1024.0*1024.0)

@class ASDownLoadInfo;

@interface ASDownLoadTableViewCell : UITableViewCell
{
@private
    IBOutlet UIProgressView* progressView;
    IBOutlet UILabel* nameLabel;
    IBOutlet UIButton* stopAndContinueBtn;
    IBOutlet UIButton* cancelBtn;
    IBOutlet UILabel* statuLabel;
    IBOutlet UILabel *speedLabel;
    IBOutlet UILabel *progressLabel;
    NSInteger fileSize;
    IBOutlet UILabel *fileSizeLabel;
    NSDate *lastDate;
    NSUInteger statu;
    id<ASDownloadTableViewCellDelegate> delegate;
    
    
}

@property (nonatomic, retain) UIProgressView* progressView;
@property (nonatomic, retain) UILabel* nameLabel;
@property (nonatomic, retain) UIButton* stopAndContinueBtn;
@property (nonatomic, retain) UIButton* cancelBtn;
@property (nonatomic, retain) ASDownLoadInfo* downLoadInfo;
@property (nonatomic, retain) id<ASDownloadTableViewCellDelegate> delegate;
@property  NSUInteger statu;
@property (nonatomic, retain) UILabel* statuLabel;
@property (nonatomic, retain) UILabel* speedLabel;
@property (nonatomic, retain) UILabel* progressLabel;
@property (nonatomic) NSInteger fileSize;
@property (nonatomic, retain) UILabel* fileSizeLabel;

-(IBAction)stopAndContinueBtnClick:(id)sender;
-(IBAction)cancelBtnClick:(id)sender;
-(void)progressChange:(float)aProgress;
-(void)setDownloadFileSize:(NSInteger)aSize;

@end

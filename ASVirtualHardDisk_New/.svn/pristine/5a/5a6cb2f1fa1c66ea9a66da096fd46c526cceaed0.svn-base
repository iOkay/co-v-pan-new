//
//  ASDownLoadTableViewCell.m
//  NSWebView
//
//  Created by xiu on 11-11-4.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ASDownLoadTableViewCell.h"
#import "ASIHTTPRequest.h"
#import "ASDownLoadList.h"
#import "ASDownLoadInfo.h"
#import "ASDownLoadStatueDefine.h"
#import "ASLocalDefine.h"

#define KDOWNLOADRELOADIMAGE @"downLoadReload.png"
#define KDOWNLOADSTOPIMAGE   @"downLoadStop.png"
#define KDOWNLOADCANCELIMAGE @"downLoadCancel.png"
#define KDOWNLOADSTARTIMAGE  @"downLoadStart.png"



@implementation ASDownLoadTableViewCell
@synthesize progressView,stopAndContinueBtn,cancelBtn,nameLabel,delegate,downLoadInfo,statuLabel;
@synthesize speedLabel;
@synthesize progressLabel;
@synthesize fileSize;
@synthesize fileSizeLabel;
@dynamic  statu;


#pragma mark -
#pragma mark statu change

-(NSUInteger)statu
{
    return statu;
}

-(void)setStatu:(NSUInteger)aStatu
{
    
    switch (aStatu) {
        case KDOWNLOADCACEL:
            self.stopAndContinueBtn.hidden = YES;
            [self.cancelBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADRELOADIMAGE] forState:UIControlStateNormal];
            [self.cancelBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADRELOADIMAGE] forState:UIControlStateHighlighted];
            self.cancelBtn.hidden = NO;
            self.progressView.hidden = YES;
            self.statuLabel.text = KDownFalse;
            self.speedLabel.text = @"0.00 KB/s";
            if (1 == self.progressView.progress) 
            {
                self.progressView.progress = 0;
            }
            self.progressLabel.text = [NSString stringWithFormat: @"%.2f %%", 
                                       self.progressView.progress*100];
            break;
        case KDOWNLOADCOMPLETE:
            self.stopAndContinueBtn.hidden = YES;
            [self.cancelBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADRELOADIMAGE] forState:UIControlStateNormal];
            [self.cancelBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADRELOADIMAGE] forState:UIControlStateHighlighted];
            self.cancelBtn.hidden = NO;
            self.progressView.hidden = YES;
            self.statuLabel.text = KDownOk;
            self.speedLabel.text = @"0.00 KB/s";
            self.progressLabel.text = @"100.00 %";
            break;
            
        case KDOWNLOADSTOP:
            self.stopAndContinueBtn.hidden = NO;
            self.cancelBtn.hidden = NO;
            [self.stopAndContinueBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADSTARTIMAGE] forState:UIControlStateNormal];
            [self.stopAndContinueBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADSTARTIMAGE] forState:UIControlStateHighlighted];
            [self.cancelBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADCANCELIMAGE] forState:UIControlStateNormal];
            [self.cancelBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADCANCELIMAGE] forState:UIControlStateHighlighted];
            self.progressView.hidden = YES;
            self.statuLabel.text = KDownSuspend;
            self.speedLabel.text = @"0.00 KB/s";
            self.progressLabel.text = [NSString stringWithFormat: @"%.2f %%", 
                                       self.progressView.progress*100];
            break;
            
        case KDOWNLOADDOWN:
            self.stopAndContinueBtn.hidden = NO;
            self.cancelBtn.hidden = NO;
            [self.cancelBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADCANCELIMAGE] forState:UIControlStateNormal];
            [self.cancelBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADCANCELIMAGE] forState:UIControlStateHighlighted];
            [self.stopAndContinueBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADSTOPIMAGE]forState:UIControlStateNormal];
            [self.stopAndContinueBtn setBackgroundImage:[UIImage imageNamed:KDOWNLOADSTOPIMAGE ]forState:UIControlStateHighlighted];
            self.progressView.hidden = NO;
            self.statuLabel.text = @"";
            self.speedLabel.text = @"0.00 KB/s";
            self.progressLabel.text = [NSString stringWithFormat: @"%.2f %%", 
                                       self.progressView.progress*100];
            break;
            
        default:
            break;
    }
    statu = aStatu;
}

-(void)progressChange:(float)aProgress
{
    /*
    NSMutableArray *downloadList = [[ASDownLoadList singel] downLoadInfoList];
    for(ASDownLoadInfo *info in downloadList)
    {
        if ([info.name isEqualToString: nameLabel.text])
        {
            info.progress = aProgress;
        }
    }
     */
    
    float downloadProgress = aProgress - progressView.progress;
    //NSLog(@"DownloadProgress:%f", downloadProgress);
    progressView.progress = aProgress;
    progressLabel.text = [NSString stringWithFormat: @"%.2f %%", aProgress*100];
    //?
    NSInteger downloadSize = fileSize*downloadProgress;
    //NSLog(@"DownloadSize:%i", downloadSize);
    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:lastDate];
    //NSLog(@"Time:%lf", time);
    if (0.0 == time)
    {
        speedLabel.text = @"0.00 KB/s";
    }
    else
    {
        speedLabel.text = [NSString stringWithFormat: @"%.2f KB/s", 
                           downloadSize/(time*1024.0)];
    }
    //NSLog(@"Speed:%@", speedLabel.text);
    [lastDate release];
    lastDate = [[NSDate date] retain];
}

-(void)setDownloadFileSize:(NSInteger)aSize
{
    fileSize = aSize;
    if (aSize <= kOneKB)
    {
        fileSizeLabel.text = [NSString stringWithFormat: @"%i B", aSize];
    }
    else if(aSize <= kOneMB)
    {
        fileSizeLabel.text = [NSString stringWithFormat: @"%.2f KB", aSize/kOneKB];
    }
    else if(aSize <= kOneGB)
    {
        fileSizeLabel.text = [NSString stringWithFormat: @"%.2f MB", aSize/kOneMB];
    }
    else
    {
        fileSizeLabel.text = [NSString stringWithFormat: @"%.2f GB", aSize/kOneGB];
    }
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        lastDate = [[NSDate date] retain];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [lastDate release];
    
    [super dealloc];
}



#pragma mark -
#pragma mark Action
//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(IBAction)stopAndContinueBtnClick:(id)sender
{
    NSIndexPath* path =  [(UITableView*)self.superview  indexPathForCell:(UITableViewCell*)self];
    if (statu == KDOWNLOADSTOP) 
    {
        if (delegate != nil ) 
        {
            [delegate downLoad:self cantinueDownLoadAtIndexPath:path];
        }
        
    }
    else if(statu == KDOWNLOADDOWN)
    {
        if (delegate != nil ) 
        {
            [delegate downLoad:self stopDownLoadAtIndexPath:path];
        }
    }
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(IBAction)cancelBtnClick:(id)sender
{
    NSIndexPath* path =  [(UITableView*)self.superview  indexPathForCell:(UITableViewCell*)self];
    
    if (self.statu == KDOWNLOADDOWN) {
        //[delegate downLoad:self stopDownLoadAtIndexPath:path];
        [delegate downLoad:self cancelDownLoadAtIndexPath:path];
    }
    else if(self.statu == KDOWNLOADCACEL)
    {
        [delegate downLoad:self reloadDownLoadAtIndexPath:path];
    }
    else if(self.statu == KDOWNLOADSTOP)
    {
        [delegate downLoad:self cancelDownLoadAtIndexPath:path];
    }
    else if(self.statu == KDOWNLOADCOMPLETE)
    {
        [delegate downLoad:self reloadDownLoadAtIndexPath:path];
    }
}


@end

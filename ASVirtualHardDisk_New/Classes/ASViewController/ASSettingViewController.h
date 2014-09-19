//
//  ASSettingViewController.h
//  ASVirtualHardDisk
//
//  Created by dhc on 11-12-8.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASServerInfo.h"
#import "NetworkController.h"

#define kConfigFile @"config"
#define kConfigFileType @"plist"
#define kIsRealImg @"realImg"

@interface ASSettingViewController : UIViewController 
{
    ASServerInfo *serverInfo;
    
    //server label
    IBOutlet UILabel *httpAddress;
    IBOutlet UILabel *ftpAddress;
	IBOutlet UILabel *contentFTPLabel;
    IBOutlet UILabel *contentHTTPLabel;
    
    IBOutlet UILabel *serverLabel;
    IBOutlet UILabel *realImgLabel;
    IBOutlet UISwitch *serverSwitch;
    IBOutlet UISwitch *realImgSwitch;
    
    IBOutlet UILabel *helpLabel;
}

@property (nonatomic, retain) ASServerInfo* serverInfo;
@property (nonatomic, retain) UILabel* httpAddress;
@property (nonatomic, retain) UILabel* ftpAddress;
@property (nonatomic, retain) UILabel *contentFTPLabel;
@property (nonatomic, retain) UILabel *contentHTTPLabel;
@property (nonatomic, retain) UILabel* serverLabel;
@property (nonatomic, retain) UILabel* realImgLabel;
@property (nonatomic, retain) UISwitch* serverSwitch;
@property (nonatomic, retain) UISwitch* realImgSwitch;
@property (nonatomic, retain) UILabel* helpLabel;

- (IBAction)operateFTPServer: (id)sender;
- (IBAction)switchRealImg: (id)sender;

@end

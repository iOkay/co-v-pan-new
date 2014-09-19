//
//  ASBluetoothViewController.h
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-3-31.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "ASBluetoothStatusManager.h"
#import "ASDataObject.h"

@interface ASBluetoothViewController : UIViewController
<GKSessionDelegate,
UITableViewDelegate,
UITableViewDataSource> {
    //IBOutlet
    IBOutlet UIView *backgroundView;
    IBOutlet UIView *mainView;
    IBOutlet UIButton *positiveButton;
    IBOutlet UIButton *negativeButton;
    IBOutlet UILabel *label;
    IBOutlet UIProgressView *progressView;
    IBOutlet UITableView *peerTableView;
    
    //GKSession
    GKSession *theSession;
    NSString *sessionID;
    NSString *currentConfPeerID;
    NSMutableArray *peersList;
    ASBluetoothStatusManager *statusManager;
    
    //File
    NSArray *filePathArray;
    id<ASDataObject> currentDirectory;
    //NSFileHandle *fileHandle;
    //double progress;
}
//IBOutlet
@property (nonatomic, retain) UIView *backgroundView;
@property (nonatomic, retain) UIView *mainView;
@property (nonatomic, retain) UIButton *positiveButton;
@property (nonatomic, retain) UIButton *negativeButton;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIProgressView *progressView;
@property (nonatomic, retain) UITableView *peerTableView;

//GKSession
@property (nonatomic, retain) NSString *currentConfPeerID;
@property (readonly) GKSession *theSession;
@property (readonly) ASBluetoothStatusManager *statusManager;

//File
@property (nonatomic, retain) NSArray *filePathArray;
@property (nonatomic, retain) id<ASDataObject> currentDirectory;

+ (id) sharedManager;
- (void) show;
- (IBAction) dismiss:(id)sender;
- (IBAction) positiveButtonPressed:(id)sender;
- (IBAction) negativeButtonPressed:(id)sender;
- (void) moveView:(UIView *)view to:(CGRect)frame during:(float)time;
- (void) hiddenAllSubdvew;
- (void) sendData:(NSData *)data;
@end

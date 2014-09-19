//
//  ASiPodLibraryViewController.h
//  iPodLibraryDemo
//
//  Created by shinren Pan on 2011/1/4.
//  Copyright 2011 home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASMusicManager.h"
@interface ASiPodLibraryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MPMediaPickerControllerDelegate>{
	ASMusicManager *musicPlayer;
	IBOutlet UITableView *musicList;
	IBOutlet UIBarButtonItem *editButton;
	IBOutlet UIImageView *backgroundView;
    IBOutlet UIBarButtonItem *rewindBarButton;
    IBOutlet UIBarButtonItem *pauseBarButton;
    IBOutlet UIBarButtonItem *fastForwardButton;
    int flag;
}
@property(nonatomic, retain)ASMusicManager *musicPlayer;
@property(nonatomic, retain)UIImageView *backgroundView;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *rewindBarButton;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *pauseBarButton;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *fastForwardButton;
-(IBAction) addMusic:(id)sender;
-(IBAction)fastForward:(id)sender;
-(IBAction)rewind:(id)sender;
-(IBAction)pause:(id)sender;
@end


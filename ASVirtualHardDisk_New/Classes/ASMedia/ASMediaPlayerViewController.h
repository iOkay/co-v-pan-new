//
//  ASMediaPlayerViewController.h
//  MediaPlayer
//
//  Created by senso senso on 10-11-30.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ASFileEx.h"
@interface ASMediaPlayerViewController : UIViewController <AVAudioRecorderDelegate>
{
@private
    UIButton *record;
    UILabel *currentRecord;
    UITextField *nameFiled;
    UIButton *reRecord;
    UIButton *bgButton;
    UIButton *playButton;
    NSString *currentDirectory;
    BOOL isPlaying;
    BOOL isPlayed;
    int countOfRecord;
    int countOfPlay;
    UILabel * tap;
    UIButton * selectAll;
    UINavigationItem *navgationItem;
    UINavigationBar *navigationBar;
}

@property (nonatomic, retain) IBOutlet UIButton *record;
@property (nonatomic, retain) IBOutlet UILabel *currentRecord;
@property (nonatomic, retain) IBOutlet UITextField *nameFiled;
@property (nonatomic, retain) IBOutlet UIButton *reRecord;
@property (nonatomic, retain) IBOutlet UIButton *bgButton;
@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) NSString *currentDirectory;
@property (nonatomic, retain) IBOutlet UILabel *tap;
@property (nonatomic, retain) IBOutlet UINavigationItem *navgationItem;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIButton *selectAll;
- (void)unuseTheRecord;
- (void)useTheRecord;
- (void)startRecording;
- (void)stopRecording;
- (void)contimueRecording;
- (void)pauseRecording;
- (IBAction)playOrPauseRecording;
- (IBAction)editEnd;
- (IBAction)editBegin;
- (IBAction)reRecordAudio:(id)sender;
- (void)changeNavigationBarColorWithColor:(UIColor *)color;
@end


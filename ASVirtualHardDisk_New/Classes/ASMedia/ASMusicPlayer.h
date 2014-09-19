//------------------------------------------------------------------------------
// Filename:        ASMusicPlayer.h
// Project:         ASVirtualHardDisk
// Author:          wangqiushuang
// Date:            11-10-17
// Version:         
// Copyright 2011 AlphaStudio. All rights reserved. 
//------------------------------------------------------------------------------
// Quote the standard library header files. 
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ASMusicPlayer : NSObject<AVAudioPlayerDelegate> 
{
 @private
    AVAudioPlayer *player;
	NSTimer *timer;
}

@property (nonatomic, retain)AVAudioPlayer *player;

- (void)dealloc;
- (void)invalidateTimer;
+ (void)stopOrPlay:(NSURL *)aURL;
+ (void)releaseTheShareInstanse;
+ (BOOL)isSameURL:(NSURL *)aURL;
+ (BOOL)isPlaying:(NSURL *)aURL;
+ (float)currentTime:(NSURL *)aURL;
+ (BOOL)playAtProgress:(float)aProgress url:(NSURL *)aURL;

@end

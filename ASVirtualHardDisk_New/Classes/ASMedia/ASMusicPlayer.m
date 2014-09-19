//------------------------------------------------------------------------------
// Filename:        ASMusicPlayer.m
// Project:         ASVirtualHardDisk
// Author:          wangqiushuang
// Date:            11-10-17
// Version:         
// Copyright 2011 AlphaStudio. All rights reserved. 
//------------------------------------------------------------------------------

// Quote header files.
#import "ASMusicPlayer.h"
#import "ASMusicPlayerDelegate.h"
#import "ASVirtualHardDiskAppDelegate.h"
#import "ASLocalDefine.h"

@interface ASMusicPlayer()

- (id)initWithURL:(NSURL *)aURL;

@end

static ASMusicPlayer *theShareInstance;

@implementation ASMusicPlayer

@synthesize player;

-(id)initWithURL:(NSURL *)aURL
{
	self = [super init];
	if (self) {
		player = [[AVAudioPlayer alloc] initWithContentsOfURL:aURL error:nil];
		player.delegate = self;
		timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateCurrentTime) userInfo:nil repeats:YES];
        AVAudioSession *session = [AVAudioSession sharedInstance];  
        [session setActive:YES error:nil];  
        [session setCategory:AVAudioSessionCategoryPlayback error:nil]; 
	}
	return self;
}

- (void)dealloc
{
	[player release];
	[super dealloc];
}

- (void)invalidateTimer
{
	[timer invalidate];
}

- (void)updateCurrentTime
{
	UIViewController *controller = ((ASVirtualHardDiskAppDelegate *)[UIApplication sharedApplication].delegate).navigationController.topViewController;
	if ([controller conformsToProtocol:@protocol(ASMusicPlayerDelegate)] &&
        [controller respondsToSelector:@selector(changeCurrentTime)]) {
		[controller changeCurrentTime];
	}
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	UIViewController *controller = ((ASVirtualHardDiskAppDelegate *)[UIApplication sharedApplication].delegate).navigationController.topViewController;
	if ([controller conformsToProtocol:@protocol(ASMusicPlayerDelegate)] &&
        [controller respondsToSelector:@selector(playToTheEndOfMusic)]) {
		[controller playToTheEndOfMusic];
	}
	[ASMusicPlayer releaseTheShareInstanse];
}

+ (void)stopOrPlay:(NSURL *)aURL
{
	if ([theShareInstance.player.url isEqual:aURL]) {
		if (theShareInstance.player.playing) {
			[theShareInstance.player pause];
		}
		else {
			[theShareInstance.player play];
		}
	} else {
		[theShareInstance invalidateTimer];
		[theShareInstance release];
		theShareInstance = nil;
		theShareInstance = [[ASMusicPlayer alloc] initWithURL:aURL];
		[theShareInstance.player play];
	}
}

+ (void)releaseTheShareInstanse
{
	if (theShareInstance) {
		[theShareInstance invalidateTimer];
		[theShareInstance release];
		theShareInstance = nil;
	}	
}
+ (BOOL)isSameURL:(NSURL *)aURL
{
	if (theShareInstance) {
		return [theShareInstance.player.url isEqual:aURL];
	} else {
		return NO;
	}

}
+ (BOOL)isPlaying:(NSURL *)aURL
{
    NSLog(@"%@",theShareInstance.player.url);
    NSLog(@"%@",aURL);
    if(theShareInstance && 
       [theShareInstance.player.url isEqual:aURL]) {
        return theShareInstance.player.playing;
    }

	return NO;
}
+ (float)currentTime:(NSURL *)aURL
{
    if(theShareInstance && 
       [theShareInstance.player.url isEqual:aURL]) {
        return theShareInstance.player.currentTime/theShareInstance.player.duration;
    }
    
	return 0.0f;
}
+ (BOOL)playAtProgress:(float)aProgress url:(NSURL *)aURL
{
	if (theShareInstance &&
		[theShareInstance.player.url isEqual:aURL]) {
			theShareInstance.player.currentTime = aProgress*theShareInstance.player.duration;
			return YES;
		}
    
    return NO;
}
@end

//
//  ASMusicManager.m
//  iPodLibraryDemo
//
//  Created by shinren Pan on 2011/1/4.
//  Copyright 2011 home. All rights reserved.
//

#import "ASMusicManager.h"


@implementation ASMusicManager
@synthesize player, mediaCollection, isPlay;

-(id)initWithPlayerType:(NSInteger)PlayerType LoadSong:(NSArray *)SongList
{
	self = [super init];
	if(self)
	{
		switch (PlayerType) 
		{
			case 0:
				player = [MPMusicPlayerController applicationMusicPlayer];
				if([SongList count] > 0)
				{
					MPMediaItemCollection *_mediaCollection = [[MPMediaItemCollection alloc]initWithItems:SongList];
					self.mediaCollection = _mediaCollection;
					[_mediaCollection release];
					
					[player setQueueWithItemCollection:mediaCollection];
					[player setRepeatMode:MPMusicRepeatModeAll];
					
				}
				else
				{
					[player setQueueWithItemCollection:nil];
					[player setRepeatMode:MPMusicRepeatModeAll];
				}
				break;
				
			case 1:
				player = [MPMusicPlayerController iPodMusicPlayer];
				if([SongList count] > 0)
				{
					MPMediaItemCollection *_mediaCollection = [[MPMediaItemCollection alloc]initWithItems:SongList];
					self.mediaCollection = _mediaCollection;
					[_mediaCollection release];
					
					[player setQueueWithItemCollection:mediaCollection];
					[player setRepeatMode:MPMusicRepeatModeAll];
					
				}
				else
				{
					[player setQueueWithItemCollection:mediaCollection];
					[player setRepeatMode:MPMusicRepeatModeAll];
				}
				break;
		}
	}
	return self;
}

- (void)reload:(NSMutableArray *)SongList
{
	if([SongList count] > 0)
	{
		MPMediaItemCollection *_mediaCollection = [[MPMediaItemCollection alloc]initWithItems:(NSArray *)SongList];
		self.mediaCollection = _mediaCollection;
		[_mediaCollection release];
		[player setQueueWithItemCollection:mediaCollection];
	}
}
- (void)play{
	[self.player play];
	isPlay = YES;
}
- (void)pause{
	[self.player pause];
}
- (void)stop{
	[self.player stop];
	isPlay = NO;
}
- (void)prev{
	[self.player skipToPreviousItem];
}
- (void)next{
	[self.player skipToNextItem];
}

- (void)clearMusicPlayer{
	self.mediaCollection = nil;
	[player setQueueWithItemCollection:nil];
}

- (void)saveToData
{
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[mediaCollection items]];
	[[NSUserDefaults standardUserDefaults]setObject:data forKey:@"songList"];
	[[NSUserDefaults standardUserDefaults]synchronize];
}
- (void)dealloc
{
	[player release];
	[mediaCollection release];
	[super dealloc];
}
@end

//
//  ASMusicManager.h
//  iPodLibraryDemo
//
//  Created by shinren Pan on 2011/1/4.
//  Copyright 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ASMusicManager : NSObject {
	MPMusicPlayerController *player;//播放器
	MPMediaItemCollection *mediaCollection;//放置音樂的容器
	BOOL isPlay;
}
@property(nonatomic, retain)MPMusicPlayerController *player;
@property(nonatomic, retain)MPMediaItemCollection *mediaCollection;
@property(nonatomic, assign)BOOL isPlay;
-(id)initWithPlayerType:(NSInteger)PlayerType LoadSong:(NSArray *)SongList;

- (void)play;//播放
- (void)pause;//暫停
- (void)stop;//停止
- (void)prev;//下一首
- (void)next;//上一首
- (void)clearMusicPlayer;//清空播放容器
- (void)saveToData;//儲存
- (void)reload:(NSArray *)SongList;//重置播放容器
@end

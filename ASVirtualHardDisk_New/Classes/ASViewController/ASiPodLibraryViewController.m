//
//  ASiPodLibraryViewController.m
//  iPodLibraryDemo
//
//  Created by shinren Pan on 2011/1/4.
//  Copyright 2011 home. All rights reserved.
//

#import "ASiPodLibraryViewController.h"
#import "ASFileListViewController.h"
#import "ASFileEx.h"
#import "ASDirectoryEx.h"

@implementation ASiPodLibraryViewController
@synthesize musicPlayer;
@synthesize backgroundView;
@synthesize fastForwardButton;
@synthesize pauseBarButton;
@synthesize rewindBarButton;

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!musicList.editing)
        return UITableViewCellEditingStyleNone;
    else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if([musicPlayer.mediaCollection count]>0)
		return [musicPlayer.mediaCollection count];
	else 
		return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [musicList dequeueReusableCellWithIdentifier:@"any-cell"];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"any-cell"] autorelease];
	cell.textLabel.text = [[[musicPlayer.mediaCollection items]objectAtIndex:indexPath.row]valueForProperty:MPMediaItemPropertyTitle];
	cell.textLabel.textColor = [UIColor whiteColor];
	return cell;
}

//利用tableView 刪除音乐
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSMutableArray *tempArray = [[musicPlayer.mediaCollection items]mutableCopy];
	
    NSString *musicName = [[NSString alloc]initWithFormat:@"%@.mp3",[tempArray objectAtIndex:indexPath.row]];
	[tempArray removeObjectAtIndex:indexPath.row];
    NSFileManager *fileManager  = [NSFileManager defaultManager];    
    [fileManager removeItemAtPath:musicName error:nil];
	[musicName release];
    
	if([tempArray count]==0)
	{
		[musicPlayer clearMusicPlayer];
	}else
	{
		[musicPlayer reload:tempArray];
	}
	[tempArray release];
	[musicList reloadData];
}
//按到tableView 上之音乐就播放那首
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	[musicPlayer.player setNowPlayingItem:[[musicPlayer.mediaCollection items]objectAtIndex:indexPath.row]];
	[musicPlayer play];
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	
	//以下用来判断目前播放的音乐是否有图片
	MPMediaItem *nowItem = [musicPlayer.player nowPlayingItem];
	MPMediaItemArtwork *artwork = [nowItem valueForProperty:MPMediaItemPropertyArtwork];
	if(artwork)
	{
		UIImage *artworkImage = [artwork imageWithSize:CGSizeMake(320, 420)];
		backgroundView.image = artworkImage;
	}
}

#pragma mark Add new Song methods
//新增音乐
-(IBAction) addMusic:(id)sender
{
	if(!(musicList.editing))
	{
		MPMediaPickerController *picker =
		[[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeMusic];
		picker.delegate						= self;
		picker.allowsPickingMultipleItems	= YES;
		picker.prompt						= @"新增歌曲";
		[self presentModalViewController: picker animated: YES];
		[picker release];
	}
}
-(IBAction)fastForward:(id)sender
{
    [musicPlayer next];
}
-(IBAction)rewind:(id)sender
{
    [musicPlayer prev];
}
-(IBAction)pause:(id)sender
{
    if(0 == flag)
    {
        [musicPlayer pause];
        flag = 1;
    }else if(1 == flag)
    {
        [musicPlayer play];
        flag = 0;
    }
}
//当picker有选取media item后按done
- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection {
	
	BOOL isADD = NO;
	NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:[musicPlayer.mediaCollection items]];
	
	for(MPMediaItem *item in [mediaItemCollection items])
	{
		if([tempArray containsObject:item] == NO)//判断所选的音乐是否有加过了
		{
			[tempArray addObject:item];
			isADD = YES;
            
            //添加到主列表
            NSString *musicName = [[NSString alloc]initWithFormat:@"%@.mp3",[item valueForProperty:MPMediaItemPropertyTitle]];
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                           initWithTitle:@"back"
                                           style:UIBarButtonItemStylePlain
                                           target:self
                                           action:nil];
            
            self.navigationItem.backBarButtonItem = backButton;
            
            NSMutableString *path = [[NSMutableString alloc] 
                                     initWithString:NSHomeDirectory()];
            [path appendString:@"/Documents/Local"];
            
            ASFileListViewController *saveRecord = 
            [[ASFileListViewController alloc] 
             initWithNibName:@"ASFileListViewController"
             bundle:nil];
            
            saveRecord.title = @"Local";
            saveRecord.currentDirectory = 
            [[ASDirectoryEx alloc] initWithFullPath:@"/"];
            ASFileEx *newFile = [[ASFileEx alloc] initWithName:musicName And:saveRecord.currentDirectory];
            [(ASDirectoryEx *)saveRecord.currentDirectory addNewItem:newFile];
            [saveRecord release];
            [newFile release];
            [musicName release];
		}
	}
	if(isADD)
	{
		[musicPlayer stop]; //一定要先停止, 不然会有问题
		[musicPlayer reload:tempArray];
		[musicPlayer saveToData];
		[musicList reloadData];
	}
	[tempArray release];
	tempArray = nil;
	[self dismissModalViewControllerAnimated: YES];
	
}
//未选取歌曲离开
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
	[self dismissModalViewControllerAnimated: YES];
}
#pragma mark -
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    flag = 0;
    self.title = @"Musics List";
    [super viewDidLoad];
	[[MPMusicPlayerController iPodMusicPlayer]stop];
	[editButton setAction:@selector(enterEditMode)];
	musicPlayer = [[ASMusicManager alloc]initWithPlayerType:0 LoadSong:nil];
	[self performSelector:@selector(initialMusicList)];
}
//判断是否有储存过音乐
- (void)initialMusicList
{
	if([[NSUserDefaults standardUserDefaults]objectForKey:@"songList"])
		[musicPlayer reload:[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"songList"]]];
	[musicList reloadData];
}
-(void)enterEditMode{
	if(musicPlayer.isPlay)
		[musicPlayer stop];
	
	[editButton setTitle:@"完成"];
	[editButton setStyle:UIBarButtonItemStyleDone];
	[editButton setAction:@selector(leaveEditMode)];
	[musicList setEditing:YES];
}
-(void)leaveEditMode{
	[editButton setTitle:@"编辑"];
	[editButton setStyle:UIBarButtonItemStyleBordered];
	[editButton setAction:@selector(enterEditMode)];
	[musicList setEditing:NO];
	[musicPlayer saveToData];
	
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


- (void)viewDidUnload {
    
	musicList = nil;
	editButton = nil;
	backgroundView = nil;
}


- (void)dealloc {
	[musicPlayer stop];
	[musicPlayer release];
	[musicList	 release];
	[editButton  release];
	[backgroundView release];
    [super dealloc];
}

@end

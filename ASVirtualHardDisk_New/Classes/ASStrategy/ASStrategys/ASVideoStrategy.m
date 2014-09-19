//
//  ASVideoStrategy.m
//  ASVirtualHardDisk
//
//  Created by 伟超 窦 on 11-11-21.
//  Copyright (c) 2011年 AlphaStudio. All rights reserved.
//

#import "ASVideoStrategy.h"
#import "ASDirectoryEx.h"
#import "ASFileType.h"
#import "ASFileListViewController.h"
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
@implementation ASVideoStrategy

//------------------------------------------------------------------------------
// -(void) execOnState:(ASTableViewCellState)state 
//    inViewController:(ASFileListViewController *)viewController 
//    withDataObject:(id<ASDataObject>)dataObject
//------------------------------------------------------------------------------
-(void) execOnState:(ASTableViewCellState)state 
   inViewController:(ASFileListViewController *)viewController 
	 withDataObject:(id<ASDataObject>)dataObject
{
	if (Selected == state) {
        
		NSString *videoName = [[NSString alloc] initWithFormat:@"%@%@",DOCUMENTS_FOLDER,[dataObject getFullItemName]];
        NSURL *url=[[NSURL alloc] initFileURLWithPath:videoName];
        MPMoviePlayerViewController* tmpMoviePlayViewController=[[MPMoviePlayerViewController alloc] initWithContentURL:url];
        [url release];     
        [videoName release];
        if (tmpMoviePlayViewController)
        {
            viewController.moviePlayViewController=tmpMoviePlayViewController;
            [viewController playVideo];       
        }
        [tmpMoviePlayViewController release]; 
        
	}
}

@end

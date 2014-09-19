//------------------------------------------------------------------------------
//  Filename:          ASMusicStrategy.m
//  Project:           ASVirtualHardDisk
//  Author:             Okay
//  Date:              11-11-23 : last edited by  Okay
//  Version:           1.0
//  Copyright:         2011年 AlphaStudio. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).

#import "ASMusicStrategy.h"
#import "ASFileListViewController.h"
#import "ASMusicPlayer.h"
#import "ASTableViewCell.h"

@implementation ASMusicStrategy

- (void) execOnState: (ASTableViewCellState)state 
    inViewController: (UIViewController *)aViewController 
      withDataObject: (id<ASDataObject>)dataObject
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    ASFileListViewController *viewController = (ASFileListViewController*)aViewController;
    NSIndexPath *indexPath = [viewController indexPath];
    ASTableViewCell *cell = (ASTableViewCell *)[[viewController documentTableView] cellForRowAtIndexPath:indexPath];
    
    if(Selected == state)
    {
        [cell mp3TableViewCelldidSelect];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSURL *url = [[NSURL alloc]
            initWithString:[cell.filePath 
            stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

        if ([ASMusicPlayer isPlaying:url]) 
        {
            [button setImage:viewController.pause forState:UIControlStateNormal];
        }
        else 
        {
            [button setImage:viewController.play forState:UIControlStateNormal];
        }
        [url release];
        button.backgroundColor = [UIColor clearColor];
        button.frame = CGRectMake(0, 0, 29, 29);
        [button addTarget:viewController 
                   action:@selector(startOrStop:) 
         forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
        
    }
    else
    {
        [cell mp3TableViewCelldidDeselect];
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button addTarget:viewController
                   action:@selector(buttonTapped:event:) 
         forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;
        
    }
}

@end

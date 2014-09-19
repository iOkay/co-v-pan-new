//------------------------------------------------------------------------------
// Filename:        ASPictureStrategy.m
// Project:         ASStrategy
// Author:          wangqiushuang
// Date:            11-10-23
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------

// Quote header files.
#import "ASPictureStrategy.h"
#import "ASPictureViewController.h"
#import "ASDirectoryEx.h"
#import "ASFileEx.h"
#import "ASFileType.h"

@implementation ASPictureStrategy

-(void) execOnState:(ASTableViewCellState)state 
   inViewController:(UIViewController *)viewController 
	 withDataObject:(id<ASDataObject>)dataObject
{
	if (Selected == state) {
		ASPictureViewController *pictureViewController = 
		[[ASPictureViewController alloc] 
		 initWithNibName:@"ASPictureViewController"
		 bundle:nil];
		
		NSString *picturePath = [dataObject getFullItemName];
		NSString *directoryPath = [picturePath stringByDeletingLastPathComponent];
		ASDirectoryEx *dir = [[ASDirectoryEx alloc] initWithFullPath:directoryPath];
		NSArray * filesArray = [dir getFileList:NO];
		[dir release];
		
		NSMutableArray *pictureArray = [[NSMutableArray alloc] init];
		for (id<ASDataObject> file in filesArray) 
        {
			if (kPicture == [file getFileType] || kPNG == [file getFileType]) 
            {
				[pictureArray addObject:file];
			}
		}
        
        for (int i = 0; i < [pictureArray count]; i++)
        {
            id<ASDataObject> file = [pictureArray objectAtIndex:i];
            NSString *fullItemName = [file getFullItemName];
            if(NSOrderedSame ==[picturePath compare:fullItemName])
            {
                pictureViewController.startIndex = i;
            }
        }
		//pictureViewController.startIndex = 2;
		pictureViewController.pictureToDisplay = pictureArray;
		[pictureArray release];
        
        
		[viewController.navigationController pushViewController:pictureViewController animated:YES];
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:[[ASDeclare singletonASDeclare] navBack]
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:nil];
        viewController.navigationItem.backBarButtonItem = backButton;
        [backButton release];
        
        [pictureViewController release];
	}
}
@end

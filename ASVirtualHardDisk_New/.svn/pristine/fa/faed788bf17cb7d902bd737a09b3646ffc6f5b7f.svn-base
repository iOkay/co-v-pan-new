//
//  ASFileAttributeViewController.m
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASFileAttributeViewController.h"
#import "ASLocalDefine.h"
#import "ASDeclare.h"
#import "ASFileAttribute.h"
#import "ASFileType.h"

@implementation ASFileAttributeViewController

@synthesize currentItem;

//------------------------------------------------------------------------------
// - (void) viewDidLoad;
//------------------------------------------------------------------------------
- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
}

//------------------------------------------------------------------------------
// - (void)didReceiveMemoryWarning
//------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

//------------------------------------------------------------------------------
// - (void)viewDidUnload
//------------------------------------------------------------------------------
- (void)viewDidUnload 
{
    [super viewDidUnload];
}

//------------------------------------------------------------------------------
// - (void)dealloc
//------------------------------------------------------------------------------
- (void)dealloc 
{
    [super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source
//------------------------------------------------------------------------------
// - (NSInteger) tableView : (UITableView *) tableView
//   numberOfRowsInSection : (NSInteger) section
//------------------------------------------------------------------------------
- (NSInteger) tableView : (UITableView *) tableView
    numberOfRowsInSection : (NSInteger) section
{
	return 6;
}

//------------------------------------------------------------------------------
// -(UITableViewCell*)tableView:(UITableView*)tableView
//        cellForRowAtIndexPath:(NSIndexPath*)indexPath
//------------------------------------------------------------------------------
-(UITableViewCell*)tableView:(UITableView*)tableView
	   cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
	static NSString* fileCellIdentifier = @"fileCellIdentifier";
	
	UITableViewCell *cell = [tableView 
	    dequeueReusableCellWithIdentifier:fileCellIdentifier];
	
	UILabel *tagLabel = [[UILabel alloc] init];
	UILabel *contentLabel = [[UILabel alloc] init];
	
	if(!cell){
		cell = [[[UITableViewCell alloc] 
					initWithStyle:UITableViewCellStyleDefault
				  reuseIdentifier:fileCellIdentifier] autorelease];
    }
	
    tagLabel.frame = CGRectMake(10,10,100,25);
    tagLabel.textAlignment = UITextAlignmentLeft;
    tagLabel.font = [UIFont boldSystemFontOfSize:18];
    tagLabel.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:tagLabel];
    
    
    contentLabel.frame = CGRectMake(108, 12, 180, 25);
    contentLabel.textAlignment = UITextAlignmentLeft;
    contentLabel.font = [UIFont boldSystemFontOfSize:15];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.adjustsFontSizeToFitWidth = YES;
    [cell.contentView addSubview:contentLabel];
    
	NSDictionary *fileAttr = [currentItem getItemAttribution];
    
	switch ([indexPath row]) 
    {
        case 0:// cell to show fileType
            tagLabel.text = kFileType;
            
            contentLabel.text = [fileAttr objectForKey:kFileTypeValue];
            
            break;
        case 1:// cell to show location
            tagLabel.text = kFilePath;
            contentLabel.text = [fileAttr objectForKey:kFileLocationValue];
            break;	
		case 2://cell to show fileSize
			tagLabel.text = kFileSize;
            contentLabel.text = [fileAttr objectForKey:kFileSizeValue];
			break;
			
		case 3://cell to show fileCreationDate
			tagLabel.text = kFileCreationDate;
            contentLabel.text = [fileAttr objectForKey:kFileCreateValue];
			break;
			
		case 4://cell to show fileModificationdDate
			tagLabel.text = kFileModificationDate;
            contentLabel.text = [fileAttr objectForKey:kFileModifyValue];
			break;
			
		case 5://cell to show fileOwerAccountName
			tagLabel.text = kFileOwerAccountName;
            contentLabel.text = [fileAttr objectForKey:kFileOwnerValue];
			break;

		default:
			break;
	}
    [tagLabel release];
    [contentLabel release];
	return cell;
	
}


//------------------------------------------------------------------------------
// -(NSIndexPath*)tableView:(UITableView*)tableView
//        willSelectRowAtIndexPath:(NSIndexPath*)indexPath
//------------------------------------------------------------------------------
-(NSIndexPath*)tableView:(UITableView*)tableView
        willSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	return nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end

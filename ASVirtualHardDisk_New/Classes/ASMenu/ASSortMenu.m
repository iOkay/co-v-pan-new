//
//  ASSortMenu.m
//  ASVirtualHardDisk
//
//  Created by Liu Dong on 11-12-12.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <Foundation/NSNotification.h>
#import <QuartzCore/QuartzCore.h>

#import "ASImageResize.h"
#import "ASSortMenu.h"

@implementation ASSortMenu
@synthesize sortType;
@synthesize sortFlag;

- (id) initWithPoint:(CGPoint)menuPoint 
       andArrowPoint:(CGPoint)arrowPoint 
       andDataSource:(id<ASMenuDataSource>)data
{
    self = [super initWithPoint:menuPoint andArrowPoint:arrowPoint andDataSource:data];
	if (self) {
		sortType = [data getSortType];
		sortFlag = [data getSortFlag];
    }
    
    return self;
}

#pragma mark -
#pragma mark Table View Delegate Method

- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
		cell.backgroundColor = [UIColor clearColor];
        
        UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
  
		selectedView.backgroundColor = [UIColor darkGrayColor];
        selectedView.layer.cornerRadius = 8.0f;
        selectedView.layer.masksToBounds = YES;
        selectedView.layer.borderWidth = 10.0f;
        selectedView.layer.borderColor = [[UIColor clearColor] CGColor];
		cell.selectedBackgroundView = selectedView;
		[selectedView release];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame: CGRectMake(40, 0, 200, 30)];
        textLabel.backgroundColor = cell.backgroundColor;
        textLabel.tag = 2;
        [cell.contentView addSubview: textLabel];
        [textLabel release];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(3, 3, 25, 25)];
        imageView.tag = 1;
        [cell.contentView addSubview: imageView];
        [imageView release];
    }
    
    // Configure the cell...
	int row = [indexPath row];

	UILabel *cellLabel = (UILabel*)[cell.contentView viewWithTag: 2];
	cellLabel.text = [item objectAtIndex:[indexPath row]];
    cellLabel.font = [UIFont boldSystemFontOfSize:17.0f];
	cellLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [item objectAtIndex: [indexPath row]];
    cell.textLabel.hidden = YES;
    
    UIImage *image = [UIImage imageNamed:[itemIcon objectAtIndex:[indexPath row]]];
    UIImageView *cellImageView = (UIImageView*)[cell.contentView viewWithTag: 1];
    cellImageView.image = image;
	if (row == sortType || row == sortFlag) 
	{
		UIImage *sImage = [UIImage imageNamed:@"selected.png"];
		UIImageView *view = [[UIImageView alloc] initWithImage:sImage];
		cell.accessoryView = view;
		[view release];
		cell.accessoryView.frame = CGRectMake(0, 0, 20, 20);
	}
    return cell;
}

- (void)tableView:(UITableView *)tableView 
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeFromSuperview];
	int row = [indexPath row];
	if (row < 4) {
		if (row != sortType) {
			[dataSource resignSortType:row andFlag:sortFlag];
			[delegate beginSortWithType:row+1 andFlag:(4 == sortFlag)];
			NSString *noticeName = [NSString stringWithFormat:@"sortType%d",row];
			[[NSNotificationCenter defaultCenter] postNotificationName:noticeName object:nil];
		}
	} else {
		if (row != sortFlag) {
			[dataSource resignSortType:sortType andFlag:row];
			[delegate beginSortWithType:sortType+1 andFlag:(4 == row)];
		}
	}
	
}

@end

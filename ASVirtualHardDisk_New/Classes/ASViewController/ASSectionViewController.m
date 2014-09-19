//
//  ASSectionViewController.m
//  ASVirtualHardDisk
//
//  Created by 刘 殿章 on 11-11-29.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASSectionViewController.h"
#import "ASLocalDefine.h"
#import "ASHelpViewController.h"
#import "ASHelpTableViewCell.h"

static const int kAppStoreId = 484338449;

@implementation ASSectionViewController
@synthesize listData,keys;
@synthesize helpTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 0.9;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.opaque = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    chose = 0;
    [helpTableView reloadData];
}

- (void) viewDidDisappear:(BOOL)animated
{
//    [self.navigationController setToolbarHidden:NO];
    [super viewDidDisappear:animated];
}

- (void)dealloc
{
    [listData release];
    [keys release];
    [helpTableView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setToolbarHidden:YES];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"help"
                                                     ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] 
                          initWithContentsOfFile:path];
    self.listData = dict;
    
    NSArray * array = [[listData allKeys]sortedArrayUsingSelector:@selector(compare:)];
    self.keys = array;
    
    [dict release];
}

- (void)viewDidUnload
{
    self.listData = nil;
    self.keys = nil;
    self.helpTableView = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//------------------------------------------------------------------------------
// - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [keys count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (0 == section)
    {
        return kIFilesBox;
    }
    else if(1 == section)
    {
        return kConnecting;
    }
    else if(2 == section)
    {
        return kDoYouLikeIt;
    }
    else
    {
        return nil;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (0==[keys count]) {
		return 0;
	}
	NSString * key = [keys objectAtIndex:section];
	NSArray * nameSection = [listData objectForKey:key];
	return [nameSection count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger section = [indexPath section];
	NSUInteger row = [indexPath row];
	
	NSString * key = [keys objectAtIndex:section];
	NSArray *nameSection = [listData objectForKey:key];
	
	static NSString * SectionsTableIdentifier = @"SectionsTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier];
	if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:SectionsTableIdentifier] 
                autorelease];
        
        /*
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 60.0f)];
        selectedView.alpha = 0.8f;
        selectedView.backgroundColor = [UIColor grayColor];
        cell.selectedBackgroundView = selectedView;
        [selectedView release];
        */
        
        //cell.selectionStyle = UITableViewCellSelectionStyleGray;
        //cell.backgroundColor = [UIColor grayColor];
	}
	cell.textLabel.text = [nameSection objectAtIndex:row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    if (2 == section) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    }

    cell.accessoryView = nil;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return indexPath;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSUInteger section = [indexPath section];
	NSUInteger row = [indexPath row];

    NSString * help = kHelpTitle;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:help
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:nil];
    if (section == 0&&row == 0) 
    {
        ASHelpViewController *helpView = [[ASHelpViewController alloc] 
                                             initWithNibName:@"ASHelpViewController"
                                             bundle:nil];
        helpView.title = kHelpIntroduction;
        self.navigationItem.backBarButtonItem = backButton;
        [self.navigationController pushViewController:helpView animated:YES];
        chose = 0;
        [helpView release]; 
    }
    if(section == 0&&row == 1)
    {
        ASHelpViewController *helpView = [[ASHelpViewController alloc] 
                                          initWithNibName:@"ASHelpViewController"
                                          bundle:nil];
        helpView.title = kHelpTip;
        self.navigationItem.backBarButtonItem = backButton;
        chose = 1;
        [self.navigationController pushViewController:helpView animated:YES];
        [helpView release];
    }
    if(section == 1)
    {
        if (row == 0) {
            ASHelpViewController *helpView = [[ASHelpViewController alloc] 
                                              initWithNibName:@"ASHelpViewController"
                                              bundle:nil];
            helpView.title = kHelpGeneral;
            self.navigationItem.backBarButtonItem = backButton;
            chose = 2;
            [self.navigationController pushViewController:helpView animated:YES];
            [helpView release];
        }
        if (row == 1) {
            ASHelpViewController *helpView = [[ASHelpViewController alloc] 
                                              initWithNibName:@"ASHelpViewController"
                                              bundle:nil];
            helpView.title = kHelpMac;
            self.navigationItem.backBarButtonItem = backButton;
            chose = 3;
            [self.navigationController pushViewController:helpView animated:YES];
            [helpView release];
        }
        if (row == 2) {
            ASHelpViewController *helpView = [[ASHelpViewController alloc] 
                                              initWithNibName:@"ASHelpViewController"
                                              bundle:nil];
            helpView.title = kHelpWindows;
            self.navigationItem.backBarButtonItem = backButton;
            chose = 4;
            [self.navigationController pushViewController:helpView animated:YES];
            [helpView release];
        }
    }
    if (2 == section && 0 == row) 
    {
        NSString *str = nil;
        str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",kAppStoreId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    [backButton release];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 45;
}

@end

 //------------------------------------------------------------------------------
//  Filename:          ASBookmarkViewController.m
//  Project:           NSWebView
//  Author:            xiu
//  Date:              11-10-24 : last edited by xiu
//  Version:           1.0
//  Copyright:         2011年 __AlphaStudio__. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).


#import "ASBookmarkViewController.h"
#import "ASWebViewModel.h"
#import "ASBookmark.h"
#import "ASAddInfoViewController.h"
#import "ASLocalDefine.h"


@interface ASBookmarkViewController (hidden)  

-(void)newFolder:(id)sender;
@end



@implementation ASBookmarkViewController
@synthesize model,delegate;

- (void) formatToolBarOfBookMark
{
    [self.navigationController setToolbarHidden:NO];
    edit = [[UIBarButtonItem alloc] 
            initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                 target:self 
                                 action:@selector(editButtonClick:)];
    [self setToolbarItems:[NSArray arrayWithObject:edit] animated:YES];
}
//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)dealloc
{
    [super dealloc];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    topToolBar.tintColor = [UIColor blackColor];
    model = [ASWebViewModel single];
    tittleLabel.text = KBOOKMARKLISTTITTLE;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)viewDidUnload
{
    [bottomDone release];
    bottomDone = nil;
    [super viewDidUnload];
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = YES;
    [tableView reloadData];
    [self formatToolBarOfBookMark];
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma tableView delegate

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [model.bookmarkList count ];
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DeleteMeCellIdentifier = @"DeleteMeCellIdentifier";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:DeleteMeCellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DeleteMeCellIdentifier]autorelease];
    
        cell.showsReorderControl = YES;
    }
    
    NSInteger row = [indexPath row];
    ASBookmark* object = (ASBookmark*)[model.bookmarkList objectAtIndex:row];
    cell.textLabel.text = object.name;
//    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = object.urlString;
//    cell.detailTextLabel.font = [UIFont systemFontOfSize:7];

    return cell;

}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSInteger fromRow = [fromIndexPath row];
    NSInteger toRow = [toIndexPath row];
    
    id object = [[model.bookmarkList objectAtIndex:fromRow] retain];
    [model.bookmarkList removeObjectAtIndex:fromRow];
    [model.bookmarkList insertObject:object atIndex:toRow];
    [object release];
    
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    ASBookmark* object = (ASBookmark*)[model.bookmarkList objectAtIndex:row];
    [delegate selectedBookmark:object.urlString];

    [self.navigationController popViewControllerAnimated:YES];
  
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)tableView:(UITableView *)atbleView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    [model.bookmarkList removeObjectAtIndex:row];
    [atbleView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
        return UITableViewCellAccessoryDisclosureIndicator;
   
}




#pragma mark -
#pragma my function
//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(IBAction)doneButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(IBAction)editButtonClick:(id)sender
{
    if (tableView.editing) 
    {
        tableView.editing = NO;
        [model saveToFile];
        NSArray* arrayBottomNo = [[NSArray alloc] initWithObjects: edit, nil];
        [self setToolbarItems: arrayBottomNo animated: YES];
        [arrayBottomNo release];
        NSArray* arrayTopNo = [[NSArray alloc]initWithObjects:fixedSpace,topDone, nil];
        [topToolBar setItems:arrayTopNo animated:YES];
        [arrayTopNo release];
        
    }
    else
    {
        //底部done按钮的创建
        if (bottomDone == nil)
        {
            bottomDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editButtonClick:)];
        }
        
        tableView.editing = YES;
        
        [topToolBar setItems:nil animated:YES];
        
        NSArray* arrayBottomOn = [[NSArray alloc]initWithObjects:bottomDone, nil];
        [self setToolbarItems: arrayBottomOn animated: YES];
        [arrayBottomOn release];
    }
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)newFolder:(id)sender
{
    
}



@end

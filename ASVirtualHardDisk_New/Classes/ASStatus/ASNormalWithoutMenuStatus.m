//
//  ASNormalWithoutMenuStatus.m
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-23.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASDataObject.h"
#import "ASDataObjectManager.h"
#import "ASDeclare.h"
#import "ASDirectoryEx.h"
#import "ASFileAttributeViewController.h"
#import "ASFileEx.h"
#import "ASFileListViewController.h"
#import "ASFileStrategyManager.h"
#import "ASFileType.h"
#import "ASImageResize.h"
#import "ASMenu.h"
#import "ASNormalWithoutMenuStatus.h"
#import "ASRightMenuModel.h"
#import "ASStatusManager.h"
#import "ASTableViewCell.h"
#import "ASSortMenuModel.h"

@interface ASNormalWithoutMenuStatus(private)

- (void)reloadToolBar:(NSNotification *)aNote;

@end

@implementation ASNormalWithoutMenuStatus

static const CGFloat kToolBarIconSize = 30.0f;
static const CGFloat kRightButtonX = 165.0f;
static const CGFloat kRightButtonXu = 20.0f;
static const CGFloat kRightButtonXl = 95.0f;
static const CGFloat kRightButtonXr = 300.0f;
static const CGFloat kButtonWith = 30.0f;

#pragma mark -
#pragma mark ASStatus Method
//------------------------------------------------------------------------------
// - (void) didDeselected
//------------------------------------------------------------------------------
- (void) didDeselected
{
    if(viewController.indexPath) {
        UITableViewCell *cell = [[viewController documentTableView]cellForRowAtIndexPath:viewController.indexPath];
        cell.selected = NO;
        
        id<ASDataObject> dataObj = [[viewController filesInCurrentDocument] objectAtIndex:[viewController.indexPath row]];
        if(kZip == [dataObj getFileType]) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [button addTarget: viewController
                       action: @selector(buttonTapped:event:) 
             forControlEvents: UIControlEventTouchUpInside];
            
            cell.accessoryView = button;
        }
    }
    
}

//------------------------------------------------------------------------------
// - (void) handleForToolBar
//------------------------------------------------------------------------------
- (void) handleForToolBar
{
	//create add dirctory button
    UIButton *tmpButton = [[UIButton alloc] init];
    tmpButton.showsTouchWhenHighlighted = YES;
	viewController.addDirectory = tmpButton;
    [tmpButton release];
    
	[viewController.addDirectory setImage:[UIImage imageNamed:@"add.png"]
                                 forState:UIControlStateNormal];
	
    //被窦伟超修改：
    [viewController.addDirectory addTarget:viewController action:@selector(showMenu:)  forControlEvents:UIControlEventTouchUpInside];
    
    viewController.addDirectory.frame = CGRectMake(30.0, 0.0, 
                                                   kToolBarIconSize,
                                                   kToolBarIconSize);
	
	//refresh file list button
	UIButton *refreshFileList = [[UIButton alloc] init];
    refreshFileList.showsTouchWhenHighlighted = YES;
	[refreshFileList setImage:[UIImage imageNamed:@"refresh.png"]
					 forState:UIControlStateNormal];
	
	[refreshFileList addTarget:viewController action:@selector(refreshDirectory:)
			  forControlEvents:UIControlEventTouchUpInside];
	refreshFileList.frame = CGRectMake(64, 0, 
                                       kToolBarIconSize,
                                       kToolBarIconSize);
	
	//search file button
	UIButton *searchFile = [[UIButton alloc] init];
    searchFile.showsTouchWhenHighlighted = YES;
	[searchFile setImage:[UIImage imageNamed:@"search.png"]
				forState:UIControlStateNormal];
	
	[searchFile addTarget:viewController action:@selector(searchFiles:)
		 forControlEvents:UIControlEventTouchUpInside];
	searchFile.frame = CGRectMake(128, 0, 
                                  kToolBarIconSize, kToolBarIconSize);
	
	//sort file button 
	//add by Liu Dong
	NSString *picName = nil;
	ASSortMenuModel *model = [ASSortMenuModel singletonASSortMenuModel];
	switch ([model getSortType]) 
	{
		case 0:
			picName = [NSString stringWithString:@"byName.png"];
			break;
		case 1:
			picName = [NSString stringWithString:@"byDate.png"];
			break;
		case 2:
			picName = [NSString stringWithString:@"byKind.png"];
			break;
		case 3:
			picName = [NSString stringWithString:@"bySize.png"];
			break;
		default:
			break;
	}
	
	UIButton *sortBtn = [[UIButton alloc]init];
    sortBtn.showsTouchWhenHighlighted = YES;
    [sortBtn setImage:[UIImage imageNamed:picName]
			 forState:UIControlStateNormal];
    
    [sortBtn addTarget:viewController action:@selector(showSortMenu:)
	  forControlEvents:UIControlEventTouchUpInside];
    sortBtn.frame = CGRectMake(192, 0,
                               kToolBarIconSize, kToolBarIconSize);
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc]
                                 initWithCustomView:sortBtn];
	
    
	UIBarButtonItem *addDirItem = [[UIBarButtonItem alloc] 
                                   initWithCustomView:viewController.addDirectory];
    
	UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] 
                                    initWithCustomView:refreshFileList];
    
	UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] 
                                   initWithCustomView:searchFile];
    
    
	
	NSMutableArray *array = [[NSMutableArray alloc] init];
    
	[array addObject:addDirItem];
    [array addObject:space];
    [array addObject:searchItem];
    [array addObject:space];
	[array addObject:sortItem];
    [array addObject:space];
	[array addObject:refreshItem];
    
    [sortBtn release];
    [refreshFileList release];
    [searchFile release];
    
    [space release];
    [sortItem release];
	[addDirItem release];
	[refreshItem release];
	[searchItem release];
    
	[viewController setToolbarItems:array animated:YES];
    
	[array release];
}

//------------------------------------------------------------------------------
// - (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer
//------------------------------------------------------------------------------
- (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer
{
    NSLog(@"NormalWithoutMenu - tapGesture");
}

//------------------------------------------------------------------------------
// - (void) handleSwipeFrom:(UISwipeGestureRecognizer *)gestureRecognizer
//------------------------------------------------------------------------------
- (void) handleSwipeFrom:(UISwipeGestureRecognizer *)gestureRecognizer
{  
    [self didDeselected];
    
    [viewController.statusManager changeToNormalWithMenuStatus];
    
    //add animation for cell selected
    UITableViewCell	*cell = (UITableViewCell *)gestureRecognizer.view;
    UIView *selectedView = cell.selectedBackgroundView;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration: 1.0f];
    [UIView setAnimationTransition: UIViewAnimationTransitionNone 
                           forView: selectedView 
                             cache: YES];
    [selectedView setAlpha:1.0f];
    [selectedView setAlpha:0.3f];
    [selectedView setAlpha:1.0f];
    [UIView commitAnimations];
    
    //add object to selectedArray
    ((UITableViewCell *)gestureRecognizer.view).selected = YES;
    NSIndexPath *indexPath =[viewController.documentTableView
                             indexPathForCell:((UITableViewCell *)gestureRecognizer.view)];
    viewController.indexPath = indexPath;
    NSUInteger row = [indexPath row];
    id<ASDataObject> dataObj = [viewController.filesInCurrentDocument objectAtIndex: row];
    
    if([viewController.selectedFiles count]) {
        [viewController.selectedFiles removeAllObjects];
    }
    [viewController.selectedFiles setObject:dataObj forKey:indexPath];
    
    CGPoint touchInTableView = [gestureRecognizer locationOfTouch:0 inView:viewController.documentTableView];
    viewController.pointOfCell = touchInTableView;
    CGPoint touch = [gestureRecognizer locationOfTouch:0 inView:viewController.view];
    
    //这个坐标要求是相对于window的，上面获取的frame是相对于self.view的，所以加了64
    ASMenu *popmenu ;
    switch (viewController.interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            popmenu = [[ASMenu alloc] initWithPoint:
                       [ASRightMenuModel pointForMenuOfPortrait:
                        CGPointMake(kRightButtonX, touch.y+64.0f)] 
                                      andArrowPoint:
                       [ASRightMenuModel pointForArrowOfPortrait:CGPointMake(kRightButtonX, touch.y+64.0f)]
                                      andDataSource:
                       [ASRightMenuModel sharedASRightMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(0));
            popmenu.delegate = viewController;
            
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            popmenu = [[ASMenu alloc] initWithPoint:
                       [ASRightMenuModel pointForMenuOfUpsideDown:
                        CGPointMake(kRightButtonXu, 300-touch.y)] 
                                      andArrowPoint:
                       [ASRightMenuModel pointForArrowOfUpsideDown:CGPointMake(kRightButtonXu, touch.y+64)]
                                      andDataSource:
                       [ASRightMenuModel sharedASRightMenuModel]];
            popmenu.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
            popmenu.delegate = viewController;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            popmenu = [[ASMenu alloc] initWithPoint:
                       [ASRightMenuModel pointForMenuOfLandscapeLeft:
                        CGPointMake(touch.y+30,80)] 
                                      andArrowPoint:
                       [ASRightMenuModel pointForArrowOfLandscapeLeft:CGPointMake(touch.y+30,115)]
                                      andDataSource:
                       [ASRightMenuModel sharedASRightMenuModel]];
            CGAffineTransform transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
            popmenu.transform = transform;
            popmenu.delegate = viewController;
            break;
        case UIInterfaceOrientationLandscapeRight:
            popmenu = [[ASMenu alloc] initWithPoint:
                       [ASRightMenuModel pointForMenuOfLandscapeRight:
                        CGPointMake(155-touch.y,300)] 
                                      andArrowPoint:
                       [ASRightMenuModel pointForArrowOfLandscapeRight:CGPointMake(155-touch.y,200)]
                                      andDataSource:
                       [ASRightMenuModel sharedASRightMenuModel]];
            transform = CGAffineTransformMakeRotation(degreesToRadian(90));
            popmenu.transform = transform;
            popmenu.delegate = viewController;
            break;
        default:
            break;
    }
    viewController.popmenu = popmenu;
    [viewController searchBarCancelButtonClicked:viewController.searchBar];
    [[[UIApplication sharedApplication] keyWindow] addSubview:popmenu];
    [popmenu release];
}

//------------------------------------------------------------------------------
// - (void) handleDidDeselectRowAtIndexPath:(NSIndexPath *)aIndexPath
//------------------------------------------------------------------------------
- (void) handleDidDeselectRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    id<ASDataObject> dataObj = [viewController.filesInCurrentDocument objectAtIndex:[aIndexPath row]];
    
    ASFileStrategyManager *fileStrategy = [ASFileStrategyManager sharedASFileStrategyManager];
    
    [fileStrategy execOnState:DeSelected inViewController:viewController withDataObject:dataObj];
    
}

//------------------------------------------------------------------------------
// - (void) handleAccessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)aIndexPath
//------------------------------------------------------------------------------
- (void) handleAccessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)aIndexPath
{
    id<ASDataObject> dataObj = [viewController.filesInCurrentDocument 
                                objectAtIndex:[aIndexPath row]];
    
    ASFileAttributeViewController *childController = 
        [[ASFileAttributeViewController alloc] 
         initWithStyle:UITableViewStyleGrouped];
    
    childController.title = [[dataObj getItemName] lastPathComponent];
    
    [viewController.navigationController pushViewController:childController
                                                   animated:YES];
    
    childController.currentItem = dataObj;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:[[ASDeclare singletonASDeclare] navBack]
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:nil];
    viewController.navigationItem.backBarButtonItem = backButton;
    
    [backButton release];
    [childController release];
}

//------------------------------------------------------------------------------
// - (void) handleDidSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
//------------------------------------------------------------------------------
- (void) handleDidSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    
    viewController.indexPath = aIndexPath;
    id<ASDataObject> dataObj = [viewController.filesInCurrentDocument 
                                objectAtIndex:[aIndexPath row]];
    
    ASFileStrategyManager *fileStrategy = 
    [ASFileStrategyManager sharedASFileStrategyManager];
    
    [fileStrategy execOnState:Selected 
             inViewController:viewController 
               withDataObject:dataObj];
}

#pragma mark -
#pragma mark life cycle
- (id) initWithViewController:(ASFileListViewController *) aViewController
{
    self = [super init];
    if(self)
    {
        viewController = aViewController;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadToolBar:) 
												     name:@"sortType0" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadToolBar:) 
												     name:@"sortType1" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadToolBar:) 
												     name:@"sortType2" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadToolBar:) 
												     name:@"sortType3" object:nil];
    }
    return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"sortType0" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"sortType1" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"sortType2" object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"sortType3" object:nil];
    [super dealloc];
}

- (void)reloadToolBar:(NSNotification *)aNote
{
	NSString *imgName = nil;
	if ([aNote.name isEqualToString:@"sortType0"]) 
	{
		imgName = [NSString stringWithString:@"byName.png"];
	}
	if ([aNote.name isEqualToString:@"sortType1"]) 
	{
		imgName = [NSString stringWithString:@"byDate.png"];
	}
	if ([aNote.name isEqualToString:@"sortType2"]) 
	{
		imgName = [NSString stringWithString:@"byKind.png"];
	}
	if ([aNote.name isEqualToString:@"sortType3"]) 
	{
		imgName = [NSString stringWithString:@"bySize.png"];
	}
	
    UIBarButtonItem *sortItem = 
        [viewController.navigationController.toolbar.items objectAtIndex:4];
	UIButton *btn = (UIButton*)sortItem.customView;
	[UIView beginAnimations:@"change button" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:btn cache:YES];
	[btn setImage:[UIImage imageNamed:imgName] 
         forState:UIControlStateNormal];
    [UIView commitAnimations];
}

@end

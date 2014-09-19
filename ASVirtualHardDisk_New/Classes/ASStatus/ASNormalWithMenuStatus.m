//
//  ASNormalWithMenuStatus.m
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-23.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASDataObject.h"
#import "ASFile.h"
#import "ASFileListViewController.h"
#import "ASImageResize.h"
#import "ASMenu.h"
#import "ASNormalWithMenuStatus.h"
#import "ASRightMenuModel.h"
#import "ASStatusManager.h"
#import "ASFileStrategyManager.h"


@implementation ASNormalWithMenuStatus

static const CGFloat kToolBarIconSize = 24.0f;
static const CGFloat kRightButtonXp = 160.0f;
static const CGFloat kRightButtonXu = 20.0f;
static const CGFloat kRightButtonXl = 95.0f;
static const CGFloat kRightButtonXr = 300.0f;

#pragma mark -
#pragma mark ASStatus Method
//------------------------------------------------------------------------------
// - (void) didDeselected
//------------------------------------------------------------------------------
- (void) didDeselected
{
    if(nil != viewController.indexPath)
    {
        UITableViewCell *cell = [[viewController documentTableView]cellForRowAtIndexPath:viewController.indexPath];
        cell.selected = NO;
        
        id<ASDataObject> dataObj = [[viewController filesInCurrentDocument] objectAtIndex:[viewController.indexPath row]];
        if(kZip == [dataObj getFileType])
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [button addTarget:viewController
                       action:@selector(buttonTapped:event:) 
             forControlEvents:UIControlEventTouchUpInside];
            
            cell.accessoryView = button;
        }
    }
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

}

//------------------------------------------------------------------------------
// - (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer
//------------------------------------------------------------------------------
- (void) handleTapGesture:(UITapGestureRecognizer *) gestureRecognizer
{
    NSLog(@"NormalWithMenu - tapGesture");
}

//------------------------------------------------------------------------------
// - (void) handleForToolBar
//------------------------------------------------------------------------------
- (void) handleForToolBar
{
    
}

//------------------------------------------------------------------------------
// - (void) handleSwipeFrom:(UISwipeGestureRecognizer *)gestureRecognizer
//------------------------------------------------------------------------------
- (void) handleSwipeFrom:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self didDeselected];
    
    UITableViewCell	*cell = (UITableViewCell *)gestureRecognizer.view;
    UIView *selectedView = cell.selectedBackgroundView;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:selectedView cache:YES];
    [selectedView setAlpha:1.0f];
    [selectedView setAlpha:0.3f];
    [selectedView setAlpha:1.0f];
    [UIView commitAnimations];
    
    //add object to selectedArray
    ((UITableViewCell *)gestureRecognizer.view).selected = YES;
    NSIndexPath *indexPath =[viewController.documentTableView indexPathForCell:((UITableViewCell *)gestureRecognizer.view)];
    viewController.indexPath = indexPath;
    NSUInteger row = [indexPath row];
    id<ASDataObject> dataObj = [viewController.filesInCurrentDocument objectAtIndex:row];
    
    if([viewController.selectedFiles count] != 0) {
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
                        CGPointMake(kRightButtonXp, touch.y+64.0f)] 
                                      andArrowPoint:
                       [ASRightMenuModel pointForArrowOfPortrait:CGPointMake(kRightButtonXp, touch.y+64.0f)]
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
    [viewController.statusManager changeToNormalWithoutMenuStatus];
}

//------------------------------------------------------------------------------
// - (void) handleDidSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
//------------------------------------------------------------------------------
- (void) handleDidSelectRowAtIndexPath:(NSIndexPath *)aIndexPath
{
    [self didDeselected];
    viewController.indexPath = aIndexPath;
    [viewController.statusManager changeToNormalWithoutMenuStatus];
}

#pragma mark -
#pragma mark life cycle
- (id) initWithViewController:(ASFileListViewController *) aViewController
{
    self = [super init];
    if(self)
    {
        viewController = aViewController;
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

@end

//
//  ASToolBarEdit.m
//  ASVirtualHardDisk
//
//  Created by 佳璇 李 on 12-2-29.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import "ASToolBarEdit.h"
#import "ASLocalDefine.h"


@implementation ASToolBarEdit

-(void)showToolBar
{
    //deletebutton
    deleteButton = [[UIButton alloc] init];
    deleteButton.showsTouchWhenHighlighted = YES;
    [deleteButton setImage:[UIImage imageNamed: kvDeletebutton] forState:UIControlStateNormal];
    [deleteButton addTarget: viewController action: @selector(deleteFile) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton setFrame: CGRectMake(0, 0, 36, 38)];
    
    deleteimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed: kvDeletebutton]];
    [deleteimage setFrame:CGRectMake(0, 0, 36, 38)];
    deleteItem = [[UIBarButtonItem alloc] initWithCustomView: deleteButton];
    
    
    //copybutton
    copyButton = [[UIButton alloc] init];
    copyButton.showsTouchWhenHighlighted = YES;
    [copyButton setImage: [UIImage imageNamed: kvCopybutton] forState: UIControlStateNormal];
    [copyButton addTarget: viewController action: @selector(copyFiles) forControlEvents:UIControlEventTouchUpInside];
    [copyButton setFrame: CGRectMake(0, 0, 36, 38)];
    
    copyimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed: kvCopybutton]];
    [copyimage setFrame:CGRectMake(0, 0, 36, 38)];
    copyItem = [[UIBarButtonItem alloc] initWithCustomView: copyButton];
    
    //movebutton
    moveButton = [[UIButton alloc] init];
    moveButton.showsTouchWhenHighlighted = YES;
    [moveButton setImage: [UIImage imageNamed: kvMovebutton] forState: UIControlStateNormal];
    [moveButton addTarget: viewController action: @selector(moveFiles) forControlEvents:UIControlEventTouchUpInside];
    [moveButton setFrame: CGRectMake(0, 0, 36, 38)];
    
    moveimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed: kvMovebutton]];
    [moveimage setFrame:CGRectMake(0, 0, 36, 38)];
    moveItem = [[UIBarButtonItem alloc] initWithCustomView: moveButton];
    
    //zipbutton
    zipButton = [[UIButton alloc] init];
    zipButton.showsTouchWhenHighlighted = YES;
    [zipButton setImage: [UIImage imageNamed: kvZipbutton] forState: UIControlStateNormal];
    [zipButton addTarget: viewController action: @selector(zipFiles) forControlEvents:UIControlEventTouchUpInside];
    [zipButton setFrame: CGRectMake(0, 0, 36, 38)];
    
    zipimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed: kvZipbutton]];
    [zipimage setFrame:CGRectMake(0, 0, 36, 38)];
    zipItem = [[UIBarButtonItem alloc] initWithCustomView: zipButton];
    
    //emailbutton
    emailButton = [[UIButton alloc] init];
    emailButton.showsTouchWhenHighlighted = YES;
    [emailButton setImage: [UIImage imageNamed: kvEmailbutton] forState: UIControlStateNormal];
    [emailButton addTarget: viewController action: @selector(emailFiles) forControlEvents:UIControlEventTouchUpInside];
    [emailButton setFrame: CGRectMake(0, 0, 36, 38)];
    
    emailimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed: kvEmailbutton]];
    [emailimage setFrame:CGRectMake(0, 0, 36, 38)];
    emailItem = [[UIBarButtonItem alloc] initWithCustomView: emailButton];
    
    
    //sharebutton
    shareButton = [[UIButton alloc] init];
    shareButton.showsTouchWhenHighlighted = YES;
    [shareButton setImage: [UIImage imageNamed: kvSharebutton] forState: UIControlStateNormal];
    [shareButton addTarget: viewController action: @selector(shareFiles) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setFrame: CGRectMake(0, 0, 36, 38)];
    
    shareimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed: kvSharebutton]];
    [shareimage setFrame:CGRectMake(0, 0, 36, 38)];
    shareItem = [[UIBarButtonItem alloc] initWithCustomView: shareButton];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]
                              initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
	NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [array addObject:space];
	[array addObject:deleteItem];
    [array addObject:space];
	[array addObject:copyItem];
    [array addObject:space];
	[array addObject:moveItem];
    [array addObject:space];
	[array addObject:zipItem];
    [array addObject:space];
	[array addObject:emailItem];
    [array addObject:space];
    [array addObject:shareItem];
    [array addObject:space];
    
    [emailItem release];
	[deleteItem release];
	[copyItem release];
	[moveItem release];
	[zipItem release];
    [shareItem release];
    [space release];

    [viewController setToolbarItems:array animated:YES];
    [array release];
}


//-(void)showVirtualToolBar
-(void)showVirtualToolBar
{
    deleteButton.hidden = YES;
    copyButton.hidden = YES;
    moveButton.hidden = YES;
    zipButton.hidden = YES;
    emailButton.hidden = YES;
    shareButton.hidden = YES;
    [deleteItem initWithCustomView:deleteimage];
    [copyItem initWithCustomView:copyimage];
    [moveItem initWithCustomView:moveimage];
    [zipItem initWithCustomView:zipimage];
    [emailItem initWithCustomView:emailimage];
    [shareItem initWithCustomView:shareimage];
    
    [deleteButton setImage:[UIImage imageNamed: kvDeletebutton] forState:UIControlStateNormal];
    [copyButton setImage:[UIImage imageNamed: kvCopybutton] forState:UIControlStateNormal];
    [moveButton setImage:[UIImage imageNamed: kvMovebutton] forState:UIControlStateNormal];
    [zipButton setImage:[UIImage imageNamed: kvZipbutton] forState:UIControlStateNormal];
    [emailButton setImage:[UIImage imageNamed: kvEmailbutton] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed: kvSharebutton] forState:UIControlStateNormal];
}

//-(void)showEntryToolBar
-(void)showEntryToolBar
{
    deleteItem.enabled = YES;
    copyItem.enabled = YES;
    moveItem.enabled = YES;
    zipItem.enabled = YES;
    emailItem.enabled = YES;
    shareItem.enabled = YES;
    
    deleteButton.hidden = NO;
    copyButton.hidden = NO;
    moveButton.hidden = NO;
    zipButton.hidden = NO;
    emailButton.hidden = NO;
    shareButton.hidden = NO;
    
    [deleteItem initWithCustomView:deleteButton];
    [copyItem initWithCustomView:copyButton];
    [moveItem initWithCustomView:moveButton];
    [zipItem initWithCustomView:zipButton];
    [emailItem initWithCustomView:emailButton];
    [shareItem initWithCustomView:shareButton];
    
    [deleteButton setImage:[UIImage imageNamed: kDeletebutton] forState:UIControlStateNormal];
    [copyButton setImage:[UIImage imageNamed: kCopybutton] forState:UIControlStateNormal];
    [moveButton setImage:[UIImage imageNamed: kMovebutton] forState:UIControlStateNormal];
    [zipButton setImage:[UIImage imageNamed: kZipbutton] forState:UIControlStateNormal];
    [emailButton setImage:[UIImage imageNamed: kEmailbutton] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed: kSharebutton] forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark life cycle
- (id) initWithViewController:(UIViewController *)aViewController
{
    self = [super init];
    if(self)
    {
        viewController = aViewController;
    }
    return self;
}
-(void)dealloc
{
    [emailButton release];
    [deleteButton release];
    [copyButton release];
    [moveButton release];
    [zipButton release];
    [shareButton release];
    
    [emailimage release];
    [deleteimage release];
    [copyimage release];
    [moveimage release];
    [zipimage release];
    [shareimage release];
    
    [super dealloc];
}
@end

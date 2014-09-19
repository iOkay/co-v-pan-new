//
//  ASToolBarEdit.h
//  ASVirtualHardDisk
//
//  Created by 佳璇 李 on 12-2-29.
//  Copyright (c) 2012年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASToolBarEdit : NSObject{
    UIViewController *viewController;
    
    UIBarButtonItem *deleteItem;
    UIBarButtonItem *copyItem;
    UIBarButtonItem *moveItem;
    UIBarButtonItem *zipItem;
    UIBarButtonItem *emailItem;
    UIBarButtonItem *shareItem;
    
    UIButton *deleteButton;
    UIButton *copyButton;
    UIButton *moveButton;
    UIButton *zipButton;
    UIButton *emailButton;
    UIButton *shareButton;
    
    UIImageView *deleteimage;
    UIImageView *copyimage;
    UIImageView *moveimage;
    UIImageView *zipimage;
    UIImageView *emailimage;
    UIImageView *shareimage;
}

- (id) initWithViewController:(UIViewController *) aViewController;
- (void) dealloc;
-(void)showToolBar;
-(void)showVirtualToolBar;
-(void)showEntryToolBar;

@end

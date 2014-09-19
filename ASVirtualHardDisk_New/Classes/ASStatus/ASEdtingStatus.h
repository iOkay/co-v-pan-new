//
//  ASEdtingStatus.h
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-23.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASStatus.h"
#import "ASToolBarEdit.h"

@class ASFileListViewController;

@interface ASEdtingStatus : NSObject <ASStatus>
{
    ASFileListViewController *viewController;    
    
//    UIBarButtonItem *deleteItem;
//    UIBarButtonItem *copyItem;
//    UIBarButtonItem *moveItem;
//    UIBarButtonItem *zipItem;
//    UIBarButtonItem *emailItem;
//    
//    UIButton *deleteButton;
//    UIButton *copyButton;
//    UIButton *moveButton;
//    UIButton *zipButton;
//    UIButton *emailButton;
//    
//    UIImageView *deleteimage;
//    UIImageView *copyimage;
//    UIImageView *moveimage;
//    UIImageView *zipimage;
//    UIImageView *emailimage;
    
    ASToolBarEdit *toolbar;
}

- (id) initWithViewController:(ASFileListViewController *)aViewController;

- (void) dealloc;

@end

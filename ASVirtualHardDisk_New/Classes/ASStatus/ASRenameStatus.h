//
//  ASRenameStatus.h
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-24.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASStatus.h"

@class ASFileListViewController;

@interface ASRenameStatus : NSObject <ASStatus>
{
    ASFileListViewController *viewController;
}

- (id) initWithViewController:(ASFileListViewController *) aViewController;

- (void) dealloc;

@end

//
//  ASNormalWithMenuStatus.h
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-10-23.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASStatus.h"

@class ASFileListViewController;

@interface ASNormalWithMenuStatus : NSObject <ASStatus>
{
    ASFileListViewController *viewController;

}

- (id)initWithViewController:(ASFileListViewController *)aViewController;

@end

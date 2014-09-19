//
//  ASVirtualHardDiskAppDelegate.h
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-8-3.
//  Copyright 2011  hebeishida. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ASRootViewController;

@interface ASVirtualHardDiskAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end


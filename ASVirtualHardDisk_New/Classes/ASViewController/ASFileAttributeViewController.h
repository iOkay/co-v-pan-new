//
//  ASFileAttributeViewController.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-7.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDataObject.h"

@interface ASFileAttributeViewController : UITableViewController 
{
@private
    id<ASDataObject> currentItem;
}

@property (nonatomic, retain) id<ASDataObject> currentItem;

@end

//
//  ASPreferencesViewController.h
//  ASVirtualHardDisk
//
//  Created by dhc on 11-12-8.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ASPreferencesViewController : UIViewController
    <UITableViewDelegate, UITableViewDataSource,
    UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    NSString *totalSpace;
    NSString *freeSpace;
    IBOutlet UITableView *preferencesTableView;
    
    UIGestureRecognizer *singleTap;
    UITextField *nickNameLabel;
}

@property (nonatomic, retain) UITableView* preferencesTableView;
@property (nonatomic, retain) NSString* totalSpace;
@property (nonatomic, retain) NSString* freeSpace;

@end

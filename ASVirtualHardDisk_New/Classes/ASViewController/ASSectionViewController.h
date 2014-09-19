//
//  ASSectionViewController.h
//  ASVirtualHardDisk
//
//  Created by 刘 殿章 on 11-11-29.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ASSectionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	NSDictionary * listData;
    NSArray * keys;
    IBOutlet UITableView *helpTableView;
}
@property (nonatomic,retain) NSDictionary * listData;
@property (nonatomic,retain) NSArray * keys;
@property (nonatomic,retain) UITableView* helpTableView;

@end

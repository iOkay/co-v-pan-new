//
//  ASTableViewCell.h
//  NSWebView
//
//  Created by xiu on 11-10-25.
//  Copyright 2011年 __AlphaStudio__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ASWebTableViewCell : UITableViewCell {
    @private
    IBOutlet UILabel* littleTitle;
    IBOutlet UITextField* bigTitle;
}

@property (nonatomic,retain)UILabel* littleTitle;
@property (nonatomic,retain)UITextField* bigTitle;

@end

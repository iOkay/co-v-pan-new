//
//  ASEmbedReaderViewController.h
//  ASVirtualHardDisk
//
//  Created by 刘 殿章 on 11-11-25.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "ZBarCameraSimulator.h"
#import "ZBarReaderView.h"
@interface ASEmbedReaderViewController: UIViewController
    < ZBarReaderViewDelegate >
{
    ZBarReaderView *readerView;
    UILabel *resultText;
    ZBarCameraSimulator *cameraSim;
}

@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;
@property (nonatomic, retain) IBOutlet UILabel *resultText;
- (IBAction)gotoTheAddress:(id)sender;
@end


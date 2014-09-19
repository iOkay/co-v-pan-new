//
//  ASScanViewController.h
//  ASVirtualHardDisk
//
//  Created by xieyajie on 11-12-7.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASMenuDelegate.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"
#import "ASDataObject.h"
#import "ASDataObject.h"

#define kTAGOFMAIL 2
#define KTAGOFDELETEALERT    3

@class ASDeclare;
@class ASMenu;
@class ASStatusManager;
@class ASReaderViewController;
@interface ASScanViewController : UIViewController 
<ASMenuDelegate,MFMailComposeViewControllerDelegate, 
UIAlertViewDelegate, MBProgressHUDDelegate,
UIGestureRecognizerDelegate,
UIDocumentInteractionControllerDelegate,UIPrintInteractionControllerDelegate> 
{
    ASReaderViewController * readViewController;
    ASMenu *scanMenu;
    
//    UIToolbar *scanbar;
    UIBarButtonItem *operate;    
    BOOL isAppear;
//    BOOL isNextLevel;
    //current directory
    id<ASDataObject> currentDirectory;
    
    ASDeclare *declare;
    
    //waiting
    MBProgressHUD *HUD;

    UIDocumentInteractionController *docController;
    
    NSData *myPDFData;
}

@property (nonatomic, retain) ASMenu *scanMenu ;
//@property (nonatomic, retain) UIToolbar *scanbar;
@property (nonatomic, retain) UIBarButtonItem *operate;
@property (nonatomic, assign) BOOL isAppear;
//@property (nonatomic, assign) BOOL isNextLevel;
@property (nonatomic, retain) UIDocumentInteractionController* docController;

@property (nonatomic, retain) NSData *myPDFData;
@property (nonatomic, retain) ASReaderViewController * readViewController;

- (void) deleteFile;
- (void) emailFiles;
- (void) email;
-(IBAction) operatePressed: (id)sender;

@end

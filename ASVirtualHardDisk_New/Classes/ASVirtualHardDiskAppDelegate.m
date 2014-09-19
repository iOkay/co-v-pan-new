//
//  ASVirtualHardDiskAppDelegate.m
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-8-3.
//  Modify by dhc on 11-12-07
//  Copyright 2011  hebeishida. All rights reserved.
//
#import "ASVirtualHardDiskAppDelegate.h"
#import "ASFileStrategyManager.h"
#import "ASFileStrategy.h"
#import "ASDirectoryEx.h"
#import "ASFileType.h"
#import "ASFileEx.h"
#import "ASReaderViewController.h"
#import "ASPictureViewController.h"
#import "ASMainViewController.h"
#import "ASServerInfo.h"
#import "ASSortMenuModel.h"
#import "ASBluetoothViewController.h"

#define kDefaultDirectoryPlist @"defaultDirectoryList"
#define kDefaultDirectoryPlistType @"plist"
#define kHowToUseFileName @"ReadMe.pdf"

@implementation ASVirtualHardDiskAppDelegate

@synthesize window;
@synthesize navigationController;
//@synthesize viewController;


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (url != nil && [url isFileURL])
    {
        NSMutableString *tempPath = [[NSMutableString alloc] 
                                 initWithString:NSHomeDirectory()];
        [tempPath appendString: @"/Documents/"];
        NSMutableString *inboxPath = [NSMutableString stringWithString: tempPath];
        [inboxPath appendString: @"/Inbox/"];
        [tempPath appendString: [[url path] lastPathComponent]];
        NSMutableString *noUTF8path = [NSMutableString stringWithString: tempPath];
        
        
        int n = 1;
        while ([[NSFileManager defaultManager] fileExistsAtPath: noUTF8path])
        {
            noUTF8path = [NSMutableString stringWithString: tempPath];
            NSString *extension = [noUTF8path pathExtension];
            NSString *newExtension = [NSString stringWithFormat: @"%i.%@", n, extension];
            [noUTF8path replaceOccurrencesOfString: @"."
                                        withString: @" "
                                           options: NSBackwardsSearch
                                             range: NSMakeRange(0, [noUTF8path length])];
            [noUTF8path replaceOccurrencesOfString: extension
                                        withString: newExtension
                                           options: NSBackwardsSearch
                                             range: NSMakeRange(0, [noUTF8path length])];
            ++n;
        }
        [tempPath release];
        NSString *path = [[noUTF8path stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding] retain];
        [[NSFileManager defaultManager] copyItemAtPath: [url path]
                                                toPath: path
                                                 error: nil];
        
        [[NSFileManager defaultManager] removeItemAtPath: [url path] error: nil];
        [[NSFileManager defaultManager] removeItemAtPath: inboxPath error: nil];
        ASFileEx *file = [[ASFileEx alloc] initWithFullPath: path];
        [path release];
        
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"FileTypeList.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"FileTypeList" ofType:@"plist"];
        }
        
        
        NSDictionary *temp=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
        if (!temp) {
            [temp release];
            [file release];
            return NO;
        }
        NSDictionary* dict=[temp objectForKey:@"TypeList"];
        
        if(nil == [dict objectForKey: [[url path] pathExtension]])
        {
            [temp release];
            [file release];
            return NO;
        }
        else
        {
            NSInteger fileType = [[dict objectForKey: [[url path] pathExtension]] intValue];
            
            id<ASFileStrategy> strategy = 
            [[[ASFileStrategyManager sharedASFileStrategyManager] strategis] 
             objectForKey:[NSNumber numberWithInt: fileType]];
            
            [strategy execOnState: 0 
                 inViewController: self.navigationController.topViewController
                   withDataObject: file];
        }
        [temp release];
        [file release];
        
        return YES;
    }
    
    return NO;
}


#pragma mark -
#pragma mark Application lifecycle

- (void) configServerInfo
{
    ASServerInfo *serverInfo = [ASServerInfo sharedASServerInfo];
    
    if(YES == serverInfo.isServerStart)
    {
        [serverInfo startFtpServer];
        [serverInfo startWebServer];
    }
    
    //bluetooth
    [ASBluetoothViewController sharedManager];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {   
    
    // Override point for customization after application launch.
    [self.window addSubview:navigationController.view];
    
    [(ASMainViewController*)navigationController.topViewController switchToNext];

    [self.window makeKeyAndVisible];
    
//    [self configServerInfoFile];
    
    [self configServerInfo];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey: @"hasStartedBefore"])
    {
        NSString *directoryPath = 
            [[NSBundle mainBundle] pathForResource: kDefaultDirectoryPlist 
                                            ofType: kDefaultDirectoryPlistType];
        NSDictionary *directoryDict = 
            [NSDictionary dictionaryWithContentsOfFile: directoryPath];
        NSArray *directoryArray = [directoryDict objectForKey: @"default"];
        NSMutableString *path = [[NSMutableString alloc] 
                                 initWithString:NSHomeDirectory()];
        [path appendString:@"/Documents/"];
        
        for (NSString *directory in directoryArray)
        {
            NSString *directoryPath = 
                [path stringByAppendingPathComponent: directory];
            [[NSFileManager defaultManager] createDirectoryAtPath: directoryPath 
                                      withIntermediateDirectories: YES 
                                                       attributes: nil 
                                                            error: nil];
        }
        
        NSString *helpFileName = NSLocalizedString(@"howToUseFileName",nil);
        NSString *helpFilePath = 
            [[NSBundle mainBundle] pathForResource: helpFileName 
                                            ofType: nil];
        [[NSFileManager defaultManager] copyItemAtPath: helpFilePath 
            toPath: [path stringByAppendingPathComponent: kHowToUseFileName]
                                                 error: nil];
        
        [path release];
        
        [[NSUserDefaults standardUserDefaults] setBool: YES 
                                                forKey: @"hasStartedBefore"];
    }
	//set sort type
	NSArray *pathArr = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *directory = [pathArr objectAtIndex:0];
	NSString *path = [directory stringByAppendingPathComponent:@"selectedCell"];
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]) 
	{
		NSArray *array = [[NSArray alloc] initWithObjects:@"0",@"4",nil];
		[array writeToFile:path atomically:YES];
		[array release];
	}
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application 
{
	ASSortMenuModel *model = [ASSortMenuModel singletonASSortMenuModel];
	[model saveSortInfo];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ApplicationDidEnterBackground" object:nil];
    [[ASServerInfo sharedASServerInfo] recordStatusOfServer];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    [[self.navigationController topViewController] viewWillAppear: NO];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"applicationWillTerminate" object:nil];
    [[ASServerInfo sharedASServerInfo] recordStatusOfServer];
   
}

- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame
{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:NO];
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

}


- (void)dealloc {
	[navigationController release];
    [window release];
    [super dealloc];
}


@end

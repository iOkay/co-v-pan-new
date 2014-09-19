//
//  ASServerInfo.m
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-28.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import "ASServerInfo.h"
#import "FtpServer.h"
#import "ASWebServer.h"
#import "ASZipEx.h"
#import "ASLocalDefine.h"

@implementation ASServerInfo

@synthesize serverName;
@synthesize file;
@synthesize ftpServer;
@synthesize isServerStart;
@synthesize isRealImage;

static ASServerInfo *serverInfo;

- (id) init
{
    self = [super init];
    if(self)
    {
        if(NO == [self isExistConfigFile])
        {
            [self createConfigFile];
            [self serverInitial];
        }
        isRealImage = NO;
        isServerStart = YES;
    }
    
    return self;
}

//------------------------------------------------------------------------------
// - (NSString *) getThePathOfConfigFile
//------------------------------------------------------------------------------
- (NSString *) getThePathOfConfigFile
{
    return [NSString stringWithFormat:@"%@/Library/config",
            NSHomeDirectory()];
}

//------------------------------------------------------------------------------
// - (NSString *) getThePathOfWebPage
//------------------------------------------------------------------------------
- (NSString *) getThePathOfWebPage
{
    return [NSString stringWithFormat:@"%@/Library/webPage",NSHomeDirectory()];
}

//------------------------------------------------------------------------------
// - (void) dealloc
//------------------------------------------------------------------------------
- (void) dealloc
{
    [serverName release];
    
	serverInfo = nil;
    
    [super dealloc];
}

- (void) recordStatusOfServer
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSString *realImage_ = nil;
    NSString *serverStart_ = nil;
    NSString *serverName_ = nil;
    
    if(YES == self.isRealImage)
        realImage_ = @"YES";
    else
        realImage_ = @"NO";
        
    if(YES == self.isServerStart)
        serverStart_ = @"YES";
    else
    {
        serverStart_ = @"NO";
        [self stopFtpServer];
        [self stopWebServer];
    }
    
    serverName_ = self.serverName;
        
    [dict setValue:realImage_ forKey:KREALIMAGE];
    [dict setValue:serverStart_ forKey:KSERVERSART];
    [dict setValue:serverName_ forKey:KSERVERNAME];
    
    NSString *configPath = [self getThePathOfConfigFile];
    [dict writeToFile:configPath atomically:YES];
    [dict release];
}

- (BOOL) isExistConfigFile
{
    return  [[NSFileManager defaultManager] 
              fileExistsAtPath:[self getThePathOfConfigFile]];
}

- (void) createConfigFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager createFileAtPath:[self getThePathOfConfigFile]
                         contents:nil attributes:nil];
}

- (void) serverInitial
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSString *realImage_ = @"NO";
    NSString *serverStart_ = @"YES";
    NSString *serverName_ = KHome;
    
    
    [dict setValue:realImage_ forKey:KREALIMAGE];
    [dict setValue:serverStart_ forKey:KSERVERSART];
    [dict setValue:serverName_ forKey:KSERVERNAME];
    
    NSString *configPath = [self getThePathOfConfigFile];
    [dict writeToFile:configPath atomically:YES];
    [dict release];
}

//------------------------------------------------------------------------------
// - (void) initSettingFile
//------------------------------------------------------------------------------
- (void) initSettingFile
{
    NSString *configPath = [self getThePathOfConfigFile];
	NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:configPath];
    
    NSString *realImage_ = nil;
    NSString *serverStart_ = nil;
    
    realImage_ = [dict valueForKey:KREALIMAGE];
    serverStart_ = [dict valueForKey:KSERVERSART];
    
    if([realImage_ isEqualToString:@"YES"])
        isRealImage = YES;
    else
        isRealImage = NO;
    
    if([serverStart_  isEqualToString:@"YES"])
        isServerStart = YES;
    else
        isServerStart = NO;
    
    self.serverName = [dict valueForKey:KSERVERNAME];
    
    [dict release];
}

#pragma mark -
#pragma mark sharedASServerInfo

//------------------------------------------------------------------------------
// + (id) sharedASServerInfo
//------------------------------------------------------------------------------
+ (id) sharedASServerInfo
{
	if (nil == serverInfo) 
    {
		serverInfo = [[ASServerInfo alloc] init];

		[serverInfo initSettingFile];
        
	}
	
	return serverInfo;
}

#pragma mark -
#pragma mark ftp server operate
//------------------------------------------------------------------------------
// - (void) startFtpServer
//------------------------------------------------------------------------------
- (void) startFtpServer
{
	NSArray *docFolders = 
        NSSearchPathForDirectoriesInDomains (NSDocumentDirectory,
                                             NSUserDomainMask,
                                             YES ); 
//    NSString *baseDir = [docFolders lastObject];
	NSString *baseDir = [docFolders lastObject];	

	FtpServer *aServer = [[FtpServer alloc ] initWithPort:20000 
                                                  withDir:baseDir 
                                             notifyObject:self ];
	serverInfo.ftpServer = aServer;
	
	serverInfo.isServerStart = YES;
	
	[aServer release];
    aServer = nil;
}

//------------------------------------------------------------------------------
// - (void) stopFtpServer
//------------------------------------------------------------------------------
- (void) stopFtpServer
{
	[serverInfo.ftpServer stopFtpServer];
	serverInfo.ftpServer=nil;
	serverInfo.isServerStart = NO;
}

#pragma mark -
#pragma mark ftp server operate
//------------------------------------------------------------------------------
// - (void) configWebServer
//------------------------------------------------------------------------------
- (void) configWebServer
{
    BOOL isExist = NO;
    BOOL isDirectory = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableString *webPath = [[NSMutableString alloc] initWithString:[self getThePathOfWebPage]];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *webZipPath = [bundle pathForResource:@"web" ofType:@"zip"];
    
    isExist = [fileManager fileExistsAtPath:webPath isDirectory:&isDirectory];
    
    if(NO == isExist)
    {
        ASZipEx *zip = [ASZipEx sharedASZipEx];
        [zip unZipFilePath:webZipPath toPath:webPath];
    }
    
    [webPath release];
}

//------------------------------------------------------------------------------
// - (void) startWebServer
//------------------------------------------------------------------------------
- (void) startWebServer
{
    if(!webServer)
    {
        webServer = [[ASWebServer alloc] init];
    }
    if(webServer)
    {
        [self configWebServer];
        [webServer startServer];
    }
}

//------------------------------------------------------------------------------
// - (void) stopWebServer
//------------------------------------------------------------------------------
- (void) stopWebServer
{
    if(webServer)
    {
        NSLog(@"ASServerInfo stopWebServer");
        [webServer stopServer];
//        [webServer release];
    }
    
}

@end

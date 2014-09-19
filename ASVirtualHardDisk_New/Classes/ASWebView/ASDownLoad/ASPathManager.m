//
//  ASPathManager.m
//  NSWebView
//
//  Created by xiu on 11-11-11.
//  Copyright 2011年 __AlphaStudio__. All rights reserved.
//

#import "ASPathManager.h"
#import "FileNameDefine.h"
#import "ASDirectoryEx.h"
#import "ASDataObject.h"
#import "ASDataObjectManager.h"


@implementation ASPathManager

static ASPathManager* _manager;


//------------------------------------------------------------------------
//------------------------------------------------------------------------
+(id)single
{
    if (_manager == nil) {
        _manager = [[ASPathManager alloc]init];
    }
    return _manager;
}




//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(id)init
{
    self = [super init];
    if (self) {
        NSMutableDictionary* fileAttributes = [[NSMutableDictionary alloc]init];
        [fileAttributes setObject:[NSDate date] forKey:NSFileCreationDate];

        BOOL is = YES;
        if (![[NSFileManager defaultManager]fileExistsAtPath:[self configPath] 
                                                 isDirectory:&is]) 
        {
            NSMutableDictionary* fileAttributes = [[NSMutableDictionary alloc]init];
            [fileAttributes setObject:[NSDate date] forKey:NSFileCreationDate];
            [[NSFileManager defaultManager]createDirectoryAtPath:[self configPath] withIntermediateDirectories:YES attributes:fileAttributes error:nil];
            [fileAttributes release];
        }
        
        if (![[NSFileManager defaultManager]fileExistsAtPath:[self webDocumentPath] isDirectory:&is]) 
        {
            NSMutableDictionary* fileAttributes = [[NSMutableDictionary alloc]init];
            [fileAttributes setObject:[NSDate date] forKey:NSFileCreationDate];
            [[NSFileManager defaultManager]createDirectoryAtPath:[self webDocumentPath] withIntermediateDirectories:YES attributes:fileAttributes error:nil];
            [fileAttributes release];
        }
        [fileAttributes release];
    }
    return self;
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)dealloc
{
    [super dealloc];
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(NSString*)configPath
{
    NSString* path = [[self applicationDocumentPath]stringByAppendingPathComponent:KDOWNLOADCONFIGFILENAME];
    return  path;
    
    
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------s
-(NSString*)webDocumentPath
{
    NSString* path = [[self documentPath]stringByAppendingPathComponent:KDOWNLOADFILENAME];
    return  path;
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(NSString*)applicationDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
    
}

-(NSString*)documentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

@end

//
//  ASDownLoadList.m
//  ASVirtualHardDisk
//
//  Created by xiu on 11-11-15.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASDownLoadList.h"
#import "ASPathManager.h"
#import "ASDownLoadInfo.h"
#import "ASDownLoadStatueDefine.h"
#import "ASIHTTPRequest.h"
#import "ASDataObjectManager.h"
#import "ASDataObject.h"
#import "ASFileEx.h"
#import "ASDirectoryEx.h"
#import "ASNewFileName.h"



#define KDOWNLISTFILENAME @"downList"

@interface ASDownLoadList(hidden)

-(void)readFromFile;
-(void)writeToFile;
-(NSString*)getFileNameWithFileName:(NSString*)fileName andPath:(NSString*)path;
-(void)applicationBackground;
@end




@implementation ASDownLoadList
@synthesize downLoadInfoList,delegate;

static ASDownLoadList* singel;

+(id)singel
{
    if (singel == nil) {
        singel = [[ASDownLoadList alloc]init];
    }
    return singel;
}


#pragma mark -
#pragma mark life 
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(id)init
{
    self = [super init];
    if (self) {
        [self readFromFile];
        if ([downLoadInfoList count] != 0)
        {
            for (ASDownLoadInfo* info in downLoadInfoList) 
            {
                info.delegate = self;
                if(info.statue == KDOWNLOADDOWN)
                {
                    info.statue = KDOWNLOADSTOP;
                    NSLog(@"%d",info.statue);
                }
            }
        }
        queue = [[NSOperationQueue alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationBackground) name:@"applicationWillTerminate" object:nil];
    }
    return self;
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(void)dealloc
{
    [self writeToFile];
    [queue cancelAllOperations];
    [queue release];
    [downLoadInfoList release];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [super dealloc];
}


#pragma mark - 
#pragma mark hidden function
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(void)readFromFile
{
    NSString* filePath = [[[ASPathManager single]configPath] stringByAppendingPathComponent:KDOWNLISTFILENAME];;
    if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) 
    {
        //        [self.downLoadInfoList initWithContentsOfFile:filePath];
        NSMutableData* data = [[NSMutableData alloc]initWithContentsOfFile:filePath];
        NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        downLoadInfoList = [[unarchiver decodeObjectForKey:@"downLoadList"]mutableCopy];
        [unarchiver finishDecoding];
        [unarchiver release];
        [data release];
        
    }
    else
    {
        downLoadInfoList = [[NSMutableArray alloc]init];
    }
    
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(void)writeToFile
{
    NSString* path = [[[ASPathManager single]configPath] stringByAppendingPathComponent:KDOWNLISTFILENAME];
    
    //    [downLoadInfoList writeToFile:path atomically:YES];
    NSMutableData* data = [[NSMutableData alloc]init];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:downLoadInfoList forKey:@"downLoadList"];
    [archiver finishEncoding];
    BOOL success = [data writeToFile:path atomically:YES];
    if (!success) {
        NSLog(@"error");
    }
    [archiver release];
    [data release];
}


#pragma mark -
#pragma mark DownLoadInfoDelegat
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(void)downLoad:(ASDownLoadInfo*)info statueChange:(NSUInteger)statue
{
    NSUInteger index = [downLoadInfoList indexOfObject:info];
    if(delegate != nil)
    {
        [delegate downLoadList:self statueChange:statue atIndex:index];
    }
}


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(void)downLoad:(ASDownLoadInfo*)info progessChange:(float)progress
{
    NSUInteger index = [downLoadInfoList indexOfObject:info];
    if (delegate != nil) {
        [delegate downLoadList:self progrerssChange:progress atIndex:index];
    }
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(void)download:(ASDownLoadInfo *)info fileSize:(NSInteger)size
{
    NSUInteger index = [downLoadInfoList indexOfObject:info];
    if (delegate != nil) {
        [delegate downLoadList:self fileSize: size atIndex: index];
    }
}

#pragma mark -
#pragma mark work with downLoadinfo
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(BOOL)stopRequestAtIndex:(NSUInteger)index
{
    if (index >= [downLoadInfoList count])
    {
        return  false;
    }
    ASDownLoadInfo* info = [downLoadInfoList objectAtIndex:index];
    [info.request cancel];
    return YES;
}


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(BOOL)cancelRequestAtIndex:(NSUInteger)index
{
    if (index >= [downLoadInfoList count]) 
    {
        return  false;
    }
    
    
    
    ASDownLoadInfo* info = [downLoadInfoList objectAtIndex:index];
    [info.request cancel];
    info.statue = KDOWNLOADCACEL;
    [info cleanTemp];
    return YES;
}


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(BOOL)reloadRequestAtIndex:(NSUInteger)index
{
    if (index >= [downLoadInfoList count]) 
    {
        return  false;
    }
    ASDownLoadInfo* info = [downLoadInfoList objectAtIndex:index];
    NSString* newFileName = [self getFileNameWithFileName:info.name andPath:[[ASPathManager single]webDocumentPath]];
    info.name = newFileName;
    [info initFilePathWithName:newFileName];
    
    [info createRequest];
    [queue addOperation:info.request];
    
    return YES;
}


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(BOOL)cantinueRequestAtindex:(NSUInteger)index
{
    if (index >= [downLoadInfoList count])
    {
        return  false;
    }
    ASDownLoadInfo* info = [downLoadInfoList objectAtIndex:index];
    [info createRequest];
    [queue addOperation:info.request];
    return YES;
    
}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(NSArray*)cleanDownLoad
{
    NSUInteger row = [downLoadInfoList count];
    NSMutableArray* arrayCellPath = [[[NSMutableArray alloc]init]autorelease];
    NSMutableArray* arrayInfo = [[NSMutableArray alloc]init];
    for (NSUInteger i = 0; i < row; i++) 
    {
        ASDownLoadInfo* info = [downLoadInfoList objectAtIndex:i];
        if (info.statue == KDOWNLOADCACEL || info.statue == KDOWNLOADCOMPLETE ) 
        {
            NSIndexPath* path = [NSIndexPath indexPathForRow:i inSection:0];
            [arrayCellPath addObject:path];   
            [arrayInfo addObject:info];
        }
    }
    
    [downLoadInfoList removeObjectsInArray:arrayInfo];
    [arrayInfo release];
    return arrayCellPath;
}


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(NSUInteger)addDownLoad:(NSString*)urlString
{
    //判断文件是否存在
    NSString* fileName = [urlString lastPathComponent];
    NSString* newFileName = [self getFileNameWithFileName:fileName andPath:[[ASPathManager single]webDocumentPath]];
    ASDownLoadInfo* info = [[ASDownLoadInfo alloc]initWithName:newFileName];
    info.delegate = self;
    info.urlString = urlString;
    info.statue = KDOWNLOADSTOP;
    [info createRequest];
    
    [downLoadInfoList addObject:info];
    [queue addOperation:info.request];
    
    
    
    NSUInteger index = [downLoadInfoList indexOfObject:info];
   
    [info release];
    return  index;
}


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(NSString*)getFileNameWithFileName:(NSString*)fileName andPath:(NSString*)path
{
    //判断文件是否存在
    NSString* filePath = [path stringByAppendingPathComponent:fileName];
    NSString* test = [[fileName copy]autorelease];
    NSInteger i = 0;
    BOOL pathTest = NO;
    while ([[NSFileManager defaultManager]fileExistsAtPath:filePath] || pathTest) {
        
        pathTest = NO;
        
        test = [[NSString stringWithFormat:@"%d",i]stringByAppendingString:fileName];
        
        filePath = [path stringByAppendingPathComponent:test];
        NSString* tempFilePath = [filePath stringByAppendingString:@".down"];
        
        //判断缓存路径是否存在
        for (ASDownLoadInfo* info in downLoadInfoList) {
            
            if([tempFilePath isEqualToString:info.tempFilePath])
            {
                pathTest = YES;
                break;
            }
        }
        
        
        i++;
    }
    
    
    
    
    return test;

}

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
-(void)applicationBackground
{
    [self writeToFile];
    [queue cancelAllOperations];
}



@end

//
//  ASDownLoadInfo.m
//  NSWebView
//
//  Created by xiu on 11-11-9.
//  Copyright 2011年 __AlphaStudio__. All rights reserved.
//

#import "ASDownLoadInfo.h"
#import "ASIHTTPRequest.h"
#import "ASDownLoadStatueDefine.h"
#import "ASPathManager.h"

@interface ASDownLoadInfo (hidden) 

@end


@implementation ASDownLoadInfo
@synthesize filePath,request,urlString,delegate;
@dynamic progress,statue;
@synthesize name;
@synthesize tempFilePath;
@synthesize fileSize;



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(id)init
{
    self = [super init];
    if (self) {
    }
    return  self;
}




//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)dealloc
{
    [name release];
    [filePath release];
    [tempFilePath release];
    [request release];
    [super dealloc];
}




//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(id)initWithName:(NSString *)aName
{
    self = [super init];
    if (self) {
        
        filePath = [[NSString alloc]initWithString:[[[ASPathManager single]webDocumentPath]stringByAppendingPathComponent:aName]];
        tempFilePath = [[NSString alloc]initWithString:[[[ASPathManager single]webDocumentPath] stringByAppendingPathComponent:[aName stringByAppendingString:@".down"]]];
        name = [[NSString alloc]initWithString:aName];
    }
    return self;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)initFilePathWithName:(NSString*)aName
{
    filePath = [[NSString alloc]initWithString:[[[ASPathManager single]webDocumentPath]stringByAppendingPathComponent:aName]];
    tempFilePath = [[NSString alloc]initWithString:[[[ASPathManager single]webDocumentPath] stringByAppendingPathComponent:[aName stringByAppendingString:@".down"]]];
    name = [[NSString alloc]initWithString:aName];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self.urlString = [aDecoder decodeObjectForKey:@"urlString"];
    self.filePath = [aDecoder decodeObjectForKey:@"filePath"];
    self.tempFilePath = [aDecoder decodeObjectForKey:@"tempFilePath"];
    self.statue = [aDecoder decodeIntegerForKey:@"statue"];
    self.progress = [aDecoder decodeFloatForKey:@"progress"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.fileSize = [aDecoder decodeIntegerForKey:@"fileSize"];
    
    return self;
}




//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.urlString forKey:@"urlString"];
    [aCoder encodeObject:self.filePath forKey:@"filePath"];
    [aCoder encodeObject:self.tempFilePath forKey:@"tempFilePath"];
    [aCoder encodeInteger:self.statue forKey:@"statue"];
    [aCoder encodeFloat:self.progress forKey:@"progress"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.fileSize forKey:@"fileSize"];
}





//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(id)copyWithZone:(NSZone *)zone
{
    ASDownLoadInfo* result = [ASDownLoadInfo allocWithZone:zone];
    result.filePath = self.filePath;
    result.tempFilePath = self.tempFilePath;
    result.statue = self.statue;
    result.progress = self.progress;
    result.request = self.request;
    return  result;
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(Boolean)createRequest
{
    if (self.urlString == nil)
        return  NO;
    NSURL* url = [[NSURL alloc]initWithString:self.urlString];
    request = [[ASIHTTPRequest alloc]initWithURL:url];
    request.temporaryFileDownloadPath = self.tempFilePath;
    request.downloadDestinationPath = self.filePath;
    request.delegate = self;
    request.downloadProgressDelegate = self;
    request.shouldRedirect = YES;
    [request setAllowResumeForFileDownloads:YES];
    [url release];
    return  YES;
    
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(NSUInteger)statue
{
    return  statue;
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)setStatue:(NSUInteger)aStatue
{
    if (statue == KDOWNLOADCACEL && aStatue == KDOWNLOADSTOP) {
        return;
    }
    if (statue == aStatue) {
        return;
    }
    statue = aStatue;
    if (delegate != nil) {
        [delegate downLoad:self statueChange:statue];
    }
}



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(float)progress
{
    return progress;
}

#pragma mark -
#pragma mark ASIProgressDelegate



//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)setProgress:(float)aProgress
{
    progress = aProgress;
    NSLog(@"%f",aProgress);
    if (delegate != nil) {
        [delegate downLoad:self progessChange:aProgress];
    }
    
}



#pragma mark -
#pragma mark ASIHTTPRequestDelegate

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)requestStarted:(ASIHTTPRequest *)aRequest
{
    self.statue = KDOWNLOADDOWN;
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)request:(ASIHTTPRequest *)aRequest 
    didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
	NSString *length = [responseHeaders objectForKey:@"Content-Length"];
	NSInteger size = [length integerValue];
    self.fileSize = size;
    [delegate download: self fileSize: size];
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)requestFailed:(ASIHTTPRequest *)aRequest
{
    NSError* error = aRequest.error;
    if (error.code == 4 ) {
        self.statue = KDOWNLOADSTOP;
    }
    else
    {
        self.statue = KDOWNLOADCACEL;
    }
    
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)requestFinished:(ASIHTTPRequest *)request
{
    self.statue = KDOWNLOADCOMPLETE;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL
{
    NSLog(@"%@",[newURL absoluteURL]);
}

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)cleanTemp
{
    if ([[NSFileManager defaultManager]fileExistsAtPath:self.tempFilePath]) {
        [[NSFileManager defaultManager]removeItemAtPath:self.tempFilePath error:nil];
    }
    self.tempFilePath = nil;
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:self.filePath]) {
        
        [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
    }
    self.filePath = nil;
}




@end

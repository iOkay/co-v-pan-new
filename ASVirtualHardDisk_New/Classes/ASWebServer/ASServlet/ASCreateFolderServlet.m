//------------------------------------------------------------------------------
//  Filename:          CreateFolderServlet.m
//  Project:           MongooseWrapper
//  Author:             Okay
//  Date:              11-11-10 : last edited by  Okay
//  Version:           1.0
//  Copyright:         2011年 __MyCompanyName__. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).

#import "ASCreateFolderServlet.h"
#import "ASDataObjectManager.h"
#import "ASDirectoryEx.h"
#import "ASDataObject.h"
#import "ASLocalDefine.h"

@implementation ASCreateFolderServlet


- (ServletResponse *)doGet:(ServletRequest *)request {
    
    [self performSelectorOnMainThread:@selector(logPath:) withObject:request.path waitUntilDone:NO];
    
    NSDictionary *params = request.parameters;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *directory = [[params valueForKey:@"path"] 
                           stringByReplacingPercentEscapesUsingEncoding:enc];
    NSString *fileName = [[params valueForKey:@"name"]
                          stringByReplacingPercentEscapesUsingEncoding:enc];
    
    ASDataObjectManager *dataManager = [ASDataObjectManager sharedDataManager];
    
    ASDirectoryEx *currentDirectory = [[ASDirectoryEx alloc] initWithFullPath:directory];
    
    ASDirectoryEx *dir = 
        [dataManager getDirectoryObject:fileName And:currentDirectory];
    
    BOOL isExist = [dataManager isItemExist:dir];
    int result = 0;
    if(NO == isExist)
    {
        result = [currentDirectory addNewItem:dir];
    }
    
    ServletResponse *resp = [[[ServletResponse alloc] init] autorelease];
    resp.statusCode = @"200 OK";
    if(1 == result)
    {
        resp.bodyString = [NSString stringWithString:@"{\"status\":\"ok\",\"message\":\"Folder created successfully.\"}"];
    }
    else if(0 == result && YES == isExist)
    {
        resp.bodyString = [NSString stringWithString:@"{\"status\":\"failed\",\"message\":\"Folder already existed.\"}"];
    }
    else
    {
        resp.bodyString = [NSString stringWithString:@"{\"status\":\"failed\",\"message\":\"Folder created failed.\"}"];
    }
    [resp addHeader:@"Content-Type" withValue:@"text/plain"];
    [currentDirectory release];
    return resp;
}

- (ServletResponse *)doPost:(ServletRequest *)request {
    return [self doGet:request];
}

- (void)logPath:(NSString *)path {
    NSLog(@"ASCreateFolderServlet");
}


@end

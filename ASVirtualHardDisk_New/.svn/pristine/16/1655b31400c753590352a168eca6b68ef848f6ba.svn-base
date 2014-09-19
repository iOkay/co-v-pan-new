//
//  UploadServlet.m
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/13/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import "ASUploadServlet.h"
#import "ASLocalDefine.h"

@implementation ASUploadServlet

const char *findNewLine(const char *str)
{
    if (str == NULL)
    {
        return NULL;
    }
    
    while (*str != '\0' && *str != '\r')
    {
        if (*(str+1) == '\n') 
        {
            break;
        }
        str++;
    }
    
    return str;
}

- (ServletResponse *)doPost:(ServletRequest *)request {
    
    [self performSelectorOnMainThread:@selector(logPath:) withObject:request.path waitUntilDone:NO];
    
    // WARNING: This is not a particularly robust implementation of the multipart
    // form data standard. It should work only for cases where there is a single
    // file element in the request.
    
    NSDictionary *params = request.parameters;
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *directory = [[params valueForKey:@"filePath"] 
                           stringByReplacingPercentEscapesUsingEncoding:enc];
        
    NSString *contentType = [request.headers valueForKey:@"Content-Type"];
//    NSArray *comps = [contentType componentsSeparatedByString:@";"];
    
    if ([contentType rangeOfString:@"multipart/form-data"].location == NSNotFound) {
        return [self sendInternalError];
    }
    
//    NSArray *bounds = [[comps objectAtIndex:1] componentsSeparatedByString:@"="];
//    NSString *boundary = [bounds objectAtIndex:1];
    
    //get file name
    const char *beginPostData = [request.body bytes];
    const char *upfilePostdata = beginPostData;
    const char *tmpPostData = beginPostData;
    int postDataLength = [request.body length];
    
    upfilePostdata = findNewLine(upfilePostdata);
    
    for(int i = 0; i < 3; i++)
    {
        upfilePostdata += 2;
        tmpPostData = upfilePostdata; 
        
        upfilePostdata = findNewLine(upfilePostdata);
    }
    
    int fileNameLength = upfilePostdata - tmpPostData;
    
    char *fileName_ = (char*)malloc(fileNameLength + 1);
    memcpy(fileName_, tmpPostData, fileNameLength);
    fileName_[fileNameLength] = '\0';
    NSString *fileNameStr = [NSString stringWithCString:fileName_ encoding:enc];
    NSLog(@"%s -- %@",__func__,fileNameStr);
    free(fileName_);
    
    // Reads the actual data
    for(int j = 0; j < 4; j++)
    {
        upfilePostdata += 2;
        upfilePostdata = findNewLine(upfilePostdata);
    }
    
    upfilePostdata += 2;
    
    int endFixLength = 153;
    int startFixLength = upfilePostdata - beginPostData;
    
    NSData *actualData = [[NSData alloc] 
                          initWithBytes:upfilePostdata 
                          length:(postDataLength - startFixLength - endFixLength)];
    
    
    // Saves the file to the documents folder
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSMutableString *filePath = [[NSMutableString alloc] initWithString:documentsDirectory];
    [filePath appendString:@"/"];
    [filePath appendString:directory];
    [filePath appendString:fileNameStr];
    
//    NSString *file = [documentsDirectory stringByAppendingPathComponent:fileNameStr];
    NSLog(@"UPLOAD TO PATH %@",filePath);
    [actualData writeToFile:filePath atomically:YES];
    [actualData release];
    actualData = nil;
    [filePath release];
    filePath = nil;
    
    ServletResponse *resp = [[[ServletResponse alloc] init] autorelease];
    resp.statusCode = @"200 OK";
    resp.bodyString = [NSString stringWithFormat:@"%@ upload successfully.", fileNameStr];
    [resp addHeader:@"Content-Type" withValue:@"text/plain"];
    
    return resp;
}

- (void)logPath:(NSString *)path {
    NSLog(@"ASUploadServlet");
}

@end

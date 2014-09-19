//------------------------------------------------------------------------------
//  Filename:          ASIconContain.m
//  Project:           ASVirtualHardDisk
//  Author:            Okay
//  Date:              11-12-30 : last edited by Okay
//  Version:           1.0
//  Copyright:         2011年 AlphaStudio. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).

#import "ASIconContain.h"

@interface ASIconContain ()

@property (nonatomic, retain) NSDictionary *dictplist;

@end

@implementation ASIconContain

@synthesize fileTypeList;
@synthesize dateFormatter;
@synthesize dictplist;

static ASIconContain *iconContain;

+ (id)sharedIconContain
{
    if(!iconContain) {
        iconContain = [[ASIconContain alloc] init];
    }
    return iconContain;
}

- (NSString *)getCustom:(NSString *)aSuffix
{
    return [dictplist valueForKey:aSuffix];
}

- (id)init
{
    self = [super init];
    if(self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"customicon" ofType:@"plist"];
        dictplist = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"FileTypeList.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"FileTypeList" ofType:@"plist"];
        }
        
        NSDictionary *temp=[[NSDictionary alloc] initWithContentsOfFile:plistPath];
        fileTypeList = [[temp objectForKey:@"TypeList"] copy];
        
        dateFormatter = [[NSDateFormatter alloc] init]; 
        [dateFormatter setDateFormat:@"yyyy/MM/dd"];
        
        [temp release];
    }
    
    return self;
}

- (void) dealloc
{
    [dictplist release];
    [fileTypeList release];
    [dateFormatter release];
    iconContain = nil;
    [super dealloc];
}

@end

//
//  ASWebViewModel.m
//  NSWebView
//
//  Created by xiu on 11-10-24.
//  Copyright 2011年 __AlphaStudio__. All rights reserved.
//

#import "ASWebViewModel.h"
#import "ASPathManager.h"

@interface ASWebViewModel(hidden)
-(NSString *)dataFilePath;
@end


@implementation ASWebViewModel
@synthesize bookmarkList;
 NSString* KconfigPath = @"webViewConfig";

static ASWebViewModel* single;

//------------------------------------------------------------------------
//------------------------------------------------------------------------
+(id)single
{
    if (single == nil) {
        single = [[ASWebViewModel alloc]init];
    }
    return single;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(id)init
{
    self = [super init];
    if (nil != self) {
        
        [self readFromFile];
    }
    return  self;
    
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)dealloc
{
    [bookmarkList release];
    [super dealloc];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)readFromFile
{
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self dataFilePath]]) 
    {
        NSMutableData* data = [[NSMutableData alloc]initWithContentsOfFile:[self dataFilePath]];
        NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        
        bookmarkList = [[NSMutableArray alloc]initWithArray:[unarchiver decodeObjectForKey:@"bookmarkList"]];
        [unarchiver finishDecoding];
        [unarchiver release];
        [data release];
    }
    else
    {
        bookmarkList = [[NSMutableArray alloc]init];
    }
    
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)saveToFile
{
    NSMutableData* data = [[NSMutableData alloc]init];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data
    ];
    [archiver encodeObject:bookmarkList forKey:@"bookmarkList"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    [archiver release];
    [data release];
    
}
                    
                    
//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(NSString *)dataFilePath
{
    return [[[ASPathManager single]configPath] stringByAppendingPathComponent:KconfigPath ];
    
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)addBookmark:(ASBookmark *)aBookmark
{
    [self.bookmarkList addObject:aBookmark];
}

@end

//------------------------------------------------------------------------------
// Filename:        ASNewFileName.m
// Project:         ASStrategy
// Author:          wangqiushuang
// Date:            11-10-31
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------

// Quote header files.
#import "ASNewFileName.h"
#import "ASDirectoryEx.h"

@implementation ASNewFileName
+(NSString *)nameOfNewFile:(NSString *)name toDirectory:(ASDirectoryEx *)directory
{
	//记录后缀名
	NSString *extensinoName = [name pathExtension];
	
	//记录文件名和长度
	NSString *mainName;
	if (0 == [extensinoName length]) {
		mainName = [NSString stringWithString:name];
	}
	else {
		mainName = [name substringToIndex:([name length] - [extensinoName length] -1)];
	}
	NSInteger mainNameLength = [mainName length];
	
	//生成正择表达式
	NSError *error = nil;
	NSString *regexString;
	if (0 == [extensinoName length]) {
		regexString = [NSString stringWithFormat:@"^%@[ ,0-9]*$",mainName];		
	}
	else {
		regexString = [NSString stringWithFormat:@"^%@[ ,0-9]*.%@$",mainName,extensinoName];
	}
	NSRegularExpression *regular = [[NSRegularExpression alloc] 
									initWithPattern:regexString
									options:NSRegularExpressionCaseInsensitive
									error:&error];
	
	//得到文件列表
	NSArray *fileList = [directory getFileList:NO];
	
	//计算max的值
	NSString *strFrom;
    NSString *strTo;
    int num;
    int max = 0;//已有文件的最大号
	int index = 0;//有多少个文件
	for (ASFileEx *file in fileList) {
        NSLog(@"ASFileEx--%@",[file getItemName]);
		NSUInteger numberOfMatches = 
            [regular numberOfMatchesInString: file.name 
                                     options: 0 
                                       range: NSMakeRange(0, [file.name length])];
		if (1 == numberOfMatches)
		{
			NSString *tempMainName;
			if (0 == [extensinoName length]) {
				tempMainName = [NSString stringWithString:file.name];
			}
			else {
				tempMainName = [file.name substringToIndex:([file.name length] - [extensinoName length] - 1)];
			}
			
			if ([tempMainName length] >= (mainNameLength + 3)) {
				strFrom = [tempMainName substringFromIndex:mainNameLength+1];
				strTo = [strFrom substringToIndex:[strFrom length]-1];
				num = [strTo intValue];
				if (num > max) {
					max = num;
				}
			}
			index++;
		}
	}
	
    [regular release];
    
	//生成newName
	NSString *newName;
	if (index > 0) {
		max ++;
		if (index < max) {
			index = max;
		}
		if (0 == [extensinoName length]) {
			newName = [NSString stringWithFormat:@"%@ %i",mainName,index];
		}
		else {
			newName = [NSString stringWithFormat:@"%@ %i.%@",mainName,index,extensinoName];
		}
	}
	else {
		newName = [NSString stringWithString:name];
	}
	
	return newName;
}

@end

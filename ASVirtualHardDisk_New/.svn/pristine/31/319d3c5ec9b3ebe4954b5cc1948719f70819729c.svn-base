//
//  ASDirectory.m
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-23.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import "ASDirectory.h"
#import "ASFile.h"


@implementation ASDirectory

#pragma mark -
#pragma mark Private Method
//------------------------------------------------------------------------------
// - (NSString *) hostname
//------------------------------------------------------------------------------
//- (NSString *) hostname
//{
//    char baseHostName[256]; 
//    int success = gethostname(baseHostName, 255);
//    if (success != 0) return nil;
//    baseHostName[255] = '\0';
//    
//#if !TARGET_IPHONE_SIMULATOR
//    return [NSString stringWithFormat:@"%s.local", baseHostName];
//#else
//	return [NSString stringWithFormat:@"%s", baseHostName];
//#endif
//}

#pragma mark -
#pragma mark Class Method
//------------------------------------------------------------------------------
// + (NSArray *) searchLocaleDocuments
//------------------------------------------------------------------------------
+ (NSArray *) searchLocaleDocuments
{
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	
	NSMutableString *path = [[NSMutableString alloc] 
                             initWithString:NSHomeDirectory()];
    [path appendString:@"/Documents/Local/"];
	
	NSArray *fileTmp = [fileManager contentsOfDirectoryAtPath:path error:NULL];
	
	[path release];
	[fileManager release];
	
	return fileTmp;
}

//------------------------------------------------------------------------------
// + (NSMutableArray *) searchDocuments:(NSString *)diectoryPath;
//------------------------------------------------------------------------------
+ (NSArray *) searchDocuments:(NSString *)directoryPath
{//search the documents in directoryPath
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	
    NSMutableString *path = [[NSMutableString alloc] 
                             initWithString:directoryPath];
    [path appendString:@"/"];
	
	NSArray *fileTmp =  [fileManager contentsOfDirectoryAtPath:path error:nil];
	
	[path release];
	[fileManager release];

	return fileTmp;

}

//------------------------------------------------------------------------------
// + (void) createRootDirectory
//------------------------------------------------------------------------------
+ (void) createRootDirectory
{//create the root directory
    
    //get the root path
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	
	NSArray *docFolders = NSSearchPathForDirectoriesInDomains(
                                               NSDocumentDirectory,
                                               NSUserDomainMask, 
                                               YES );
	NSString *baseDir =  [NSString stringWithFormat:@"%@/Local",
                          [docFolders lastObject]];
	
    //set directory attribute
	NSMutableDictionary *fileAttribute = [[NSMutableDictionary alloc] init];
	NSDate *createDate = [NSDate date];
	//NSString *owner = [self	hostname];
	
	[fileAttribute setObject:createDate forKey:NSFileCreationDate];
	//[fileAttribute setObject:owner forKey:NSFileOwnerAccountName];
	
	if([fileManager createDirectoryAtPath:baseDir
		   withIntermediateDirectories:YES 
							attributes:fileAttribute
									error:NULL])
    {
		NSLog(@"SS");
	}
    else
    {
		NSLog(@"FF");
    }
	
	[fileAttribute release];
	[fileManager release];
}

//------------------------------------------------------------------------------
// + (NSString *) addNewDirectory:(NSString *)directoryPath
//------------------------------------------------------------------------------
+ (NSString *) addNewDirectory:(NSString *)directoryPath
{//add new directory in the given path
	
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	NSMutableString *path = [[NSMutableString alloc] 
                             initWithString:directoryPath];
	[path appendString:@"/"];
	
	NSArray *filesTmp = [fileManager contentsOfDirectoryAtPath:path error:nil];
	
	NSMutableArray *arrayForFile = [[NSMutableArray alloc] init];
	NSString *file;
	
    //set regexString
//    NSString *regexString = @"^unnamed([1-9]+)$";
    //check how many tolerant files
//	for (int i = 0; i < [filesTmp count]; i++)
//    {
//		file = [[filesTmp objectAtIndex:i] lowercaseString];
////        if([file isMatchedByRegex:regexString] || 
////           [file isEqualToString:@"unnamed"])
////        {
////            [arrayForFile addObject:file];
////        }
//		if ([file rangeOfString:@"untitled"].length != 0)
//        {
//			[arrayForFile addObject:file];
//        }
//	}
    NSError *error = nil;
    NSString *regexString = @"^untitled([(][0-9]+[)])?$";
    NSRegularExpression *regular = [[NSRegularExpression alloc] 
                                    initWithPattern:regexString
                                    options:NSRegularExpressionCaseInsensitive
                                    error:&error];
    for(int i = 0; i < [filesTmp count]; i++)
    {
        file = [[filesTmp objectAtIndex:i] lowercaseString];
		NSUInteger numberOfMatches = [regular numberOfMatchesInString:file
															options:0
															  range:NSMakeRange(0, [file length])];
        if(numberOfMatches)
        {
            [arrayForFile addObject:file];
        }
    }
    
    [regular release];
    regular = nil;
    
	int length = [@"untitled" length];
	
	NSString *fileForNew;
	NSString *strFrom;
	NSString *strTo;
	int num;
	int max = 0;
	//name the new directory
	if([arrayForFile count] >0 )
    {
		for (int j = 0; j < [arrayForFile count]; j++) 
        {
			NSString *fileN = [arrayForFile objectAtIndex:j];
			if([fileN length] >= (length+3))
            {
				strFrom = [fileN substringFromIndex:length+1];
				strTo = [strFrom substringToIndex:[strFrom length]-1];
				num = [strTo intValue];
		
				if(num >= max)
					max = num;
			}
		}
		max++;
		fileForNew = [NSString stringWithFormat:@"Untitled(%d)",max];
	}
    else 
    {
		fileForNew = [NSString stringWithFormat:@"Untitled"];
	}

	[arrayForFile release];
	[path appendString:fileForNew];
	
    //set the diretory attribute
	NSMutableDictionary *fileAttribute = [[NSMutableDictionary alloc] init];
	NSDate *createDate = [NSDate date];
	//NSString *owner = [self	hostname];
	
	[fileAttribute setObject:createDate forKey:NSFileCreationDate];
	//[fileAttribute setObject:owner forKey:NSFileOwnerAccountName];
	
    //create the new directory
	[fileManager createDirectoryAtPath:path
           withIntermediateDirectories:YES 
				            attributes:fileAttribute
						         error:NULL];
	
    //get the new directory added directory path for return
	NSString *_path = [NSString stringWithFormat:@"%@",path];
	
	[path release];
	[fileAttribute release];
	[fileManager release];
	
	return _path;
}

//------------------------------------------------------------------------------
// + (BOOL) isDirectory:(NSString *)directoryPath
//------------------------------------------------------------------------------
+ (BOOL) isDirectory:(NSString *)directoryPath
{//judge if directory
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	BOOL isDir;
	
	[fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
	
	[fileManager release];
	return isDir;
}

//------------------------------------------------------------------------------
// + (int) contentFiles:(NSString *)directoryPath
//------------------------------------------------------------------------------
+ (int) contentFiles:(NSString *)directoryPath
{//check if contains files in the given path
	
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	NSArray *content = [fileManager contentsOfDirectoryAtPath:directoryPath 
                                                        error:nil];
	NSString *firstChar;
    int hiddenFileCounts = 0;
    for(int i = 0; i < [content count]; i++)
    {
        NSString *fileName = [content objectAtIndex:i];
        firstChar = [fileName substringToIndex:1];
        if(YES == [firstChar isEqualToString:@"."])
        {
            hiddenFileCounts ++;
        }
    }
    
	[fileManager release];
	
	return ([content count] - hiddenFileCounts);
}

//------------------------------------------------------------------------------
// + (BOOL) containDirectory:(NSString *)directoryPath
//------------------------------------------------------------------------------
+ (BOOL) containDirectory:(NSString *)directoryPath
{//check if contains directory in the given path
	BOOL isContain;
    BOOL result = NO;
	
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	NSArray *content = [fileManager contentsOfDirectoryAtPath:directoryPath 
                                                        error:nil];
	
	for(int i=0; i < [content count]; i++)
    {
		NSMutableString *path = [[NSMutableString alloc] 
                                 initWithString:directoryPath];
		[path appendString:@"/"];
		[path appendString:[content objectAtIndex:i]];
		
		[fileManager fileExistsAtPath:path isDirectory:&isContain];
        
		if (isContain == YES) 
        {
			result = YES;
		}
		[path release];
	}
    [fileManager release];
	return result;
}

//------------------------------------------------------------------------------
// + (NSMutableArray *) findFile:(NSString *)file
//------------------------------------------------------------------------------
+ (NSMutableArray *) findFile:(NSString *)afile
{//search files that whose name contains the given string
    
	NSMutableString *path = [[NSMutableString alloc] 
                             initWithString:NSHomeDirectory()];
    [path appendString:@"/Documents/Local/"];
	NSFileManager *localFileManager=[[NSFileManager alloc] init];
	NSDirectoryEnumerator *dirEnum =
    [localFileManager enumeratorAtPath:path];
    NSArray *files = [dirEnum allObjects];
	
	NSString *file;
    NSString *firstChar;
	NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    for(int i = 0; i < [files count]; i++)
    {
        file = [[files objectAtIndex:i] lowercaseString];
        
        if([file rangeOfString:@"/"].length != 0)
        {
			NSString *fileT = [[file componentsSeparatedByString:@"/"] 
                               lastObject];
			if([fileT rangeOfString:afile].length != 0)
            {
                firstChar = [fileT substringToIndex:1];
                if(![firstChar isEqualToString:@"."]) //hide the hidden file
                {
                    [array addObject:[files objectAtIndex:i]];
                }
            }
		}
        else
        {
			if([file rangeOfString:afile].length != 0)
            {
                firstChar = [file substringToIndex:1];
                if(![firstChar isEqualToString:@"."]) //hide the hidden file
                {
                    [array addObject:[files objectAtIndex:i]];
                }
            }
		}

        
    }
//	while ((file = [[dirEnum nextObject] lowercaseString])) 
//    {
//		if([file rangeOfString:@"/"].length != 0)
//        {
//			NSString *fileT = [[file componentsSeparatedByString:@"/"] 
//                               lastObject];
//			if([fileT rangeOfString:afile].length != 0)
//            {
//				[array addObject:file];
//            }
//		}
//        else
//        {
//			if([file rangeOfString:afile].length != 0)
//            {
//				[array addObject:file];
//            }
//		}
//	}
	[localFileManager release];
    [path release];
	return array;
}

//------------------------------------------------------------------------------
//+ (BOOL) isExist:(NSString *)directoryPath
//------------------------------------------------------------------------------
+ (BOOL) isExist:(NSString *)directoryPath
{//judge the directory if exist
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL isDir;
	
	return [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
}

//------------------------------------------------------------------------------
//+ (NSArray *) searchPictureInDirectory:(NSString *)directoryPath
//------------------------------------------------------------------------------
+ (NSArray *) searchPictureInDirectory:(NSString *)directoryPath
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    NSError *error;
    
    NSArray *fileTmp = [fileManager contentsOfDirectoryAtPath:directoryPath
                        error:&error];
    
    for(int i = 0; i < [fileTmp count]; i++)
    {
        NSMutableString *path = [[NSMutableString alloc] 
                                 initWithString:directoryPath];
        [path appendString:@"/"];
        [path appendString:[fileTmp objectAtIndex:i]];
        
        ASFile *file = [[ASFile alloc] initWithFilePath:path];
        
        if(kPicture == file.fileStyle || kPNG == file.fileStyle)
        {
            [array addObject:file];
        }
        
        [path release];
        [file release];
    }
    [fileManager release];
    return array;
}

@end

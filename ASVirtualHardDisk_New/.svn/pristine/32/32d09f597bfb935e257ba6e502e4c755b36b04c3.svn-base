//
//  ASFile.m
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-23.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import "ASFile.h"
#import "ASDirectory.h"
#import "ASDeclare.h"
#import "ASLocalDefine.h"

@implementation ASFile

@synthesize fileStyle;
@synthesize fileType;
@synthesize filePath;
@synthesize fileName;
@synthesize fileSize;
@synthesize fileCreation;
@synthesize fileModify;
@synthesize fileOwner;
@synthesize fileLocation;

@synthesize selected;

#pragma mark -
#pragma mark private method
//------------------------------------------------------------------------------
// - (void) markFileType
//------------------------------------------------------------------------------
//- (void) markFileType
//{
//	
//	NSString *isPicture = @"jpg bmp tiff gif jpeg";
//	NSString *isVideo = @"avi rmvb mp4 mov mpeg mpg flv wmv";
//	
//	if([ASDirectory isDirectory:filePath])
//    {
//		fileStyle = kDirectory;
//    }
//	else if([fileType length] >= 3)
//    {
//		if([fileType isEqualToString:@"pdf"])
//        {
//			fileStyle = kPDF;
//        }
//		else if([fileType isEqualToString:@"epub"])
//        {
//			fileStyle = kEpub;
//        }
//		else if([fileType isEqualToString:@"mp3"] || 
//                [fileType isEqualToString:@"wma"])
//        {
//			fileStyle = kMP3;
//        }
//		else if([fileType isEqualToString:@"txt"])
//        {
//			fileStyle = kTXT;
//        }
//		else if([fileType isEqualToString:@"zip"] /*|| 
//                [fileType isEqualToString:@"rar"]*/)
//        {
//			fileStyle = kZip;
//        }
//        else if([fileType isEqualToString:@"rtf"])
//        {
//            fileStyle = kRTF;
//        }
//		else if([fileType isEqualToString:@"doc"] || 
//                [fileType isEqualToString:@"docx"])
//        {
//			fileStyle = kDoc;
//        }
//		else if([fileType isEqualToString:@"xlsx"] || 
//                [fileType isEqualToString:@"xltx"] || 
//                [fileType isEqualToString:@"xltm"] ||
//                [fileType isEqualToString:@"xls"])
//        {
//			fileStyle = kExcle;
//        }
//		else if([fileType isEqualToString:@"ppt"] || 
//                [fileType isEqualToString:@"ppsx"] || 
//                [fileType isEqualToString:@"pptm"] || 
//                [fileType isEqualToString:@"pps"])
//        {
//			fileStyle = kPPT;
//        }
//		else if([fileType isEqualToString:@"png"])
//        {
//			fileStyle = kPNG;
//        }
//		else if(([isPicture rangeOfString:fileType].length) != 0)
//        {
//			fileStyle = kPicture;
//        }
//		else if(([isVideo rangeOfString:fileType].length) != 0)
//        {
//			fileStyle = kVideo;
//        }
//		else 
//        {
//			fileStyle = kUnknow;
//        }
//	}
//    else if ([fileType isEqualToString:@"rm"]) 
//    {
//		fileStyle = kVideo;
//    }
//	else if([fileType length] == 0)
//    {
//		fileStyle = kUnknow;
//    }
//	else 
//    {
//		fileStyle = kUnknow;
//    }
//}
- (void) markFileType
{
	
	NSString *isPicture = kPictureSuffixName;
	NSString *isVideo = kMoveSuffixName;
	
	if([ASDirectory isDirectory:filePath])
    {
		fileStyle = kDirectory;
    }
	else if([fileType length] >= 3)
    {
		if([fileType isEqualToString:kPDFSuffixName])
        {
			fileStyle = kPDF;
        }
		else if([fileType isEqualToString:kEpubSuffixName])
        {
			fileStyle = kEpub;
        }
		else if([fileType isEqualToString:kMP3SuffixName] || 
                [fileType isEqualToString:kWMASuffixName])
        {
			fileStyle = kMP3;
        }
		else if([fileType isEqualToString:kTXTSuffixName])
        {
			fileStyle = kTXT;
        }
		else if([fileType isEqualToString:kZipSuffixName] /*|| 
                                                           [fileType isEqualToString:@"rar"]*/)
        {
			fileStyle = kZip;
        }
        else if([fileType isEqualToString:kRTFSuffixName])
        {
            fileStyle = kRTF;
        }
		else if([fileType isEqualToString:kDocSuffixName] || 
                [fileType isEqualToString:kDocxSuffixName])
        {
			fileStyle = kDoc;
        }
		else if([fileType isEqualToString:kXlsxSuffixName] || 
                [fileType isEqualToString:kXltxSuffixName] || 
                [fileType isEqualToString:kXltmSuffixName] ||
                [fileType isEqualToString:kXlsSuffixName])
        {
			fileStyle = kExcle;
        }
		else if([fileType isEqualToString:kPPTSuffixName] || 
                [fileType isEqualToString:kPPTSXSuffixName] || 
                [fileType isEqualToString:kPPTMSuffixName] || 
                [fileType isEqualToString:kPPSSuffixName])
        {
			fileStyle = kPPT;
        }
		else if([fileType isEqualToString:kPNGSuffixName])
        {
			fileStyle = kPNG;
        }
        else if([fileType isEqualToString:kGIFSuffixName])
        {
            fileStyle = kGIF;
        }
		else if(([isPicture rangeOfString:fileType].length) != 0)
        {
			fileStyle = kPicture;
        }
		else if(([isVideo rangeOfString:fileType].length) != 0)
        {
			fileStyle = kVideo;
        }
		else 
        {
			fileStyle = kUnknow;
        }
	}
    else if ([fileType isEqualToString:kRMSuffixName]) 
    {
		fileStyle = kVideo;
    }
	else if([fileType length] == 0)
    {
		fileStyle = kUnknow;
    }
	else 
    {
		fileStyle = kUnknow;
    }
}
//------------------------------------------------------------------------------
// - (void) initFile
//------------------------------------------------------------------------------
- (void) initFile
{
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	
	//get the attribute of file
	NSDictionary *fileAttributesDic = [fileManager 
                                       attributesOfItemAtPath:filePath 
                                                        error:NULL];

	//file name
    NSArray *array = [filePath componentsSeparatedByString:@"/"];
	fileName = [[NSString alloc] initWithString:[array lastObject]];
    
    //file location
    //get the root path
	NSArray *docFolders = NSSearchPathForDirectoriesInDomains(
                                                              NSDocumentDirectory,
                                                              NSUserDomainMask, 
                                                              YES );
	NSString *baseDir =  [NSString stringWithFormat:@"%@/Local",
                          [docFolders lastObject]];
    NSRange range = [filePath rangeOfString:baseDir];
    fileLocation = [[NSString alloc] initWithString:
                    [filePath substringFromIndex:range.length]];

	//file size
	NSNumber *size = [fileAttributesDic objectForKey:NSFileSize];
	int tmp = [size intValue];
	
	if(tmp >= 1024 && tmp < 1048576)
    {
		tmp = tmp / 1024;
		fileSize = [[NSString alloc] initWithFormat:@"%6dKB",tmp];
	}
    else if (tmp >= 1048576) 
    {
		tmp = tmp / (1024*1024);
		fileSize = [[NSString alloc] initWithFormat:@"%6dMB",tmp];
	}
    else if(tmp < 1024)
    {
		fileSize = [[NSString alloc] initWithFormat:@"%7dB",tmp];
	}

	//file type
	if ([fileAttributesDic objectForKey:NSFileType] == NSFileTypeDirectory)
    {
		fileType = [[NSString alloc] initWithString:declare.directoryType];
    }
	else if ([filePath pathExtension].length != 0) 
    {
		fileType = [[NSString alloc] initWithString:[filePath pathExtension]];
    }
	else 
    {
		fileType = [[NSString alloc] initWithString:declare.UnkonwType];
    }
	
	//creation date
	NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init]; 
	[dateFormatter setDateFormat:@"yyyy/MM/dd"];
	NSDate *creation = [fileAttributesDic objectForKey:NSFileCreationDate];
    if(creation == nil)
    {
        creation = [NSDate date];
    }
	fileCreation = [[NSString alloc] 
                    initWithString:[dateFormatter stringFromDate:creation]];
	
	//modify date
	NSDate *modify = [fileAttributesDic objectForKey:NSFileModificationDate];
    if(modify == nil)
    {
        modify = [NSDate date];
    }
	fileModify = [[NSString alloc] 
                  initWithString:[dateFormatter stringFromDate:modify]];
	
	//file owner
    if([fileAttributesDic objectForKey:NSFileOwnerAccountName] == nil)
    {
        fileOwner = [[NSString alloc] initWithString:@"Admin"];
    }
    else 
    {
        fileOwner = [[NSString alloc] 
                     initWithString:[fileAttributesDic 
                                     objectForKey:NSFileOwnerAccountName]];
    }
	
	[self markFileType];
	
	self.selected = NO;
	
	[dateFormatter release];
	[fileManager release];
}

#pragma mark -
#pragma mark public method
//- (void) setFileName:(NSString *)aFileName{
//	[aFileName retain];
//	[fileName release];
//	fileName = aFileName;
//}
//
//- (NSString *) fileName{
//	if(!fileName)
//	{
//		NSArray *array = [filePath componentsSeparatedByString:@"/"];
//		self.fileName = [[[array lastObject] retain] autorelease];
//	}
//	return fileName;
//
//}

//------------------------------------------------------------------------------
// - (id) initWithFilePath:(NSString *)aFilePath
//------------------------------------------------------------------------------
- (id) initWithFilePath:(NSString *)aFilePath
{
    self = [super init];
	if (self) 
    {
        declare = [ASDeclare singletonASDeclare];
		filePath = [[NSString alloc] initWithString:aFilePath];
		[self initFile];
	}
	
	return self;
}

//------------------------------------------------------------------------------
// - (id) init
//------------------------------------------------------------------------------
- (id) init
{
	return [self initWithFilePath:nil];
}

//------------------------------------------------------------------------------
// - (void) deleteFile
//------------------------------------------------------------------------------
- (void) deleteFile
{
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	
	[fileManager removeItemAtPath:filePath error:NULL];
	
	[fileManager release];
}

//------------------------------------------------------------------------------
// - (void) rename:(NSString *)newFileName
//------------------------------------------------------------------------------
- (void) rename:(NSString *)newFileName
{

	NSArray *array = [filePath componentsSeparatedByString:@"/"];
	
	if (![newFileName isEqualToString:[array lastObject]]) 
    {
        //split joint the new file path
        NSMutableString *path = [[NSMutableString alloc] init];
        
        for (int i = 0; i < ([array count]-1); i++) 
        {
            [path appendString:[array objectAtIndex:i]];
            [path appendString:@"/"];
        }
        
        [path appendString:newFileName];
        
        if(fileStyle == kDirectory || fileStyle == kUnknow)//check if directory
        {
            [path appendString:@""];
        }
        else 
        {
            [path appendString:@"."];
            [path appendString:fileType];
        }
        
        NSFileManager *fm = [[NSFileManager alloc] init];
        NSError *error = [[NSError alloc] init];
        
        //move the the file to the new filepath (it is rename operation)
        if(![filePath isEqualToString:path])
        {
            if([fm moveItemAtPath:filePath toPath:path error:&error] != YES)
            {
                NSLog(@"Unable to move file: %@",[error localizedDescription]);
            }
        }
        
        [error release];
        [path release];
        [fm release];
	}
	
}

//------------------------------------------------------------------------------
// - (void) copyToDirectory:(NSString *)directoryPath
//------------------------------------------------------------------------------
- (void) copyToDirectory:(NSString *)directoryPath
{//copy file operation
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	
    if(directoryPath != nil)
    {
        [fileManager copyItemAtPath:self.filePath toPath:directoryPath error:nil];
    }
	
	[fileManager release];
}

//------------------------------------------------------------------------------
// - (void) createFile
//------------------------------------------------------------------------------
- (void) createFile
{//create the file by the filePath
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	
	NSMutableDictionary *fileAttribute = [[NSMutableDictionary alloc] init];
	NSDate *createDate = [NSDate date];
	//NSString *owner = [self	hostname];
	
	[fileAttribute setObject:createDate forKey:NSFileCreationDate];
	//[fileAttribute setObject:owner forKey:NSFileOwnerAccountName];
	
	[fileManager createFileAtPath:filePath contents:nil 
                       attributes:fileAttribute];
	
	[fileAttribute release];
	[fileManager release];
}

//------------------------------------------------------------------------------
// - (BOOL) isFileExist
//------------------------------------------------------------------------------
- (BOOL) isFileExist
{//check the file is exsit
	NSFileManager *fileManager = [[NSFileManager alloc] init];
	BOOL isExist;
	
	isExist = [fileManager fileExistsAtPath:filePath];
	
	[fileManager release];
	
	return isExist;
}

//------------------------------------------------------------------------------
// - (void) dealloc
//------------------------------------------------------------------------------
- (void) dealloc{
//    NSLog(@"filePath:%d",[filePath retainCount]);
//    NSLog(@"fileName:%d",[fileName retainCount]);
//     NSLog(@"fileLocation:%d",[fileLocation retainCount]);
	[filePath release];
//
	[fileName release];
    [fileLocation release];
	[fileSize release];
    [fileType release];
	[fileCreation release];
	[fileModify release];
	[fileOwner release];
    
	[super dealloc];
}

@end

//
//  ASFile.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-23.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDirectory		0
#define kMP3			1
#define kPDF			2
#define kEpub			3
#define kPNG			4
#define kPicture		5
#define kDoc			6
#define kExcle			7
#define kPPT			8
#define kZip			9
#define kVideo			10
#define kUnknow         11
#define kTXT			12
#define kRTF            13
#define kGIF            14

//the suffix name of files
#define kPictureSuffixName  @"jpg bmp tiff jpeg"
#define kMoveSuffixName     @"avi rmvb mp4 mov mpeg mpg flv wmv"
#define kPDFSuffixName      @"pdf"
#define kEpubSuffixName     @"epub"
#define kMP3SuffixName      @"mp3"
#define kWMASuffixName      @"wma"
#define kTXTSuffixName      @"txt"
#define kZipSuffixName      @"zip"
#define kRTFSuffixName      @"rtf"
#define kDocSuffixName      @"doc"
#define kDocxSuffixName     @"docx"
#define kXlsxSuffixName     @"xlsx"
#define kXltxSuffixName     @"xltx"
#define kXltmSuffixName     @"xltm"
#define kXlsSuffixName      @"xls"
#define kPPTSuffixName      @"ppt"
#define kPPTSXSuffixName    @"ppsx"
#define kPPTMSuffixName     @"pptm"
#define kPPSSuffixName      @"pps"
#define kPNGSuffixName      @"png"
#define kRMSuffixName       @"rm"
#define kGIFSuffixName      @"gif"

//file owner
//#define kFileOnwer @"Admin"

@class ASDeclare;

@interface ASFile : NSObject{
	int fileStyle;
	//file path
	NSString *filePath;
	//file attribute
	NSString *fileName;
	NSString *fileType;
	NSString *fileSize;
	NSString *fileCreation;
	NSString *fileModify;
	NSString *fileOwner;
    NSString *fileLocation;
	
	BOOL selected;
    
    ASDeclare *declare;
}

@property (nonatomic) BOOL selected;
@property (readonly) int fileStyle;
@property (nonatomic, retain) NSString *fileType;
@property (nonatomic, retain) NSString *filePath;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) NSString *fileSize;
@property (nonatomic, retain) NSString *fileCreation;
@property (nonatomic, retain) NSString *fileModify;
@property (nonatomic, retain) NSString *fileOwner;
@property (nonatomic, copy) NSString *fileLocation;

//- (void) setFileName:(NSString *)aFileName;
//- (NSString *) fileName;
/*
    @function   - (id) initWithFilePath:(NSString *)aFilePath
    @abstract   init a file via the filePath:
                set filePath and init the file Attribute
    @param      (NSString *) aFilePath - the path for file
    @result     id
*/
- (id) initWithFilePath:(NSString *)aFilePath;

/*
    @function   - (void) deleteFile
    @abstract   delete the file
    @param      no
    @result     void
*/
- (void) deleteFile;

/*
    @function   - (void) rename:(NSString*)newFileName
    @abstract   rename the file with the newFileName
    @param      (NSString *)newFileName
    @result     void
*/
- (void) rename:(NSString *)newFileName;

/*
    @function   - (void) copyToDirectory:(NSString *)directorypath
    @abstract   copy the file to another path
    @param      (NSString *)directoryPath - the new path
    @result     void
*/
- (void) copyToDirectory:(NSString *)directoryPath;

/*
    @function   - (void) createFile
    @abstract   create file with filePath
    @param      no
    @result     void
*/
- (void) createFile;

/*
    @function   - (BOOL) isFileExist
    @abstract   judge the file whether exist or not
    @param      no
    @result     BOOL : if exist, return YES
                       else, return NO
*/
- (BOOL) isFileExist;

/*
    @function   - (void) dealloc
    @abstract   dealloc
    @param      no
    @result     void
*/
- (void) dealloc;


@end

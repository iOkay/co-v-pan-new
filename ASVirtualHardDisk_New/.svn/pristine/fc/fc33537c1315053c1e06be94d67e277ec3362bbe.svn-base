//
//  ASDirectory.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-23.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASDirectory : NSObject {
}

/*
    @function   + (NSArray *) searchDocuments:(NSString *)directoryPath
    @abstract   search the files and directorys in the path
    @param      (NSString *)directoryPath - directory path
    @result     NSArray * - retur a array contain 
                            the file names in the directory
*/
+ (NSArray *) searchDocuments:(NSString *)directoryPath;

/*
    @function   + (NSString *) addNewDirectory:(NSString *)directoryPath
    @abstract   add a new directory in the given path
    @param      (NSString *)directoryPath - directory path to add 
    @result     NSString * - return the new directory's path
*/
+ (NSString *) addNewDirectory:(NSString *)directoryPath;

/*
    @function   + (BOOL) isDirectory:(NSString *)directoryPath
    @abstract   judge if a directory
    @param      (NSString *)directory path
    @result     BOOL - if is a directory, return YES
                       else, return NO
*/
+ (BOOL) isDirectory:(NSString *)directoryPath;

/*
    @function   + (int) contentFiles:(NSString *)directoryPath
    @abstract   get how many files the directory contains
    @param      (NSString *)directoryPath - the directory path 
    @result     int - reuturn how many files the directory contains
*/
+ (int) contentFiles:(NSString *)directoryPath;

/*
    @function   + (NSArray *) searchLocaleDocuments
    @abstract   search the documents in root directory
    @param      none
    @result     NSArray* - return a array 
                           that contains documents in root directory
*/
+ (NSArray *) searchLocaleDocuments;

/*
    @function   + (NSMutableArray *) findFile:(NSString *)afile
    @abstract   find the file in local
    @param      (NSString *)aFile - the file name to find
    @result     NSMutableArray* - return a mutable array 
                                  contains the search result
*/
+ (NSMutableArray *) findFile:(NSString *)afile;

/*
    @function   + (BOOL) containDirectory:(NSString *)directoryPath
    @abstract   judge if contains directory
    @param      (NSString *)directoryPath - directory path to check
    @result     BOOL - if contains, return YES
                    else, return NO
*/
+ (BOOL) containDirectory:(NSString *)directoryPath;

/*
    @function   + (BOOL) isExist:(NSString *)directoryPath
    @abstract   judge whether the directory given exist
    @param      (NSString *)directoryPath - the directoryPath to check
    @result     BOOL - if exist, return YES
                       else, return NO
*/
+ (BOOL) isExist:(NSString *)directoryPath;

/*
    @function   + (void) createRootDirectory
    @abstract   create the root directory
    @param      none
    @result     void
*/
+ (void) createRootDirectory;

/*
 @function   + (NSArray *) searchPictureInDirectory:(NSString *)directoryPath
 @abstract   find the pictures in the given directory
 @param      (NSString *)directoryPath - the directory path to search
 @result     NSArray * - a array contain all pictures in the directory
 */
+ (NSArray *) searchPictureInDirectory:(NSString *)directoryPath;

@end

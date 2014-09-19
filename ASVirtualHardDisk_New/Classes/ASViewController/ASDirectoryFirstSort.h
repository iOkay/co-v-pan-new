//
//  ASDirectoryFirstSort.h
//  ASVirtualHardDisk
//
//  Created by Liu Dong on 11-12-6.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASDataObject.h"


@interface ASDirectoryFirstSort : NSObject {

}

+(id)singleASDirectoryFirstSort;

-(BOOL)compareByName:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond 
                 isAsc:(BOOL)aFlag;
-(BOOL)compareByDate:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond 
                 isAsc:(BOOL)aFlag;
-(BOOL)compareBySize:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond 
                 isAsc:(BOOL)aFlag;
-(BOOL)compareByType:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond 
                 isAsc:(BOOL)aFlag;

-(NSString *)getNameWithoutType:(NSString *)aName;
-(int)getSizeValue:(NSString *)aSize;
-(int)getSizeType:(NSString *)aSize;

-(void)directoryFirstSort:(NSMutableArray *)aRootArray 
						  compareType:(int)aType isAsc:(BOOL)aFlag;

-(int)insertFile:(id<ASDataObject>)aFile inToArray:(NSMutableArray *)aArray;

@end

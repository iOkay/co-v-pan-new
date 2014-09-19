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

-(BOOL)isBiggerThanByName:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond;
-(BOOL)isBiggerThanByDate:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond;
-(BOOL)isBiggerThanByType:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond;
-(BOOL)isBiggerThanBySize:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond;

-(NSString *)getNameWithoutType:(NSString *)aName;
-(int)getSizeValue:(NSString *)aSize;
-(int)getSizeType:(NSString *)aSize;

-(void)sort:(NSMutableArray *)aSortArray compareType:(int)aType isAsc:(BOOL)flag;
-(NSMutableArray *)directoryFirstSort:(id<ASDataObject>)aRootItem 
						  compareType:(int)aType isAsc:(BOOL)flag;

@end

//
//  ASDirectoryFirstSort.m
//  ASVirtualHardDisk
//
//  Created by Liu Dong on 11-12-6.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import "ASDirectoryFirstSort.h"
#import "ASFileAttribute.h"

#define BYNAME 1
#define BYDATE 2
#define BYTYPE 3
#define BYSIZE 4

@implementation ASDirectoryFirstSort

-(NSString *)getNameWithoutType:(NSString *)aName
{
	NSMutableString *temp = [NSMutableString stringWithString:aName];
	int len = [temp length];
	
	NSRange range = [temp rangeOfString:@"."];
	while (range.location != NSNotFound) 
	{
		[temp deleteCharactersInRange:NSMakeRange(0, range.location+1)];
		range = [temp rangeOfString:@"."];
	}
	int typeLen = [temp length];
	
	NSMutableString *name = [NSMutableString stringWithString:aName];
	[name deleteCharactersInRange:NSMakeRange(len-typeLen, typeLen)];
	return (NSString*)name;
}

-(BOOL)isBiggerThanByName:(id <ASDataObject>)aFirst andCompareItem:(id <ASDataObject>)aSecond 
{
	NSString *name_1 = [aFirst getItemName];
	NSString *name_2 = [aSecond getItemName];
	if (0 != [aFirst getFileType]) 
	{
		name_1 = [self getNameWithoutType:name_1];
	}
	if (0 != [aSecond getFileType]) 
	{
		name_2 = [self getNameWithoutType:name_2];
	}
	
	NSComparisonResult compareResult = [name_1 caseInsensitiveCompare:name_2];
	if (compareResult == NSOrderedDescending) 
	{
		return YES;
	}
	else 
	{
		return NO;
	}
}

-(BOOL)isBiggerThanByDate:(id <ASDataObject>)aFirst andCompareItem:(id <ASDataObject>)aSecond
{
	NSDictionary *dic_1 = [aFirst getItemAttribution];
	NSString *date_1 = [dic_1 objectForKey:kFileCreateValue];
	NSDictionary *dic_2 = [aSecond getItemAttribution];
	NSString *date_2 = [dic_2 objectForKey:kFileCreateValue];
	
	NSComparisonResult compareResult = [date_1 compare:date_2];
	if (compareResult == NSOrderedDescending) 
	{
		return YES;
	}
	else 
	{
		if (compareResult == NSOrderedAscending) 
		{
			return NO;
		}
		return [self isBiggerThanByName:aFirst andCompareItem:aSecond];
	}
}

-(BOOL)isBiggerThanByType:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond
{
	int type_1 = [aFirst getFileType];
	int type_2 = [aSecond getFileType];
	
	if (type_1 > type_2) 
	{
		return YES;
	}
	else 
	{
		if (type_1 < type_2) 
		{
			return NO;
		}
		return [self isBiggerThanByName:aFirst andCompareItem:aSecond];
	}
}

-(int)getSizeType:(NSString *)aSize
{
	if ([aSize hasSuffix:@"KB"]) 
	{
		return 2;
	}
	else 
	{
		if ([aSize hasSuffix:@"MB"]) 
		{
			return 3;
		}
		return 1;
	}
}

-(int)getSizeValue:(NSString *)aSize
{
	NSMutableString *size = [NSMutableString stringWithString:aSize];
	NSRange range;
	if ([size hasSuffix:@"KB"]) 
	{
		range = [size rangeOfString:@"KB"];
	}
	else 
	{
		if ([size hasSuffix:@"MB"]) 
		{
			range = [size rangeOfString:@"MB"];
		}
		else 
		{
			range = [size rangeOfString:@"B"];
		}
	}
	if (range.location != NSNotFound) 
	{
		[size deleteCharactersInRange:range];
	}
	
	return [size intValue]; 
}

-(BOOL)isBiggerThanBySize:(id <ASDataObject>)aFirst andCompareItem:(id <ASDataObject>)aSecond
{
	NSDictionary *dic_1 = [aFirst getItemAttribution];
	NSString *size_1 = [dic_1 objectForKey:kFileSizeValue];
	NSDictionary *dic_2 = [aSecond getItemAttribution];
	NSString *size_2 = [dic_2 objectForKey:kFileSizeValue];
	
	if ([size_1 isEqualToString:size_2]) 
	{
		return ![self isBiggerThanByName:aFirst andCompareItem:aSecond];
	}
	
	int sizeType_1 = [self getSizeType:size_1];
	int sizeType_2 = [self getSizeType:size_2];
	int sizeValue_1 = [self getSizeValue:size_1];
	int sizeValue_2 = [self getSizeValue:size_2];
	
	if (sizeType_1 != sizeType_2) 
	{
		return sizeType_1 > sizeType_2;
	}
	else 
	{
		return sizeValue_1 > sizeValue_2;
	}

}

-(void)sort:(NSMutableArray *)aSortArray compareType:(int)aType isAsc:(BOOL)flag
{
	for (int i = [aSortArray count] - 1; i > 0; i--) 
	{
		for (int j = 0; j < i; j++) 
		{
			id<ASDataObject> obj_1 = [aSortArray objectAtIndex:j];
			id<ASDataObject> obj_2 = [aSortArray objectAtIndex:j+1];
			BOOL compare;
			
			switch (aType) 
			{
				case BYNAME:
					compare = flag?[self isBiggerThanByName:obj_1 andCompareItem:obj_2]:
					![self isBiggerThanByName:obj_1 andCompareItem:obj_2];
					break;
				case BYDATE:
					compare = flag?[self isBiggerThanByDate:obj_1 andCompareItem:obj_2]:
					![self isBiggerThanByDate:obj_1 andCompareItem:obj_2];
					break;
				case BYTYPE:
					compare = [self isBiggerThanByType:obj_1 andCompareItem:obj_2];
					break;
				case BYSIZE:
					compare = flag?[self isBiggerThanBySize:obj_1 andCompareItem:obj_2]:
					![self isBiggerThanBySize:obj_1 andCompareItem:obj_2];
					break;

				default:
					break;
			}
			
			if (compare) 
			{
				[aSortArray replaceObjectAtIndex:j withObject:obj_2];
				[aSortArray replaceObjectAtIndex:j+1 withObject:obj_1];
			}
		}
	}
}

-(NSMutableArray *)directoryFirstSort:(id <ASDataObject>)aRootItem
						  compareType:(int)aType isAsc:(BOOL)flag
{
	NSArray *fileList = [aRootItem getFileList:NO];
	NSMutableArray *array = [[NSMutableArray alloc] initWithArray:fileList];
	[self sort:array compareType:aType isAsc:flag];
	
	NSMutableArray *fileArray = [[NSMutableArray alloc] initWithCapacity:[array count]/2];
	for (int i = 0; i < [array count]; i++) 
	{
		id<ASDataObject> obj = [array objectAtIndex:i];
		if (0 != [obj getFileType]) 
		{
			[fileArray addObject:obj];
			[array removeObjectAtIndex:i];
			i--;
		}
	}
	
	int directoryCount = [array count];
	for (int i = directoryCount; i < directoryCount + [fileArray count]; i++) 
	{
		id obj = [fileArray objectAtIndex:i - directoryCount];
		[array addObject:obj];
	}
	
	[fileArray release];
	return [array autorelease];
}

@end

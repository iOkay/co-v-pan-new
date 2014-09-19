//
//  ASDirectoryFirstSort.m
//  ASVirtualHardDisk
//
//  Created by Liu Dong on 11-12-6.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import "ASDirectoryFirstSort.h"
#import "ASFileAttribute.h"
#import "ASSortMenuModel.h"

#define BYNAME 1
#define BYDATE 2
#define BYTYPE 3
#define BYSIZE 4

@implementation ASDirectoryFirstSort

static ASDirectoryFirstSort *singleModel = nil;
+(id)singleASDirectoryFirstSort
{
	if (nil == singleModel) 
	{
		singleModel = [[ASDirectoryFirstSort alloc] init];
	}
	return singleModel;
}

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

-(BOOL)compareByName:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond 
                 isAsc:(BOOL)aFlag
{
	int type_1 = [aFirst getFileType];
	int type_2 = [aSecond getFileType];
	
	if (0 == type_1 && 0 != type_2) 
	{
		return NO;
	}
	if (0 != type_1 && 0 == type_2) 
	{
		return YES;
	}
	
	NSString *name_1 = [aFirst getItemName];
	NSString *name_2 = [aSecond getItemName];
	if (0 != type_1) 
	{
		name_1 = [self getNameWithoutType:name_1];
		name_2 = [self getNameWithoutType:name_2];
	}
	
	NSComparisonResult compareResult = [name_1 caseInsensitiveCompare:name_2];
	if (compareResult == NSOrderedDescending) 
	{
		return aFlag;
	}
	else 
	{
		return !aFlag;
	}
}

-(BOOL)compareByDate:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond 
                 isAsc:(BOOL)aFlag
{
	int type_1 = [aFirst getFileType];
	int type_2 = [aSecond getFileType];
	
	if (0 == type_1 && 0 != type_2) 
	{
		return NO;
	}
	if (0 != type_1 && 0 == type_2) 
	{
		return YES;
	}
	
	NSString *date_1 = [aFirst getFileCreateDate];
	NSString *date_2 = [aSecond getFileCreateDate];
	
	NSComparisonResult compareResult = [date_1 compare:date_2];
	if (compareResult == NSOrderedDescending) 
	{
		return aFlag;
	}
	else 
	{
		if (compareResult == NSOrderedAscending) 
		{
			return !aFlag;
		}
		return [self compareByName:aFirst andCompareItem:aSecond isAsc:YES];
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

-(BOOL)compareBySize:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond 
                 isAsc:(BOOL)aFlag
{
	int type_1 = [aFirst getFileType];
	int type_2 = [aSecond getFileType];
	
	if (0 == type_1 && 0 != type_2) 
	{
		return NO;
	}
	if (0 != type_1 && 0 == type_2) 
	{
		return YES;
	}
	
	NSDictionary *dic_1 = [aFirst getItemAttribution];
	NSString *size_1 = [dic_1 objectForKey:kFileSizeValue];
	NSDictionary *dic_2 = [aSecond getItemAttribution];
	NSString *size_2 = [dic_2 objectForKey:kFileSizeValue];
	
	if ([size_1 isEqualToString:size_2]) 
	{
		return [self compareByName:aFirst andCompareItem:aSecond isAsc:YES];
	}
	
	int sizeType_1 = [self getSizeType:size_1];
	int sizeValue_1 = [self getSizeValue:size_1];
	int sizeType_2 = [self getSizeType:size_2];
	int sizeValue_2 = [self getSizeValue:size_2];
	
	if (sizeType_1 != sizeType_2) 
	{
		return aFlag?(sizeType_1 > sizeType_2):(sizeType_1 < sizeType_2);
	}
	return aFlag?(sizeValue_1 > sizeValue_2):(sizeValue_1 < sizeValue_2);
}

-(BOOL)compareByType:(id<ASDataObject>)aFirst andCompareItem:(id<ASDataObject>)aSecond 
			   isAsc:(BOOL)aFlag
{
	int type_1 = [aFirst getFileType];
	int type_2 = [aSecond getFileType];
	
	if (0 == type_1 && 0 != type_2) 
	{
		return NO;
	}
	if (0 != type_1 && 0 == type_2) 
	{
		return YES;
	}
	
	if (type_1 > type_2) 
	{
		return aFlag;
	}
	else 
	{
		if (type_1 < type_2) 
		{
			return !aFlag;
		}
		return [self compareByName:aFirst andCompareItem:aSecond isAsc:YES];
	}
}

-(void)directoryFirstSort:(NSMutableArray *)aRootArray
						  compareType:(int)aType isAsc:(BOOL)aFlag
{
	NSMutableArray *array = aRootArray;
	
	for (int i = [array count] - 1; i > 0; i--) 
	{
		for (int j = 0; j < i; j++) 
		{
			id<ASDataObject> obj_1 = [array objectAtIndex:j];
			id<ASDataObject> obj_2 = [array objectAtIndex:j+1];
			BOOL compare = NO;
			
			switch (aType) 
			{
				case BYNAME:
					compare = [self compareByName:obj_1 andCompareItem:obj_2 isAsc:aFlag];
					break;
				case BYDATE:
					compare = [self compareByDate:obj_1 andCompareItem:obj_2 isAsc:aFlag];
					break;
				case BYTYPE:
					compare = [self compareByType:obj_1 andCompareItem:obj_2 isAsc:aFlag];
					break;
				case BYSIZE:
					compare = [self compareBySize:obj_1 andCompareItem:obj_2 isAsc:aFlag];
					break;
					
				default:
					break;
			}
			
			if (compare) 
			{
				[array replaceObjectAtIndex:j withObject:obj_2];
				[array replaceObjectAtIndex:j+1 withObject:obj_1];
			}
		}
	}
}

-(int)insertFile:(id <ASDataObject>)aFile inToArray:(NSMutableArray *)aArray
{
	ASSortMenuModel *model = [ASSortMenuModel singletonASSortMenuModel];
	int type = [model getSortType]+1;
	BOOL flag = (4 == [model getSortFlag]);
	
	int i = 0;
	BOOL is = YES;
	id<ASDataObject> obj = nil;

	for (; i < [aArray count]; i++) 
	{
		obj = [aArray objectAtIndex:i];
		switch (type) 
		{
			case BYNAME:
				is = [self compareByName:aFile andCompareItem:obj isAsc:flag];
				break;
			case BYDATE:
				is = [self compareByDate:aFile andCompareItem:obj isAsc:flag];
				break;
			case BYTYPE:
				is = [self compareByType:aFile andCompareItem:obj isAsc:flag];
				break;
			case BYSIZE:
				is = [self compareBySize:aFile andCompareItem:obj isAsc:flag];
				break;
			default:
				break;
		}
		if (!is) 
		{
			break;
		}
	}
	[aArray insertObject:aFile atIndex:i];
	return i;
}

@end

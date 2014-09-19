//------------------------------------------------------------------------------
// Filename:        ASNewFileName.h
// Project:         ASStrategy
// Author:          wangqiushuang
// Date:            11-10-31
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------
// Quote the standard library header files. 
#import <Foundation/Foundation.h>
@class ASDirectoryEx;
/*
    @abstract	
*/

@interface ASNewFileName : NSObject 
{
@private
    
    //Declare instance variaites.

}

/*
 @abstract    
 @result      
 */

+(NSString *)nameOfNewFile:(NSString *)name toDirectory:(ASDirectoryEx *)directory;
@end

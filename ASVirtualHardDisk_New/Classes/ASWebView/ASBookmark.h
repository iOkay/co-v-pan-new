//------------------------------------------------------------------------------
//  Filename:       ASBookmark.h
//  Project:        NSWebView
//  Author:         xiu
//  Date:           11-10-25 : last edited by xiu
//  Version:        1.0
//  Copyright       2011年 __AlphaStudio__. All rights reserved.
//------------------------------------------------------------------------------
//  Quote the standard library header files.




#import <Foundation/Foundation.h>


@interface ASBookmark : NSObject <NSCoding,NSCopying>
{
@private
    NSString* urlString;
    NSString* name;
}

@property (nonatomic, retain) NSString* urlString;
@property (nonatomic, retain) NSString* name;


-(id)init;
-(void)dealloc;


@end

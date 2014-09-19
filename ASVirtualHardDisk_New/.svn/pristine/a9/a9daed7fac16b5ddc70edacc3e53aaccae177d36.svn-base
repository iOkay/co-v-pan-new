//------------------------------------------------------------------------------
//  Filename:          ASBookmark.m
//  Project:           NSWebView
//  Author:            xiu
//  Date:              11-10-25 : last edited by xiu
//  Version:           1.0
//  Copyright:         2011年 __AlphaStudio__. All rights reserved.
//------------------------------------------------------------------------------
// Quote the header file(s).

#import "ASBookmark.h"


@implementation ASBookmark
@synthesize urlString,name;

//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(void)dealloc
{
    [urlString release];
    [name release];
    [super dealloc];
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.urlString forKey:@"urlString"];
    
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.urlString = [aDecoder decodeObjectForKey:@"urlString"];
    }
    return  self;
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------
-(id)copyWithZone:(NSZone *)zone
{
    ASBookmark* copy = [[self class]allocWithZone:zone];
    copy.name = self.name;
    copy.urlString = self.urlString;
    return copy;
}



@end

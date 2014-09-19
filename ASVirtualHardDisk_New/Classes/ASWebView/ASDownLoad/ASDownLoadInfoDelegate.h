//
//  ASDownLoadInfoDelegate.h
//  NSWebView
//
//  Created by xiu on 11-11-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//




@class ASDownLoadInfo;

@protocol ASDownLoadInfoDelegate <NSObject>
@required
-(void)download:(ASDownLoadInfo*)info fileSize:(NSInteger)size;
-(void)downLoad:(ASDownLoadInfo*)info statueChange:(NSUInteger)statue;
-(void)downLoad:(ASDownLoadInfo*)info progessChange:(float)progress;

@end

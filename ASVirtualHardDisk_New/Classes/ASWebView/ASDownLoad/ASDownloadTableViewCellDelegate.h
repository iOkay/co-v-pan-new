//
//  ASDownloadTableViewCellDelegate.h
//  NSWebView
//
//  Created by xiu on 11-10-31.
//  Copyright 2011年 __AlphaStudio__. All rights reserved.
//



@class ASDownLoadTableViewCell;
@class NSIndexPath;

@protocol ASDownloadTableViewCellDelegate
-(void)downLoad:(ASDownLoadTableViewCell*)tableCell stopDownLoadAtIndexPath:(NSIndexPath*)path;
-(void)downLoad:(ASDownLoadTableViewCell*)tableCell cantinueDownLoadAtIndexPath:(NSIndexPath*)path;
-(void)downLoad:(ASDownLoadTableViewCell*)tableCell cancelDownLoadAtIndexPath:(NSIndexPath*)path;

-(void)downLoad:(ASDownLoadTableViewCell *)tableCell reloadDownLoadAtIndexPath:(NSIndexPath *)path;

@end

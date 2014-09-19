//
//  ASDownLoadInfo.h
//  NSWebView
//
//  Created by xiu on __AlphaStudio__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIProgressDelegate.h"
#import "ASDownLoadInfoDelegate.h"
#import "ASIHTTPRequestDelegate.h"

@class  ASIHTTPRequest;

@interface ASDownLoadInfo : NSObject<NSCoding,NSCopying,ASIProgressDelegate,ASIHTTPRequestDelegate> 
{
    @private
    NSString* name;
    ASIHTTPRequest* request;
    NSString* filePath;
    NSString* tempFilePath;
    NSString* urlString;
    NSUInteger statue;
    NSInteger fileSize;
    float progress;
    id<ASDownLoadInfoDelegate> delegate;
    
}


@property (nonatomic,retain) NSString* filePath;
@property (nonatomic,retain) NSString* tempFilePath;
@property (nonatomic,retain) ASIHTTPRequest* request;
@property (nonatomic,retain) NSString* name;
@property (nonatomic,retain) NSString* urlString;
@property (nonatomic,retain) id<ASDownLoadInfoDelegate> delegate;
@property NSUInteger statue;
@property NSInteger fileSize;
@property float progress;


-(id)init;
-(id)initWithName:(NSString*)aName;
-(void)dealloc;
-(Boolean)createRequest;
-(void)cleanTemp;
-(void)initFilePathWithName:(NSString*)aName;





@end

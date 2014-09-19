//
//  ASDownLoadList.h
//  ASVirtualHardDisk
//
//  Created by xiu on 11-11-15.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASDownLoadListDelegate.h"
#import "ASDownLoadInfoDelegate.h"

@interface ASDownLoadList : NSObject <ASDownLoadInfoDelegate>{
    NSOperationQueue* queue;  
    NSMutableArray* downLoadInfoList;
    id<ASDownLoadListDelegate> delegate;
}

@property (nonatomic,retain) NSMutableArray* downLoadInfoList;
@property (nonatomic,retain) id<ASDownLoadListDelegate> delegate;

+(id)singel;

-(id)init;
-(void)dealloc;

-(BOOL)stopRequestAtIndex:(NSUInteger)index;
-(BOOL)cancelRequestAtIndex:(NSUInteger)index;
-(BOOL)cantinueRequestAtindex:(NSUInteger)index;
-(BOOL)reloadRequestAtIndex:(NSUInteger)index;
-(NSArray*)cleanDownLoad;
-(NSUInteger)addDownLoad:(NSString*) urlString;




@end

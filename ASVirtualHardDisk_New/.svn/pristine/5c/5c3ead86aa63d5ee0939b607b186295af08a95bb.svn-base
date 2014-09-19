//
//  ASWebViewModel.h
//  NSWebView
//
//  Created by xiu on 11-10-24.
//  Copyright 2011年 __AlphaStudio__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASBookmark.h"



@interface ASWebViewModel : NSObject {
@private
    NSMutableArray* bookmarkList;
}

@property (nonatomic, retain) NSMutableArray* bookmarkList;

+(id)single;
-(void)readFromFile;
-(void)saveToFile;
-(id)init;
-(void)dealloc;
-(void)addBookmark:(ASBookmark*)aBookmark;


@end

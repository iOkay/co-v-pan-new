//
//  LFWebView.h
//  Untitled
//
//  Created by sie kensou on 11-12-19.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ASWebViewDelegate;

@interface ASWebView : UIWebView {
    NSInteger           resourceCount;
    NSInteger           loadCount;
    
    NSTimeInterval      startTime;
    NSTimeInterval      endTime;
    
    id<ASWebViewDelegate>   ASDelegate;
}

@property (nonatomic, assign) id<ASWebViewDelegate> ASDelegate;
@end

@protocol ASWebViewDelegate<NSObject>

- (void)webView:(ASWebView *)webView updateStatus:(NSInteger)totalRequest requestLoaded:(NSInteger)loadedRequest startLoadTime:(NSTimeInterval)startTime;

@end

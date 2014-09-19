//
//  LFWebView.m
//  Untitled
//
//  Created by dhc on 11-12-19.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import "ASWebView.h"

@interface UIWebView(ASUseForNoWarning)
- (id)webView:(id)sender identifierForInitialRequest:(NSURLRequest *)aRequest fromDataSource:(id)dataSource;
- (NSURLRequest *)webView:(id)sender resource:(id)identifier willSendRequest:(NSURLRequest *)aRequest
		 redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(id)dataSource;
- (void)webView:(id)sender resource:(id)identifier didFinishLoadingFromDataSource:(id)dataSource;
- (void)webView:(id)sender resource:(id)identifier didFailLoadingWithError:(NSError *)error fromDataSource:(id)dataSource;
@end


@interface ASWebView()
- (void)clearState;
- (void)updateLoadStatus;
@end


@implementation ASWebView

@synthesize ASDelegate;

- (id) initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self != nil) {
        [self clearState];
    }
    return self;
}

- (void) dealloc
{
    ASDelegate = nil;
    [super dealloc];
}

- (void)loadRequest:(NSURLRequest *)request
{
    [self clearState];
    startTime = [[NSDate date] timeIntervalSince1970];
    return [super loadRequest:request];
}

- (void)clearState
{
    resourceCount = 0;
    loadCount = 0;
    startTime = 0;
    endTime = 0;    
}

- (void)updateLoadStatus
{
    if (loadCount == resourceCount)
    {
        endTime = [[NSDate date] timeIntervalSince1970];
    }
    
    if (ASDelegate && [ASDelegate respondsToSelector:@selector(webView:updateStatus:requestLoaded:startLoadTime:)])
        [ASDelegate webView:self updateStatus:resourceCount requestLoaded:loadCount startLoadTime:startTime];
}

- (id)webView:(id)sender identifierForInitialRequest:(NSURLRequest *)aRequest fromDataSource:(id)dataSource
{
	//		you can start a new  page load progress here,however it is not really exact.but just can get through
	if (fabs(endTime) > 0.000001)
	{
		[self clearState];
		startTime = [[NSDate date] timeIntervalSince1970];
	}
    
    resourceCount++;
    [self updateLoadStatus];
	return [super webView:sender identifierForInitialRequest:aRequest fromDataSource:dataSource];
}

//- (NSURLRequest *)webView:(id)sender resource:(id)identifier willSendRequest:(NSURLRequest *)aRequest
//		 redirectResponse:(NSURLResponse *)redirectResponse fromDataSource:(id)dataSource
//{
//	return [super webView:sender resource:identifier willSendRequest:aRequest
//						redirectResponse:redirectResponse fromDataSource:dataSource];
//}

- (void)webView:(id)sender resource:(id)identifier didFinishLoadingFromDataSource:(id)dataSource
{
    loadCount++;
    [self updateLoadStatus];
	return [super webView:sender resource:identifier didFinishLoadingFromDataSource:dataSource];
}

- (void)webView:(id)sender resource:(id)identifier didFailLoadingWithError:(NSError *)error fromDataSource:(id)dataSource
{
    loadCount++;
    [self updateLoadStatus];
	return [super webView:sender resource:identifier didFailLoadingWithError:error fromDataSource:dataSource];
}

@end

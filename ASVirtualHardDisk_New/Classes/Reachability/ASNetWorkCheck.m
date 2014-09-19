//
//  ASNetWorkCheck.m
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-18.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import "ASNetWorkCheck.h"
#import "Reachability.h"
#import "ASNetWorkCheck.h"
//#import "ASDeclare.h"

@implementation ASNetWorkCheck

+(BOOL)isExistenceNetwork
{
//	declare = [ASDeclare singletonASDeclare];
	BOOL isExistenceNetwork = FALSE;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwork=FALSE;
			//   NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
			isExistenceNetwork=FALSE;
			//   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
			isExistenceNetwork=TRUE;
			//  NSLog(@"正在使用wifi网络");        
            break;
    }
//	if (!isExistenceNetwork) {
//		
//		UIAlertView *myalert = [[UIAlertView alloc] 
//								initWithTitle:declare.alertWarning
//								message:declare.alertMessage 
//								delegate:self 
//								cancelButtonTitle:declare.alertSure
//								otherButtonTitles:nil];
//		[myalert show];
//		[myalert release];
//	}
	return isExistenceNetwork;
}


@end

//
//  ASRecvBroadCast.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CFSocket.h>
#import <sys/socket.h>
#import <sys/types.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <stdio.h>
#import <stdlib.h>
#import <unistd.h>
#import <netdb.h>

@interface ASRecvBroadCast : NSObject {
	//store the avaliable pc
	//NSMutableArray *avaliablePCArray;
	
	//store the info for pc
	NSMutableDictionary *infoForAvaliablePC;
	
	//socket for listen
	int sockListen;
	
	//the loacl ip for sending to pc
	NSString *localAddress;
	
	//sockaddr_in struct used to listen
	struct sockaddr_in address;
	
	//mark if needs to recv
	BOOL needRecv;
	
	//a thread to recv broadCast
	NSThread *recvThread;
}

@property (nonatomic, retain) NSMutableDictionary *infoForAvaliablePC;
//@property (nonatomic, retain) NSMutableArray *avaliablePCArray;
@property (nonatomic, retain) NSString *localAddress;
@property (nonatomic, retain) NSThread *recvThread;
@property struct sockaddr_in address;
@property int sockListen;
@property BOOL needRecv;

- (void) initSocket;
- (void) startRecvBroadCast:(id)array;
- (void) stopRecv;
- (void) sendMessage:(NSString *) remoteIp;

@end

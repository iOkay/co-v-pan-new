//
//  ASRecvBroadCast.m
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-10.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ASRecvBroadCast.h"


@implementation ASRecvBroadCast

@synthesize infoForAvaliablePC;
//@synthesize avaliablePCArray;
@synthesize recvThread;
@synthesize localAddress;
@synthesize address;
@synthesize sockListen;
@synthesize needRecv;

//------------------------------------------------------------------------------
// - (NSString *) localIPAddress
// get the ip address of local
//------------------------------------------------------------------------------
- (NSString *) localIPAddress
{
	char baseHostName[255]="";
	gethostname(baseHostName, 255);
	
	struct hostent *host = gethostbyname(baseHostName);
    if (host == NULL)
	{
        herror("resolv");
		return NULL;
	}
    else {
        struct in_addr **list = (struct in_addr **)host->h_addr_list;
		return [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
    }
	
	return NULL;
}

- (id) init{
	if (self = [super init]) {
		//avaliablePCArray = [[NSMutableArray alloc]init];
		infoForAvaliablePC = [[NSMutableDictionary alloc]init];
	}
	return self;
}

- (void) initSocket{
	if((self.sockListen = socket(AF_INET, SOCK_DGRAM, 0)) == -1)
	{
		perror("socket");
		exit(1);
	}
	
	localAddress = [self localIPAddress];
	
	address.sin_family = AF_INET;
	address.sin_addr.s_addr = htonl(INADDR_ANY);
	address.sin_port = htons(1535);	
	
	if(bind(sockListen, (struct sockaddr_in*) &address, sizeof(address)) != 0){
		printf("Cant't bind socket to local port!\n");
		return ;
	}

}

- (void) recvBroadCast:(id)array{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	char cRecvBuff[1024];
	struct sockaddr_in saClient;
	int nSize, nbSize;
	[self initSocket];
	NSLog(@"%@",array);
	
	
	if([infoForAvaliablePC count]){
		//[avaliablePCArray removeAllObjects];
		[infoForAvaliablePC removeAllObjects];
	}
	
	while (needRecv) {
		nSize = sizeof(struct sockaddr_in);
		nbSize = recvfrom(sockListen, cRecvBuff, 1024, 0, (struct sockaddr_in*) &saClient, &nSize);
		if (nbSize == -1) {
			printf("address = %s\r",inet_ntoa(saClient.sin_addr));
			printf("Recv Error!\n");
			break;
		}
		
		//cRecvBuff[nbSize] = '\0';
		
		NSString *remoteName = [NSString stringWithCString:cRecvBuff];
		
		NSString *remoteIP = [NSString stringWithCString:inet_ntoa(saClient.sin_addr)];		
        
	}
	
	[pool release];
}

- (void) startRecvBroadCast:(id)array{
	NSLog(@"Start thread");
	recvThread = [[NSThread alloc] initWithTarget:self selector:@selector(recvBroadCast:) object:array];
	if (recvThread == nil) {
		NSLog(@"Thread bad");
		return ;
	}
	needRecv = YES;
	[recvThread start];
	
}

- (void) stopRecv{
	close(sockListen);
	[recvThread release];
	recvThread = nil;
}

- (void) sendMessage:(NSString *)remoteIp{
	int sockSend;
	struct sockaddr_in	sendAddr;

	char ip[128];
	strcpy(ip,[remoteIp UTF8String]);
	
	if ((sockSend = socket(AF_INET, SOCK_DGRAM, 0)) == -1) {
		NSLog(@"Socket Error");
		return ;
	}
	
	int conn;
	size_t dataSended;
	
	sendAddr.sin_family = AF_INET;
	sendAddr.sin_addr.s_addr = inet_addr(ip);
	sendAddr.sin_port = htons(1535);
	
	conn = connect(sockSend, (struct sockaddr_in *) &sendAddr, sizeof(struct sockaddr_in));
	if (conn == -1) {
		NSLog(@"Connect error.");
	}
	
	for(int i = 0; i < 50; i++){
		dataSended = send(sockSend, ip, strlen(ip), 0);
		if (dataSended == -1) {
			NSLog(@"Send data error.");
		}
	}
	
 }

- (void) dealloc {
	//[avaliablePCArray release];
	[infoForAvaliablePC release];
	[localAddress release];
	sockListen = NULL;
	[super dealloc];
}

@end

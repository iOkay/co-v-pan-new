//
//  ASBluetoothStatusManager.m
//  ASVirtualHardDisk
//
//  Created by wang qiushuang on 12-4-1.
//  Copyright 2012年 AlphaStudio. All rights reserved.
//

#import "ASBluetoothStatusManager.h"

#import "ASBluetoothConnectingStatus.h"
#import "ASBluetoothDisconnectedStatus.h"
#import "ASBluetoothReceiveRequestStatus.h"
#import "ASBluetoothReceivingStatus.h"
#import "ASBluetoothRequestSendFileStatus.h"
#import "ASBluetoothSendingStatus.h"
//#import "ASBluetoothShowAvailablePeersStatus.h"
#import "ASBluetoothUnavailableStatus.h"

#import "ASBluetoothViewController.h"
#import "ASBluetoothDataHandler.h"
#import "ASZipEx.h"
#import "ASDataObjectManager.h"
#import "ASNewFileName.h"

@implementation ASBluetoothStatusManager

@synthesize status;

#pragma mark - cycle life
- (id)init
{
    self = [super init];
    if (self) {
        connectingStatus = [[ASBluetoothConnectingStatus alloc]
                            init];
        disconnectedStatus = [[ASBluetoothDisconnectedStatus alloc]
                              init];
        receiveRequestStatus = [[ASBluetoothReceiveRequestStatus alloc]
                                init];
        receivingStatus = [[ASBluetoothReceivingStatus alloc]
                           init];
        requestSendFileStatus = [[ASBluetoothRequestSendFileStatus alloc]
                                 init];
        sendingStatus = [[ASBluetoothSendingStatus alloc]
                         init];
        //showAvailablePeersStatus = [[ASBluetoothShowAvailablePeersStatus alloc]
        //                            init];
        unavailableStatus = [[ASBluetoothUnavailableStatus alloc]
                             init];
        
        status = disconnectedStatus;
    }
    
    return self;
}

- (void) dealloc
{
    [connectingStatus release];
    [disconnectedStatus release];
    [receiveRequestStatus release];
    [receivingStatus release];
    [requestSendFileStatus release];
    [sendingStatus release];
    //[showAvailablePeersStatus release];
    [unavailableStatus release];
    
    status = nil;
    
    [super dealloc];
}

#pragma mark - ChageTo
- (void)changeToConnectingStatus
{
    status = connectingStatus;
    [status configView];
}
- (void)changeToDisconnectedStatus
{
    [status disconnectCurrentPeer];
    status = disconnectedStatus;
}
- (void)changeToReceiveRequestStatus
{
    status = receiveRequestStatus;
}
- (void)changeToRequestSendFileStatus
{
    status = requestSendFileStatus;
    [status configView];
    ASBluetoothViewController * bluetoothViewController = [ASBluetoothViewController sharedManager];
    NSInteger numberOfFile = [bluetoothViewController.filePathArray count];
    [ASBluetoothDataHandler sendNumberOfFiles:numberOfFile];
}
- (void)changeToReceivingStatus
{
    status = receivingStatus;
    [status configView];
    
    //设置接收文件的路径
    ASBluetoothViewController * bluetoothViewController = 
    [ASBluetoothViewController sharedManager];
    
    NSString *peerName = [bluetoothViewController.theSession
                          displayNameForPeer:bluetoothViewController.currentConfPeerID];
    
    NSString *tempfileName = [[NSString alloc] initWithFormat:@"from%@.zip",peerName];
    ASDirectoryEx *directory = [[ASDirectoryEx alloc] initWithFullPath:@"/Received/"];
    NSString *fileName = [ASNewFileName nameOfNewFile:tempfileName
                                          toDirectory:directory];
    [directory release];
    [tempfileName release];
    
    ASDataObjectManager *dataObjectManager = 
    [ASDataObjectManager sharedDataManager];
    
    NSMutableString *filePath = [[NSMutableString alloc] 
                                initWithString:[dataObjectManager getRootPath]];
    
    [filePath appendFormat:@"/Received/%@",fileName];
    
    ((ASBluetoothReceivingStatus *)status).filePath = filePath;
    
    //handle
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        
    [filePath release];
}
- (void)changeToSendingStatus
{
    status = sendingStatus;
    [status configView];
    
    //压缩文件
    ASBluetoothViewController * bluetoothViewController = 
    [ASBluetoothViewController sharedManager];

    ASZipEx *aszip = [ASZipEx sharedASZipEx];

    NSString *zipPath = [[NSString alloc] initWithFormat:@"%@/Library/BluetoothTemp.zip",NSHomeDirectory()];
    [aszip zipFiles:bluetoothViewController.filePathArray
              toZip:zipPath
   currentDirectory:bluetoothViewController.currentDirectory];

    //发送第一个包
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:zipPath];
    ((ASBluetoothSendingStatus *)status).fileHandle = fileHandle;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:zipPath
                                                             error:nil];
    
    ((ASBluetoothSendingStatus *)status).filePath = zipPath;
    ((ASBluetoothSendingStatus *)status).fileSize = [attributes fileSize];
    ((ASBluetoothSendingStatus *)status).sizeHasSended = 0;
    [status sendData];
    
    [zipPath release];
}
//- (void)changeToShowAvailablePeersStatus
//{
//    status = showAvailablePeersStatus;
//}
- (void)changeToUnavailableStatus
{
    status = unavailableStatus;
    [status configView];
}
@end

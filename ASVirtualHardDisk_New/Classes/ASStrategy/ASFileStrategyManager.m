//------------------------------------------------------------------------------
// Filename:        ASFileStrategyManager.m
// Project:         ASStrategy
// Author:          wangqiushuang
// Date:            11-10-22
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------

// Quote header files.

#import "ASDataObject.h"
#import "ASDirectoryStrategy.h"
#import "ASFileStrategy.h"
#import "ASFileStrategyManager.h"
#import "ASFileType.h"
#import "ASPictureStrategy.h"
#import "ASReaderStrategy.h"
#import "ASTextStrategy.h"
#import "ASZipStrategy.h"
#import "ASCanNotOpenStrategy.h"

#import "ASVideoStrategy.h"
#import "ASMusicStrategy.h"


@interface ASFileStrategyManager()
-(id) init;
@end

static ASFileStrategyManager *sharedInstance;

@implementation ASFileStrategyManager

@synthesize strategis;

+ (ASFileStrategyManager *) sharedASFileStrategyManager
{
	if (nil == sharedInstance) {
		sharedInstance = [[ASFileStrategyManager alloc] init];
	}
	
	return sharedInstance;
}

- (void) dealloc
{
	[strategis release];
	[super dealloc];
}

- (id) init
{
	self = [super init];
	if (self) {
		id<ASFileStrategy> textStrategy = [[ASTextStrategy alloc] init];
		id<ASFileStrategy> readerStrategy = [[ASReaderStrategy alloc] init];
		id<ASFileStrategy> zipStrategy = [[ASZipStrategy alloc] init];
		id<ASFileStrategy> pictureStrategy = [[ASPictureStrategy alloc] init];
        id<ASFileStrategy> directoryStrategy = [[ASDirectoryStrategy alloc] init];
		id<ASFileStrategy> canNotOpenStrategy = [[ASCanNotOpenStrategy alloc] init];
        
        //add by dou 
        id<ASFileStrategy> videoStrategy = [[ASVideoStrategy alloc] init];
        id<ASFileStrategy> musicStrategy = [[ASMusicStrategy alloc] init];
        
		NSArray *strategyArray = [[NSArray alloc] initWithObjects:
								  directoryStrategy,//kDirectory
								  musicStrategy,//kMP3
								  readerStrategy,//kPDF
								  canNotOpenStrategy,//kEpub
								  pictureStrategy,//kPNG
								  pictureStrategy,//kPicture
								  readerStrategy,//kDoc
								  readerStrategy,//kExcle
								  readerStrategy,//kPPT
								  zipStrategy,//kZip
								  videoStrategy,//canNotOpenStrategy,//kVideo
								  canNotOpenStrategy,//kUnknow
								  textStrategy,//kTXT
								  canNotOpenStrategy,//kRTF
								  readerStrategy,//kGIF
								  nil];
		[textStrategy release];
		[readerStrategy release];
		[zipStrategy release];
		[pictureStrategy release];
        [directoryStrategy release];
        [canNotOpenStrategy release];
        [musicStrategy release];
        [videoStrategy release];
    
		NSArray *keyArray = [[NSArray alloc] initWithObjects:
							 [NSNumber numberWithInt:kDirectory],
							 [NSNumber numberWithInt:kMP3],
							 [NSNumber numberWithInt:kPDF],
							 [NSNumber numberWithInt:kEpub],
							 [NSNumber numberWithInt:kPNG],
							 [NSNumber numberWithInt:kPicture],
							 [NSNumber numberWithInt:kDoc],
							 [NSNumber numberWithInt:kExcle],
							 [NSNumber numberWithInt:kPPT],
							 [NSNumber numberWithInt:kZip],
							 [NSNumber numberWithInt:kVideo],
							 [NSNumber numberWithInt:kUnknow],
							 [NSNumber numberWithInt:kTXT],
							 [NSNumber numberWithInt:kRTF],
							 [NSNumber numberWithInt:kGIF],
							 nil]; //需要改为file的类型的

		
		strategis = [[NSDictionary alloc] initWithObjects:strategyArray forKeys:keyArray];
		
		[strategyArray release];
		[keyArray release];
	}
	return self;
}
-(void) execOnState:(ASTableViewCellState)state
   inViewController:(UIViewController *)viewController 
	 withDataObject:(id<ASDataObject>)dataObject
{
    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    
	NSInteger type = [dataObject getFileType];
	
	id<ASFileStrategy> strategy = 
	[strategis objectForKey:[NSNumber numberWithInt:type]];
	
	[strategy execOnState:state inViewController:viewController withDataObject:dataObject];
}
@end

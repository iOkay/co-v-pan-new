
//  ASReaderViewController.m
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-9-15.
//  Copyright 2011年 AlphaStudio. All rights reserved.


#import "ASReaderViewController.h"
#import "ASFileEx.h"
#import "ASFileType.h"
#import "ASLocalDefine.h"

@interface ASReaderViewController() 
- (void) loadContentIntoWebView;
@end


@implementation ASReaderViewController

@synthesize displayView;
//@synthesize filePath;
@synthesize button;
@synthesize file;

-(void)loadFile: (NSString*)aPath
{
    self.displayView.scalesPageToFit = YES;
    NSURL *fileURL = [NSURL fileURLWithPath: aPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
    [self.displayView loadRequest:request];

}

//------------------------------------------------------------------------------
//- (void)loadContentIntoWebView:(NSString *)path
//  used to display the content of the file
//------------------------------------------------------------------------------
- (void) loadContentIntoWebView
{
	NSMutableString *ap = [[NSMutableString alloc] initWithString:NSHomeDirectory()];
	[ap appendString:@"/Documents/"];
	[ap appendString:[file getFullItemName]];
	
    if(file.fileStyle == kGIF)
    {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:ap];
        CGSize size = image.size;

        
        if(size.width > 320.0f || size.height > 460.0f)
        {
        }
        else
        {
            CGRect frame = CGRectMake((320.0f-size.width)/2,
                                      (460.0f-44.0f-size.height)/2, 
                                      size.width,
                                      size.height+50.0f);
            
            displayView.frame = frame;
        }
        
        NSData *gifData = [[NSData alloc] 
                           initWithContentsOfFile:ap];
        
        [displayView loadData:gifData MIMEType:@"image/gif" 
             textEncodingName:nil baseURL:nil];

        [gifData release];
        gifData = nil;
        [image release];
        image = nil;
    }
    else
    {
        self.displayView.scalesPageToFit = YES;
        NSURL *fileURL = [NSURL fileURLWithPath:ap];
        NSLog(@"%@", ap);
        NSURLRequest *request = [NSURLRequest requestWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
        [self.displayView loadRequest:request];
    }
	[ap release];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        /*self.displayView.userInteractionEnabled = YES;
        self.displayView.delegate = self;*/
        
    }
    return self;
}


- (void)dealloc
{
    [file release];
    [displayView release];
    [button release];

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{    
	[super viewDidLoad];
    picOrPDF = 1;
    if (file != nil)
    {
        [self loadContentIntoWebView];
    }
    currentDirectory = file;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
	self.file = nil;
    self.displayView = nil;
	self.button = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(void) printPressed:(id)sender
{
    UIPrintInteractionController *controller = [UIPrintInteractionController
                                                sharedPrintController]; 
    if(!controller){
        NSLog(@"Couldn't get shared UIPrintInteractionController!"); 
        return;
    } 
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error){
        if(!completed && error){
            NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
        }
    };
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"PDF";//[textField text];
    printInfo.duplex = UIPrintInfoDuplexLongEdge; 
    controller.printInfo = printInfo; 
    controller.showsPageRange = YES;
    
    UIViewPrintFormatter *viewFormatter = [self.displayView viewPrintFormatter];
    viewFormatter.startPage = 0; 
    controller.printFormatter = viewFormatter;
    
    [controller presentAnimated:YES completionHandler:completionHandler];
}

@end

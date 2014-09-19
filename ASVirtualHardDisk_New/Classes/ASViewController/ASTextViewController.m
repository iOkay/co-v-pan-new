//------------------------------------------------------------------------------
// Filename:        ASTextViewController.m
// Project:         ASVirtualHardDisk
// Author:          wangqiushuang
// Date:            11-9-15
// Version:         
// Copyright 2011 Alpha Studio. All rights reserved. 
//------------------------------------------------------------------------------

// Quote header files.
#import "ASTextViewController.h"
#import "ASDeclare.h"
#import "ASLocalDefine.h"
#import "ASFileEx.h"

@implementation ASTextViewController
@synthesize textView;
@synthesize textPath;
@synthesize file;

-(void) printPressed:(id)sender
{
    UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
    if(!controller){
        NSLog(@"Couldn't get shared UIPrintInteractionController!");
        return;
    }
    UIPrintInteractionCompletionHandler completionHandler = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if(completed && error)
            NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
    };
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"txt";//[textField text];
    printInfo.duplex = UIPrintInfoDuplexLongEdge; 
    controller.printInfo = printInfo; 
    controller.showsPageRange = YES;
    
    UIViewPrintFormatter *viewFormatter = [self.textView viewPrintFormatter];
    viewFormatter.startPage = 0; 
    controller.printFormatter = viewFormatter;
    
    [controller presentAnimated:YES completionHandler:completionHandler];
}

- (void) saveFile
{
    if (0 != encoding) 
    {
        if (![[NSFileManager defaultManager] fileExistsAtPath: textPath])
        {
            [[NSFileManager defaultManager] createFileAtPath: textPath contents: nil attributes: nil];
        }
        NSFileHandle *textFile = [NSFileHandle fileHandleForWritingAtPath:textPath];
        NSString *string = [textView.text copy];
        NSData *data =[string dataUsingEncoding:encoding];
        [textFile writeData:data];
        [textFile truncateFileAtOffset:[data length]];
        [string release];
        [textFile closeFile];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification 
{

    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	
    CGSize kbSize=[aValue CGRectValue].size;
    CGRect newRect = textView.frame;
    
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait||
        self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) 
    {
        newRect.size.height = 416 - kbSize.height;
    }
    else
    {
        newRect.size.height = 268 - kbSize.width;
    }
    
    textView.frame = newRect;
    
	UIBarButtonItem *bookMark = [[UIBarButtonItem alloc]
								 initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
								 target:self 
								 action:@selector(done)];
	self.navigationItem.rightBarButtonItem = bookMark;
	[bookMark release];	
}
-(void)done
{
	[textView resignFirstResponder];
	self.navigationItem.rightBarButtonItem = nil;
	if(self.interfaceOrientation == UIInterfaceOrientationPortrait ||
       self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        textView.frame = CGRectMake(0, 0, 320, 416);
    else
        textView.frame = CGRectMake(0, 0, 480, 268);
    textFieldDidChanged = NO;
    [self saveFile];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if(file != nil)
    {
        currentDirectory = file;
    }
}

- (void) textViewTextDidChanged
{
    textFieldDidChanged = YES;
}

- (void) waitForResponder
{
    if (nil == textPath) {
		@throw [NSException exceptionWithName:@"MoviePathIsNil" reason:@"MoviePathIsNil" userInfo:nil];
	}
	else 
    {
        if (YES == textFieldDidChanged) 
        {
            [textView resignFirstResponder];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAlertWarning
                                                            message:KAltermofiy                                                           delegate:self
                                                  cancelButtonTitle:kDeleteFileAlertCancel
                                                  otherButtonTitles:KSave, nil];
            [alert show];
            [alert release];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }

	}
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.alpha = 0.9;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self.navigationController setToolbarHidden:NO];
//    scanbar.hidden = NO;
//    scanbar.tintColor = [UIColor blackColor];
//    scanbar.alpha = 0.9;
//    scanbar.barStyle = UIBarStyleBlack;
//    scanbar.translucent = NO;
//    if (self.interfaceOrientation==UIInterfaceOrientationPortrait||
//        self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
//    {
//        scanbar.frame = CGRectMake(0, 372, 320, 44);
//    }
//    else
//    {
//        scanbar.frame = CGRectMake(0, 236, 480, 32);
//    }
    
    self.navigationItem.title = [textPath lastPathComponent];
    
	if (nil == textPath) {
		@throw [NSException exceptionWithName:@"MoviePathIsNil" reason:@"MoviePathIsNil" userInfo:nil];
	}
	else {
		NSFileHandle *textFile = [NSFileHandle fileHandleForReadingAtPath:textPath];
        [textFile seekToFileOffset:0];
		NSData *data = [textFile readDataToEndOfFile];
		[textFile closeFile];
		NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];//NSStringEncoding
        NSLog(@"%i",[string length]);
		encoding = NSUTF8StringEncoding;
		if(nil == string)
		{
			NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
			string = [[NSString alloc] initWithData:data encoding:enc];
			encoding = enc;
		}
        if(nil == string)
        {
            string = [[NSString alloc] initWithData:data encoding:NSUTF16StringEncoding];
            encoding = NSUTF16StringEncoding;
        }
		if (nil == string) {
			encoding = 0;
			textView.editable = NO;
			UILabel *label = [[UILabel alloc] init];
			label.frame = CGRectMake(0, 70, 320, 55);
			label.text = KNotOpen;
			label.textAlignment = UITextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:20];
			[self.view addSubview:label];
			[label release];
		}
		else {
			textView.text = string;
			[string release];
		}
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] 
                                       initWithTitle:[[ASDeclare singletonASDeclare] navBack]
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(waitForResponder)];
        
        self.navigationItem.leftBarButtonItem = leftButton;
        [leftButton release];
        
        textFieldDidChanged = NO;
        
        [[NSNotificationCenter defaultCenter] 
         addObserver:self 
         selector:@selector(textViewTextDidChanged) 
         name:UITextViewTextDidChangeNotification 
         object:self.textView];
	}
}

- (void) handleSingleTap: (UITapGestureRecognizer *)sender
{
    return ;
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
//    if (interfaceOrientation==UIInterfaceOrientationPortrait||
//        interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
//    {
//        scanbar.frame = CGRectMake(0, 372, 320, 44);
//    }
//    else
//    {
//        scanbar.frame = CGRectMake(0, 236, 480, 32);
//    }
}

#pragma mark -
#pragma mark Alert Delegate Method
//------------------------------------------------------------------------------
//   - (void)alertView:(UIAlertView *)alertView 
//clickedButtonAtIndex:(NSInteger)buttonIndex
//------------------------------------------------------------------------------
- (void)alertView:(UIAlertView *)alertView 
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(KTAGOFDELETEALERT == alertView.tag)
    {
        //delete file finally
        if(0 == buttonIndex)
        {
            id<ASDataObject> dataObj = currentDirectory;
            [dataObj remove];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if(1 == buttonIndex)
        {
            ;
        }
    }
    else
    {
    
        if(0 == buttonIndex)
        {
            NSLog(@"%@",kDeleteFileAlertCancel);
        }
        else if(1 == buttonIndex)
        {
            [self saveFile];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
	[[NSNotificationCenter defaultCenter] 
        removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	self.textView = nil;
	self.textPath = nil;
    self.file = nil;
    
    [super viewDidUnload];
}


- (void)dealloc 
{
	[textPath release];
	[textView release];
    [file release];
    [super dealloc];
}


@end

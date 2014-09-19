//
//  ASPictureViewController.m
//  ASVirtualHardDisk
//
//  Created by dai yunxing on 11-9-16.
//  Copyright 2011年 AlphaStudio. All rights reserved.
//

#import "ASPictureViewController.h"
#import "ASFileEx.h"
#import "ASImageResize.h"
#import "ASLocalDefine.h"

@interface ASPictureViewController (private)
-(void) setRotatePictureSize:(UIImageView *)aImgView;
-(void) pictureRotate:(int)aType;
-(void) reSetScrollView:(UIImage *)aImg;
@end

@implementation ASPictureViewController

static ASPictureViewController * pictureControl = nil;

@synthesize sv;
@synthesize pictureToDisplay;
@synthesize startIndex;
@synthesize totalPages=totalPages_;
@synthesize imgViewArray;
@synthesize mImgView;
@synthesize rotateView;
@synthesize isRotated;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [pictureToDisplay release];
    [imgViewArray release];
    [mImgView release];
    [sv release];
	[rotateView release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



+ (id) getPictureControlSingleObject
{
    if(pictureControl == nil)
        pictureControl = [[ASPictureViewController alloc] init];
    
    return pictureControl;
}

-(CGSize)setScrollViewBeginDragging:(CGSize)aSize
{
    CGSize size;
    if(self.interfaceOrientation == UIInterfaceOrientationPortrait ||
       self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        size.width = KFrame_Size_Width/2 - aSize.width/2;
        size.height = KFrame_Size_Height/2- aSize.height/2;
    }
    else
    {
        size.width = KFrame_Landspace_Size_Width/2- aSize.width/2;
        size.height = KFrame_Landspace_Size_Height/2 - aSize.height/2;
        
    }
    
    return size;
    
}


-(CGSize)setLandScapeImgViewLocation:(UIImageView *)aImgView
{
    CGSize size = aImgView.image.size;
    
    float picShape = size.height / size.width;
	if (picShape >= KPicture_Landspace_Size_Height / KPicture_Landspace_Size_Width) 
	{
		size.height = KPicture_Landspace_Size_Height;
		size.width = KPicture_Landspace_Size_Height / picShape;
	}
	else 
	{
		size.width = KPicture_Landspace_Size_Width;
		size.height = KPicture_Landspace_Size_Width * picShape;
	}
    
    return size;
}


-(void)getLandScapeImgViewLocation:(UIImageView *)aImgView andIndex:(int)index
{
    aImgView.image = [[imgViewArray objectAtIndex:index] image];
    CGSize lsize = [self setLandScapeImgViewLocation:[imgViewArray objectAtIndex:index]];
    CGSize lsize2 = [self setScrollViewBeginDragging:lsize];
    [aImgView setFrame:CGRectMake(lsize2.width, lsize2.height,lsize.width, lsize.height)];
}

- (void) setStyleOftheToolBar
{
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.translucent = YES;
    self.navigationController.toolbar.alpha = 0.7f;
}

//------------------------------------------------------------------------------
// - (void) showPictureInLandspaceView
//------------------------------------------------------------------------------
- (void) showPictureInLandspaceView
{
    totalPages_ = [pictureToDisplay count];
    if(imgViewArray)
    {
        [imgViewArray removeAllObjects];
        [imgViewArray release];
        imgViewArray = nil;
    }
    imgViewArray = [[NSMutableArray alloc] init];
    if(sv != nil)
    {
        [sv removeFromSuperview];
        [sv release];
        sv = nil;
    }
    
    self.navigationController.navigationBar.hidden = NO;
    
    sv = [[UIScrollView alloc] initWithFrame:
          CGRectMake(0.0f,
                     0.0f, 
                     KFrame_Landspace_Size_Width, 
                     KFrame_Landspace_Size_Height)];
    sv.contentSize = CGSizeMake(
                                3 *KFrame_Landspace_Size_Width,
                                sv.frame.size.height);
    sv.contentOffset = CGPointMake(480, 0);
    sv.pagingEnabled = YES;
    sv.delegate = self;
	
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv]; 
    
    for(int i = 0; i < totalPages_; i++)
    {
		ASFileEx *file = [pictureToDisplay objectAtIndex:i];
		
		NSMutableString *ap = [[NSMutableString alloc] initWithString:NSHomeDirectory()];
		[ap appendString:@"/Documents"];
		[ap appendString:[file getFullItemName]];
        
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:ap];
        [ap release];
        ap = nil;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imgViewArray addObject:imageView];        
        [imageView release];
        imageView = nil;
        [image release];
        image = nil;
    }
    if(mImgView)
    {
        [mImgView release];
        mImgView = nil;
    }
    mImgView =[[UIImageView alloc] init];
    
    [self getLandScapeImgViewLocation:mImgView andIndex:startIndex];
    [self.view addSubview:mImgView];
    [self.view bringSubviewToFront:mImgView];
    
    [self setStyleOftheToolBar];
}

-(CGSize)setImgViewLocation:(UIImageView *)aImgView
{

    CGSize size = aImgView.image.size;
	
    float picShape = size.height / size.width;
	if (picShape >= KPicture_Size_Height / KPicture_Size_Width) 
	{
		size.height = KPicture_Size_Height;
		size.width = KPicture_Size_Height / picShape;
	}
	else 
	{
		size.width = KPicture_Size_Width;
		size.height = KPicture_Size_Width * picShape;
	}
    
    return size;
}


-(void)getImgViewLocation:(UIImageView *)aImgView andIndex:(int)index
{
    aImgView.image = [[imgViewArray objectAtIndex:index] image];
    CGSize size = [self setImgViewLocation:[imgViewArray objectAtIndex:index]];
    CGSize size2 = [self setScrollViewBeginDragging:size];
    [aImgView setFrame:CGRectMake(size2.width, size2.height,size.width, size.height)];
    
}


-(void) loadFile: (NSString*)aPath
{
    self.navigationController.navigationBar.hidden = YES;
    
    sv = [[UIScrollView alloc] initWithFrame:
          CGRectMake(0.0f,
                     0.0f, 
                     KFrame_Size_Width, 
                     KFrame_Size_Height)];
    
    sv.contentSize = CGSizeMake(3* KFrame_Size_Width,
                                sv.frame.size.height);
    sv.contentOffset = CGPointMake(320, 0);
    sv.pagingEnabled = YES;
    sv.delegate = self;
    sv.backgroundColor = [UIColor blackColor];
    
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile: aPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    [imgViewArray addObject:imageView];
    
    [imageView release];
    [image release];
    if(mImgView)
    {
        [mImgView release];
        mImgView = nil;
    }
    mImgView =[[UIImageView alloc] init];
    
    [self.view addSubview:mImgView];
    [self.view bringSubviewToFront:mImgView];
}

//------------------------------------------------------------------------------
//- (void) showPictureInView
//------------------------------------------------------------------------------
- (void) showPictureInView
{
    totalPages_ = [pictureToDisplay count];
    if(imgViewArray)
    {
        [imgViewArray removeAllObjects];
        [imgViewArray release];
        imgViewArray = nil;
    }
    imgViewArray = [[NSMutableArray alloc] init];
    
    if(sv != nil)
    {
        [sv removeFromSuperview];
        [sv release];
        sv = nil;
    }
    
    self.navigationController.navigationBar.hidden = NO;
    
    
    sv = [[UIScrollView alloc] initWithFrame:
          CGRectMake(0.0f,
                     0.0f, 
                     KFrame_Size_Width, 
                     KFrame_Size_Height)];
    
    sv.contentSize = CGSizeMake(3* KFrame_Size_Width,
                                sv.frame.size.height);
    sv.contentOffset = CGPointMake(320, 0);
    sv.pagingEnabled = YES;
    sv.delegate = self;
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv];
    
    for(int i = 0; i < totalPages_; i++)
    {
        ASFileEx *file = [pictureToDisplay objectAtIndex:i];
		
		NSMutableString *ap = [[NSMutableString alloc] initWithString:NSHomeDirectory()];
		[ap appendString:@"/Documents"];
		[ap appendString:[file getFullItemName]];
		
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:ap];
        [ap release];
        ap = nil;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        [imgViewArray addObject:imageView];
        
        [imageView release];
        imageView = nil;
        [image release];
        image = nil;
    }
    if(mImgView)
    {
        [mImgView release];
        mImgView = nil;
    }
    mImgView =[[UIImageView alloc] init];
    
    [self getImgViewLocation:mImgView andIndex:startIndex];
    [self.view addSubview:mImgView];
    [self.view bringSubviewToFront:mImgView];
    
    [self setStyleOftheToolBar];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    picOrPDF = 2;
    if (pictureToDisplay != nil)
    {
        UIInterfaceOrientation toOrienttation = self.interfaceOrientation;
        
        if(toOrienttation == UIInterfaceOrientationPortrait ||
           toOrienttation == UIInterfaceOrientationPortraitUpsideDown)
        {
            [self showPictureInView];
        }
        else if(toOrienttation == UIInterfaceOrientationLandscapeLeft ||
                toOrienttation == UIInterfaceOrientationLandscapeRight)
        {
            [self showPictureInLandspaceView];
        }
        
        currentDirectory = [pictureToDisplay objectAtIndex:startIndex];
    }
	self.isRotated = NO;
//	UIBarButtonItem *item = [scanbar.items objectAtIndex:2];
	UIBarButtonItem *item = [self.toolbarItems objectAtIndex:2];
    item.customView.hidden = NO;
//	item = [scanbar.items objectAtIndex:4];
    item = [self.toolbarItems objectAtIndex:4];
	item.customView.hidden = NO;
}

//- (void) viewWillLayoutSubviews
//{
//    self.isAppear = YES;

//    if (self.interfaceOrientation==UIInterfaceOrientationPortrait||
//        self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
//    {
//        [self showPictureInView];
//        self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 44);
////        scanbar.frame = CGRectMake(0, 436, 320, 44);
//    }
//    else
//    {
//        [self showPictureInLandspaceView];
//        self.navigationController.navigationBar.frame = CGRectMake(0, 20, 480, 32);
////        scanbar.frame = CGRectMake(0, 288, 480, 32);
//    }
//}

- (void)viewDidUnload
{
    self.pictureToDisplay = nil;
	self.sv = nil;
    self.imgViewArray = nil;
	self.rotateView = nil;
    [super viewDidUnload];
}
//------------------------------------------------------------------------------
// - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//------------------------------------------------------------------------------
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

//------------------------------------------------------------------------------
// - (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//------------------------------------------------------------------------------
- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:interfaceOrientation
                                            duration:duration];
    
    if (interfaceOrientation==UIInterfaceOrientationPortrait||
        interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
    {
        [self showPictureInView];
//        self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 44);
//        scanbar.frame = CGRectMake(0, 436, 320, 44);
    }
    else
    {
        [self showPictureInLandspaceView];
//        self.navigationController.navigationBar.frame = CGRectMake(0, 20, 480, 32);
//        scanbar.frame = CGRectMake(0, 288, 480, 32);
    }
}

- (void)alertView:(UIAlertView *)alertView 
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(0 == buttonIndex)
    {
        [(id<ASDataObject>)[pictureToDisplay objectAtIndex:startIndex] remove];
        [pictureToDisplay removeObjectAtIndex:startIndex];
        totalPages_--;
        if(startIndex > totalPages_ || startIndex <= 0)
            startIndex = 0;
        else
            startIndex --;
        if(0 == [pictureToDisplay count])
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            UIInterfaceOrientation interfaceOrienttation = 
            [UIApplication sharedApplication].statusBarOrientation; 
            if(UIInterfaceOrientationPortrait == interfaceOrienttation ||
               UIInterfaceOrientationPortraitUpsideDown == interfaceOrienttation)
            {
                [self showPictureInView];
            }
            else
            {
                [self showPictureInLandspaceView];
            }
        }
    }
    else
    {
        ;
    }
}

#pragma mark -
#pragma mark scroll view delegate method

//通过scrollview委托来实现首尾相连的效果
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //开始滑动时，主imageview图片置空
    mImgView.image = nil;

    //scrollview上添加三个imageview
    //第一个imageview的图片为当前图片的前一张图片（如果当前图片为第一张则显示最后一张图片）
    //第二个imageview的图片为当前图片
    //第三个imageview的图片为当前图片的后一张图片（如果当前图片为最后一张则显示第一张图片）
	UIImageView *imView1 = nil;
	UIImageView *tempView1 = [imgViewArray objectAtIndex:(startIndex == 0 ? (totalPages_ - 1) : (startIndex - 1))];
	if (1 == totalPages_ || 2 == totalPages_) 
	{
		imView1 = [[UIImageView alloc] initWithImage:tempView1.image];
	}
	else
	{
		imView1 = tempView1;
	}
	
    UIImageView *imView2 = nil;
   	if (isRotated) 
	{
		imView2 = self.rotateView;
	}
	else 
	{
		imView2 = [imgViewArray objectAtIndex:startIndex];
	}
	
	UIImageView *imView3 = nil;
	UIImageView *tempView3 = [imgViewArray objectAtIndex:(startIndex == (totalPages_ - 1) ? 0 : (startIndex + 1))];
	if (1 == totalPages_) 
	{
		imView3 = [[UIImageView alloc] initWithImage:tempView3.image];
	}
	else 
	{
		imView3 = tempView3;
	}


    
	if(self.interfaceOrientation == UIInterfaceOrientationPortrait ||
       self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        CGSize size1 =[self setImgViewLocation:imView1];
        CGSize size11 = [self setScrollViewBeginDragging:size1];
        [imView1 setFrame:CGRectMake(size11.width, size11.height,size1.width, size1.height)];
        
        CGSize size2 =[self setImgViewLocation:imView2];
        CGSize size22 = [self setScrollViewBeginDragging:size2];
        [imView2 setFrame:CGRectMake(320.0+size22.width, size22.height, size2.width, size2.height)];
        
        CGSize size3 =[self setImgViewLocation:imView3];
        CGSize size33 = [self setScrollViewBeginDragging:size3];
        [imView3 setFrame:CGRectMake(640.0+size33.width, size33.height, size3.width, size3.height)];
        
        
        
        
    }
    else
    {
        CGSize lsize1 =[self setLandScapeImgViewLocation:imView1];
        CGSize lsize11 = [self setScrollViewBeginDragging:lsize1];
        [imView1 setFrame:CGRectMake(lsize11.width, lsize11.height,lsize1.width, lsize1.height)];
        
        CGSize lsize2 =[self setLandScapeImgViewLocation:imView2];
        CGSize lsize22 = [self setScrollViewBeginDragging:lsize2];
        [imView2 setFrame:CGRectMake(480.0+lsize22.width, lsize22.height, lsize2.width, lsize2.height)];
        
        CGSize lsize3 =[self setLandScapeImgViewLocation:imView3];
        CGSize lsize33 = [self setScrollViewBeginDragging:lsize3];
        [imView3 setFrame:CGRectMake(960.0+lsize33.width, lsize33.height, lsize3.width, lsize3.height)];
        
    }
    [self.sv addSubview:imView1];
    [self.sv addSubview:imView2];	
    [self.sv addSubview:imView3];
    
	if (1 == totalPages_) 
	{
		[imView1 release];
		[imView3 release];
	}
	if (2 == totalPages_) 
	{
		[imView1 release];
	}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if(self.interfaceOrientation == UIInterfaceOrientationPortrait ||
       self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        //scrollview结束滚动时判断是否已经换页
        if (self.sv.contentOffset.x > 320.0) {
            
            //如果是最后一张图片，则将主imageview内容置为第一张图片
            //如果不是最后一张图片，则将主imageview内容置为下一张图片
            if (startIndex < (totalPages_ - 1)) {
                startIndex ++;
                [self getImgViewLocation:mImgView andIndex:startIndex];
                
            } else {
                startIndex= 0;
                [self getImgViewLocation:mImgView andIndex:startIndex];
            }
            NSLog(@"current offset >320:%f", self.sv.contentOffset.x);
            
        } else if (self.sv.contentOffset.x < 320.0) {
            
            //如果是第一张图片，则将主imageview内容置为最后一张图片
            //如果不是第一张图片，则将主imageview内容置为上一张图片
            if (startIndex > 0) {
                startIndex--;
                [self getImgViewLocation:mImgView andIndex:startIndex];
            } else {
                startIndex = totalPages_ - 1;
                [self getImgViewLocation:mImgView andIndex:startIndex];
            }
            NSLog(@"current offset <320:%f", self.sv.contentOffset.x);
            
        } else {
            
            //没有换页，则主imageview仍然为之前的图片
            [self getImgViewLocation:mImgView andIndex:startIndex];
            NSLog(@"current offset :%f", self.sv.contentOffset.x);
        }
        
        //始终将scrollview置为第2页
        [self.sv setContentOffset:CGPointMake(320.0, 0.0)];
    }
    else
    {
        //scrollview结束滚动时判断是否已经换页
        if (self.sv.contentOffset.x > 480.0) {
            
            //如果是最后一张图片，则将主imageview内容置为第一张图片
            //如果不是最后一张图片，则将主imageview内容置为下一张图片
            if (startIndex < (totalPages_ - 1)) {
                startIndex ++;
                [self getLandScapeImgViewLocation:mImgView andIndex:startIndex];
                
            } else {
                startIndex= 0;
                [self getLandScapeImgViewLocation:mImgView andIndex:startIndex];
            }
            NSLog(@"current offset >320:%f", self.sv.contentOffset.x);
            
        } else if (self.sv.contentOffset.x < 480.0) {
            
            //如果是第一张图片，则将主imageview内容置为最后一张图片
            //如果不是第一张图片，则将主imageview内容置为上一张图片
            if (startIndex > 0) {
                startIndex--;
                [self getLandScapeImgViewLocation:mImgView andIndex:startIndex];
            } else {
                startIndex = totalPages_ - 1;
                [self getLandScapeImgViewLocation:mImgView andIndex:startIndex];
            }
            NSLog(@"current offset <320:%f", self.sv.contentOffset.x);
            
        } else {
            
            //没有换页，则主imageview仍然为之前的图片
            [self getLandScapeImgViewLocation:mImgView andIndex:startIndex];
            NSLog(@"current offset :%f", self.sv.contentOffset.x);
        }
        
        //始终将scrollview置为第2页
        [self.sv setContentOffset:CGPointMake(480.0, 0.0)];
        
    }
	
	
	
	//移除scrollview上的图片
    
	for (UIImageView *theView in [self.sv subviews]) {
		[theView removeFromSuperview];
	}
    self.isRotated = NO;
}

-(void) setRotatePictureSize:(UIImageView *)aImgView
{
	if (self.interfaceOrientation == UIInterfaceOrientationPortrait ||
		self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
	{
		CGSize picSize = [self setImgViewLocation:aImgView];
		CGSize borderSize = [self setScrollViewBeginDragging:picSize];
		[aImgView setFrame:CGRectMake(borderSize.width, borderSize.height, picSize.width, picSize.height)];
	}
	
	else
	{
		CGSize picSize = [self setLandScapeImgViewLocation:aImgView];
		CGSize borderSize = [self setScrollViewBeginDragging:picSize];
		[aImgView setFrame:CGRectMake(borderSize.width, borderSize.height, picSize.width, picSize.height)];
	}
}

-(void) reSetScrollView:(UIImage *)aImg
{
	UIImageView *imgView = [[UIImageView alloc] initWithImage:aImg];
	
	self.rotateView = imgView;
	self.isRotated = YES;
	
	[imgView release];
}

#pragma mark -
#pragma mark picture rotate methods

-(void) pictureRotate:(int)aType
{
	CGSize size = mImgView.image.size;
	
	UIGraphicsBeginImageContext(CGSizeMake(size.height, size.width));
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context, size.height/2, size.width/2);
	CGContextRotateCTM(context, M_PI/2*aType);
	CGContextScaleCTM(context, 1.0, -1.0);
	CGContextDrawImage(context, CGRectMake(-size.width/2, -size.height/2, size.width, size.height), [mImgView.image CGImage]);
	UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	[self reSetScrollView:newImg];
	
	mImgView.image = newImg;
	[self setRotatePictureSize:mImgView];
}

/*-(void) rotatePressed
{
	UIBarButtonItem *item = [scanbar.items objectAtIndex:2];
	item.customView.hidden = NO;
	item = [scanbar.items objectAtIndex:4];
	item.customView.hidden = NO;
}*/
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
    UIImage *image = mImgView.image;
    printInfo.outputType = UIPrintInfoOutputPhoto;
    printInfo.jobName = @"image";//[[self.imageURL path] lastPathComponent];
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    if(!controller.printingItem && image.size.width > image.size.height)
        printInfo.orientation = UIPrintInfoOrientationLandscape;    
    controller.printInfo = printInfo; 
    controller.printingItem = mImgView.image;
    [controller presentAnimated:YES completionHandler:completionHandler];
}

-(void) quarterCCWPressed
{
	[self pictureRotate:-1];
}

-(void) quarterCWPressed
{
	[self pictureRotate:1];
}

@end

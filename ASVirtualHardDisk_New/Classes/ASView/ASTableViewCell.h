//
//  ASTableViewCell.h
//  ASVirtualHardDisk
//
//  Created by Yunxing.D on 11-8-23.
//  Copyright 2011 AlphaStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASDataObject.h"
#import "HJManagedImageV.h"

@interface ASTableViewCell:UITableViewCell
{
 @private
    NSMutableString    *filePath;
	UITextField        *mainText;
    
    //for music play
    UISlider           *mp3Slider;
    HJManagedImageV    *iconView;
}

@property (nonatomic, retain) NSMutableString *filePath;
@property (nonatomic, retain) IBOutlet UITextField *mainText;
@property (nonatomic, retain) UISlider *mp3Slider;
@property (nonatomic, retain) HJManagedImageV *iconView;

/*
 @function   - (id) initWithStyle:(UITableViewCellStyle) style 
                     reuseIdentifier:(NSString *)reuseIdentifier
    @abstract   init the cell define by myself
    @param      (UITableViewCellStyle) style - the style for cell
                (NSString *) reuseIdentifier - the identifier for cell
    @result     id
*/
- (id)initWithStyle:(UITableViewCellStyle) style 
        reuseIdentifier:(NSString *)reuseIdentifier;

/*
    @function   - (void) confirmCell:
    @abstract   set the cell image
    @param      (id<ASDataObject>) aItem - the dataObject to display
    @result     void
*/
- (void)confirmCell:(id<ASDataObject>) aItem;

- (void)mp3TableViewCelldidSelect;
- (void)mp3TableViewCelldidDeselect;

@end

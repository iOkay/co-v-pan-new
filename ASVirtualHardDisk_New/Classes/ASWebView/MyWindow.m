//
//  MyWindow.m
//  NSWebView
//
//  Created by xiu on 11-11-6.
//  Copyright 2011年 __AlphaStudio__. All rights reserved.
//

#import "MyWindow.h"


@implementation MyWindow

- (void)tapAndHoldAction:(NSTimer*)timer
{
	contextualMenuTimer = nil;
	NSDictionary *coord = [NSDictionary dictionaryWithObjectsAndKeys:
						   [NSNumber numberWithFloat:tapLocation.x],@"x",
						   [NSNumber numberWithFloat:tapLocation.y],@"y",nil];

    if ([[[[self hitTest:CGPointMake(tapLocation.x, tapLocation.y) withEvent:UIEventTypeTouches] superview]superview] isKindOfClass:[UIWebView class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TapAndHoldNotification" object:coord];
    }
	
}

- (void)sendEvent:(UIEvent *)event
{
	NSSet *touches = [event touchesForWindow:self];
	[touches retain];
	
	[super sendEvent:event];    // Call super to make sure the event is processed as usual
	
	if ([touches count] == 1) { // We're only interested in one-finger events
		UITouch *touch = [touches anyObject];
		
		switch ([touch phase]) {
			case UITouchPhaseBegan:  // A finger touched the screen
				tapLocation = [touch locationInView:self];
				[contextualMenuTimer invalidate];
				contextualMenuTimer = 
                [NSTimer scheduledTimerWithTimeInterval:0.8
                            target:self 
                            selector:@selector(tapAndHoldAction:)
                            userInfo:nil repeats:NO];
				break;
				
			case UITouchPhaseEnded:
			case UITouchPhaseMoved:
                
			case UITouchPhaseCancelled:
				[contextualMenuTimer invalidate];
				contextualMenuTimer = nil;
				break;
                
            case UITouchPhaseStationary:
                break;
		}
	} else {                    // Multiple fingers are touching the screen
		[contextualMenuTimer invalidate];
		contextualMenuTimer = nil;
	}
	[touches release];
}


@end

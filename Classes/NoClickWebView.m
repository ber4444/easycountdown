//
//  NoClickWebView.m
//  Countdown
//
//  Created by Gabor Berenyi on 15/12/14.
//
//

#import "NoClickWebView.h"

@implementation NoClickWebView

- (NSView*)hitTest:(NSPoint)aPoint{
    // return the next responder
    return (NSView*)[self nextResponder];
}

@end

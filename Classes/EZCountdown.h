// Easy's Countdown
// 2010-2014 easyb

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#include <CoreFoundation/CoreFoundation.h>
#import "NoClickWebView.h"

@interface EZCountdown : NSObject {
    NSTimer *timer;
    NSTimeInterval end;
    NoClickWebView *timeView;
    NSView *theView;
    NSSize viewSize;
    NSUserDefaults *defaults;
}

- (id)initWithView:(NSView *)aView;
- (void)tick;

@end

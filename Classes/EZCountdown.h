// Easy's Countdown
// 2010-2014 easyb

#import <Cocoa/Cocoa.h>

@interface EZCountdown : NSObject {
    NSTimer *timer;
    NSTimeInterval end;

    NSTextField *timeView;
    NSView *theView;

    NSSize viewSize;

    NSUserDefaults *defaults;
}
- (id)initWithView:(NSView *)aView;
- (void)tick;

@end

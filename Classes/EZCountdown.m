// Easy's Countdown
// 2010-2014 easyb

#import "EZCountdown.h"

@implementation EZCountdown

- (id)initWithView:(NSView *)aView {
    [super init];

    theView = aView;
    timeView = [[aView subviews] objectAtIndex:0];

    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(tick)
                     userInfo:NULL repeats:YES];

    viewSize = [theView frame].size;
    
    [timeView setDrawsBackground:NO];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"intro" ofType:@"html"];
    [timeView setMainFrameURL:path];
    
    defaults = [NSUserDefaults standardUserDefaults];

    return self;
}

- (void)tick {
    NSString *output;
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];
    
    int hour = 24 - [components hour] - 1;
    int minute = 60 - [components minute] - 1;
    int second = 60 - [components second] - 1;
    
    output = [NSString stringWithFormat:@"2015 Begins in: %02d Hrs %02d Min %02d Sec", hour, minute, second];

    if (hour == 0 && minute == 0 && second == 0)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"countdownDidEnd" object:nil];
    else
        [[timeView windowScriptObject] evaluateWebScript: [NSString stringWithFormat:@"dummy('%@')", output]];
}

- (void)dealloc {
    [super dealloc];
}

@end

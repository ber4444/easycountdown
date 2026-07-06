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
    
    NSDateComponents *currentComponents = [calendar components:NSCalendarUnitYear fromDate:now];
    NSInteger nextYear = [currentComponents year] + 1;
    
    NSDateComponents *newYearComponents = [[[NSDateComponents alloc] init] autorelease];
    [newYearComponents setYear:nextYear];
    [newYearComponents setMonth:1];
    [newYearComponents setDay:1];
    [newYearComponents setHour:0];
    [newYearComponents setMinute:0];
    [newYearComponents setSecond:0];
    
    NSDate *newYearDate = [calendar dateFromComponents:newYearComponents];
    
    NSDateComponents *difference = [calendar components:(NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now toDate:newYearDate options:0];
    
    NSInteger day = [difference day];
    NSInteger hour = [difference hour];
    NSInteger minute = [difference minute];
    NSInteger second = [difference second];
    
    if (day > 0) {
        output = [NSString stringWithFormat:@"%ld Begins in: %ld Days %02ld Hrs %02ld Min %02ld Sec", (long)nextYear, (long)day, (long)hour, (long)minute, (long)second];
    } else {
        output = [NSString stringWithFormat:@"%ld Begins in: %02ld Hrs %02ld Min %02ld Sec", (long)nextYear, (long)hour, (long)minute, (long)second];
    }

    if (day == 0 && hour == 0 && minute == 0 && second == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"countdownDidEnd" object:nil];
    } else {
        [[timeView windowScriptObject] evaluateWebScript: [NSString stringWithFormat:@"dummy('%@')", output]];
    }
}

- (void)dealloc {
    [super dealloc];
}

@end

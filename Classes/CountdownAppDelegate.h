// Easy's Countdown
// 2010-2014 easyb

#import <Cocoa/Cocoa.h>

@class EZCountdown;
@class EZFireworks;

@interface CountdownAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    NSView *mainView;
    QTMovieView *movieView;

    NSUserDefaults *defaults;
    QTMovie *movie;

    IBOutlet NSTextField *timeView;

    EZCountdown *countdown;
    EZFireworks *fireworks;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSView *mainView;

- (IBAction)test:(id)sender;
- (IBAction)toggleFullScreen:(id)sender;
- (IBAction)selectMoviePath:(id)sender;
- (void)changeFont:(id)sender;
- (void)showMovie;
- (void)setMoviePath:(NSOpenPanel*)panel returnCode:(int)returnCode contextInfo:(void *)contextInfo;

@end

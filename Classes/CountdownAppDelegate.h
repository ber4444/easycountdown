// Easy's Countdown
// 2010-2014 easyb

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "AppWindow.h"
#import "EZCountdown.h"
#import "NoClickWebView.h"

@class EZCountdown;

@interface CountdownAppDelegate : NSObject <NSApplicationDelegate> {
    AppWindow *window;
    NSView *mainView;
    QTMovieView *movieView;
    NSUserDefaults *defaults;
    QTMovie *movie;
    IBOutlet NoClickWebView *timeView;
    EZCountdown *countdown;
}

@property (assign) IBOutlet AppWindow *window;
@property (assign) IBOutlet NSView *mainView;

- (IBAction)test:(id)sender;
- (IBAction)selectMoviePath:(id)sender;
- (void)changeFont:(id)sender;
- (void)showMovie;
- (void)setMoviePath:(NSOpenPanel*)panel returnCode:(int)returnCode contextInfo:(void *)contextInfo;

@end

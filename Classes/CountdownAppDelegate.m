// Easy's Countdown
// 2010-2012 easyb

#import <QTKit/QTKit.h>

#import "CountdownAppDelegate.h"

#import "EZCountdown.h"
#import "EZFireworks.h"

@implementation CountdownAppDelegate

@synthesize window, mainView;

+ (void)initialize {
    NSString *defaultsPath = [[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"];
    NSDictionary *defaultsDict = [NSDictionary dictionaryWithContentsOfFile:defaultsPath];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:defaultsDict];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [window setContentView:mainView];

    countdown = [[EZCountdown alloc] initWithView:mainView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countdownDidEnd:) name:@"countdownDidEnd" object:nil];
    defaults = [NSUserDefaults standardUserDefaults];
}

- (void)countdownDidEnd:(NSNotification *) notification {
    NSRect screenRect = [[NSScreen mainScreen] frame];

    fireworks = [[EZFireworks alloc] initWithView:mainView andRect:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];

    if ([defaults integerForKey:@"timeToMovie"] && [defaults stringForKey:@"moviePath"]) {

        [NSTimer scheduledTimerWithTimeInterval:[defaults integerForKey:@"timeToMovie"]
                 target:self selector:@selector(showMovie) userInfo:NULL repeats:NO];
    }
}

- (void)showMovie {
    NSString *fileName = [defaults stringForKey:@"moviePath"];
    movie = [QTMovie movieWithFile:fileName error:nil];
    [movie autoplay];

    NSRect screenRect = [[NSScreen mainScreen] frame];
    movieView = [[QTMovieView alloc] init];
    [movieView setFrame:screenRect];
    [movieView setMovie:movie];
    [movieView setPreservesAspectRatio:YES];

    window.contentView = movieView;
}

- (IBAction)toggleFullScreen:(id)sender {
    if ([window.contentView isInFullScreenMode] == NO) {
        [window.contentView enterFullScreenMode:[NSScreen mainScreen] withOptions:nil];
        //[mainView setFrameSize:[[NSScreen mainScreen] frame].size];
        //[countdown centerText];
    } else {
        [window.contentView exitFullScreenModeWithOptions:nil];
        //[countdown centerText];
    }

    NSLog(@"view height:%f", [window.contentView frame].size.height);
    NSLog(@"view width:%f", [window.contentView frame].size.width);
    NSLog(@"screen height:%f", [[NSScreen mainScreen] frame].size.height);
    NSLog(@"screen width:%f", [[NSScreen mainScreen] frame].size.width);
}

- (IBAction)selectMoviePath:(id)sender {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:YES];
    [panel setResolvesAliases:YES];
    [panel setTitle:@"Choose the movie file"];
    [panel setPrompt:@"Choose"];

    [panel beginSheetForDirectory:nil file:nil types:nil modalForWindow:[self window]
           modalDelegate:self
           didEndSelector:@selector(setMoviePath:returnCode:contextInfo:)
           contextInfo:self];
}

- (void)setMoviePath:(NSOpenPanel*)panel returnCode:(int)returnCode contextInfo:(void *)contextInfo {
    [panel orderOut:self];

    if (returnCode != NSOKButton)
        return;

    NSArray* paths = [panel URLs];
    NSURL* url = [paths objectAtIndex: 0];
    [defaults setValue:[url path] forKey:@"moviePath"];
}

- (void)applicationWillTerminate:(NSNotification *)notification {

}

//Quit app when the window is closed
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    return NSTerminateNow;
}

- (void)dealloc {
    [countdown release];
    [fireworks release];
    [movieView release];
    [movie release];
    [super dealloc];
}

@end

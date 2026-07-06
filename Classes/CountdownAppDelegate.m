// Easy's Countdown
// 2010-2014 easyb

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

#import "CountdownAppDelegate.h"

@implementation CountdownAppDelegate

@synthesize window, mainView;

+ (void)initialize {
    NSString *defaultsPath = [[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"];
    NSDictionary *defaultsDict = [NSDictionary dictionaryWithContentsOfFile:defaultsPath];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:defaultsDict];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
    [[window contentView] addSubview:mainView];
    [window setBackgroundColor:[NSColor clearColor]];
    [window  setOpaque:NO];
    
    countdown = [[EZCountdown alloc] initWithView:mainView];
        
    [[NSNotificationCenter defaultCenter]
        addObserver:self selector:@selector(countdownDidEnd:) name:@"countdownDidEnd"
        object:nil];
    defaults = [NSUserDefaults standardUserDefaults];
}

- (void)changeFont:(id)sender {
    NSFontManager *fontManager = [NSFontManager sharedFontManager];
    NSFont *oldFont = [NSFont fontWithName:[defaults objectForKey:@"fontName"]
                              size:[defaults integerForKey:@"fontSize"]];
    NSFont *font = [fontManager convertFont:oldFont];
    [defaults setValue:font.fontName forKey:@"fontName"];
    [defaults setValue:[NSNumber numberWithFloat:font.pointSize] forKey:@"fontSize"];
    return;
}

- (void)countdownDidEnd:(NSNotification *) notification {
    [countdown release];
    countdown = nil;
    if ([defaults stringForKey:@"moviePath"])
        [self showMovie];
}

- (IBAction)test:(id)sender {
    [timeView  setHidden:YES];
    if ([defaults stringForKey:@"moviePath"])
        [self showMovie];
}

- (void)showMovie {
    NSString *fileName = [defaults stringForKey:@"moviePath"];
    NSURL *fileURL = [NSURL fileURLWithPath:fileName];
    movie = [AVPlayer playerWithURL:fileURL];
    
    // Loop the video
    movie.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[movie currentItem]];
    
    [movie play];

    NSRect screenRect = [[NSScreen mainScreen] frame];
    movieView = [[AVPlayerView alloc] init];
    [movieView setFrame:screenRect];
    [movieView setPlayer:movie];
    [movieView setControlsStyle:AVPlayerViewControlsStyleNone];

    // TODO: find better solution
    window.contentView = movieView;

    [window.contentView enterFullScreenMode:[NSScreen mainScreen] withOptions:nil];
    [mainView exitFullScreenModeWithOptions:nil];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero completionHandler:nil];
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

    if (returnCode != NSModalResponseOK)
        return;

    NSArray* paths = [panel URLs];
    NSURL* url = [paths objectAtIndex: 0];
    [defaults setValue:[url path] forKey:@"moviePath"];
}

- (void)applicationWillTerminate:(NSNotification *)notification {

}

// Quit app when the window is closed
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    return NSTerminateNow;
}

- (void)dealloc {
    [countdown release];
    [movieView release];
    [movie release];
    [super dealloc];
}

@end

//
//  AppWindow.m
//  Countdown
//
//  Created by Gabor Berenyi on 11/12/14.
//
//

#import "AppWindow.h"

@implementation AppWindow

- (id) initWithContentRect: (NSRect) contentRect
                 styleMask: (NSWindowStyleMask) aStyle
                   backing: (NSBackingStoreType) bufferingType
                     defer: (BOOL) flag
{
    if (![super initWithContentRect: contentRect
                          styleMask: NSWindowStyleMaskBorderless
                            backing: bufferingType
                              defer: flag]) return nil;
    [self setMovableByWindowBackground:TRUE];
    [self setMovable:TRUE];
    [self setCollectionBehavior:NSWindowCollectionBehaviorStationary];
    return self;
}

- (BOOL) canBecomeKeyWindow{
    return YES;
}

- (void)mouseDown:(NSEvent *)theEvent{
    NSRect mouseRect = NSMakeRect([self mouseLocationOutsideOfEventStream].x, [self mouseLocationOutsideOfEventStream].y, 0, 0);
    currentLocation = [self convertRectToScreen:mouseRect].origin;
    
    offsetX = currentLocation.x - [self frame].origin.x;
    offsetY = currentLocation.y - [self frame].origin.y;
}

- (void)mouseDragged:(NSEvent *)theEvent{
    NSRect mouseRect = NSMakeRect([self mouseLocationOutsideOfEventStream].x, [self mouseLocationOutsideOfEventStream].y, 0, 0);
    currentLocation = [self convertRectToScreen:mouseRect].origin;
    
    newOrigin.x = currentLocation.x - offsetX;
    newOrigin.y = currentLocation.y - offsetY;
    
    [self setFrameOrigin:newOrigin];
}

- (BOOL)performKeyEquivalent:(NSEvent *)evento {
    unichar keyChar = ([[evento charactersIgnoringModifiers] characterAtIndex: 0]);
    BOOL retVal = NO;
    id mainView = [[self.contentView subviews] lastObject];
    NoClickWebView *aWebView = [[mainView subviews] lastObject];
    switch(keyChar) {
        case '+':
            [[aWebView windowScriptObject] evaluateWebScript: [NSString stringWithFormat:@"zoom('%0.1f')", 0.1]];
            retVal = YES;
            break;
        case '-':
            [[aWebView windowScriptObject] evaluateWebScript: [NSString stringWithFormat:@"zoom('%0.1f')", -0.1]];
            retVal = YES;
            break;
        default:
            retVal = [super performKeyEquivalent:evento];
    }
    return retVal;
}

@end

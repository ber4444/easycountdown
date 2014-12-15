//
//  AppWindow.h
//  Countdown
//
//  Created by Gabor Berenyi on 11/12/14.
//
//

#import <Cocoa/Cocoa.h>
#import "NoClickWebView.h"

@interface AppWindow : NSWindow {
    NSPoint currentLocation;
    NSPoint newOrigin;
    int offsetX,offsetY;
}

@end


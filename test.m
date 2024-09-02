#import <AppKit/AppKit.h>

@interface FloatingButton : NSButton
@end

@implementation FloatingButton

- (void)mouseDragged:(NSEvent *)event {
    NSPoint currentPosition = [event locationInWindow];
    [self setFrameOrigin:currentPosition];
}

@end

void setupFloatingButton() {
    NSWindow *mainWindow = [NSApp mainWindow];

    FloatingButton *button = [[FloatingButton alloc] initWithFrame:NSMakeRect(20, 100, 50, 50)];
    [button setWantsLayer:YES];
    [button.layer setCornerRadius:25];
    [button setTitle:@"Button"];
    [button setTarget:button];
    [button setAction:@selector(buttonPressed)];

    [mainWindow.contentView addSubview:button];
}

@implementation FloatingButton

- (void)buttonPressed {
    NSLog(@"Button pressed");
}

@end

__attribute__((constructor))
static void initializer() {
    NSLog(@"[INFO] Dylib injected successfully!");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        setupFloatingButton();
    });
}

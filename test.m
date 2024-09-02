#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <dlfcn.h>

@interface FloatingButton : UIButton
@end

@implementation FloatingButton

// Make the button draggable
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.superview];
    self.center = currentPosition;
}

@end

void setupFloatingButton() {
    // Get the main application window
    UIWindow *mainWindow = [UIApplication sharedApplication].windows.firstObject;

    // Create the floating button
    FloatingButton *button = [FloatingButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 100, 50, 50); // Initial position and size
    button.layer.cornerRadius = 25;
    button.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1]; // Lightly visible initially

    // Set the button's target actions
    [button addTarget:button action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:button action:@selector(buttonTouchedDown) forControlEvents:UIControlEventTouchDown];
    [button addTarget:button action:@selector(buttonTouchedUp) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];

    // Add the button to the main window
    [mainWindow addSubview:button];
}

// Actions for button state changes
@implementation FloatingButton

// Button pressed action
- (void)buttonPressed {
    NSLog(@"Button pressed");
    // Add any action you want to trigger here
}

// When the button is touched down
- (void)buttonTouchedDown {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0]; // Opaque black when touched
}

// When the touch is released
- (void)buttonTouchedUp {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1]; // Revert to initial appearance
}

@end

// Run setup when the dylib is loaded
__attribute__((constructor))
static void initializer() {
    NSLog(@"[INFO] Dylib injected successfully!");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        setupFloatingButton();
    });
}

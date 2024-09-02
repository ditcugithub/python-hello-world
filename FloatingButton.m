// FloatingButton.m

#import "FloatingButton.h"

@implementation FloatingButton

+ (instancetype)sharedInstance {
    static FloatingButton *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [FloatingButton buttonWithType:UIButtonTypeCustom];
        sharedInstance.frame = CGRectMake(50, 100, 60, 60);
        sharedInstance.layer.cornerRadius = 30;
        sharedInstance.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [sharedInstance addTarget:sharedInstance action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [sharedInstance addTarget:sharedInstance action:@selector(buttonTouchDown:) forControlEvents:UIControlEventTouchDown];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:sharedInstance action:@selector(handlePan:)];
        [sharedInstance addGestureRecognizer:panGesture];
    });
    return sharedInstance;
}

- (void)showButton {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

- (void)buttonTapped:(UIButton *)sender {
    sender.backgroundColor = [UIColor blackColor];
}

- (void)buttonTouchDown:(UIButton *)sender {
    sender.backgroundColor = [UIColor blackColor];
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGPoint translation = [gesture translationInView:keyWindow];
    CGPoint newCenter = CGPointMake(self.center.x + translation.x, self.center.y + translation.y);
    self.center = newCenter;
    [gesture setTranslation:CGPointZero inView:keyWindow];
}

@end

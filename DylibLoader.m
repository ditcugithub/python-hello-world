// DylibLoader.m

#import <UIKit/UIKit.h>
#import "FloatingButton.h"

__attribute__((constructor))
static void initialize() {
    [[FloatingButton sharedInstance] showButton];
}

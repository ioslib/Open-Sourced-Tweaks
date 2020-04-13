#import "SBCRootListController.h"

@implementation SBCAppearanceSettings

-(UIColor *)tintColor {
    return [UIColor colorWithRed:0.70 green:0.56 blue:0.95 alpha:1.00];
}

-(UIColor *)statusBarTintColor {
    return [UIColor whiteColor];
}

-(UIColor *)navigationBarTitleColor {
    return [UIColor whiteColor];
}

-(UIColor *)navigationBarTintColor {
    return [UIColor whiteColor];
}

-(UIColor *)tableViewCellSeparatorColor {
    return [UIColor colorWithWhite:0 alpha:0];
}

-(UIColor *)navigationBarBackgroundColor {
    return [UIColor colorWithRed:0.70 green:0.56 blue:0.95 alpha:1.00];
}

-(BOOL)translucentNavigationBar {
    return NO;
}

-(NSUInteger)largeTitleStyle {
    return 2;
}

@end
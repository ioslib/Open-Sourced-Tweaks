#import <AudioToolbox/AudioToolbox.h>
#import "AXNAppCell.h"
#import "AXNManager.h"

@implementation AXNAppCell

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _style = -1;

    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
    [self addGestureRecognizer:recognizer];

    self.layer.cornerRadius = 13;
    self.layer.continuousCorners = YES;
    self.layer.masksToBounds = YES;

    self.iconView = [[UIImageView alloc] initWithFrame:frame];
    self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;

    self.badgeLabel = [[UILabel alloc] initWithFrame:frame];
    self.badgeLabel.font = [UIFont boldSystemFontOfSize:14];
    self.badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.badgeLabel.text = @"0";
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.backgroundColor = [UIColor blackColor];
    self.badgeLabel.layer.cornerRadius = 10;
    self.badgeLabel.layer.masksToBounds = YES;
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;

    self.blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.blurView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    // self.blurView.bounds = self.bounds;

    _styleConstraints = @[
        @[  // default
            [self.iconView.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-30],
            [self.badgeLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [self.badgeLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10],
            [self.badgeLabel.heightAnchor constraintEqualToConstant:20],
            [self.badgeLabel.widthAnchor constraintEqualToConstant:30],
        ],
        @[  // packed
            [self.iconView.topAnchor constraintEqualToAnchor:self.topAnchor constant:10],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10],
            [self.badgeLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5],
            [self.badgeLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],
            [self.badgeLabel.heightAnchor constraintEqualToConstant:20],
            [self.badgeLabel.widthAnchor constraintEqualToConstant:30],
        ],
        @[  // compact
            [self.iconView.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],
            [self.badgeLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [self.badgeLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],
            [self.badgeLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10],
            [self.badgeLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10],
        ],
        @[  // tiny
            [self.iconView.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-25],
            [self.badgeLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [self.badgeLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],
            [self.badgeLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:5],
            [self.badgeLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5],
        ],
        @[  // group
            [self.iconView.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-28],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],

            [self.badgeLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [self.badgeLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:5],
            [self.badgeLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-5],
            [self.badgeLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [self.badgeLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-5],
        ],
        @[  // group rounded
            [self.iconView.topAnchor constraintEqualToAnchor:self.topAnchor constant:8],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:3],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-26],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-8],

            [self.badgeLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
            [self.badgeLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:8],
            [self.badgeLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-8],
            [self.badgeLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:33],
            [self.badgeLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-7],
        ]
    ];

    if (_style == 5) self.alpha = 0.5;
    if ([[AXNManager sharedInstance] dynamicBadges])
    {
        self.badgeLabel.textColor = [[[AXNManager sharedInstance] wallpaperColorCache] objectForKey:@"secondary"];
    }
    return self;
}

-(void)axnClearAll {
    [[AXNManager sharedInstance] clearAll:self.bundleIdentifier];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(axnClearAll));
}

-(void)showMenu:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        AudioServicesPlaySystemSound(1519);

        [self becomeFirstResponder];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        menu.menuItems = @[
            [[UIMenuItem alloc] initWithTitle:@"Clear All" action:@selector(axnClearAll)],
        ];
        [menu setTargetRect:self.bounds inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
}

-(void)setBundleIdentifier:(NSString *)value {
    _bundleIdentifier = value;

    self.iconView.image = [[AXNManager sharedInstance] getIcon:value withStyle:_style];

    self.badgeLabel.backgroundColor = [UIColor clearColor];
    if(_style !=4) self.badgeLabel.textColor = [[AXNManager sharedInstance] fallbackColor];

    BOOL iOS13 = [[[UIDevice currentDevice] systemVersion] floatValue] >= 13;

    if (self.badgesShowBackground && self.iconView.image && !iOS13 && _style != 4) {
        if ([AXNManager sharedInstance].backgroundColorCache[value] && [AXNManager sharedInstance].textColorCache[value]) {
            self.badgeLabel.backgroundColor = [[AXNManager sharedInstance].backgroundColorCache[value] copy];
            self.badgeLabel.textColor = [[AXNManager sharedInstance].textColorCache[value] copy];

        } else {
            __weak AXNAppCell *weakSelf = self;
            MPArtworkColorAnalyzer *colorAnalyzer = [[MPArtworkColorAnalyzer alloc] initWithImage:self.iconView.image algorithm:0];
            [colorAnalyzer analyzeWithCompletionHandler:^(MPArtworkColorAnalyzer *analyzer, MPArtworkColorAnalysis *analysis) {
                [AXNManager sharedInstance].backgroundColorCache[value] = [analysis.backgroundColor copy];
                [AXNManager sharedInstance].textColorCache[value] = [analysis.primaryTextColor copy];
                [weakSelf badgeLabel].backgroundColor = [analysis.backgroundColor copy];
                [weakSelf badgeLabel].textColor = [analysis.primaryTextColor copy];
            }];
        }
    }
    if (_style == 5)
    {
        self.badgeLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    }
    if ([[AXNManager sharedInstance] dynamicBadges])
    {
        self.badgeLabel.textColor = [[[AXNManager sharedInstance] wallpaperColorCache] objectForKey:@"secondary"];
    }
}

-(void)setNotificationCount:(NSInteger)value {
    _notificationCount = value;

    if (value <= 99) {
        self.badgeLabel.text = [NSString stringWithFormat:@"%ld", value];
    } else {
        self.badgeLabel.text = @"99+";
    }
    if ([[AXNManager sharedInstance] dynamicBadges])
    {
        self.badgeLabel.textColor = [[[AXNManager sharedInstance] wallpaperColorCache] objectForKey:@"secondary"];
    }
}

-(void)setSelectionStyle:(NSInteger)style {
    _selectionStyle = style;

    self.iconView.alpha = 1.0;
    self.badgeLabel.alpha = 1.0;
    self.backgroundColor = [UIColor clearColor];
}

-(void)setStyle:(NSInteger)style {
    if (_style == style) return;
    NSInteger oldStyle = _style;

    if (style >= [_styleConstraints count] || style < 0) _style = 0;
    else _style = style;

    if(style == 4) {
        self.badgeLabel.textAlignment = NSTextAlignmentRight;
        self.badgeLabel.backgroundColor = [UIColor clearColor];
        self.badgeLabel.textColor = [UIColor blackColor];

        [self addSubview:self.blurView];
        [self addSubview:self.badgeLabel];
        [self addSubview:self.iconView];
    } else if (style == 5) 
    {
        self.layer.cornerRadius = 18;
        [self addSubview:self.blurView];
        [self addSubview:self.badgeLabel];
        [self addSubview:self.iconView];
        self.alpha = 0.5;
        self.badgeLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    } else {
        [self addSubview:self.iconView];
        [self addSubview:self.badgeLabel];
    }
    if (oldStyle != -1) [NSLayoutConstraint deactivateConstraints:_styleConstraints[oldStyle]];
    [NSLayoutConstraint activateConstraints:_styleConstraints[_style]];
    [self setNeedsLayout];
}

-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];

    if (selected) {
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            switch (self.selectionStyle) {
                case 1:
                    if (![AXNManager sharedInstance].fadeEntireCell)
                    {
                        self.iconView.alpha = 1;
                        self.badgeLabel.alpha = 1;
                    } else {self.alpha = 1;}
                    break;
                default:
                    if (!self.darkMode) self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
                    else self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            }
        } completion:NULL];
    } else {
        [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            switch (self.selectionStyle) {
                case 1:
                    if (![AXNManager sharedInstance].fadeEntireCell)
                    {
                        self.iconView.alpha = 0.5;
                        self.badgeLabel.alpha = 0.5;
                    } else {self.alpha = 0.5;}
                    break;
                default:
                    self.backgroundColor = [UIColor clearColor];
            }
        } completion:NULL];
    }
}

@end

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

static UIColor *avatarLightBorderColor;
static UIColor *avatarDarkBorderColor;

__attribute__((constructor))
static void initialize() {
    avatarLightBorderColor = [UIColor whiteColor];
    avatarDarkBorderColor = [UIColor blackColor];
}

%hook UIView

- (void)layoutSubviews {
    %orig;
    
    // 检查是否为微信的头像视图
    if ([self isKindOfClass:NSClassFromString(@"WCAvatarView")] || 
        [self isKindOfClass:NSClassFromString(@"WCContactAvatarView")]) {
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = avatarLightBorderColor.CGColor;
    }
    
    // 检查是否为微信的消息气泡
    if ([self isKindOfClass:NSClassFromString(@"WCBubbleView")] || 
        [self isKindOfClass:NSClassFromString(@"WCMessageBubbleView")]) {
        self.layer.cornerRadius = 12.0;
        self.layer.masksToBounds = YES;
    }
    
    // 检查是否为微信的按钮
    if ([self isKindOfClass:NSClassFromString(@"WCButton")] || 
        [self isKindOfClass:[UIButton class]]) {
        // 只处理特定的按钮，避免影响所有按钮
        if (self.frame.size.height > 30 && self.frame.size.height < 50) {
            self.layer.cornerRadius = 8.0;
            self.layer.masksToBounds = YES;
        }
    }
}

%end

%hook UIImageView

- (void)layoutSubviews {
    %orig;
    
    // 处理图片视图的圆角
    if ([self isKindOfClass:NSClassFromString(@"WCAvatarView")] || 
        [self isKindOfClass:NSClassFromString(@"WCContactAvatarView")]) {
        self.layer.cornerRadius = 8.0;
        self.layer.masksToBounds = YES;
    }
}

%end

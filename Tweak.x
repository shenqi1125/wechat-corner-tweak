#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static BOOL enabled = YES;
static BOOL borderEnabled = NO;

static CGFloat avatarRadius = 65.0;
static CGFloat avatarBorderWidth = 1.9;
static UIColor *avatarLightBorderColor = [UIColor whiteColor];
static UIColor *avatarDarkBorderColor = [UIColor blackColor];

static CGFloat inputRadius = 18.0;
static CGFloat inputBorderWidth = 0.0;

static CGFloat patRadius = 15.0;
static CGFloat patBorderWidth = 2.0;

static CGFloat timeRadius = 10.0;
static CGFloat timeBorderWidth = 1.8;

static CGFloat buttonRadius = 20.0;
static CGFloat buttonBorderWidth = 0.0;

static CGFloat emojiRadius = 22.6;
static CGFloat emojiBorderWidth = 0.0;

static CGFloat layerRadius = 28.4;
static CGFloat layerBorderWidth = 0.0;

static CGFloat listRadius = 17.0;
static CGFloat listBorderWidth = 0.0;

static void loadSettings() {
    NSDictionary *prefs = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"com.example.wechatcorner.prefs"];
    
    if (prefs) {
        enabled = [prefs[@"enabled"] boolValue];
        borderEnabled = [prefs[@"borderEnabled"] boolValue];
        
        avatarRadius = [prefs[@"avatarRadius"] floatValue];
        avatarBorderWidth = [prefs[@"avatarBorderWidth"] floatValue];
        
        inputRadius = [prefs[@"inputRadius"] floatValue];
        inputBorderWidth = [prefs[@"inputBorderWidth"] floatValue];
        
        patRadius = [prefs[@"patRadius"] floatValue];
        patBorderWidth = [prefs[@"patBorderWidth"] floatValue];
        
        timeRadius = [prefs[@"timeRadius"] floatValue];
        timeBorderWidth = [prefs[@"timeBorderWidth"] floatValue];
        
        buttonRadius = [prefs[@"buttonRadius"] floatValue];
        buttonBorderWidth = [prefs[@"buttonBorderWidth"] floatValue];
        
        emojiRadius = [prefs[@"emojiRadius"] floatValue];
        emojiBorderWidth = [prefs[@"emojiBorderWidth"] floatValue];
        
        layerRadius = [prefs[@"layerRadius"] floatValue];
        layerBorderWidth = [prefs[@"layerBorderWidth"] floatValue];
        
        listRadius = [prefs[@"listRadius"] floatValue];
        listBorderWidth = [prefs[@"listBorderWidth"] floatValue];
    }
}

static void applyCornerToView(UIView *view, CGFloat radius, CGFloat borderWidth, UIColor *borderColor) {
    if (!enabled || !view) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        view.layer.cornerRadius = radius;
        view.layer.masksToBounds = YES;
        
        if (borderEnabled && borderWidth > 0) {
            view.layer.borderWidth = borderWidth;
            if (borderColor) {
                view.layer.borderColor = borderColor.CGColor;
            }
        } else {
            view.layer.borderWidth = 0;
        }
    });
}

%hook UIView

- (void)didMoveToWindow {
    %orig;
    
    if (!enabled) return;
    
    NSString *className = NSStringFromClass([self class]);
    
    if ([className containsString:@"Avatar"]) {
        applyCornerToView(self, avatarRadius, avatarBorderWidth, avatarLightBorderColor);
    } else if ([className containsString:@"Input"]) {
        applyCornerToView(self, inputRadius, inputBorderWidth, nil);
    } else if ([className containsString:@"Button"]) {
        applyCornerToView(self, buttonRadius, buttonBorderWidth, nil);
    } else if ([className containsString:@"Emoji"]) {
        applyCornerToView(self, emojiRadius, emojiBorderWidth, nil);
    }
}

%end

%hook UIImageView

- (void)didMoveToWindow {
    %orig;
    
    if (!enabled) return;
    
    if ([self.accessibilityLabel containsString:@"头像"] || 
        [self.accessibilityIdentifier containsString:@"avatar"]) {
        applyCornerToView(self, avatarRadius, avatarBorderWidth, avatarLightBorderColor);
    }
}

%end

%hook UITextView

- (void)didMoveToWindow {
    %orig;
    
    if (!enabled) return;
    
    applyCornerToView(self, inputRadius, inputBorderWidth, nil);
}

%end

%hook UITextField

- (void)didMoveToWindow {
    %orig;
    
    if (!enabled) return;
    
    applyCornerToView(self, inputRadius, inputBorderWidth, nil);
}

%end

%hook UIButton

- (void)didMoveToWindow {
    %orig;
    
    if (!enabled) return;
    
    applyCornerToView(self, buttonRadius, buttonBorderWidth, nil);
}

%end

%hook UILabel

- (void)didMoveToWindow {
    %orig;
    
    if (!enabled) return;
    
    NSString *text = self.text;
    if ([text containsString:@"拍一拍"] || [self.accessibilityLabel containsString:@"拍一拍"]) {
        applyCornerToView(self, patRadius, patBorderWidth, nil);
    }
}

%end

%ctor {
    loadSettings();
    
    CFNotificationCenterAddObserver(
        CFNotificationCenterGetDarwinNotifyCenter(),
        NULL,
        (CFNotificationCallback)loadSettings,
        CFSTR("com.example.wechatcorner.prefschanged"),
        NULL,
        CFNotificationSuspensionBehaviorCoalesce
    );
}
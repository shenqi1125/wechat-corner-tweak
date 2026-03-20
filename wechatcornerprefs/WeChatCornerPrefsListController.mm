#import <Preferences/Preferences.h>

@interface WeChatCornerPrefsListController : PSListController
@end

@implementation WeChatCornerPrefsListController

- (id)specifiers {
    if (!_specifiers) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
    }
    return _specifiers;
}

@end

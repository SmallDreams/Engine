#import "SalemPlugin.h"
#if __has_include(<salem/salem-Swift.h>)
#import <salem/salem-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "salem-Swift.h"
#endif

@implementation SalemPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSalemPlugin registerWithRegistrar:registrar];
}
@end

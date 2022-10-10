#import "CooperationPlugin.h"
#if __has_include(<cooperation/cooperation-Swift.h>)
#import <cooperation/cooperation-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "cooperation-Swift.h"
#endif

@implementation CooperationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCooperationPlugin registerWithRegistrar:registrar];
}
@end

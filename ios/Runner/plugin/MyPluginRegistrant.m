//
//  Generated file. Do not edit.
//

#import "MyPluginRegistrant.h"
#import "RongIMServerPlugin.h"

@implementation MyPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [RongIMServerPlugin registerWithRegistrar:[registry registrarForPlugin:@"RongIMServerPlugin"]];
}

@end

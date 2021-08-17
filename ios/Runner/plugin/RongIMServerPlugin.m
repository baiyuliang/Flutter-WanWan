// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Foundation/Foundation.h>
#import "RongIMServerPlugin.h"
#import <Flutter/Flutter.h>

static NSString *const CHANNEL_NAME = @"rongim/server";

@implementation RongIMServerPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:CHANNEL_NAME
                                                                binaryMessenger:registrar.messenger];
    [channel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
        NSString *method = [call method];
//        NSDictionary *arguments = [call arguments];
        if ([method isEqualToString:@"register"]) {
            NSMutableDictionary * mutableDictionary=[NSMutableDictionary dictionaryWithCapacity:2];
            mutableDictionary[@"code"] = @(-1);
            mutableDictionary[@"error"] = @"注册失败";
            result(mutableDictionary);
        } else if ([method isEqualToString:@"user"]) {
            NSMutableDictionary * mutableDictionary=[NSMutableDictionary dictionaryWithCapacity:2];
            mutableDictionary[@"code"] = @(-1);
            mutableDictionary[@"error"] = @"获取用户信息失败";
            result(mutableDictionary);
        }
    }];
}

@end

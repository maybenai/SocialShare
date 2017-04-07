//
//  AppDelegate.m
//  ShareDemo
//
//  Created by lisonglin on 2017/4/6.
//  Copyright © 2017年 lisonglin. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <UMSocialCore/UMSocialCore.h>


#define UMengAppKey         @"your umeng key"
#define ShareSDKAppKey      @"your shareSDK key"
#define ShareSDKSecret      @"your ShareSDKSecret"

#define TENCENT_CONNECT_APP_KEY @"your qq id"
#define TENCENT_CONNECT_APP_SECRECT @"your qq secret"

#define WEIXIN_APP_ID           @"your weixin id"
#define WEIXIN_APP_SECRET       @"your weixin secret"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //umeng
    [self setUpUmeng];
    
    //shareSDK注册
    [self registerShareSDK];
    
    return YES;
}

- (void)setUpUmeng
{
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置umeng的appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengAppKey];
    
    //设置微信的appkey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WEIXIN_APP_ID appSecret:WEIXIN_APP_SECRET redirectURL:@"www.kchome.com"];
}


- (void)registerShareSDK
{
    [ShareSDK registerApp:ShareSDKAppKey activePlatforms:@[@(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
        
        switch (platformType) {
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
                
            default:
                break;
        }
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:TENCENT_CONNECT_APP_KEY appKey:TENCENT_CONNECT_APP_SECRECT authType:SSDKAuthTypeBoth];
                break;
                
            default:
                break;
        }
    }];
}

//设置回调 仅支持iOS9以上的系统
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    
    
    
    return result;
}

//支持所有的iOS系统
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

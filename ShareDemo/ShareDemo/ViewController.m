//
//  ViewController.m
//  ShareDemo
//
//  Created by lisonglin on 2017/4/6.
//  Copyright © 2017年 lisonglin. All rights reserved.
//

#import "ViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
//系统自带的share
- (IBAction)systemShareClick {
    
    NSArray * activityItems = @[@"你要分享的内容"];
    UIActivityViewController * activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
        
        if (completed) {
            //分享完成
            
            
        }else{
            //分享失败
        }
        
        [activityVC dismissViewControllerAnimated:YES completion:nil];
    };
    
    activityVC.completionWithItemsHandler = myBlock;
    
    activityVC.excludedActivityTypes = @[UIActivityTypePostToFacebook,
                                         UIActivityTypePostToTwitter,
                                         UIActivityTypePostToWeibo,
                                         UIActivityTypeMessage,
                                         UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop,
                                         UIActivityTypeOpenInIBooks];
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
}
//umengShare
- (IBAction)umengShareClick {
    
    /*
     直接跳转到相应的分享 没有分享面板
    //创建分享消息对象
    UMSocialMessageObject * messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString * thumbUrl = @"http://www.baidu.com";
    
    UMShareWebpageObject * shareObject = [UMShareWebpageObject shareObjectWithTitle:@"share" descr:@"umengShare" thumImage:thumbUrl];
    
    //设置网页地址
    shareObject.webpageUrl = @"http://www.baidu.com";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_WechatSession messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"error");
        }else{
            
            if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse * resp = result;
                
                //分享结果消息
                UMSocialLogInfo(@"%@",resp.message);
                
                //第三方原始返回的数据
                UMSocialLogInfo(@"%@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"%@",result);
            }
            
        }
        NSLog(@"error");
        
    }];
    */
    
    
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        switch (platformType) {
            case UMSocialPlatformType_WechatSession:
                NSLog(@"WechatSession");
                break;
            case UMSocialPlatformType_WechatTimeLine:
                NSLog(@"WechatTimeLine");
                break;
            default:
                break;
        }
    }];
    
    
}
//shareSDKShare
- (IBAction)shareSDKClick {
    
    
    //创建分享参数
    NSMutableDictionary * shareParams = [NSMutableDictionary dictionary];
    
    [shareParams SSDKSetupShareParamsByText:@"share"
                                     images:@[[UIImage imageNamed:@"logo"]]
                                        url:[NSURL URLWithString:@"http://www.baidu.com"]
                                      title:@"title"
                                       type:SSDKContentTypeAuto];
    
    [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        
    }];
}

@end

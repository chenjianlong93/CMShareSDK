//
//  CMShareManager.m
//  CMShareSDK
//
//  Created by lx2 on 2018/7/9.
//  Copyright © 2018年 lx2. All rights reserved.
//

#import "CMShareManager.h"
#import "WechatApiRequestHandler.h"
#import "QQApiRequestHandler.h"
#import <WXApi.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface CMShareManager ()<WXApiDelegate,TencentSessionDelegate>

@property (nonatomic, copy) NSString *wechatId;
@property (nonatomic, copy) NSString *qqAppId;

@property (nonatomic, assign) CMShareScene scene;
@property (nonatomic, strong) TencentOAuth *auth;

@property (nonatomic, copy) CMShareCompletionHandler completionBlock;

@end

@implementation CMShareManager

+ (instancetype)shareInstance{
    static CMShareManager * manage ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [CMShareManager new];
    });
    return manage;
}

+ (CMShareManager *)defaultManager {
    return [self  shareInstance];
}

- (void)setWeChatAppKey:(NSString *)Key {
    self.wechatId = Key;
    [WXApi registerApp:Key];
}

- (void)setQQAppKey:(NSString *)Key {
    self.qqAppId = Key;
    self.auth = [[TencentOAuth alloc] initWithAppId:Key andDelegate:self];
}

- (CMShareScene)currentShareScene {
    return self.scene;
}

#pragma mark - 第三方库 OPEN URL 处理
- (BOOL)handleOpenURL:(NSURL *)url{
    if ([url.scheme isEqualToString:self.wechatId]) {
        return  [WXApi handleOpenURL:url delegate:self];
    }else if ([url.scheme isEqualToString:self.qqAppId]){
        return [TencentOAuth HandleOpenURL:url];
    }
    
    return NO;
}

#pragma mark - 分享接口
- (void)shareToPlatform:(CMShareScene)scene messageObject:(CMShareMessageModel *)messageObject currentViewController:(id)currentViewController completion:(CMShareCompletionHandler)completion {
    self.scene = scene;
    self.completionBlock = completion;
    if (scene <= 2) {
        [WechatApiRequestHandler shareToWechatInScene:scene messageObject:messageObject];
    }else {
        QQApiSendResultCode resuletCode = [QQApiRequestHandler shareToQQInScene:scene messageObject:messageObject];
        [self qqOnResp:resuletCode];
    }
}

#pragma  mark - 微信回调
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        switch (resp.errCode) {
            case WXSuccess:
                self.completionBlock(CMShareErrorCode_Success, @"分享成功");
                break;
            case WXErrCodeCommon:
                self.completionBlock(CMShareErrorCode_Common, @"未知错误类型");
                break;
            case WXErrCodeUserCancel:
                self.completionBlock(CMShareErrorCode_UserCancel, @"用户取消分享");
                break;
            case WXErrCodeSentFail:
                self.completionBlock(CMShareErrorCode_SentFail, @"发送失败");
                break;
            case WXErrCodeAuthDeny:
                self.completionBlock(CMShareErrorCode_AuthDeny, @"授权失败");
                break;
            case WXErrCodeUnsupport:
                self.completionBlock(CMShareErrorCode_Unsupport, @"微信版本不支持");
                break;
                
            default:
                break;
        }
    }
}

#pragma  mark - QQ回调
- (void)qqOnResp:(QQApiSendResultCode)resultCode {
    switch (resultCode) {
        case EQQAPISENDSUCESS:
            self.completionBlock(CMShareErrorCode_Success, @"分享成功");
            break;
        case EQQAPIQQNOTINSTALLED:
            self.completionBlock(CMShareErrorCode_QQNotInstalled, @"未安装QQ");
            break;
        case EQQAPIQQNOTSUPPORTAPI:
            self.completionBlock(CMShareErrorCode_QQNotSupportApi, @"当前QQ版本不支持的Api");
            break;
        case EQQAPIMESSAGETYPEINVALID:
            self.completionBlock(CMShareErrorCode_QQMessageTypeInvalid, @"QQ消息类型无效");
            break;
        case EQQAPIMESSAGECONTENTNULL:
            self.completionBlock(CMShareErrorCode_QQMessageContentNull, @"分享消息内容为空");
            break;
        case EQQAPIMESSAGECONTENTINVALID:
            self.completionBlock(CMShareErrorCode_QQMessageContentInvalid, @"分享消息内容无效");
            break;
        case EQQAPIAPPNOTREGISTED:
        case EQQAPIAPPSHAREASYNC:
        case EQQAPIQQNOTSUPPORTAPI_WITH_ERRORSHOW:
//        case EQQAPISHAREDESTUNKNOWN:
            self.completionBlock(CMShareErrorCode_Common, @"未知错误类型");
            break;
        case EQQAPISENDFAILD:
            self.completionBlock(CMShareErrorCode_SentFail, @"发送失败");
            break;
        case EQQAPIQZONENOTSUPPORTTEXT:
            self.completionBlock(CMShareErrorCode_QZoneNotSupportText, @"QQ空间不支持文本分享");
            break;
        case EQQAPIQZONENOTSUPPORTIMAGE:
            self.completionBlock(CMShareErrorCode_QZoneNotSupportImage, @"QQ空间不支持单张图片分享");
            break;
        case EQQAPIVERSIONNEEDUPDATE:
            self.completionBlock(CMShareErrorCode_Unsupport, @"QQ版本不支持");
            break;
            
        default:
            break;
    }
}

@end

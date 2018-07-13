//
//  CMShareEnums.h
//  CMShareSDK
//
//  Created by lx2 on 2018/7/9.
//  Copyright © 2018年 lx2. All rights reserved.
//

#ifndef CMShareEnums_h
#define CMShareEnums_h

typedef NS_ENUM (NSInteger, CMShareScene) {
    CMShareScene_WXSceneSession     = 0,         // 微信联系人
    CMShareScene_WXSceneTimeline    = 1,         // 微信朋友圈
    CMShareScene_WXSceneFavorite    = 2,         // 微信收藏
    CMShareScene_QQSceneSession     = 3,         // QQ联系人
    CMShareScene_QQSceneQZone       = 4          // QQ空间
};

typedef NS_ENUM (NSInteger, CMShareErrorCode) {
    CMShareErrorCode_Success                    = 0,         // 分享成功
    CMShareErrorCode_Common                     = -1,        // 普通错误类型
    CMShareErrorCode_UserCancel                 = -2,        // 用户点击取消并返回
    CMShareErrorCode_SentFail                   = -3,        // 发送失败
    CMShareErrorCode_AuthDeny                   = -4,        // 授权失败
    CMShareErrorCode_Unsupport                  = -5,        // App版本不支持
    // 以下错误码只有QQ分享才会出现
    CMShareErrorCode_QQNotInstalled             = -6,        // QQ未安装
    CMShareErrorCode_QQNotSupportApi            = -7,        // QQ不支持的Api
    CMShareErrorCode_QQMessageTypeInvalid       = -8,        // QQ消息类型无效
    CMShareErrorCode_QQMessageContentNull       = -9,        // QQ消息内容为空
    CMShareErrorCode_QQMessageContentInvalid    = -10,       // QQ消息内容无效
    CMShareErrorCode_QZoneNotSupportText        = -11,       // QQ空间不支持文本分享
    CMShareErrorCode_QZoneNotSupportImage       = -12,       // QQ空间不支持分享单张图片
};

#endif /* CMShareEnums_h */

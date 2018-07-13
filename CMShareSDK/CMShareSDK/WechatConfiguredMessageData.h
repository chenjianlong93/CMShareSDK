//
//  WechatConfiguredMessageData.h
//  CMShareSDK
//
//  Created by lx2 on 2018/7/10.
//  Copyright © 2018年 lx2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WXApiObject.h>

@interface WechatConfiguredMessageData : NSObject

/**
 组装微信多媒体数据
 
 @param title 标题
 @param description 描述
 @param mediaObject 多媒体对象
 @param messageExt 信息扩展
 @param action 信息行为
 @param thumbImage 缩略图
 @param tagName 标签
 @return 返回多媒体数据
 */
+ (WXMediaMessage *)messageWithTitle:(NSString *)title
                         Description:(NSString *)description
                              Object:(id)mediaObject
                          MessageExt:(NSString *)messageExt
                       MessageAction:(NSString *)action
                          ThumbImage:(UIImage *)thumbImage
                            MediaTag:(NSString *)tagName;

/**
 微信分享请求
 
 @param text 文本
 @param message 多媒体类型
 @param bText YES为文本,NO为多媒体类型
 @param scene 分享场景
 @return 消息请求
 */
+ (SendMessageToWXReq *)requestWithText:(NSString *)text
                         OrMediaMessage:(WXMediaMessage *)message
                                  bText:(BOOL)bText
                                InScene:(enum WXScene)scene;

/**
 微信分享响应
 
 @param text 文本
 @param message 多媒体类型
 @param bText YES为文本,NO为多媒体类型
 @return 消息响应
 */
+ (GetMessageFromWXResp *)responseWithText:(NSString *)text
                            OrMediaMessage:(WXMediaMessage *)message
                                     bText:(BOOL)bText;

@end

//
//  CMShareManager.h
//  CMShareSDK
//
//  Created by lx2 on 2018/7/9.
//  Copyright © 2018年 lx2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMShareModel.h"
#import "CMShareEnums.h"

/**
 数据处理过的返回 Block
 
 */
typedef void (^CMShareCompletionHandler) (CMShareErrorCode responseCode, NSString *msg);

@interface CMShareManager : NSObject

/**
 获取默认单例

 @return 单例
 */
+ (CMShareManager *)defaultManager;

/**
 设置微信的 AppKey
 */
- (void)setWeChatAppKey:(NSString *)Key;

/**
 设置QQ互联的 AppKey
 */
- (void)setQQAppKey:(NSString *)Key;

/**
 *  获得从sso或者web端回调到本app的回调
 *
 *  @param url qq微信等打开本app的回调的url
 *
 *  @return 是否处理  YES代表处理成功，NO代表不处理
 */
- (BOOL)handleOpenURL:(NSURL *)url;

/**
 获取当前分享的平台
 
 @return 当前分享平台
 */
- (CMShareScene)currentShareScene;

/**
 *  设置分享平台
 *
 *  @param scene  平台类型 @see CMShareScene
 *  @param messageObject  分享的content @see CMShareMessageModel
 *  @param currentViewController 用于弹出类似邮件分享、短信分享等这样的系统页面
 *  @param completion   回调
 *  @discuss currentViewController 只正对sms,email等平台需要传入viewcontroller的平台，其他不需要的平台可以传入nil
 */
- (void)shareToPlatform:(CMShareScene)scene
          messageObject:(CMShareMessageModel *)messageObject
  currentViewController:(id)currentViewController
             completion:(CMShareCompletionHandler)completion;

@end

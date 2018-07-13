//
//  WechatApiRequestHandler.h
//  CMShareSDK
//
//  Created by lx2 on 2018/7/10.
//  Copyright © 2018年 lx2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CMShareEnums.h"
#import "CMShareModel.h"

@interface WechatApiRequestHandler : NSObject

+ (BOOL)shareToWechatInScene:(CMShareScene)scene messageObject:(CMShareMessageModel *)messageObject;

@end

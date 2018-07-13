//
//  QQApiRequestHandler.h
//  CMShareSDK
//
//  Created by lx2 on 2018/7/10.
//  Copyright © 2018年 lx2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "CMShareModel.h"
#import "CMShareEnums.h"

@interface QQApiRequestHandler : NSObject

+ (QQApiSendResultCode)shareToQQInScene:(CMShareScene)scene messageObject:(CMShareMessageModel *)messageObject;

@end

//
//  CMShareHelper.m
//  CMShareSDK
//
//  Created by lx2 on 2018/7/9.
//  Copyright © 2018年 lx2. All rights reserved.
//

#import "CMShareHelper.h"

@implementation CMShareHelper

+ (BOOL)isBlankString:(NSString*)string {
    if((string == nil)||(string==NULL))
        return YES;
    if([string isKindOfClass:[NSNull class]])
        return YES;
    if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length]==0)
        return YES;
    return NO;
}

@end

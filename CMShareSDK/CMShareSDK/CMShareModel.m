//
//  CMShareModel.m
//  CMShareSDK
//
//  Created by lx2 on 2018/7/9.
//  Copyright © 2018年 lx2. All rights reserved.
//

#import "CMShareModel.h"
#import "CMShareHelper.h"
#import <UIKit/UIKit.h>
#import "CMShareManager.h"

@implementation CMShareModel

@dynamic thumbImage;
static id _thumbImage;

+ (id)shareModelWithTitle:(NSString *)title descr:(NSString *)descr thumImage:(id)thumImage {
    CMShareModel *model = [CMShareModel new];
    model.title = title;
    model.descr = descr;
    model.thumbImage = thumImage;
    return model;
}

- (void)setThumbImage:(id)thumbImage {
    if (!thumbImage) {
        return;
    }
    if ([thumbImage isKindOfClass:[UIImage class]]) {
        _thumbImage = thumbImage;
    }else if ([thumbImage isKindOfClass:[NSString class]]) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: thumbImage]];
        if (data) {
            _thumbImage = [UIImage imageWithData:data];
        }
    }else if ([thumbImage isKindOfClass:[NSData class]]) {
        _thumbImage = [UIImage imageWithData:thumbImage];
    }
}

- (id)thumbImage {
    // 微信图片需求的格式是UIImage，QQ则是NSData
    if ([CMShareManager defaultManager].currentShareScene > 2) {
        return UIImageJPEGRepresentation(_thumbImage, 1);
    }else {
        return _thumbImage;
    }
}

@end

@implementation CMShareMessageModel

+ (CMShareMessageModel *)messageObject {
    return [CMShareMessageModel new];
}

@end

@implementation CMShareImageModel

+ (CMShareImageModel *)shareModelWithTitle:(NSString *)title descr:(NSString *)descr thumImage:(id)thumImage {
    CMShareImageModel *model = [CMShareImageModel new];
    model.title = title;
    model.descr = descr;
    model.thumbImage = thumImage;
    return model;
}

- (void)setShareImage:(id)shareImage {
    if (!shareImage) {
        return;
    }
    if ([shareImage isKindOfClass:[UIImage class]]) {
        _shareImage =  UIImageJPEGRepresentation(_shareImage, 1); //UIImagePNGRepresentation(_shareImage) ? UIImagePNGRepresentation(_shareImage) :
    }else if ([shareImage isKindOfClass:[NSString class]]) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: shareImage]];
        _shareImage = data;
    }else if ([shareImage isKindOfClass:[NSData class]]) {
        _shareImage = shareImage;
    }
}

@end

@implementation CMShareMusicModel

+ (CMShareMusicModel *)shareModelWithTitle:(NSString *)title descr:(NSString *)descr thumImage:(id)thumImage {
    CMShareMusicModel *model = [CMShareMusicModel new];
    model.title = title;
    model.descr = descr;
    model.thumbImage = thumImage;
    return model;
}

@end

@implementation CMShareVideoModel

+ (CMShareVideoModel *)shareModelWithTitle:(NSString *)title descr:(NSString *)descr thumImage:(id)thumImage {
    CMShareVideoModel *model = [CMShareVideoModel new];
    model.title = title;
    model.descr = descr;
    model.thumbImage = thumImage;
    return model;
}

@end

@implementation CMShareWebpageModel

+ (CMShareWebpageModel *)shareObjectWithTitle:(NSString *)title descr:(NSString *)descr thumImage:(id)thumImage {
    CMShareWebpageModel *model = [CMShareWebpageModel new];
    model.title = title;
    model.descr = descr;
    model.thumbImage = thumImage;
    return model;
}

@end

@implementation CMShareEmotionModel

+ (CMShareEmotionModel *)shareObjectWithTitle:(NSString *)title descr:(NSString *)descr thumImage:(id)thumImage {
    CMShareEmotionModel *model = [CMShareEmotionModel new];
    model.title = title;
    model.descr = descr;
    model.thumbImage = thumImage;
    return model;
}

@end

@implementation CMShareFileModel

+ (CMShareFileModel *)shareObjectWithTitle:(NSString *)title descr:(NSString *)descr thumImage:(id)thumImage {
    CMShareFileModel *model = [CMShareFileModel new];
    model.title = title;
    model.descr = descr;
    model.thumbImage = thumImage;
    return model;
}

@end

@implementation CMShareMiniProgramModel

+ (CMShareMiniProgramModel *)shareObjectWithTitle:(NSString *)title descr:(NSString *)descr thumImage:(id)thumImage {
    CMShareMiniProgramModel *model = [CMShareMiniProgramModel new];
    model.title = title;
    model.descr = descr;
    model.thumbImage = thumImage;
    return model;
}

@end


//
//  QQApiRequestHandler.m
//  CMShareSDK
//
//  Created by lx2 on 2018/7/10.
//  Copyright © 2018年 lx2. All rights reserved.
//

#import "QQApiRequestHandler.h"
#import <TencentOpenAPI/QQApiInterface.h>

@implementation QQApiRequestHandler

+ (QQApiSendResultCode)shareToQQInScene:(CMShareScene)scene messageObject:(CMShareMessageModel *)messageObject {
    
    QQApiObject *shareObject;
    // 文本消息分享
    if (!messageObject.shareObject) {
        QQApiTextObject *text = [QQApiTextObject objectWithText:messageObject.text];
        shareObject = text;
    }else {
        
        if ([messageObject.shareObject isKindOfClass:[CMShareImageModel class]]) {
            
            CMShareImageModel *imageModel = messageObject.shareObject;
            // 图片数组
            if (imageModel.shareImageArray && imageModel.shareImageArray.count) {
                QQApiImageArrayForQZoneObject *imageArray = [QQApiImageArrayForQZoneObject objectWithimageDataArray:imageModel.shareImageArray title:imageModel.title];
                shareObject = imageArray;
            }else { //单张图片分享
                QQApiImageObject *image = [QQApiImageObject objectWithData:imageModel.shareImage previewImageData:imageModel.thumbImage title:imageModel.title description:imageModel.descr];
                shareObject = image;
            }
            
        }else if ([messageObject.shareObject isKindOfClass:[CMShareMusicModel class]]) {
            
            CMShareMusicModel *musicModel = messageObject.shareObject;
            QQApiAudioObject *music = [QQApiAudioObject objectWithURL:[NSURL URLWithString:musicModel.musicUrl] title:musicModel.title description:musicModel.descr previewImageData:musicModel.thumbImage];
            shareObject = music;
            
        }else if ([messageObject.shareObject isKindOfClass:[CMShareVideoModel class]]) {
            
            CMShareVideoModel *videoModel = messageObject.shareObject;
            QQApiVideoObject *video = [QQApiVideoObject objectWithURL:[NSURL URLWithString:videoModel.videoUrl] title:videoModel.title description:videoModel.descr previewImageData:videoModel.thumbImage];
            shareObject = video;
            
        }else if ([messageObject.shareObject isKindOfClass:[CMShareWebpageModel class]]) {
            
            CMShareWebpageModel *webpageModel = messageObject.shareObject;
            QQApiNewsObject *webpage = [QQApiNewsObject objectWithURL:[NSURL URLWithString:webpageModel.webpageUrl] title:webpageModel.title description:webpageModel.descr previewImageData:webpageModel.thumbImage];
            shareObject = webpage;
            
        }else if ([messageObject.shareObject isKindOfClass:[CMShareFileModel class]]) {
            
            CMShareFileModel *fileModel = messageObject.shareObject;
            QQApiFileObject *file = [QQApiFileObject objectWithData:fileModel.fileData previewImageData:fileModel.thumbImage title:fileModel.title description:fileModel.descr];
            shareObject = file;
            
        }
    }
    if (!shareObject) {
        return EQQAPISENDFAILD;
    }
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:shareObject];
    if (scene == CMShareScene_QQSceneSession) {
        return [QQApiInterface sendReq:req];
    }else {
        return [QQApiInterface SendReqToQZone:req];
    }
}

@end

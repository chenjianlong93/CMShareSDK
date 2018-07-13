//
//  WechatApiRequestHandler.m
//  CMShareSDK
//
//  Created by lx2 on 2018/7/10.
//  Copyright © 2018年 lx2. All rights reserved.
//

#import "WechatApiRequestHandler.h"
#import "WechatConfiguredMessageData.h"
#import <WXApiObject.h>
#import <WXApi.h>

@implementation WechatApiRequestHandler

+ (BOOL)shareToWechatInScene:(CMShareScene)scene messageObject:(CMShareMessageModel *)messageObject {
    if (!messageObject.shareObject) {
        return [self sendTextInScene:scene messageObject:messageObject];
    }else {
        return [self sendMediaInScene:scene messageObject:messageObject];
    }
}

// 分享文本消息
+ (BOOL)sendTextInScene:(CMShareScene)scene
          messageObject:(CMShareMessageModel *)messageObject {
    SendMessageToWXReq *req = [WechatConfiguredMessageData
                               requestWithText:messageObject.text
                                OrMediaMessage:nil
                                         bText:YES
                                       InScene:(enum WXScene)scene];
    return [WXApi sendReq:req];
}

// 分享多媒体消息
+ (BOOL)sendMediaInScene:(CMShareScene)scene
           messageObject:(CMShareMessageModel *)messageObject {
    CMShareModel *shareModel = messageObject.shareObject;
    id shareObject;
    if ([messageObject.shareObject isKindOfClass:[CMShareImageModel class]]) {
        
        CMShareImageModel *imageModel = messageObject.shareObject;
        WXImageObject *image = [WXImageObject object];
        image.imageData = imageModel.shareImage;
        shareObject = image;
        
    }else if ([messageObject.shareObject isKindOfClass:[CMShareMusicModel class]]) {
        
        CMShareMusicModel *musicModel = messageObject.shareObject;
        WXMusicObject *music = [WXMusicObject object];
        music.musicUrl = musicModel.musicUrl;
        music.musicDataUrl = musicModel.musicDataUrl;
        shareObject = music;
        
    }else if ([messageObject.shareObject isKindOfClass:[CMShareVideoModel class]]) {
        
        CMShareVideoModel *videoModel = messageObject.shareObject;
        WXVideoObject *video = [WXVideoObject object];
        video.videoUrl = videoModel.videoUrl;
        video.videoLowBandUrl = videoModel.videoLowBandUrl;
        shareObject = video;
        
    }else if ([messageObject.shareObject isKindOfClass:[CMShareWebpageModel class]]) {
        
        CMShareWebpageModel *webpageModel = messageObject.shareObject;
        WXWebpageObject *webpage = [WXWebpageObject object];
        webpage.webpageUrl = webpageModel.webpageUrl;
        shareObject = webpage;
        
    }else if ([messageObject.shareObject isKindOfClass:[CMShareEmotionModel class]]) {
        
        CMShareEmotionModel *emotionModel = messageObject.shareObject;
        WXEmoticonObject *emotion = [WXEmoticonObject object];
        emotion.emoticonData = emotionModel.emoticonData;
        shareObject = emotion;
        
    }else if ([messageObject.shareObject isKindOfClass:[CMShareFileModel class]]) {
        
        CMShareFileModel *fileModel = messageObject.shareObject;
        WXFileObject *file = [WXFileObject object];
        file.fileExtension = fileModel.fileExtension;
        file.fileData = fileModel.fileData;
        shareObject = file;
        
    }else if ([messageObject.shareObject isKindOfClass:[CMShareMiniProgramModel class]]) {
        
        CMShareMiniProgramModel *miniProgramModel = messageObject.shareObject;
        WXMiniProgramObject *miniProgram = [WXMiniProgramObject object];
        miniProgram.webpageUrl = miniProgramModel.webpageUrl;
        miniProgram.userName = miniProgramModel.userName;
        miniProgram.path = miniProgramModel.path;
        miniProgram.hdImageData = miniProgramModel.hdImageData;
        miniProgram.withShareTicket = miniProgramModel.withShareTicket;
        miniProgram.miniProgramType = miniProgramModel.miniProgramType;
        shareObject = miniProgram;
        
    }
    
    WXMediaMessage *message = [WechatConfiguredMessageData messageWithTitle:shareModel.title
                                                            Description:shareModel.descr
                                                                 Object:shareObject
                                                             MessageExt:nil
                                                          MessageAction:nil
                                                             ThumbImage:shareModel.thumbImage
                                                               MediaTag:nil];
    
    SendMessageToWXReq* req = [WechatConfiguredMessageData requestWithText:nil
                                                        OrMediaMessage:message
                                                                 bText:NO
                                                               InScene:(enum WXScene)scene];
    return [WXApi sendReq:req];
}

@end

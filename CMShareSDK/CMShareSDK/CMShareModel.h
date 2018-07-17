//
//  CMShareModel.h
//  CMShareSDK
//
//  Created by lx2 on 2018/7/9.
//  Copyright © 2018年 lx2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMShareModel : NSObject

/**
 * 标题
 * @note 标题的长度依各个平台的要求而定
 */
@property (nonatomic, copy) NSString *title;

/**
 * 描述
 * @note 描述内容的长度依各个平台的要求而定
 */
@property (nonatomic, copy) NSString *descr;

/**
 * 缩略图 UIImage或者NSData类型或者NSString类型（图片url）
 */
@property (nonatomic, strong) id thumbImage;

/**
 * @param title 标题
 * @param descr 描述
 * @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
 *
 */
+ (id)shareModelWithTitle:(NSString *)title
                    descr:(NSString *)descr
                thumImage:(id)thumImage;

@end

@interface CMShareMessageModel : NSObject

/**
 * text 文本内容
 * @note 非纯文本分享文本
 */
@property (nonatomic, copy) NSString  *text;

/**
 * 分享的所媒体内容对象(必须是CMShareModel或其子类CMShareImageModel、CMShareMusicModel、CMShareVideoModel、CMShareWebpageModel)
 */
@property (nonatomic, strong) id shareObject;

/**
 * 其他相关参数(预留)
 */
@property (nonatomic, strong) NSDictionary *moreInfo;

+ (CMShareMessageModel *)messageObject;

@end

@interface CMShareImageModel : CMShareModel

/** 分享单个图片（支持UIImage，NSdata以及图片链接Url NSString类对象集合）
 * @note 图片大小根据各个平台限制而定
 */
@property (nonatomic, retain) id shareImage;

/** 分享图片数组，支持 UIImage、NSData     类型
 * @note 仅支持分享到：
 *      微博平台，最多可分享9张图片
 *      QZone平台，最多可分享20张图片
 */
@property (nonatomic, copy) NSArray *shareImageArray;

/**
 * @param title 标题
 * @param descr 描述
 * @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
 *
 */
+ (CMShareImageModel *)shareModelWithTitle:(NSString *)title
                                     descr:(NSString *)descr
                                 thumImage:(id)thumImage;

@end

@interface CMShareMusicModel : CMShareModel

/** 音乐网页的url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString *musicUrl;
/** 音乐lowband网页的url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString *musicLowBandUrl;
/** 音乐数据url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString *musicDataUrl;

/**音乐lowband数据url地址
 * @note 长度不能超过10K
 */
@property (nonatomic, retain) NSString *musicLowBandDataUrl;

/**
 * @param title 标题
 * @param descr 描述
 * @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
 *
 */
+ (CMShareMusicModel *)shareModelWithTitle:(NSString *)title
                                     descr:(NSString *)descr
                                 thumImage:(id)thumImage;

@end

@interface CMShareVideoModel : CMShareModel

/**
 视频网页的url
 
 @warning 不能为空且长度不能超过255
 */
@property (nonatomic, strong) NSString *videoUrl;

/**
 视频lowband网页的url
 
 @warning 长度不能超过255
 */
@property (nonatomic, strong) NSString *videoLowBandUrl;

/**
 视频数据流url
 
 @warning 长度不能超过255
 */
@property (nonatomic, strong) NSString *videoStreamUrl;

/**
 视频lowband数据流url
 
 @warning 长度不能超过255
 */
@property (nonatomic, strong) NSString *videoLowBandStreamUrl;


/**
 * @param title 标题
 * @param descr 描述
 * @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
 *
 */
+ (CMShareVideoModel *)shareModelWithTitle:(NSString *)title
                                     descr:(NSString *)descr
                                 thumImage:(id)thumImage;

@end

@interface CMShareWebpageModel : CMShareModel

/** 网页的url地址
 * @note 不能为空且长度不能超过10K
 */
@property (nonatomic, retain) NSString *webpageUrl;

/**
 * @param title 标题
 * @param descr 描述
 * @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
 *
 */
+ (CMShareWebpageModel *)shareModelWithTitle:(NSString *)title
                                         descr:(NSString *)descr
                                     thumImage:(id)thumImage;

@end

#pragma mark ------------------以下数据类型仅支持微信好友分享(微信表情、文件、微信小程序)，文件支持微信收藏-----------------

@interface CMShareEmotionModel : CMShareModel

/** 表情真实数据内容
 * @note 大小不能超过10M
 */
@property (nonatomic, retain) NSData *emoticonData;

/**
 * @param title 标题
 * @param descr 描述
 * @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
 *
 */
+ (CMShareEmotionModel *)shareModelWithTitle:(NSString *)title
                                        descr:(NSString *)descr
                                    thumImage:(id)thumImage;

@end

@interface CMShareFileModel : CMShareModel

/** 文件后缀名
 * @note 长度不超过64字节
 */
@property (nonatomic, retain) NSString  *fileExtension;

/** 文件真实数据内容
 * @note 大小不能超过10M
 */
@property (nonatomic, retain) NSData    *fileData;

/**
 * @param title 标题
 * @param descr 描述
 * @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
 *
 */
+ (CMShareFileModel *)shareModelWithTitle:(NSString *)title
                                     descr:(NSString *)descr
                                 thumImage:(id)thumImage;

@end

@interface CMShareMiniProgramModel : CMShareModel

@property (nonatomic, strong) NSString *webpageUrl; //低版本网页链接

@property (nonatomic, strong) NSString *userName;   //小程序username

@property (nonatomic, strong) NSString *path;       //小程序页面的路径

@property (nonatomic, strong) NSData *hdImageData;   // 小程序新版本的预览图 128k

@property (nonatomic, assign) BOOL withShareTicket;   //是否使用带 shareTicket 的转发

@property (nonatomic, assign) NSInteger miniProgramType;  // 分享小程序的版本（正式，开发，体验）

/**
 * @param title 标题
 * @param descr 描述
 * @param thumImage 缩略图（UIImage或者NSData类型，或者image_url）
 *
 */
+ (CMShareMiniProgramModel *)shareModelWithTitle:(NSString *)title
                                            descr:(NSString *)descr
                                        thumImage:(id)thumImage;

@end



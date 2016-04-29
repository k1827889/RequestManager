//
//  UserLogin.h
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../WebRequest.h"


/**
 *  用户相册图片管理
 */
@interface UserAlbum : WebRequest

@property(nonatomic,strong) UIImage* m_ImagePhoto;//相册图片
@property(nonatomic,strong) NSString* m_strPhotoId;//相册图片ID
@property (nonatomic, copy)  ReqSuccessObject successBlock; //保存成功回调


/**
 *  上传相册图片
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)UpLoadPhoto:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  删除相册图片
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)DeletePhoto:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  设置相册主图片
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)SetMainPhoto:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

@end

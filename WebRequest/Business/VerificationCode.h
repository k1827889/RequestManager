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
 *  验证码
 */
@interface VerificationCode : WebRequest

@property(nonatomic,strong) NSString* m_strType;   //验证码类型
@property(nonatomic,strong) NSString* m_strPhone;  //手机号码
@property (nonatomic, copy) ReqSuccessObject successBlock; //保存成功回调

/**
 *  验证码获取
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)GetVCode:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

@end

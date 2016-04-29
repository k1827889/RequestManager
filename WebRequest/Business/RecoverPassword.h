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
 *  找回密码
 */
@interface RecoverPassword : WebRequest

@property(nonatomic,strong) NSString* m_strPhone;        //手机
@property(nonatomic,strong) NSString* m_strPassword;     //密码
@property(nonatomic,strong) NSString* m_strVCode;        //验证码

@property (nonatomic, copy) ReqSuccessBlock successBlock; //保存成功回调

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessBlock)successBlock failure:(ErrorData)failBlock;

@end

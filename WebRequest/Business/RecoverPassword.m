//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "RecoverPassword.h"
#import "../../ProConst.h"

@implementation RecoverPassword

@synthesize m_strPhone;        //手机
@synthesize m_strPassword;     //密码
@synthesize m_strVCode;        //验证码

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessBlock)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strPhone forKey:@"mobile"];
    [parameters setObject:m_strPassword forKey:@"password"];
    [parameters setObject:m_strVCode forKey:@"vcode"];
    
    //加路由
    NSString* strroute =@"api/user/changPwdByVcode";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    [self StartRequest:^(id responseObject)
     {
         if (successBlock)
         {
             successBlock();
         }
     }
     failure:failBlock
     ];
}

@end

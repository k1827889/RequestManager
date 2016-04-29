//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "VerificationCode.h"
#import "../../ProConst.h"

@implementation VerificationCode

@synthesize m_strType;   //验证码类型
@synthesize m_strPhone;  //手机号码

/**
 *  验证码获取
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)GetVCode:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strType forKey:@"type"];
    [parameters setObject:m_strPhone forKey:@"mobile"];
    
    //加路由
    NSString* strroute =@"api/vcode/index";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (weakSelf.successBlock)
         {
             weakSelf.successBlock(responseObject);
         }
     }
     failure:failBlock
     ];
}


@end

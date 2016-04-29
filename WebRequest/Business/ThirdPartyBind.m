//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "ThirdPartyBind.h"
#import "../../ProConst.h"

@implementation ThirdPartyBind

@synthesize m_nOpenType;        //1:QQ 2:WeChat 3:weibo
@synthesize m_strOpenID;        //openid
@synthesize m_bIsBind;          //是否绑定

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
    NSString* str = nil;
    //加路由
    NSString* strroute = nil;
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strOpenID forKey:@"openId"];
    str = [NSString stringWithFormat:@"%d",m_nOpenType];
    [parameters setObject:str forKey:@"openType"];
    if (m_bIsBind)
    {
        strroute = @"api/user/thirdBind";
    }
    else
    {
        strroute = @"api/user/removeThirdBind";
    }
    
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

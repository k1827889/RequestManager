//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "Interactive.h"
#import "../../ProConst.h"

@implementation Interactive

@synthesize m_strEmail;     //邮箱
@synthesize m_strContent;     //发动态的内容

/**
 *  用户反馈
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)Feedback:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strEmail forKey:@"email"];
    [parameters setObject:m_strContent forKey:@"content"];
    
    //加路由
    NSString* strroute =@"api/feedback/add";
    
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

/**
 *  签到
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)SignIn:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = nil;
    
    //加路由
    NSString* strroute =@"api/user/signin";
    
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

//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "UserLogin.h"
#import "../../ProConst.h"
#import "../../../MainDlg/My/Data/UserData.h"

@implementation UserLogin

@synthesize m_strUserName;  //用户名
@synthesize m_strPassword;  //密码

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strUserName forKey:@"username"];
    [parameters setObject:m_strPassword forKey:@"password"];
    
    [self SetReqUrl:LoginUrl Route:nil ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         //分析数据
         [weakSelf ParseData:responseObject];
     }
     failure:failBlock
     ];
}

/**
 *  解析数据
 *
 *  @param dcData <#dcData description#>
 */
-(void)ParseData:(NSDictionary*) dcData
{
    if ( !self.successBlock )
        return;
    
    UserData* Data = nil;
    if ( !isNull(dcData) )
    {
        //得到数据
        Data = [[UserData alloc] InitWithDictionary:dcData];
    }
    
    //回调
    self.successBlock(Data);
}

@end

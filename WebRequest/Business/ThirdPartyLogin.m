//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "ThirdPartyLogin.h"
#import "../../ProConst.h"
#import "../../../MainDlg/My/Data/UserData.h"

@implementation ThirdPartyLogin

@synthesize m_nOpenType;        //1:QQ 2:WeChat 3:weibo
@synthesize m_strOpenID;        //openid
@synthesize m_strUserName;      //用户名
@synthesize m_strUserImgUrl;    //用户头像

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
    NSString* str = nil;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strOpenID forKey:@"openId"];
    str = [NSString stringWithFormat:@"%d",m_nOpenType];
    [parameters setObject:str forKey:@"openType"];
    [parameters setObject:m_strUserName forKey:@"nickname"];
    [parameters setObject:m_strUserImgUrl forKey:@"headimgurl"];
    
    [self SetReqUrl:ThirdPartyLoginUrl Route:nil ReqParameters:parameters];
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

//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "UserInfo.h"
#import "../../ProConst.h"
#import "../../../MainDlg/My/Data/UserData.h"

@implementation UserInfo

@synthesize m_strUserId;            //用户的id
@synthesize m_strUserName;          //用户名
@synthesize m_strRealName;          //真实姓名
@synthesize m_strBirthday;          //生日
@synthesize m_nAge;                 //年龄
@synthesize m_bySex;                //性别 1:男 0:女
@synthesize m_strPhone;             //手机号码
@synthesize m_strEmail;             //邮箱
@synthesize m_nHeight;              //身高
@synthesize m_fWeight;              //体重
@synthesize m_strPlace;             //地理位置
@synthesize m_strSignature;         //个性签名


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
    NSMutableDictionary *parameters = nil;
    if (m_strUserId)
    {
        parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:m_strUserId forKey:@"uid"];
    }
    
    //加路由
    NSString* strroute =@"api/user/getUserInfo";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
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


/**
 *  更新用户信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)UpdateUserInfo:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSString *str = nil;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    if (!m_strUserName)
    {
        [parameters setObject:@"" forKey:@"nickname"];
    }
    else
    {
        [parameters setObject:m_strUserName forKey:@"nickname"];
    }
    
    if (!m_strEmail)
    {
        [parameters setObject:@"" forKey:@"email"];
    }
    else
    {
        [parameters setObject:m_strEmail forKey:@"email"];
    }
    
    if (!m_strPhone)
    {
        [parameters setObject:@"" forKey:@"mobile"];
    }
    else
    {
        [parameters setObject:m_strPhone forKey:@"mobile"];
    }
    
    if (!m_strBirthday)
    {
        [parameters setObject:@"" forKey:@"birthday"];
    }
    else
    {
        [parameters setObject:m_strBirthday forKey:@"birthday"];
    }
    
    if (!m_strPlace)
    {
        [parameters setObject:@"" forKey:@"location"];
    }
    else
    {
        [parameters setObject:m_strPlace forKey:@"location"];
    }
    
    if (!m_strRealName)
    {
        [parameters setObject:@"" forKey:@"realname"];
    }
    else
    {
        [parameters setObject:m_strRealName forKey:@"realname"];
    }
    
    
    str = [[NSString alloc]initWithFormat:@"%d",m_bySex];
    [parameters setObject:str forKey:@"gender"];
    
    str = [[NSString alloc]initWithFormat:@"%.1f",m_fWeight];
    [parameters setObject:str forKey:@"weight"];
    
    str = [[NSString alloc]initWithFormat:@"%d",m_nHeight];
    [parameters setObject:str forKey:@"height"];
    
    if (!m_strSignature)
    {
        [parameters setObject:@"" forKey:@"signature"];
    }
    else
    {
        [parameters setObject:m_strSignature forKey:@"signature"];
    }
    
    //加路由
    NSString* strroute =@"api/user/updateUserInfo";
    
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

//
//  NetWorkManager.m
//  Cougar
//
//  Created by zly on 15/12/18.
//  Copyright © 2015年 zly. All rights reserved.
//

#import "RequestManager.h"
#import <AFNetworking.h>
#import "ProConst.h"

/**
 *  网络请求管理类
 */
@interface RequestManager()
{
    //HTTP请求类
    AFHTTPSessionManager *m_manager;
    
    //网络状态管理
    AFNetworkReachabilityManager *m_StatusManager;
    NSString * m_strSessionID;  //会话id 如果为空则为失效
    BOOL m_bUpdateSession;      //会话是否更新
    BOOL m_bFirstLogin;         //会话是否有效
    NSDate * m_dtLoginTime;     //登陆时间
    
    //保存上次的请求参数
    NSString * m_strUrl;
    NSMutableDictionary* m_dcparameters;
    NSString* m_strRoute;
    
    //附加的请求参数
    NSDictionary* m_dcAttachParameters;
    
    //保存用户名和密码，用于更新会话
    NSString*  m_strUser;              //账号
    NSString*  m_strPassword;          //密码
    
    NSString*  m_strOpenID;            //第三方登录的openid
    int        m_nOpenType;            //登录类型 0:手机登录 1:QQ 2:WeChat 3:weibo
    NSString*  m_strUserName;          //昵称
    NSString*  m_strUserImgUrl;        //用户头像url
    
    //当前更新的次数
    int m_nCurrentUpdateCount;
    
    //当前重试的次数
    int m_nRetryCount;
}
@end


@implementation RequestManager

/**
 *  重载
 *
 *  @return
 */
- (instancetype) init
{
    if ( self = [super init] )
    {
        m_manager = nil;
        m_StatusManager = nil;
        m_dcparameters = [[NSMutableDictionary alloc]init];
        
        m_bFirstLogin = YES;
        m_bUpdateSession = NO;
        m_nCurrentUpdateCount = 0;
        m_nRetryCount = 0;
    }
    
    return self;
}

-(void) dealloc
{
    NSLog(@"%s dealloc", object_getClassName(self));
}

/**
 *  开始网络状态监听
 *
 *  @return
 */
-(void)StartNetWorkMonitor
{
    m_StatusManager = [AFNetworkReachabilityManager sharedManager];
    [m_StatusManager startMonitoring];
    [m_StatusManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
    {
        switch (status)
        {
            case AFNetworkReachabilityStatusNotReachable:
            {
                NSLog(@"无网络");
            }
            break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                NSLog(@"WiFi网络");
            }
            break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                NSLog(@"无线网络");
            }
            break;
                
            default:
            {
               NSLog(@"未知网络");
            }
            break;
                
        }
    }];
}

/**
 *  停止网络状态监听
 */
-(void)StopNetWorkMonitor
{
    if (m_StatusManager)
    {
        [m_StatusManager stopMonitoring];
        m_StatusManager = nil;
    }
}

/**
 *  是否联网
 *
 *  @return <#return value description#>
 */
-(BOOL)IsNetworking
{
    if (m_StatusManager.networkReachabilityStatus <= 0)
    {
        return NO;
    }
    
    return YES;
}

/**
 *  设置请求超时时间
 *
 *  @param dTimeOut <#nTimeOut description#>
 */
-(void)SetRequestTimeOut:(double)dTimeOut
{
    if (m_manager)
    {
        m_manager.requestSerializer.timeoutInterval = dTimeOut;
    }
}

/**
 *  取消请求
 */
-(void)CancelRequest
{
    if (m_manager)
    {
        [m_manager.operationQueue cancelAllOperations];
    }
}

/**
 *  得到主域名url
 *
 *  @return <#return value description#>
 */
-(NSString*)GetDomainNameUrl
{
    return DomainNameUrl;
}

/**
 *  得到会话ID
 *
 *  @return <#return value description#>
 */
-(NSString*)GetSessionID
{
    return m_strSessionID;
}

/**
 *  得到登录类型
 *
 *  @return 0:手机登录 1:QQ 2:WeChat 3:weibo
 */
-(NSInteger)GetLoginType
{
    return m_nOpenType;
}

/**
 *  关闭实例
 */
-(void)UnInit
{
    //取消所有请求
    [self CancelRequest];
    
    //HTTP请求类
    if(m_manager)
    {
        m_manager = nil;
    }
    
    //停止网络临控
    if (m_StatusManager)
    {
        [self StopNetWorkMonitor];
    }
    
    //会话id
    if (m_strSessionID)
    {
        m_strSessionID = nil;
    }
}

/**
 *  会话状态和响应状态判断
 *
 *  @param JSONData <#JSONData description#>
 *
 *  @return 1为登录成功，-1为更新accessToken过期，-2为其他设备登录，0为登录失败（请求结果,1为成功，0为失败）
 */
-(int)StatusJudge:(id)JSONData success:(SuccessData)ReqSuccess failure:(ErrorData)ReqFailure
{
    NSString *strResponse = [JSONData valueForKeyPath:@"status"];
    int nRet = [strResponse intValue];
    
    // 在AFN的block内使用，防止造成循环引用
    ZWeakSelf;
    
    if (nRet==-1)
    {
        m_strSessionID = nil;
        if (m_nCurrentUpdateCount>=SessionUpdateRetryCount)
        {
            NSString* str = @"获取会话失败!";
            NSError* err = [[NSError alloc] initWithDomain:str
                                                      code:-1
                                                  userInfo:nil];
            if (ReqFailure)
            {
                ReqFailure(err);
            }
            
            return 0;
        }
        
        //更新会话
        [self SessionUpdate:ReqSuccess failure:ReqFailure];
    }
    else if (nRet==1)
    {
        //会话为空时先获取会话
        if (!m_strSessionID)
        {
            //保存会话id
            strResponse = [JSONData valueForKeyPath:@"accessToken"];
            m_strSessionID = strResponse;
            
            //保存登录时间
            strResponse = [JSONData valueForKeyPath:@"loginTime"];
            long lTimen = [strResponse longLongValue];
            m_dtLoginTime = [NSDate dateWithTimeIntervalSince1970:lTimen];
        }
        
        //首次登录时
        if (m_bFirstLogin)
        {
            m_bFirstLogin = NO;
        }
        else
        {
            //只有是更新会话时才重新发送
            if (m_bUpdateSession)
            {
                //把状态置回
                m_bUpdateSession = NO;
                
                m_nCurrentUpdateCount = 0;
                
                //重新发送请求
                [weakSelf RePostRequest:ReqSuccess failure:ReqFailure];
            }
            else
            {
                //需要将重试次数重置
                m_nRetryCount = 0;
            }
        }
        
    }
    else if(nRet==0)
    {
        NSString* str = [JSONData valueForKeyPath:@"msg"];
        if (!str)
        {
            str = @"服务器没有返回数据!";
        }
        NSError* err = [[NSError alloc] initWithDomain:str
                                                  code:0
                                              userInfo:nil];
        if (ReqFailure)
        {
            ReqFailure(err);
        }
    }
    else if(nRet==-2)
    {
        NSString* str = @"在其他设备登录";
        NSError* err = [[NSError alloc] initWithDomain:str
                                                  code:-2
                                              userInfo:nil];
        if (ReqFailure)
        {
            ReqFailure(err);
        }
    }
    else
    {
        NSString* str = @"未知错误";
        NSError* err = [[NSError alloc] initWithDomain:str
                                                  code:-100
                                              userInfo:nil];
        if (ReqFailure)
        {
            ReqFailure(err);
        }
    }

    return nRet;
}

/**
 *  会话更新
 *
 *  @param strUser     用户名
 *  @param strPassword 密码
 *
 *  @return 返回新的会话id
 */
-(void)SessionUpdate:(SuccessData)ReqSuccess failure:(ErrorData)ReqFailure
{
    //确认为更新会话状态
    m_bUpdateSession = YES;
    
    //更新次数++
    m_nCurrentUpdateCount++;
    
    //登录方式判断
    if (m_nOpenType==0)
    {
        //发送登录请求
        [self UserLogin:m_strUser Password:m_strPassword success:ReqSuccess failure:ReqFailure];
    }
    else
    {
        //发送第三方登录请求
        [self ThirdPartyLogin:m_nOpenType OpenID:m_strOpenID UserName:m_strUserName UserImgUrl:m_strUserImgUrl success:ReqSuccess failure:ReqFailure];
    }
}

/**
 *  Get请求
 *
 *  @param strUrl      <#strPath description#>
 *  @param dcParameters <#dcParameters description#>
 *
 *  @return <#return value description#>
 */
- (void)GetRequest:(NSString *)strUrl ReqParameters:(NSDictionary *)dcParameters
{
    
}

- (void)PostRequest:(NSString *)strUrl ReqParameters:(NSDictionary *)dcParameters Route:(NSString*)strRoute  success:(SuccessData)ReqSuccess failure:(ErrorData)ReqFailure
{
    if ( !m_manager )
    {
        m_manager = [AFHTTPSessionManager manager];
        //设置超时
        [self SetRequestTimeOut:10.0f];
    }
    
    NSMutableDictionary *parameters3 = [[NSMutableDictionary alloc]init];
    
    //组装请求参数
    if (dcParameters)
    {
        NSMutableDictionary *parameters2 = [[NSMutableDictionary alloc]init];
        [parameters2 setObject:dcParameters forKey:@"params"];
        
        [parameters3 setObject:parameters2 forKey:@"data"];
    }

    //加会话id
    if (m_strSessionID)
    {
        [parameters3 setObject:m_strSessionID forKey:@"accessToken"];
    }
    
    //附加参数
    if (m_dcAttachParameters)
    {
        [parameters3 addEntriesFromDictionary:m_dcAttachParameters];
    }
    
    //加上路由
    if (strRoute)
    {
        [parameters3 setObject:strRoute forKey:@"routeUrl"];
    }
    
    //不为更新会话时才保存本次请求的数据
    if ( !m_bUpdateSession )
    {
        m_strUrl = strUrl;
        m_dcparameters = parameters3;
        m_strRoute = strRoute;
    }
    
    //申明请求的数据是json类型
    m_manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    m_manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //申明返回的结果是json类型
    m_manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 在AFN的block内使用，防止造成循环引用
    ZWeakSelf;
    
    //发送请求
    [m_manager POST:strUrl parameters:parameters3 success:^(NSURLSessionDataTask *task, id responseObject)
     {
         //判断状态是否有效
         int nRet = [weakSelf StatusJudge:responseObject success:ReqSuccess failure:ReqFailure];
         if (nRet==1)
         {
             if ( m_nRetryCount==0 && ReqSuccess )
             {
                 //成功回调
                 ReqSuccess(responseObject);
             }
             
         }
         
     }
     
    failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         if (ReqFailure)
         {
             ReqFailure(error);
         }
     }];
}


/**
 *  重发上一次请求
 */
- (void)ReGetRequest
{
    
}

/**
 *  重发上一次请求
 */
- (void)RePostRequest:(SuccessData)ReqSuccess failure:(ErrorData)ReqFailure
{
    if ( ++m_nRetryCount>RequestRetryCount )
    {
        if (ReqFailure)
        {
            ReqFailure(nil);
        }
        return;
    }
    
    [self PostRequest:m_strUrl ReqParameters:m_dcparameters Route:m_strRoute success:ReqSuccess failure:ReqFailure];
}

/**
 *  附加请求参数
 */
-(void)SetAttachParameters:(NSDictionary*)dcAttachParameters
{
    m_dcAttachParameters = dcAttachParameters;
}




/**
 *  登录
 *
 *  @param strUserName <#strUserName description#>
 *  @param strPassword <#strPassword description#>
 */
-(void)UserLogin:(NSString*)strUserName Password:(NSString*)strPassword success:(SuccessData)success failure:(ErrorData)failure
{
    //数据保存
    m_nOpenType = 0;
    m_strUser = strUserName;
    m_strPassword = strPassword;
    
    //传入的参数
    NSMutableDictionary *parameters1 = [[NSMutableDictionary alloc]init];
    [parameters1 setObject:strUserName forKey:@"username"];
    [parameters1 setObject:strPassword forKey:@"password"];
    
    [self PostRequest:LoginUrl ReqParameters:parameters1 Route:nil success:success failure:failure];
}

/**
 *  第三方登录
 *
 *  @param nOpenType     1:QQ 2:WeChat 3:weibo
 *  @param strOpenID     <#strOpenID description#>
 *  @param strUserName   <#strUserName description#>
 *  @param strUserImgUrl <#strUserImgUrl description#>
 *  @param success       <#success description#>
 *  @param failure       <#failure description#>
 */
-(void)ThirdPartyLogin:(int)nOpenType OpenID:(NSString *)strOpenID UserName:(NSString*)strUserName UserImgUrl:(NSString*)strUserImgUrl success:(SuccessData)success failure:(ErrorData)failure
{
    //数据保存
    m_nOpenType = nOpenType;
    m_strOpenID = strOpenID;
    m_strUserName = strUserName;
    m_strUserImgUrl = strUserImgUrl;
    
    //传入的参数
    NSString* str = nil;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:strOpenID forKey:@"openId"];
    str = [NSString stringWithFormat:@"%d",nOpenType];
    [parameters setObject:str forKey:@"openType"];
    [parameters setObject:strUserName forKey:@"nickname"];
    [parameters setObject:strUserImgUrl forKey:@"headimgurl"];
    
    [self PostRequest:ThirdPartyLoginUrl ReqParameters:parameters Route:nil success:success failure:failure];
}


@end

//
//  NetWorkManager.h
//  Cougar
//
//  Created by zly on 15/12/18.
//  Copyright © 2015年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^SuccessData)(id responseObject);

typedef void (^ErrorData)(NSError *error);


/**
 *  web请求管理类
 */
@interface RequestManager : NSObject


/**
 *  开始网络状态监听
 *  建议延时调用eg:[self performSelector:@selector(login:) withObject:nil afterDelay:0.35f];
 *
 *  @return <#return value description#>
 */
-(void)StartNetWorkMonitor;

/**
 *  停止网络状态监听
 */
-(void)StopNetWorkMonitor;

/**
 *  是否联网
 *
 *  @return <#return value description#>
 */
-(BOOL)IsNetworking;

/**
 *  设置请求超时时间
 *
 *  @param dTimeOut nTimeOut description
 */
-(void)SetRequestTimeOut:(double)dTimeOut;

/**
 *  取消请求
 */
-(void)CancelRequest;

/**
 *  得到主域名url
 *
 *  @return <#return value description#>
 */
-(NSString*)GetDomainNameUrl;

/**
 *  得到会话ID
 *
 *  @return <#return value description#>
 */
-(NSString*)GetSessionID;

/**
 *  得到登录类型
 *
 *  @return 0:手机登录 1:QQ 2:WeChat 3:weibo
 */
-(NSInteger)GetLoginType;

/**
 *  关闭实例
 */
-(void)UnInit;


/**
 *  会话状态和响应状态判断
 *
 *  @param JSONData <#JSONData description#>
 *
 *  @return 1为登录成功，-1为更新accessToken过期，-2为其他设备登录，0为登录失败（请求结果,1为成功，0为失败）
 */
-(int)StatusJudge:(id)JSONData success:(SuccessData)ReqSuccess failure:(ErrorData)ReqFailure;


/**
 *  会话更新
 *
 *  @param strUser     用户名
 *  @param strPassword 密码
 *
 *  @return 返回新的会话id
 */
-(void)SessionUpdate:(SuccessData)ReqSuccess failure:(ErrorData)ReqFailure;

/**
 *  Get请求
 *
 *  @param strUrl      <#strPath description#>
 *  @param dcParameters <#dcParameters description#>
 *
 *  @return <#return value description#>
 */
- (void)GetRequest:(NSString *)strUrl ReqParameters:(NSDictionary *)dcParameters;

/**
 *  Post请求
 *
 *  @param strUrl       <#strUrl description#>
 *  @param dcParameters <#dcParameters description#>
 *  @param strRoute     路由
 */
- (void)PostRequest:(NSString *)strUrl ReqParameters:(NSDictionary *)dcParameters Route:(NSString*)strRoute  success:(SuccessData)ReqSuccess failure:(ErrorData)ReqFailure;

/**
 *  重发上一次请求
 */
- (void)ReGetRequest;

/**
 *  重发上一次请求
 */
- (void)RePostRequest:(SuccessData)ReqSuccess failure:(ErrorData)ReqFailure;


/**
 *  附加请求参数
 */
-(void)SetAttachParameters:(NSDictionary*)dcAttachParameters;



/**
 *  登录
 *
 *  @param strUserName <#strUserName description#>
 *  @param strPassword <#strPassword description#>
 */
-(void)UserLogin:(NSString*)strUserName Password:(NSString*)strPassword success:(SuccessData)success failure:(ErrorData)failure;

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
-(void)ThirdPartyLogin:(int)nOpenType OpenID:(NSString *)strOpenID UserName:(NSString*)strUserName UserImgUrl:(NSString*)strUserImgUrl success:(SuccessData)success failure:(ErrorData)failure;


@end

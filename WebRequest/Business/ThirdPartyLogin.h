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
 *  第三方登录
 */
@interface ThirdPartyLogin : WebRequest

@property(nonatomic,assign) int m_nOpenType;              //1:QQ 2:WeChat 3:weibo
@property(nonatomic,strong) NSString* m_strOpenID;        //openid
@property(nonatomic,strong) NSString* m_strUserName;      //用户名
@property(nonatomic,strong) NSString* m_strUserImgUrl;    //用户头像

@property (nonatomic, copy) ReqSuccessObject successBlock; //保存成功回调

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

@end

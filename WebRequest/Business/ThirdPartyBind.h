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
 *  第三方绑定和解绑
 */
@interface ThirdPartyBind : WebRequest

@property(nonatomic,assign) int m_nOpenType;              //1:QQ 2:WeChat 3:weibo
@property(nonatomic,strong) NSString* m_strOpenID;        //openid
@property(nonatomic,assign) BOOL m_bIsBind;               //是否绑定

@property (nonatomic, copy) ReqSuccessBlock successBlock; //保存成功回调

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessBlock)successBlock failure:(ErrorData)failBlock;

@end

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
 *  手机绑定和解绑（目前不支持解绑）
 */
@interface PhoneBind : WebRequest

@property(nonatomic,strong) NSString* m_strPhone;        //手机
@property(nonatomic,strong) NSString* m_strVCode;        //验证码
@property(nonatomic,assign) BOOL m_bIsBind;              //是否绑定

@property (nonatomic, copy) ReqSuccessBlock successBlock; //保存成功回调

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessBlock)successBlock failure:(ErrorData)failBlock;

@end

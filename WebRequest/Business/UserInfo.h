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
 *  用户信息
 */
@interface UserInfo : WebRequest

@property (nonatomic,strong) NSString*  m_strUserId;            //用户的id
@property (nonatomic,strong) NSString*  m_strUserName;          //用户名(昵称)
@property (nonatomic,strong) NSString*  m_strRealName;          //真实姓名
@property (nonatomic,strong) NSString*  m_strBirthday;          //生日
@property (nonatomic,assign) int        m_nAge;                 //年龄
@property (nonatomic,assign) Byte       m_bySex;                //性别 1:男 0:女
@property (nonatomic,strong) NSString*  m_strPhone;             //手机号码
@property (nonatomic,strong) NSString*  m_strEmail;             //邮箱
@property (nonatomic,assign) int        m_nHeight;              //身高
@property (nonatomic,assign) float      m_fWeight;              //体重
@property (nonatomic,strong) NSString*  m_strPlace;             //地理位置
@property (nonatomic,strong) NSString*  m_strSignature;         //个性签名

@property (nonatomic, copy) ReqSuccessObject successBlock; //保存成功回调

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;


/**
 *  更新用户信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)UpdateUserInfo:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

@end

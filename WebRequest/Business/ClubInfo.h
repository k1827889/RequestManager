//
//  UserLogin.h
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../WebRequest.h"

@class AuthData;


/**
 *  俱乐部信息
 */
@interface ClubInfo : WebRequest

@property(nonatomic,strong) NSString* m_strClubID;  //俱乐部ID

@property(nonatomic,assign) int m_nPage;         //页数

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

@property(nonatomic,strong) NSString* m_strKeyword; //资讯搜索关键字

@property(nonatomic,strong) AuthData* m_AuthData;  //俱乐部认证数据
@property(nonatomic,strong) UIImage* m_AvatarImage;//俱乐部头像

@property (nonatomic, copy) ReqSuccessObject successBlock; //保存成功回调
@property (nonatomic, copy) ReqSuccessArray successBlock2; //保存成功回调

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;


/**
 *  获取俱乐部所有裁判和教练
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetClubWorkers:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  获取俱乐部列表
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetClubList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;



/**
 *  俱乐部认证
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)Authentication:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

@end

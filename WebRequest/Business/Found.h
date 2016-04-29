//
//  UserLogin.h
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../WebRequest.h"

@class FoundFilter;

/**
 *  发现信息
 */
@interface Found : WebRequest

@property(nonatomic,strong) NSString* m_strFoundID;  //发现ID
@property(nonatomic,assign) int m_nFoundType;       //发现类型
@property(nonatomic,strong) NSString* m_strKeyword; //发现搜索关键字
@property(nonatomic,strong) FoundFilter* m_FoundFilter; //发现搜索

@property(nonatomic,strong) NSString* m_strContent;  //评价内容
@property(nonatomic,strong) NSString* m_strTag;      //评价标签
@property(nonatomic,strong) NSString* m_strStar;     //评价分数

@property(nonatomic,strong) NSString* m_strUserId; //用户id
@property(nonatomic,assign) int m_nClubType;       //活动1，课程2

@property(nonatomic,assign) int m_nPage;         //页数

@property (nonatomic, copy) ReqSuccessObject successBlock; //保存成功回调
@property (nonatomic, copy) ReqSuccessArray successBlock2; //保存成功回调

/**
 *  发现分类列表信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)GetTypeList:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  发现列表信息
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetLists:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  搜索发现列表信息根据关键字
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)Search:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  参与活动、课程报名等
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)Participate:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  取消活动、课程报名等
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)ParticipateCancel:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  签到活动、课程报名等
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)SignIn:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  发现评价列表信息
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetEvaluationList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  发现评价信息模板
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetEvaluationTemplate:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  发送评价
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)SendEvaluate:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  获取用户参与的列表
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetUserPartakeList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  获取俱乐部发布的列表 活动1，课程2
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetClubPublishList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;


@end

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
 *  用户关注、取消关注、得到关注和粉丝总数、得到关注、粉丝、俱乐部列表
 */
@interface UserFollow : WebRequest

@property(nonatomic,strong) NSString* m_strUserID;  //用户ID

@property(nonatomic,assign) int m_nFollowType;       //1:俱乐部 2:用户
@property(nonatomic,assign) int m_nUserType;         //1:俱乐部 2:粉丝 3:关注

@property(nonatomic,assign) int m_nPage;         //页数

@property (nonatomic, copy) ReqSuccessBlock successBlock; //保存成功回调
@property (nonatomic, copy) ReqSuccessObject successBlock2; //保存成功回调
@property (nonatomic, copy) ReqSuccessArray successBlock3; //保存成功回调

/**
 *  关注用户/俱乐部
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)DoFollow:(ReqSuccessBlock)successBlock failure:(ErrorData)failBlock;

/**
 *  取消关注用户/俱乐部
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)UnFollow:(ReqSuccessBlock)successBlock failure:(ErrorData)failBlock;

/**
 *  获取关注、粉丝、俱乐部总数
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)GetFollowFansCount:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  获取关注、粉丝、俱乐部列表
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)GetUsers:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

@end

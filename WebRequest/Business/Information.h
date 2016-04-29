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
 *  资讯信息
 */
@interface Information : WebRequest

@property(nonatomic,strong) NSString* m_strInfoID;  //资讯ID
@property(nonatomic,assign) int m_nInfoType;        //资讯类型
@property(nonatomic,strong) NSString* m_strKeyword; //资讯搜索关键字

@property(nonatomic,assign) int m_nPage;         //页数

@property (nonatomic, copy) ReqSuccessObject successBlock; //保存成功回调
@property (nonatomic, copy) ReqSuccessArray successBlock2; //保存成功回调

/**
 *  资讯分类列表信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)GetTypeList:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  资讯列表信息
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetLists:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  搜索资讯列表信息根据关键字
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)Search:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  收藏资讯
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)Collect:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;


@end

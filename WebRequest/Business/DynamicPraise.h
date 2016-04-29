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
 *  获取动态点赞列表、点赞、取消点赞
 */
@interface DynamicPraise : WebRequest

@property(nonatomic,strong)NSString* m_strDynamicId;  //动态ID
@property(nonatomic,assign) BOOL m_bLimit;            //是否限制
@property(nonatomic,assign) int m_nPage;              //页数


@property (nonatomic, copy) ReqSuccessArray successBlock; //保存成功回调
@property (nonatomic, copy) ReqSuccessObject successBlock2; //保存成功回调

/**
 *  开始请求，获取点赞列表
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  点赞
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)OnPraise:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

@end

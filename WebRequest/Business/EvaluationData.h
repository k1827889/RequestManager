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
 *  获取评价数据
 */
@interface EvaluationData : WebRequest

@property(nonatomic,strong)NSString* m_strDynamicId;  //动态ID
@property(nonatomic,assign) BOOL m_bLimit;            //是否限制
@property(nonatomic,assign) int m_nPage;              //页数
@property(nonatomic,strong)NSString* m_strKey;        //对应模块名称
@property(nonatomic,strong)NSString* m_strValue;      //具体的值

@property(nonatomic,strong)NSString* m_strContent;          //评论内容
@property(nonatomic,strong)NSString* m_strEvaluationID;     //评论ID


@property (nonatomic, copy) ReqSuccessArray successBlock;   //保存成功回调
@property (nonatomic, copy) ReqSuccessObject successBlock2; //保存成功回调
@property (nonatomic, copy) ReqSuccessBlock successBlock3;  //保存成功回调

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  发送评论
 *
 *  @param successBlock
 *  @param failBlock
 */
-(void)SendComment:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  删除评论
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)DeleteComment:(ReqSuccessBlock)successBlock failure:(ErrorData)failBlock;


@end

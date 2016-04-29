//
//  UserLogin.h
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../WebRequest.h"

//运动数据
@class SportData;

//排名过滤条件
@class RankFilter;


/**
 *  运动记录
 */
@interface SportRecord : WebRequest

@property(nonatomic,strong) SportData* m_sData;   //运动数据

@property(nonatomic,strong) NSString* m_strUserId; //用户id
@property(nonatomic,strong) NSString* m_strId;     //记录id
@property(nonatomic,assign) int m_nPage;         //页数

@property(nonatomic,strong)UIImage* m_ImageShare;     //用于分享的图片数据

@property(nonatomic,strong)RankFilter* m_RankFilter;  //记录排名条件

@property (nonatomic, copy) ReqSuccessObject successBlock; //保存成功回调
@property (nonatomic, copy) ReqSuccessArray successBlock2; //保存成功回调


/**
 *  上传运动记录
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Upload:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  得到运行记录列表
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetRecordList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;


/**
 *  得到运行记录的详情
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetRecordDetail:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  得到运动类型列表信息
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetSportTypeList:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  得到运动统计数据
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetSportTotal:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  分享运动记录
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)ShareRecord:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  得到运动记录排名
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetRank:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;


@end

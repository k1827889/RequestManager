//
//  UserLogin.h
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../WebRequest.h"

//坐标
@class ZGeoPoint;


/**
 *  获取动态列表
 */
@interface DynamicList : WebRequest

@property(nonatomic,assign) int m_nDynamicType;  //动态类型 0:附近动态 1:好友圈 2:俱乐部
@property(nonatomic,assign) int m_nPage;         //页数
@property(nonatomic,strong) ZGeoPoint* m_pt;   //发表的地理位置经纬度

@property(nonatomic,strong) NSString* m_strUserId; //用户id

@property (nonatomic, copy) ReqSuccessArray successBlock; //保存成功回调

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  获取用户发布的列表
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetPublishList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;


@end

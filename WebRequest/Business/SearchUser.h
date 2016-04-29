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
 *  搜索用户
 */
@interface SearchUser : WebRequest

@property(nonatomic,assign) int m_nType;       //1:附近的人 2:教练 3:裁判
@property(nonatomic,assign) int m_nPage;       //页数
@property(nonatomic,strong) ZGeoPoint* m_pt;   //发表的地理位置经纬度

@property(nonatomic,strong) NSString* m_strKeyword;   //用户昵称搜索

@property (nonatomic, copy) ReqSuccessArray successBlock; //保存成功回调

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

/**
 *  昵称搜索用户
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)OnSearch:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock;

@end

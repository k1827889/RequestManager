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
@interface DynamicDetail : WebRequest

@property(nonatomic,strong)NSString* m_strDynamicId;  //动态ID

@property (nonatomic, copy) ReqSuccessObject successBlock; //保存成功回调


@property(nonatomic,strong)ZGeoPoint* m_pt;         //发动态的坐标
@property(nonatomic,strong)NSString* m_strPlace;    //发动态的地名
@property(nonatomic,strong)NSString* m_strIP;       //发动态的IP
@property(nonatomic,assign)int m_nType;             //1:视频 2:照片 3:文字
@property(nonatomic,assign)int m_nSendType;         //1:person oter:club
@property(nonatomic,strong)NSString* m_strTime;     //发动态的时间
@property(nonatomic,strong)NSString* m_strContent;     //发动态的内容
@property(nonatomic,strong)NSMutableArray*    m_arrPhotos;  //发动态的图片本地路径数组

@property(nonatomic,strong)UIImage* m_ImageShare;     //用于分享的图片数据


/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  发布动态
 *
 *  @param successBlock
 *  @param failBlock
 */
-(void)PublicDynamic:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  删除动态
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)DeleteDynamic:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;




@end

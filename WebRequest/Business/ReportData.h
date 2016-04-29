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
 *  举报
 */
@interface ReportData : WebRequest

@property(nonatomic,strong)NSString* m_strId;       //ID
@property(nonatomic,strong)NSString* m_strType;     //评论内容

@property (nonatomic, copy) ReqSuccessObject successBlock;  //保存成功回调

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;


@end

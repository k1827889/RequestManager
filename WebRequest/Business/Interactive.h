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
 *  用户反馈、签到
 */
@interface Interactive : WebRequest

@property (nonatomic,strong) NSString*  m_strEmail;     //邮箱
@property(nonatomic,strong)  NSString* m_strContent;     //发动态的内容
@property (nonatomic, copy)  ReqSuccessObject successBlock; //保存成功回调


/**
 *  用户反馈
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)Feedback:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

/**
 *  签到
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)SignIn:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;

@end

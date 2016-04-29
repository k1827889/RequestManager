//
//  ProConst.h
//  Cougar
//
//  Created by zly on 15/12/22.
//  Copyright © 2015年 zly. All rights reserved.
//

#ifndef ProConst_h
#define ProConst_h

/**
 *  工程全局使用的宏定义
 */

// app测试宏，上传到app store时注释，同时删除蒲公英sdk
#define __App_Test__

// 弱引用
#define ZWeakSelf __weak typeof(self) weakSelf = self;

//高德地图key
#define AMapKey @"ca3bb4ed3a507fb92ccb04dbd378451c"

//UMSocialAppkey
#define UMSocial_APP_ID @"56d3a55067e58e56bc00267d"

//pgyAppkey
#define PGY_APP_ID @"1bf3dad5d9c842e38e18431b3325327d"

// 域名
#define DomainNameUrl @"http://www.abc.com/"

//美洲狮官网
#define CougarUrl @"http://www.abc.com"

//登录
#define LoginUrl @"http://www.abc.com"

//第三方登录
#define ThirdPartyLoginUrl @"http://www.abc.com"

//注册
#define RegisterUrl @"http://www.abc.com"

//其它请求
#define OptionUrl @"http://www.abc.com"

// 使用测试的用户名和密码
#define TestUser        @"test17"
#define TestPassword    @"123456"

// 会话更新重试次数
#define SessionUpdateRetryCount  5

// 发送失败重试次数
#define RequestRetryCount  5

//成功和失败的提醒时间
#define SuccessRemindTime 1.0f
#define FailRemindTime 2.0f


//常用状态判断宏
#define isNull(x)             ( !x || [x isKindOfClass:[NSNull class]] || [x isEqual:@""] )
#define toInt(x)              ( isNull(x) ? 0 : [x intValue])
#define isEmptyString(x)      ( isNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"] )


#endif /* ProConst_h */

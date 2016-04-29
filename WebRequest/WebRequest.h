//
//  WebRequest.h
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../RequestManager.h"

/**
 *  请求类型
 */
typedef NS_ENUM(NSInteger, emRequestType)
{
    GetRequest = 0,//Get请求
    PostRequest = 1,//Post请求
    
};

//成功后直接返回对象
typedef void (^ReqSuccessObject)(id responseObject);

//成功后直接
typedef void (^ReqSuccessBlock)();

//成功后直接返回对象数组
typedef void (^ReqSuccessArray)( NSArray* arrData);


/**
 *  web请求基类，依赖于afn和networkmanager
 */
@interface WebRequest : NSObject


/**
*  设置请求参数
*
*  @param strUrl       请求的url
*  @param strRoute     路由地址
*  @param dcParameters 请求的参数
*/
-(void)SetReqUrl:(NSString *)strUrl Route:(NSString*)strRoute ReqParameters:(NSDictionary *)dcParameters;

/**
 *  设置请求类型，默认为post
 *
 *  @param RequestType
 */
-(void)SetRequestType:(emRequestType)RequestType;

/**
 *  是否原数据返回
 *
 *  @param bIsSrcData <#bIsSrcData description#>
 */
-(void)SetReturnSrcData:(BOOL)bIsSrcData;

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)StartRequest:(SuccessData)successBlock failure:(ErrorData)failBlock;


@end

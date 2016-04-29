//
//  WebRequest.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "WebRequest.h"
#import "AppDelegate.h"

@interface WebRequest()
{
    //保存上次的请求参数
    NSString * m_strUrl;
    NSString * m_strRoute;
    NSMutableDictionary * m_dcparameters;
    
    //请求类型,默认为post
    emRequestType m_RequestType;
    
    //是否原数据返回
    BOOL m_bIsSrcData;
}
@end

@implementation WebRequest

//重载init
-(instancetype) init
{
    self = [super init];
    if ( self )
    {
        m_RequestType = PostRequest;
        m_bIsSrcData = NO;
    }
    return self;
}

/**
 *  设置请求参数
 *
 *  @param strUrl       请求的url
 *  @param strRoute     路由地址
 *  @param dcParameters 请求的参数
 */
-(void)SetReqUrl:(NSString *)strUrl Route:(NSString*)strRoute ReqParameters:(NSDictionary *)dcParameters
{
    m_strUrl = strUrl;
    m_strRoute = strRoute;
    m_dcparameters = [[NSMutableDictionary alloc]initWithDictionary:dcParameters];
}

/**
 *  设置请求类型，默认为post
 *
 *  @param RequestType
 */
-(void)SetRequestType:(emRequestType)RequestType
{
    m_RequestType = RequestType;
}

/**
 *  是否原数据返回
 *
 *  @param bIsSrcData <#bIsSrcData description#>
 */
-(void)SetReturnSrcData:(BOOL)bIsSrcData
{
    m_bIsSrcData = bIsSrcData;
}

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)StartRequest:(SuccessData)successBlock failure:(ErrorData)failBlock
{
    //检查参数
    [self CheckParameters];
    
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    
    //附加参数
    NSDictionary* dcParameters = [self AttachParameters];
    [app.m_ProManager.m_RequestManager SetAttachParameters:dcParameters];
    
    //发送请求
    [app.m_ProManager.m_RequestManager PostRequest:m_strUrl ReqParameters:m_dcparameters Route:m_strRoute success:^(id responseObject)
    {
        //成功处理
        [self OnSuccessHandle:responseObject SuccessBlock:successBlock];
    }
    failure:^(NSError *error)
    {
        //失败处理
        [self OnFailedHandle:error failure:failBlock];
        
    }];
    
}


/**
 *  请求之前检查参数
 *
 *  @return <#return value description#>
 */
-(BOOL)CheckParameters
{
    BOOL bRet = YES;
    
    //检查url参数
    if (!m_strUrl)
    {
        bRet = NO;
    }
    
    //检查数据
    if (!m_dcparameters)
    {
        bRet = NO;
    }
    
    return bRet;
}

/**
 *  附加请求参数
 */
-(NSDictionary* )AttachParameters
{
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    NSMutableDictionary *dcparameters = [[NSMutableDictionary alloc]init];
    
    [dcparameters setObject:app.m_ProManager.m_DefaultData.m_strDevices forKey:@"app"];
    [dcparameters setObject:app.m_ProManager.m_DefaultData.m_strSoftVersion forKey:@"v"];
    [dcparameters setObject:app.m_ProManager.m_DefaultData.m_strAppUDID forKey:@"mobileno"];
    
    return dcparameters;
}


/**
 *  处理成功
 *
 *  @param responseObject <#responseObject description#>
 *  @param successBlock   <#successBlock description#>
 */
-(void)OnSuccessHandle:(id)responseObject SuccessBlock:(SuccessData)successBlock
{
    if (successBlock)
    {
        if (m_bIsSrcData)
        {
            successBlock(responseObject);
        }
        else
        {
            //解析需要的数据实体
            NSDictionary *dcattributes = [responseObject valueForKeyPath:@"data"];
            successBlock(dcattributes);
        }
    }
}

/**
 *  处理失败
 *
 *  @param error     <#error description#>
 *  @param failBlock <#failBlock description#>
 */
-(void)OnFailedHandle:(NSError*)error failure:(ErrorData)failBlock
{
    if (failBlock)
    {
        failBlock(error);
    }
}

-(void) dealloc
{
    NSLog(@"%s dealloc", object_getClassName(self));
}

@end

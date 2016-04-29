//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "DynamicPraise.h"
#import "../../ProConst.h"
#import "../../../MainDlg/Dynamic/Data/DynamicData.h"
#import "../../../MainDlg/Dynamic/Data/InteractData.h"

@implementation DynamicPraise

@synthesize m_strDynamicId;  //动态ID
@synthesize m_bLimit;        //是否限制
@synthesize m_nPage;         //页数

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strDynamicId forKey:@"id"];
    
    //加路由
    NSString* strroute = nil;
    
    if (m_bLimit)
    {
        [parameters setObject:@"true" forKey:@"limit"];
        
        strroute =@"api/dynamicDetail/getPraise";
    }
    else
    {
        [parameters setObject:@"false" forKey:@"limit"];
        
        strroute = [[NSString alloc]initWithFormat:@"api/dynamicDetail/getPraise/page/%d",m_nPage];
    }
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         //分析数据
         [weakSelf ParseData:responseObject];
     }
     failure:failBlock
     ];
}

/**
 *  解析数据
 *
 *  @param dcData <#dcData description#>
 */
-(void)ParseData:(NSDictionary*) dcData
{
    if ( !self.successBlock )
        return;
    
    NSMutableArray* arrData = [[NSMutableArray alloc]init];
    if ( !isNull(dcData) )
    {
        //解析点赞数组
        NSArray *postsFromResponse = [dcData valueForKeyPath:@"praises"];
        for (NSDictionary *attributes in postsFromResponse)
        {
            PraiseData* Data = [[PraiseData alloc]InitWithDictionary:attributes];
            [arrData addObject:Data];
        }
    }
    
    //回调
    self.successBlock(arrData);
}


/**
 *  点赞
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)OnPraise:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strDynamicId forKey:@"id"];
    
    //加路由
    NSString* strroute =@"api/dynamic/praise";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (weakSelf.successBlock2)
         {
             weakSelf.successBlock2(responseObject);
         }
     }
     failure:failBlock
     ];
}


@end

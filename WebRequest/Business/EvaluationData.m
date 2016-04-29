//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "EvaluationData.h"
#import "../../ProConst.h"
#import "../../../MainDlg/Dynamic/Data/DynamicData.h"
#import "../../../MainDlg/Dynamic/Data/InteractData.h"

@implementation EvaluationData

@synthesize m_strDynamicId;         //动态ID
@synthesize m_bLimit;               //是否限制
@synthesize m_nPage;                //页数
@synthesize m_strKey;               //对应模块名称
@synthesize m_strValue;             //具体的值

@synthesize m_strContent;           //评论内容
@synthesize m_strEvaluationID;      //评论ID

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
    [parameters setObject:m_strKey forKey:@"module"];
    [parameters setObject:m_strValue forKey:@"ext_value"];
    
    //加路由
    NSString* strroute = nil;
    
    if (m_bLimit)
    {
        [parameters setObject:@"true" forKey:@"limit"];
        
        strroute =@"api/comment/getComment";
    }
    else
    {
        [parameters setObject:@"false" forKey:@"limit"];
        
        strroute = [[NSString alloc]initWithFormat:@"api/comment/getComment/page/%d",m_nPage];
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
        //解析评论数组
        NSArray *postsFromResponse = [dcData valueForKeyPath:@"comments"];
        for (NSDictionary *attributes in postsFromResponse)
        {
            CommentData* Data = [[CommentData alloc]InitWithDictionary:attributes];
            [arrData addObject:Data];
        }
    }
    
    //回调
    self.successBlock(arrData);
}


/**
 *  发送评论
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)SendComment:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strDynamicId forKey:@"did"];
    [parameters setObject:m_strKey forKey:@"module"];
    [parameters setObject:m_strValue forKey:@"ext_value"];
    
    [parameters setObject:@"" forKey:@"lng"];
    [parameters setObject:@"" forKey:@"lat"];
    
    [parameters setObject:m_strContent forKey:@"content"];
    
    //加路由
    NSString* strroute =@"api/comment/add";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         //分析数据
         [weakSelf ParseData2:responseObject];
     }
     failure:failBlock
     ];
}


/**
 *  解析数据
 *
 *  @param dcData <#dcData description#>
 */
-(void)ParseData2:(NSDictionary*) dcData
{
    if ( !self.successBlock2 )
        return;
    
    CommentData* Data = nil;
    if ( !isNull(dcData) )
    {
        //解析评论
        Data = [[CommentData alloc]InitWithDictionary:dcData];
    }
    
    //回调
    self.successBlock2(Data);
}

/**
 *  删除评论
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)DeleteComment:(ReqSuccessBlock)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock3 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strDynamicId forKey:@"did"];
    [parameters setObject:m_strEvaluationID forKey:@"id"];
    
    //加路由
    NSString* strroute =@"api/comment/del";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (weakSelf.successBlock3)
         {
             weakSelf.successBlock3();
         }
     }
     failure:failBlock
     ];
}

@end

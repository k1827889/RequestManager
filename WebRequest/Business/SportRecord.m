//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "SportRecord.h"
#import "../../ProConst.h"
#import "../../../MainDlg/Sport/Data/SportData.h"
#import "../../../MainDlg/Sport/Data/SportRank.h"
#import "../../../MainDlg/My/Rank/RankFilter.h"
#import "../../../Utilities/GeoPoint/ZGeoPoint.h"
#import "../../../Utilities/Utilities.h"

@implementation SportRecord

@synthesize m_sData;   //运动数据

@synthesize m_strUserId; //用户id
@synthesize m_strId;     //记录id
@synthesize m_nPage;     //页数

@synthesize m_ImageShare;     //用于分享的图片数据

@synthesize m_RankFilter;  //记录排名条件

/**
 *  上传运动记录
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Upload:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock;
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSDictionary *parameters = [m_sData ToDictionary];
    
    //加路由
    NSString* strroute =@"api/record/addRecord";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (weakSelf.successBlock)
         {
             weakSelf.successBlock(responseObject);
         }
     }
     failure:failBlock
     ];
}

/**
 *  得到运行记录列表
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetRecordList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strUserId forKey:@"uid"];
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/record/getRecord/page/%d",m_nPage];
    
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
    if ( !self.successBlock2 )
        return;
    
    NSMutableArray* arrData = [[NSMutableArray alloc]init];
    if ( !isNull(dcData) )
    {
        //解析动态数组
        NSArray *postsFromResponse = [dcData valueForKeyPath:@"record"];
        for (int i=0; i<postsFromResponse.count;i++ )
        {
            NSDictionary *attributes = [postsFromResponse objectAtIndex:i];
            SportData* Data = [[SportData alloc]InitWithDictionary:attributes];
            [arrData addObject:Data];
        }
    }
    
    //回调
    self.successBlock2(arrData);
}

/**
 *  得到运行记录的详情
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetRecordDetail:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strUserId forKey:@"uid"];
    [parameters setObject:m_strId forKey:@"id"];
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/record/getRecordDetail"];
    
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
    if ( !self.successBlock )
        return;
    
    SportData* Data = nil;
    if ( !isNull(dcData) )
    {
        Data = [[SportData alloc]InitWithDictionary:dcData];
    }
    
    //回调
    self.successBlock(Data);
}

/**
 *  得到运动类型列表信息
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetSportTypeList:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSDictionary *parameters = nil;
    
    //加路由
    NSString* strroute =@"api/activity/getType";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (weakSelf.successBlock)
         {
             weakSelf.successBlock(responseObject);
         }
     }
     failure:failBlock
     ];
}

/**
 *  得到运动统计数据
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetSportTotal:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strUserId forKey:@"uid"];
    
    //加路由
    NSString* strroute =@"api/Activity/RecordSum";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (weakSelf.successBlock)
         {
             weakSelf.successBlock(responseObject);
         }
     }
     failure:failBlock
     ];
}

/**
 *  分享运动记录
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)ShareRecord:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strUserId forKey:@"uid"];
    [parameters setObject:m_strId forKey:@"id"];
    
    //图片
    NSString* strImagebase64 = [NSString stringWithFormat:@"data:image/jpeg;base64,"];
    //转base64
    NSString* strbase64 = [ZMediaFile ImageToBase64String:m_ImageShare];
    if (strbase64)
    {
        strImagebase64 = [strImagebase64 stringByAppendingString:strbase64];
    }
    [parameters setObject:strImagebase64 forKey:@"picture"];
    
    //加路由
    NSString* strroute =@"api/activity/sharePic";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (weakSelf.successBlock)
         {
             weakSelf.successBlock(responseObject);
         }
     }
     failure:failBlock
     ];
}

/**
 *  得到运动记录排名
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetRank:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString* str = [[NSString alloc]initWithFormat:@"%d",m_RankFilter.m_nSportType];
    [parameters setObject:str forKey:@"sportType"];
    
    str = [[NSString alloc]initWithFormat:@"%d",m_RankFilter.m_nDay];
    [parameters setObject:str forKey:@"rankDay"];
    
    [parameters setObject:@"0" forKey:@"searchType"];
    
    str = [[NSString alloc]initWithFormat:@"%f",m_RankFilter.m_dlongitude];
    [parameters setObject:str forKey:@"lng"];
    str = [[NSString alloc]initWithFormat:@"%f",m_RankFilter.m_dlatitude];
    [parameters setObject:str forKey:@"lat"];
    
    if (!m_RankFilter.m_strProvince)
    {
        m_RankFilter.m_strProvince = @"";
    }
    [parameters setObject:m_RankFilter.m_strProvince forKey:@"province"];
    
    if (!m_RankFilter.m_strCity)
    {
        m_RankFilter.m_strCity = @"";
    }
    [parameters setObject:m_RankFilter.m_strCity forKey:@"city"];
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/record/getRank/page/%d",m_nPage];
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    [self SetReturnSrcData:YES];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (weakSelf.successBlock)
         {
             weakSelf.successBlock(responseObject);
         }
     }
     failure:failBlock
     ];
}


@end

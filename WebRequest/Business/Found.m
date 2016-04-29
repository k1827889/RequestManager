//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "Found.h"
#import "../../ProConst.h"
#import "../../../MainDlg/Found/Data/FoundData.h"
#import "../../../MainDlg/Found/Data/FoundFilter.h"
#import "../../../Utilities/Utilities.h"
#import "../../../MainDlg/Dynamic/Data/InteractData.h"


@implementation Found

@synthesize m_strFoundID;  //发现ID
@synthesize m_nFoundType;  //发现类型
@synthesize m_strKeyword; //发现搜索关键字
@synthesize m_FoundFilter; //发现搜索

@synthesize m_nPage;         //页数

@synthesize m_strContent;  //评价内容
@synthesize m_strTag;      //评价标签
@synthesize m_strStar;     //评价分数

@synthesize m_strUserId; //用户id
@synthesize m_nClubType;       //活动1，课程2



/**
 *  发现分类列表信息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)GetTypeList:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = nil;
    
    //加路由
    NSString* strroute =@"api/DiscoverType/List";
    
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
 *  发现列表信息
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetLists:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *str = [[NSString alloc]initWithFormat:@"%d",m_nFoundType];
    [parameters setObject:str forKey:@"type"];
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/Discover/SearchByType/page/%d",m_nPage];
    
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
        NSArray *postsFromResponse = [dcData valueForKeyPath:@"discover"];
        for (int i=0; i<postsFromResponse.count;i++ )
        {
            NSDictionary *attributes = [postsFromResponse objectAtIndex:i];
            FoundData* Data = [[FoundData alloc]InitWithDictionary:attributes];
            [arrData addObject:Data];
        }
    }
    
    //回调
    self.successBlock2(arrData);
}


/**
 *  搜索发现列表信息根据关键字
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)Search:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    NSString *str = [[NSString alloc]initWithFormat:@"%d",m_nFoundType];
    [parameters setObject:str forKey:@"type"];
    [parameters setObject:@"" forKey:@"lableid"];
    if (m_strKeyword)
    {
        [parameters setObject:m_strKeyword forKey:@"name"];
    }
    else
    {
        [parameters setObject:@"" forKey:@"name"];
    }
    
    if (m_FoundFilter.m_strPlace)
    {
        [parameters setObject:m_FoundFilter.m_strPlace forKey:@"address"];
    }
    else
    {
        [parameters setObject:@"" forKey:@"address"];
    }
    
    if (m_FoundFilter.m_arrFreeType.count>0)
    {
        str = [m_FoundFilter.m_arrFreeType objectAtIndex:0];
        [parameters setObject:str forKey:@"is_free"];
    }
    else
    {
        [parameters setObject:@"" forKey:@"is_free"];
    }
    
    if (m_FoundFilter.m_arrPlaceType.count>0)
    {
        str = [m_FoundFilter.m_arrPlaceType objectAtIndex:0];
        [parameters setObject:str forKey:@"area_type"];
    }
    else
    {
        [parameters setObject:@"" forKey:@"area_type"];
    }
    
    if (m_FoundFilter.m_arrSportType)
    {
        str = [ZTool ArrTostr:m_FoundFilter.m_arrSportType Separator:@","];
        [parameters setObject:str forKey:@"sport_type"];
    }
    else
    {
        [parameters setObject:@"" forKey:@"sport_type"];
    }
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/Discover/Search/page/%d",m_nPage];
    
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
 *  参与活动、课程报名等
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)Participate:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strFoundID forKey:@"discover_id"];
    
    //加路由
    NSString* strroute =@"api/SignUp/Add";
    
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
 *  取消活动、课程报名等
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)ParticipateCancel:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strFoundID forKey:@"did"];
    
    //加路由
    NSString* strroute =@"api/SignUp/cancel";
    
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
 *  签到活动、课程报名等
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)SignIn:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strFoundID forKey:@"discover_id"];
    
    //加路由
    NSString* strroute =@"api/SignUp/signUp";
    
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
 *  发现评价列表信息
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetEvaluationList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strFoundID forKey:@"discoverid"];
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/DiscoverComments/CommentsList/page/%d",m_nPage];
    
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
    
    NSMutableArray* arrData = [[NSMutableArray alloc]init];
    if ( !isNull(dcData) )
    {
        //解析评论数组
        NSArray *postsFromResponse = [dcData valueForKeyPath:@"discover"];
        for (NSDictionary *attributes in postsFromResponse)
        {
            CommentData* Data = [[CommentData alloc]InitWithDictionary:attributes];
            [arrData addObject:Data];
        }
    }
    
    //回调
    self.successBlock2(arrData);
}

/**
 *  发现评价信息模板
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetEvaluationTemplate:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strFoundID forKey:@"discoverid"];
    
    //加路由
    NSString* strroute =@"api/DiscoverComments/GetCommentsByDiscoverid";
    
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
 *  发送评价
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)SendEvaluate:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strFoundID forKey:@"discoverid"];
    [parameters setObject:m_strContent forKey:@"content"];
    [parameters setObject:m_strTag forKey:@"lableid"];
    [parameters setObject:m_strStar forKey:@"satisfaction"];
    
    //加路由
    NSString* strroute =@"api/DiscoverComments/Add";
    
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
 *  获取用户参与的列表
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetUserPartakeList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strUserId forKey:@"uid"];
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/Discover/RecentJoin/page/%d",m_nPage];
    
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
 *  获取俱乐部发布的列表 活动1，课程2
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetClubPublishList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strUserId forKey:@"deptid"];
    NSString* str = [NSString stringWithFormat:@"%d",m_nClubType];
    [parameters setObject:str forKey:@"type"];
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/Discover/MyClub/page/%d",m_nPage];
    
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


@end

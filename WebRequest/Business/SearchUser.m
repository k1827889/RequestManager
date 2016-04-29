//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "SearchUser.h"
#import "../../ProConst.h"
#import "../../../MainDlg/My/Data/UserData.h"
#import "../../../Utilities/GeoPoint/ZGeoPoint.h"

@implementation SearchUser

@synthesize m_nType;  //1:附近的人 2:教练 3:裁判
@synthesize m_nPage;  //页数
@synthesize m_pt;     //发表的地理位置经纬度

@synthesize m_strKeyword;   //用户昵称搜索

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
    
    //加路由
    NSString* strroute = nil;
    
    if (m_nType==1)
    {
        strroute = [[NSString alloc]initWithFormat:@"api/dynamic/person/page/%d",m_nPage];
    }
    else if (m_nType==2)
    {
        strroute = [[NSString alloc]initWithFormat:@"api/dynamic/clubPerson/page/%d",m_nPage];
        [parameters setObject:@"coach" forKey:@"type"];
    }
    else if (m_nType==3)
    {
        strroute = [[NSString alloc]initWithFormat:@"api/dynamic/clubPerson/page/%d",m_nPage];
        [parameters setObject:@"referee" forKey:@"type"];
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
        //解析动态数组
        NSArray *postsFromResponse = [dcData valueForKeyPath:@"dynamic"];
        for (int i=0; i<postsFromResponse.count;i++ )
        {
            NSDictionary *attributes = [postsFromResponse objectAtIndex:i];
            UserData* Data = [[UserData alloc]InitWithDictionary:attributes];
            [arrData addObject:Data];
        }
    }
    
    //回调
    self.successBlock(arrData);
}


/**
 *  昵称搜索用户
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)OnSearch:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strKeyword forKey:@"nickname"];
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/user/search/page/%d",m_nPage];
    
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

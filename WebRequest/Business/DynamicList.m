//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "DynamicList.h"
#import "../../ProConst.h"
#import "../../../MainDlg/Dynamic/Data/DynamicData.h"
#import "../../../Utilities/GeoPoint/ZGeoPoint.h"

@implementation DynamicList

@synthesize m_nDynamicType;  //动态类型 0:附近动态 1:好友圈 2:俱乐部
@synthesize m_nPage;         //页数
@synthesize m_pt;          //发表的地理位置经纬度

@synthesize m_strUserId;    //用户id

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
    NSString *str = nil;
    
    //加路由
    NSString* strroute = nil;
    
    if (m_nDynamicType==0)
    {
        strroute = [[NSString alloc]initWithFormat:@"api/dynamic/index/page/%d",m_nPage];
        
        if(m_pt)
        {
            str = [NSString stringWithFormat:@"%f",m_pt.longitudeDouble];
            [parameters setObject:str forKey:@"lng"];
            str = [NSString stringWithFormat:@"%f",m_pt.latutideDouble];
            [parameters setObject:str forKey:@"lat"];
        }
        else
        {
            [parameters setObject:@"" forKey:@"lng"];
            [parameters setObject:@"" forKey:@"lat"];
        }
        [parameters setObject:@"1" forKey:@"freshen"];
    }
    else if (m_nDynamicType==1)
    {
        strroute = [[NSString alloc]initWithFormat:@"api/Dynamic/FriendsList/page/%d",m_nPage];
    }
    else if (m_nDynamicType==2)
    {
        strroute = [[NSString alloc]initWithFormat:@"api/dynamic/club/Page/%d",m_nPage];
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
            DynamicData* Data = [[DynamicData alloc]InitWithDictionary:attributes];
            [arrData addObject:Data];
        }
    }
    
    //回调
    self.successBlock(arrData);
}


/**
 *  获取用户发布的列表
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetPublishList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strUserId forKey:@"uid"];
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/Dynamic/DynamicListByUid/page/%d",m_nPage];
    
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

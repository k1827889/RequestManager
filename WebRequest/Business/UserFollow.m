//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "UserFollow.h"
#import "../../ProConst.h"
#import "../../../MainDlg/My/Data/UserData.h"
#import "../../../MainDlg/My/Data/ClubData.h"

@implementation UserFollow

@synthesize m_strUserID;        //用户ID
@synthesize m_nFollowType;      //1:俱乐部 2:用户
@synthesize m_nPage;            //页数
@synthesize m_nUserType;        //1:俱乐部 2:粉丝 3:关注

/**
 *  关注用户
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)DoFollow:(ReqSuccessBlock)successBlock failure:(ErrorData)failBlock;
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strUserID forKey:@"fuid"];
    
    //关注俱乐部还是用户
    if (m_nFollowType==1)
    {
        [parameters setObject:@"club" forKey:@"type"];
    }
    else
    {
        [parameters setObject:@"person" forKey:@"type"];
    }
    
    //加路由
    NSString* strroute = @"api/follow/doFollow";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (weakSelf.successBlock)
         {
             weakSelf.successBlock();
         }
     }
     failure:failBlock
     ];
}

/**
 *  取消关注用户/俱乐部
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)UnFollow:(ReqSuccessBlock)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strUserID forKey:@"fuid"];
    
    //关注俱乐部还是用户
    if (m_nFollowType==1)
    {
        [parameters setObject:@"club" forKey:@"type"];
    }
    else
    {
        [parameters setObject:@"person" forKey:@"type"];
    }
    
    //加路由
    NSString* strroute = @"api/follow/unFollow";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (weakSelf.successBlock)
         {
             weakSelf.successBlock();
         }
     }
     failure:failBlock
     ];
}

/**
 *  获取关注、粉丝、俱乐部总数
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)GetFollowFansCount:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = nil;
    
    //加路由
    NSString* strroute = @"api/follow/getFollowCount";
    
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


/**
 *  关注、粉丝、俱乐部列表
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)GetUsers:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock3 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = nil;
    
    //加路由
    NSString* strroute = nil;
    if (m_nUserType==1)
    {
        strroute = [[NSString alloc]initWithFormat:@"api/follow/followingclub/page/%d",m_nPage];
        
    }
    else if (m_nUserType==2)
    {
        strroute = [[NSString alloc]initWithFormat:@"api/follow/follower/page/%d",m_nPage];
    }
    else
    {
        strroute = [[NSString alloc]initWithFormat:@"api/follow/following/page/%d",m_nPage];
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
    if ( !self.successBlock3 )
        return;
    
    NSMutableArray* arrData = [[NSMutableArray alloc]init];
    if ( !isNull(dcData) )
    {
        NSArray *postsFromResponse = (NSArray *)dcData;
        if (m_nFollowType==1)
        {
            for (int i=0; i<postsFromResponse.count;i++ )
            {
                NSDictionary *attributes = [postsFromResponse objectAtIndex:i];
                ClubData* Data = [[ClubData alloc]InitWithDictionary:attributes];
                [arrData addObject:Data];
            }
        }
        else
        {
            for (int i=0; i<postsFromResponse.count;i++ )
            {
                NSDictionary *attributes = [postsFromResponse objectAtIndex:i];
                UserData* Data = [[UserData alloc]InitWithDictionary:attributes];
                [arrData addObject:Data];
            }
        }
    }
    
    //回调
    self.successBlock3(arrData);
}

@end

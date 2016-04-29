//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "DynamicDetail.h"
#import "../../ProConst.h"
#import "../../../MainDlg/Dynamic/Data/DynamicData.h"
#import "../../../Utilities/GeoPoint/ZGeoPoint.h"
#import "../../../Utilities/Utilities.h"

@implementation DynamicDetail

@synthesize m_strDynamicId;  //动态ID

@synthesize m_pt;         //发动态的坐标
@synthesize m_strPlace;    //发动态的地名
@synthesize m_strIP;       //发动态的IP
@synthesize m_nType;     //1:视频 2:照片 3:文字
@synthesize m_nSendType; //1:person oter:club
@synthesize m_strTime;     //发动态的时间
@synthesize m_strContent;     //发动态的内容
@synthesize m_arrPhotos;  //发动态的图片本地路径数组

@synthesize m_ImageShare;     //用于分享的图片数据

/**
 *  开始请求
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
-(void)Start:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strDynamicId forKey:@"id"];
    
    //加路由
    NSString* strroute = @"api/dynamicDetail/getDetail";
    
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
    
    DynamicData* Data = nil;
    
    if ( !isNull(dcData) )
    {
        //解析
        Data = [[DynamicData alloc]InitWithDictionary:dcData];
    }
    
    //回调
    self.successBlock(Data);
}

/**
 *  发布动态
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)PublicDynamic:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    NSString *str = nil;
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
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
    
    //地名
    if (m_strPlace)
    {
        [parameters setObject:m_strPlace forKey:@"location"];
    }
    
    //IP
    [parameters setObject:m_strIP forKey:@"ip"];
    
    //发送类型
    if (m_nSendType==1)
    {
        str = @"person";
    }
    else
    {
        str = @"club";
    }
    [parameters setObject:str forKey:@"type"];
    
    //时间
    [parameters setObject:m_strTime forKey:@"create_time"];
    
    //内容
    [parameters setObject:m_strContent forKey:@"content"];
    
    NSMutableArray * arrPic = [[NSMutableArray alloc]init];
    //文字
    if (m_nType==3)
    {
        [arrPic addObject:@""];
        [parameters setObject:arrPic forKey:@"pictures"];
    }
    //照片
    else if (m_nType==2)
    {
        if (!m_ImageShare)
        {
            for (int i=0; i<m_arrPhotos.count; i++)
            {
                NSString* strImg = [m_arrPhotos objectAtIndex:i];
                NSString *pathExtension = [strImg pathExtension];
                NSString* strImagebase64 = [NSString stringWithFormat:@"data:image/%@;base64,", pathExtension];
                
                //得到自动处理压缩后的图片
                
                UIImage* image = [UIImage imageWithContentsOfFile:strImg];
                if (image)
                {
                    //转base64
                    NSString* strbase64 = [ZMediaFile ImageToBase64String:image];
                    if (strbase64)
                    {
                        strImagebase64 = [strImagebase64 stringByAppendingString:strbase64];
                        [arrPic addObject:strImagebase64];
                    }
                }
            }
        }
        else
        {
            NSString* strImagebase64 = [NSString stringWithFormat:@"data:image/jpeg;base64,"];
            //转base64
            NSString* strbase64 = [ZMediaFile ImageToBase64String:m_ImageShare];
            if (strbase64)
            {
                strImagebase64 = [strImagebase64 stringByAppendingString:strbase64];
            }
            [arrPic addObject:strImagebase64];
        }
    }
    [parameters setObject:arrPic forKey:@"pictures"];
    
    //加路由
    NSString* strroute =@"api/dynamic/add";
    
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
 *  删除动态
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)DeleteDynamic:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strDynamicId forKey:@"id"];
    
    //加路由
    NSString* strroute = @"api/dynamic/del";
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         if (self.successBlock)
         {
             self.successBlock(responseObject);
         }
     }
     failure:failBlock
     ];
}


@end

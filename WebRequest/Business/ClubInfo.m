//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "ClubInfo.h"
#import "../../ProConst.h"
#import "../../../MainDlg/My/Data/ClubData.h"
#import "../../../MainDlg/My/Data/UserData.h"
#import "../../../MainDlg/My/Authentication/AuthData.h"
#import "../../../Utilities/Utilities.h"

@implementation ClubInfo

@synthesize m_strClubID;            //俱乐部ID

@synthesize m_nPage;         //页数

@synthesize m_strUserName;          //用户名
@synthesize m_strRealName;          //真实姓名
@synthesize m_strBirthday;          //生日
@synthesize m_nAge;                 //年龄
@synthesize m_bySex;                //性别 1:男 0:女
@synthesize m_strPhone;             //手机号码
@synthesize m_strEmail;             //邮箱
@synthesize m_nHeight;              //身高
@synthesize m_fWeight;              //体重
@synthesize m_strPlace;             //地理位置
@synthesize m_strSignature;         //个性签名

@synthesize m_strKeyword; //资讯搜索关键字

@synthesize m_AuthData;  //俱乐部认证数据
@synthesize m_AvatarImage;//俱乐部头像


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
    [parameters setObject:m_strClubID forKey:@"id"];
    
    //加路由
    NSString* strroute =@"api/club/index";
    
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
    
    ClubData* Data = nil;
    if ( !isNull(dcData) )
    {
        //得到数据
        Data = [[ClubData alloc] InitWithDictionary:dcData];
    }
    
    //回调
    self.successBlock(Data);
}


/**
 *  获取俱乐部所有裁判和教练
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetClubWorkers:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strClubID forKey:@"id"];
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/club/getWorkers/page/%d",m_nPage];
    
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
        NSArray *postsFromResponse = (NSArray *)dcData;
        for (int i=0; i<postsFromResponse.count;i++ )
        {
            NSDictionary *attributes = [postsFromResponse objectAtIndex:i];
            UserData* Data = [[UserData alloc]InitWithDictionary:attributes];
            [arrData addObject:Data];
        }
    }
    
    //回调
    self.successBlock2(arrData);
}


/**
 *  获取俱乐部列表
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)GetClubList:(ReqSuccessArray)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock2 = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (m_strKeyword)
    {
        [parameters setObject:m_strKeyword forKey:@"name"];
    }
    else
    {
        [parameters setObject:@"" forKey:@"name"];
    }
    
    if (m_strPlace)
    {
        [parameters setObject:m_strPlace forKey:@"location"];
    }
    else
    {
        [parameters setObject:@"" forKey:@"location"];
    }
    
    //加路由
    NSString* strroute = [[NSString alloc]initWithFormat:@"api/Discover/ClubList/page/%d",m_nPage];
    
    [self SetReqUrl:OptionUrl Route:strroute ReqParameters:parameters];
    [self SetRequestType:PostRequest];
    
    ZWeakSelf;
    [self StartRequest:^(id responseObject)
     {
         //分析数据
         [weakSelf ParseData3:responseObject];
     }
     failure:failBlock
     ];
}

/**
 *  解析数据
 *
 *  @param dcData <#dcData description#>
 */
-(void)ParseData3:(NSDictionary*) dcData
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
            ClubData* Data = [[ClubData alloc]InitWithDictionary:attributes];
            [arrData addObject:Data];
        }
    }
    
    //回调
    self.successBlock2(arrData);
}


/**
 *  俱乐部认证
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)Authentication:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    
    if (!m_AuthData.m_strTheClubName)
    {
        [parameters setObject:@"" forKey:@"deptname"];
    }
    else
    {
        [parameters setObject:m_AuthData.m_strTheClubName forKey:@"deptname"];
    }
    
    if (!m_AuthData.m_strRealName)
    {
        [parameters setObject:@"" forKey:@"realname"];
    }
    else
    {
        [parameters setObject:m_AuthData.m_strRealName forKey:@"realname"];
    }
    
    if (!m_AuthData.m_strPhone)
    {
        [parameters setObject:@"" forKey:@"tel"];
    }
    else
    {
        [parameters setObject:m_AuthData.m_strPhone forKey:@"tel"];
    }
    
    if (!m_AuthData.m_strEmail)
    {
        [parameters setObject:@"" forKey:@"email"];
    }
    else
    {
        [parameters setObject:m_AuthData.m_strEmail forKey:@"email"];
    }
    
    if (!m_AuthData.m_strRemark)
    {
        [parameters setObject:@"" forKey:@"remark"];
    }
    else
    {
        [parameters setObject:m_AuthData.m_strRemark forKey:@"remark"];
    }
    
    //得到自动处理压缩后的图片
    if (self.m_AvatarImage)
    {
        //传入的参数
        NSString* strImagebase64 = [NSString stringWithFormat:@"data:image/jpeg;base64,"];
        
        //转base64
        NSString* strbase64 = [ZMediaFile ImageToBase64String:self.m_AvatarImage];
        if (strbase64)
        {
            strImagebase64 = [strImagebase64 stringByAppendingString:strbase64];
        }
        
        [parameters setObject:strImagebase64 forKey:@"avatar"];
    }
    
    //营业执照
    if (m_AuthData.m_strBusinessImgURL)
    {
        NSString *pathExtension = [m_AuthData.m_strBusinessImgURL pathExtension];
        NSString* strImagebase64 = [NSString stringWithFormat:@"data:image/%@;base64,", pathExtension];
        
        //得到自动处理压缩后的图片
        
        UIImage* image = [UIImage imageWithContentsOfFile:m_AuthData.m_strBusinessImgURL];
        if (image)
        {
            //转base64
            NSString* strbase64 = [ZMediaFile ImageToBase64String:image];
            if (strbase64)
            {
                strImagebase64 = [strImagebase64 stringByAppendingString:strbase64];
            }
            [parameters setObject:strImagebase64 forKey:@"business"];
        }
    }
    
    //法人身份证正面
    if (m_AuthData.m_strIDImgURL)
    {
        NSString *pathExtension = [m_AuthData.m_strIDImgURL pathExtension];
        NSString* strImagebase64 = [NSString stringWithFormat:@"data:image/%@;base64,", pathExtension];
        
        //得到自动处理压缩后的图片
        
        UIImage* image = [UIImage imageWithContentsOfFile:m_AuthData.m_strIDImgURL];
        if (image)
        {
            //转base64
            NSString* strbase64 = [ZMediaFile ImageToBase64String:image];
            if (strbase64)
            {
                strImagebase64 = [strImagebase64 stringByAppendingString:strbase64];
            }
            [parameters setObject:strImagebase64 forKey:@"legalfront"];
        }
    }
    
    //法人身份证背面
    if (m_AuthData.m_strID2ImgURL)
    {
        NSString *pathExtension = [m_AuthData.m_strID2ImgURL pathExtension];
        NSString* strImagebase64 = [NSString stringWithFormat:@"data:image/%@;base64,", pathExtension];
        
        //得到自动处理压缩后的图片
        
        UIImage* image = [UIImage imageWithContentsOfFile:m_AuthData.m_strID2ImgURL];
        if (image)
        {
            //转base64
            NSString* strbase64 = [ZMediaFile ImageToBase64String:image];
            if (strbase64)
            {
                strImagebase64 = [strImagebase64 stringByAppendingString:strbase64];
            }
            [parameters setObject:strImagebase64 forKey:@"legalbehind"];
        }
    }
    
    //法人银行账号正面
    if (m_AuthData.m_strBankImgURL)
    {
        NSString *pathExtension = [m_AuthData.m_strBankImgURL pathExtension];
        NSString* strImagebase64 = [NSString stringWithFormat:@"data:image/%@;base64,", pathExtension];
        
        //得到自动处理压缩后的图片
        
        UIImage* image = [UIImage imageWithContentsOfFile:m_AuthData.m_strBankImgURL];
        if (image)
        {
            //转base64
            NSString* strbase64 = [ZMediaFile ImageToBase64String:image];
            if (strbase64)
            {
                strImagebase64 = [strImagebase64 stringByAppendingString:strbase64];
            }
            [parameters setObject:strImagebase64 forKey:@"bcfront"];
        }
    }
    
    //法人银行账号背面
    if (m_AuthData.m_strBank2ImgURL)
    {
        NSString *pathExtension = [m_AuthData.m_strBank2ImgURL pathExtension];
        NSString* strImagebase64 = [NSString stringWithFormat:@"data:image/%@;base64,", pathExtension];
        
        //得到自动处理压缩后的图片
        
        UIImage* image = [UIImage imageWithContentsOfFile:m_AuthData.m_strBank2ImgURL];
        if (image)
        {
            //转base64
            NSString* strbase64 = [ZMediaFile ImageToBase64String:image];
            if (strbase64)
            {
                strImagebase64 = [strImagebase64 stringByAppendingString:strbase64];
            }
            [parameters setObject:strImagebase64 forKey:@"bcbehind"];
        }
    }
    
    //加路由
    NSString* strroute =@"api/department/add";
    
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

@end

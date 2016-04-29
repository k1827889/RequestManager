//
//  UserLogin.m
//  Cougar
//
//  Created by zly on 16/4/22.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "UserAlbum.h"
#import "../../ProConst.h"
#import "../../../Utilities/Utilities.h"

@implementation UserAlbum

@synthesize m_ImagePhoto;//相册图片
@synthesize m_strPhotoId;//相册图片ID

/**
 *  上传相册图片
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)UpLoadPhoto:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    //得到自动处理压缩后的图片
    if (m_ImagePhoto)
    {
        //传入的参数
        NSString* strImagebase64 = [NSString stringWithFormat:@"data:image/jpeg;base64,"];
        
        //转base64
        NSString* strbase64 = [ZMediaFile ImageToBase64String:m_ImagePhoto];
        if (strbase64)
        {
            strImagebase64 = [strImagebase64 stringByAppendingString:strbase64];
        }
        
        [parameters setObject:strImagebase64 forKey:@"picture"];
    }
    
    //加路由
    NSString* strroute =@"api/userImg/upload";
    
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
 *  删除相册图片
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)DeletePhoto:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strPhotoId forKey:@"imgId"];
    
    //加路由
    NSString* strroute =@"api/userImg/delete";
    
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
 *  设置相册主图片
 *
 *  @param successBlock <#successBlock description#>
 *  @param failBlock    <#failBlock description#>
 */
-(void)SetMainPhoto:(ReqSuccessObject)successBlock failure:(ErrorData)failBlock
{
    //保存回调
    self.successBlock = successBlock;
    
    //传入的参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:m_strPhotoId forKey:@"imgId"];
    
    //加路由
    NSString* strroute =@"api/userImg/setMainHeadImg";
    
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

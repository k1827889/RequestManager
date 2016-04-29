//
//  ProManager.h
//  Cougar
//
//  Created by zly on 15/12/18.
//  Copyright © 2015年 zly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"
#import "../MainDlg/My/Data/UserData.h"
#import "../Utilities/DefaultData/ZDefaultData.h"

/**
 *  工程管理器
 */
@interface ProManager : NSObject

@property(nonatomic,strong) RequestManager * m_RequestManager;  //请求管理类
@property(nonatomic,strong) UserData * m_UserData;              //用户的基本数据
@property(nonatomic,strong) NSString * m_strDomainNameUrl;      //主域名
@property(nonatomic,strong) ZDefaultData * m_DefaultData;       //默认数据


/**
 *  初始化基本管理
 */
-(void)InitProManage;

/**
 *  注销基本管理
 */
-(void)UnInitProManage;


@end

//
//  AppManager.m
//  Cougar
//
//  Created by zly on 15/12/18.
//  Copyright © 2015年 zly. All rights reserved.
//

#import "ProManager.h"

@implementation ProManager

@synthesize m_RequestManager;  //请求管理类
@synthesize m_UserData;             //用户的基本数据
@synthesize m_strDomainNameUrl;     //主域名
@synthesize m_DefaultData;          //默认数据


/**
 *  初始化基本管理
 */
-(void)InitProManage
{
    //============== Begin 用户基本数据管理 =================================
    m_UserData = nil;
    
    //============== Begin 创建请求管理管理器 =================================
    m_RequestManager = [[RequestManager alloc]init];
    
    //开启网络监听
    [m_RequestManager StartNetWorkMonitor];
    
//    //设置进程停止1秒，用于显示启动图同时可为网络监听状态做准备
//    [NSThread sleepForTimeInterval:1.0];
    
    //保存主域名
    m_strDomainNameUrl = [m_RequestManager GetDomainNameUrl];
    
    //加载默认数据
    m_DefaultData = [ZDefaultData ReadLocalData];
    
}

/**
 *  注销基本管理
 */
-(void)UnInitProManage
{
    //============== Begin 用户基本数据管理 =================================
    m_UserData = nil;
    
    //============== Begin 默认用户基本数据管理 =================================
//    m_DefaultData.m_strUser = nil;
    m_DefaultData.m_strPassword = nil;
    [ZDefaultData SaveLocalData:m_DefaultData];
    
    //请求管理
    [m_RequestManager UnInit];
    
}


/**
 *  重载
 *
 *  @return <#return value description#>
 */
- (instancetype) init
{
    if ( self = [super init] )
    {
        m_RequestManager = nil;
    }
    
    return self;
}

-(void) dealloc
{
    NSLog(@"%s dealloc", object_getClassName(self));
}

@end

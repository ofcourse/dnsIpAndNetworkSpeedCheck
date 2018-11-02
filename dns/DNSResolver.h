//
//  DNSResolver.h
//  dns
//
//  Created by macbook on 2018/11/2.
//  Copyright © 2018年 HSG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DNSResolver : NSObject

//获取本地网络的dns列表
- (NSString *)getDNSAddressesCSV;
//根据域名获取ip地址
- (NSString*)getIPWithHostName:(const NSString*)hostName;
@end

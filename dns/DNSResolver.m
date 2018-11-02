//
//  DNSResolver.m
//  dns
//
//  Created by macbook on 2018/11/2.
//  Copyright © 2018年 HSG. All rights reserved.
//

#import "DNSResolver.h"
#include <resolv.h>
#include <netdb.h>
#include <arpa/inet.h>

@implementation DNSResolver {
    res_state _state;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _state = malloc(sizeof(struct __res_state));
        if (EXIT_SUCCESS != res_ninit(_state)) {
            free(_state);
            return nil;
        }
    }
    return self;
}

- (void)dealloc {
    res_ndestroy(_state);
    free(_state);
}

#pragma mark - Public

- (NSString *)getDNSAddressesCSV
{
    NSMutableArray *addresses = [NSMutableArray new];
    
    union res_sockaddr_union servers[NI_MAXSERV];
    
    int serversFound = res_9_getservers(_state, servers, NI_MAXSERV);
    
    char hostBuffer[NI_MAXHOST];
    for (int i = 0; i < serversFound; i ++) {
        union res_sockaddr_union s = servers[i];
        if (s.sin.sin_len > 0) {
            if (EXIT_SUCCESS == getnameinfo((struct sockaddr *)&s.sin,  // Pointer to your struct sockaddr
                                            (socklen_t)s.sin.sin_len,   // Size of this struct
                                            (char *)&hostBuffer,        // Pointer to hostname string
                                            sizeof(hostBuffer),         // Size of this string
                                            nil,                        // Pointer to service name string
                                            0,                          // Size of this string
                                            NI_NUMERICHOST)) {          // Flags given
                [addresses addObject:[NSString stringWithUTF8String:hostBuffer]];
            }
        }
    }
    
    return [addresses componentsJoinedByString:@","];
}

/// 根据域名获取IP地址
- (NSString*)getIPWithHostName:(const NSString*)hostName
{
    const char *hostN= [hostName UTF8String];
    
    // 记录主机的信息，包括主机名、别名、地址类型、地址长度和地址列表 结构体
    struct hostent *phot;
    
    @try {
        // 返回对应于给定主机名的包含主机名字和地址信息的hostent结构指针
        phot = gethostbyname(hostN);
        
        struct in_addr ip_addr;
        
        memcpy(&ip_addr, phot->h_addr_list[0], 4);
        
        char ip[20] = {0};
        
        inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
        
        NSString* strIPAddress = [NSString stringWithUTF8String:ip];
        
        return strIPAddress;
        
    }
    @catch (NSException *exception) {
        return nil;
    }
}

@end

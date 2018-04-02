//
//  InternetConnection.m
//  Dentistkart
//
//  Created by ihub on 5/24/16.
//  Copyright © 2016 Google Inc. All rights reserved.
//

#import "InternetConnection.h"
#import "SystemConfiguration/SystemConfiguration.h"
static InternetConnection *sharedRestInstance = nil;
@implementation InternetConnection


+(InternetConnection*)getSharedInstance{
    if (!sharedRestInstance) {
        sharedRestInstance = [[super allocWithZone:NULL]init];
        
    }
    return sharedRestInstance;
}

#pragma mark Custom Actions
-(BOOL)CheckNetwork
{
    const char *host_name = "www.google.com";
    if( [self checkConnection:host_name] )
    {
        //NSLog(@"Net available");
        return YES;
    }
    else
    {
        //NSLog(@"Net Not available");
        return NO;
    }
}

- (BOOL) checkConnection:(const char*) host_name
{
    BOOL _isDataSourceAvailable = NO;
    Boolean success;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
    
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    _isDataSourceAvailable = success &&(flags & kSCNetworkFlagsReachable) &&!(flags & kSCNetworkFlagsConnectionRequired);
    
    CFRelease(reachability);
    
    return _isDataSourceAvailable;
}

@end

//
//  IMIHLOrdersList.m
//  iMediHubLIMS
//
//  Created by ihub on 1/5/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLOrdersList.h"

@implementation IMIHLOrdersList
- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.orders forKey:@"orders"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.orders = [decoder decodeObjectForKey:@"orders"];
    
    return self;
    
}
-(IMIHLOrdersList*)getOrdersListResult:(NSDictionary *)orderresult_dict{
    
    self.orders = [NSMutableArray new];
    for (NSDictionary *order_dict in orderresult_dict) {
        
        ALOrders*orderObj = [ALOrders new];
        NSString*orderid_str = [order_dict objectForKey:@"orderid"];
        
        if ([orderid_str isEqual:[NSNull null]]||[orderid_str isEqualToString:@"null"]||[orderid_str isEqualToString:@"(null)"]||orderid_str==nil||orderid_str==NULL) {
            orderid_str=@"Not Available";
        }
        
        orderObj.orderId = orderid_str;
        
        NSString*orderflag_str = [NSString stringWithFormat:@"%@",[order_dict objectForKey:@"flag"]];
        
        if ([orderflag_str isEqual:[NSNull null]]||[orderflag_str isEqualToString:@"null"]||[orderflag_str isEqualToString:@"(null)"]||orderflag_str==nil||orderflag_str==NULL) {
            orderflag_str=@"Not Available";
        }
        
        orderObj.orderFlag = orderflag_str;

        
        NSString*orderdatetime = [order_dict objectForKey:@"orderDate"];
        if ([orderdatetime isEqual:[NSNull null]]||[orderdatetime isEqualToString:@"null"]||[orderdatetime isEqualToString:@"(null)"]||orderdatetime==nil||orderdatetime==NULL) {
            orderdatetime=@"Not Available";
        }
        
        NSArray* service_arr = [order_dict objectForKey:@"patientservices"];
        NSLog(@"service_arr:%@",service_arr);
        orderObj.orderServicesDict = [NSMutableDictionary new];
        if ([service_arr isEqual:[NSNull null]]||[service_arr isEqual:nil]||service_arr == NULL) {
            NSLog(@"empty servicess");
            [orderObj.orderServicesDict setObject:@"empty" forKey:@"empty"];
        }else{
        [orderObj.orderServicesDict setObject:service_arr forKey:orderid_str];
        }
       
        NSArray * arr = [orderdatetime componentsSeparatedByString:@" "];
        //NSLog(@"Array values date times are : %@",arr);
        NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
       
        orderObj.orderDate = [arr objectAtIndex:0];
        orderObj.orderTime = strtime;
        [self.orders addObject:orderObj];
        orderObj = nil;
    }
    
    return self;
}
@end

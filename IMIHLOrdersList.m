//
//  IMIHLOrdersList.m
//  iMediHubLIMS
//
//  Created by ihub on 1/5/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLOrdersList.h"

@implementation IMIHLOrdersList
-(void)allocteArry{
    self.orderid_arr = [[NSMutableArray alloc]init];
    self.orderdate_arr = [[NSMutableArray alloc]init];
    self.ordertime_arr = [[NSMutableArray alloc]init];
    self.orderflag_arr = [[NSMutableArray alloc]init];
    self.orderservices_dict = [[NSMutableDictionary alloc]init];
}
- (void) encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.orderid_arr forKey:@"orderid_arr"];
    [encoder encodeObject:self.orderdate_arr forKey:@"orderdate_arr"];
    [encoder encodeObject:self.ordertime_arr forKey:@"ordertime_arr"];
    [encoder encodeObject:self.orderflag_arr forKey:@"orderflag_arr"];
    [encoder encodeObject:self.orderservices_dict forKey:@"orderservices_dict"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.orderid_arr = [decoder decodeObjectForKey:@"orderid_arr"];
    self.orderdate_arr = [decoder decodeObjectForKey:@"orderdate_arr"];
    self.ordertime_arr = [decoder decodeObjectForKey:@"ordertime_arr"];
    self.orderflag_arr = [decoder decodeObjectForKey:@"orderflag_arr"];
    self.orderservices_dict = [decoder decodeObjectForKey:@"orderservices_dict"];
    
    
    
    return self;
    
}
-(IMIHLOrdersList*)getOrdersListResult:(NSDictionary *)orderresult_dict{
    
    [self allocteArry];
    for (NSDictionary *order_dict in orderresult_dict) {
        NSString*orderid_str = [order_dict objectForKey:@"orderid"];
        
        if ([orderid_str isEqual:[NSNull null]]||[orderid_str isEqualToString:@"null"]||[orderid_str isEqualToString:@"(null)"]||orderid_str==nil||orderid_str==NULL) {
            orderid_str=@"Not Available";
        }
        
        [self.orderid_arr addObject:orderid_str];
        
        NSString*orderflag_str = [NSString stringWithFormat:@"%@",[order_dict objectForKey:@"flag"]];
        
        if ([orderflag_str isEqual:[NSNull null]]||[orderflag_str isEqualToString:@"null"]||[orderflag_str isEqualToString:@"(null)"]||orderflag_str==nil||orderflag_str==NULL) {
            orderflag_str=@"Not Available";
        }
        
        [self.orderflag_arr addObject:orderflag_str];

        
        NSString*orderdatetime = [order_dict objectForKey:@"orderDate"];
        if ([orderdatetime isEqual:[NSNull null]]||[orderdatetime isEqualToString:@"null"]||[orderdatetime isEqualToString:@"(null)"]||orderdatetime==nil||orderdatetime==NULL) {
            orderdatetime=@"Not Available";
        }
        
        NSArray* service_arr = [order_dict objectForKey:@"patientservices"];
        if ([service_arr isEqual:[NSNull null]]||[service_arr isEqual:nil]||service_arr == NULL) {
            [self.orderservices_dict setObject:@"Not Available" forKey:@"empty"];
        }
        
        [self.orderservices_dict setObject:service_arr forKey:orderid_str];
        NSArray * arr = [orderdatetime componentsSeparatedByString:@" "];
        //NSLog(@"Array values date times are : %@",arr);
        NSString*strtime = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:1],[arr objectAtIndex:2]];
        [self.orderdate_arr addObject:[arr objectAtIndex:0]];
        [self.ordertime_arr addObject:strtime];

        
    }
    
    return self;
}
@end

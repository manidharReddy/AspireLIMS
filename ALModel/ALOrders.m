//
//  ALOrders.m
//  AspireLIMS
//
//  Created by ihub on 22/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "ALOrders.h"

@implementation ALOrders
- (void)encodeWithCoder:(NSCoder *)encoder {
    
    [encoder encodeObject:self.orderId forKey:@"orderId"];
    [encoder encodeObject:self.orderDate forKey:@"orderDate"];
    [encoder encodeObject:self.orderTime forKey:@"orderTime"];
    [encoder encodeObject:self.orderFlag forKey:@"orderFlag"];
    [encoder encodeObject:self.orderServicesDict forKey:@"orderServicesDict"];
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    self.orderId = [decoder decodeObjectForKey:@"orderId"];
    self.orderDate = [decoder decodeObjectForKey:@"orderDate"];
    self.orderTime = [decoder decodeObjectForKey:@"orderTime"];
    self.orderFlag = [decoder decodeObjectForKey:@"orderFlag"];
    self.orderServicesDict = [decoder decodeObjectForKey:@"orderServicesDict"];
    return self;
    
}

- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else if (![super isEqual:other]) {
        return NO;
    } else {
        ALOrders*orderObj = (ALOrders*)other;
        return [self.orderId isEqual:orderObj.orderId] && [self.orderDate isEqual:orderObj.orderDate] && [self.orderTime isEqual:orderObj.orderTime] && [self.orderFlag isEqual:orderObj.orderFlag];
    }
}

- (NSUInteger)hash
{
    return self.orderId.hash + self.orderDate.hash + self.orderTime.hash + self.orderFlag.hash;
}

@end

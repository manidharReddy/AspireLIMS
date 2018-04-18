//
//  ALOrders.h
//  AspireLIMS
//
//  Created by ihub on 22/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALOrders : NSObject<NSCoding>
@property(strong,nonatomic) NSString*orderDate;
@property(strong,nonatomic) NSString*orderId;
@property(strong,nonatomic) NSString*orderTime;
@property(strong,nonatomic) NSString*orderFlag;
@property(strong,nonatomic) NSMutableDictionary*orderServicesDict;

@end

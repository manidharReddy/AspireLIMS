//
//  IMIHLOrdersList.h
//  iMediHubLIMS
//
//  Created by ihub on 1/5/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALOrders.h"
@interface IMIHLOrdersList : NSObject<NSCoding>
@property(strong,nonatomic)NSMutableArray<ALOrders*>*orders;
-(IMIHLOrdersList*)getOrdersListResult:(NSDictionary*)orderresult_dict;
@end

//
//  IMIHLOrdersList.h
//  iMediHubLIMS
//
//  Created by ihub on 1/5/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLOrdersList : NSObject
@property(strong,nonatomic)NSMutableArray*orderid_arr;
@property(strong,nonatomic)NSMutableArray*orderdate_arr;
@property(strong,nonatomic)NSMutableArray*ordertime_arr;
@property(strong,nonatomic)NSMutableArray*orderflag_arr;
@property(strong,nonatomic)NSMutableDictionary*orderservices_dict;
-(IMIHLOrdersList*)getOrdersListResult:(NSDictionary*)orderresult_dict;
@end

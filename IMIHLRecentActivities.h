//
//  IMIHLRecentActivities.h
//  AspireLIMS
//
//  Created by ihub on 09/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLRecentActivities : NSObject
@property(strong,nonatomic) NSMutableDictionary*allRecentActivitiesDict;
@property(strong,nonatomic) NSMutableArray*allRecentActivities;
-(NSArray*)filterArrayUsingCustomProperty:(NSArray*)arrayList value:(NSString*)value;
-(IMIHLRecentActivities*)setRecentActivitiesList:(NSDictionary*)responseDictionary;

@end

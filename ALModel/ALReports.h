//
//  ALReports.h
//  AspireLIMS
//
//  Created by ihub on 10/04/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALTest.h"
@interface ALReports : NSObject
@property(strong,nonatomic) NSString*testTypeObj;
@property(strong,nonatomic) NSString*testIsRepeatedObj;
@property(strong,nonatomic) NSDictionary<NSString*,ALTest*>*repeatedTestsDict;
@property(strong,nonatomic) NSMutableArray*resultDataArrObj;

+(ALReports*)getSharedInstance;
-(void)allocate;
@end

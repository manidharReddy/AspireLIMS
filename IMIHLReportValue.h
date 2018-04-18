//
//  IMIHLReportValue.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 21/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALReports.h"
#import "ALGroup.h"
#import "ALReports.h"
@interface IMIHLReportValue : NSObject<NSCoding>
@property(strong,nonatomic) NSMutableArray<ALReports*>*alReportObjsArry;
@property(strong,nonatomic) NSMutableOrderedSet<ALReports*>*alReportObjsSet;


-(IMIHLReportValue*)getReports:(NSDictionary*)responseresult ifSearch:(BOOL)isType;
-(ALTest*)setDataForAlTestObj:(NSDictionary*)dict;
@end

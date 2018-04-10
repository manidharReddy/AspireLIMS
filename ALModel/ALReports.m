//
//  ALReports.m
//  AspireLIMS
//
//  Created by ihub on 10/04/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import "ALReports.h"
static ALReports *sharedAlReportsInstance = nil;
@implementation ALReports

+(ALReports*)getSharedInstance{
    if (!sharedAlReportsInstance) {
        sharedAlReportsInstance = [[super allocWithZone:NULL]init];
        //[sharedAlReportsInstance allocate];
    }
    return sharedAlReportsInstance;
}
-(void)allocate{
    self.resultDataArrObj = [NSMutableArray new];
    self.repeatedTestsDict = [NSDictionary new];
}
@end

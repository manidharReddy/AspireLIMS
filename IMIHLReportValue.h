//
//  IMIHLReportValue.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 21/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLReportValue : NSObject<NSCoding>
/*Individual test parameters in Array*/
@property(strong,nonatomic) NSMutableArray*testid_arr;
@property(strong,nonatomic) NSMutableArray*testname_arr;
@property(strong,nonatomic) NSMutableArray*departmentid_arr;
@property(strong,nonatomic) NSMutableArray*departmentname_arr;
@property(strong,nonatomic) NSMutableArray*testunits_arr;
@property(strong,nonatomic) NSMutableArray*testdate_arr;
@property(strong,nonatomic) NSMutableArray*testminvalue_arr;
@property(strong,nonatomic) NSMutableArray*testmaxvalue_arr;
@property(strong,nonatomic) NSMutableArray*testresultvalue_arr;
@property(strong,nonatomic) NSMutableArray*testcriticallowvalue_arr;
@property(strong,nonatomic) NSMutableArray*testcriticalhighvalue_arr;
@property(strong,nonatomic) NSMutableArray*type_arr;
@property(strong,nonatomic) NSMutableArray*isentered_arr;
@property(strong,nonatomic) NSMutableArray*testdatesplit_arr;
@property(strong,nonatomic) NSMutableArray*testtimesplit_arr;
@property(strong,nonatomic) NSMutableArray*testranges_arr;
@property(strong,nonatomic) NSMutableArray*isrepeated_arr;
/*Group test parameters in Array*/

//@property(strong,nonatomic) NSMutableArray*grouptid_arr;
//@property(strong,nonatomic) NSMutableArray*grouptname_arr;
@property(strong,nonatomic) NSMutableArray*groupttestobj_arr;
@property(strong,nonatomic) NSMutableArray*panelgroupobj_arr;
@property(strong,nonatomic) NSMutableArray*paneltestobj_arr;
@property(strong,nonatomic) NSMutableDictionary*grouptest_dict;
@property(strong,nonatomic) NSMutableDictionary*paneltest_dict;
@property(strong,nonatomic) NSMutableDictionary*panelgroup_dict;
-(IMIHLReportValue*)getReportResult:(NSDictionary*)responseresult;

@end

//
//  IMIHLSearchResults.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 01/08/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLSearchResults : NSObject
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


@property(strong,nonatomic) NSMutableArray*serviceid_arr;
@property(strong,nonatomic) NSMutableArray*servicename_arr;

-(IMIHLSearchResults*)getReportResult:(NSDictionary*)responseresult;
-(IMIHLSearchResults*)getSearchServiceResult:(NSDictionary*)responseresult;
@end

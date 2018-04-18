//
//  ALTest.h
//  AspireLIMS
//
//  Created by ihub on 10/04/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALTest : NSObject
@property(strong,nonatomic) NSString*testid;
@property(strong,nonatomic) NSString*testname;
@property(strong,nonatomic) NSString*departmentid;
@property(strong,nonatomic) NSString*departmentname;
@property(strong,nonatomic) NSString*testunits;
@property(strong,nonatomic) NSString*testdate;
@property(strong,nonatomic) NSString*testminvalue;
@property(strong,nonatomic) NSString*testmaxvalue;
@property(strong,nonatomic) NSString*testresultvalue;
@property(strong,nonatomic) NSString*testcriticallowvalue;
@property(strong,nonatomic) NSString*testcriticalhighvalue;
@property(strong,nonatomic) NSString*type;
@property(strong,nonatomic) NSString*isentered;
@property(strong,nonatomic) NSString*testdatesplit;
@property(strong,nonatomic) NSString*testtimesplit;
@property(strong,nonatomic) NSString*testranges;
@property(strong,nonatomic) NSString*isrepeated;
@end

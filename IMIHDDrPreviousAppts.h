//
//  IMIHDDrPreviousAppts.h
//  iMediHubLIMS
//
//  Created by ihub on 06/06/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHDDrPreviousAppts : NSObject
@property (strong,nonatomic) NSMutableArray*doctname_arr;
@property (strong,nonatomic) NSMutableArray*dept_id_arr;
@property (strong,nonatomic) NSMutableArray*test_id_arr;
@property (strong,nonatomic) NSMutableArray*testname_arr;
@property (strong,nonatomic) NSMutableArray*deptname_arr;
@property (strong,nonatomic) NSMutableArray*bookedtime_arr;
@property (strong,nonatomic) NSMutableArray*bookeddate_arr;
@property (strong,nonatomic) NSMutableArray*status_arr;

-(IMIHDDrPreviousAppts*)getAppointmentsList:(NSDictionary*)responseresult;
@end

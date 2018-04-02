//
//  IMIHLAppointments.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 30/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLAppointments : NSObject
@property (strong,nonatomic) NSMutableArray*apointmentId_arr;
@property (strong,nonatomic) NSMutableArray*dept_id_arr;
@property (strong,nonatomic) NSMutableArray*test_id_arr;
@property (strong,nonatomic) NSMutableArray*testname_arr;
@property (strong,nonatomic) NSMutableArray*deptname_arr;
@property (strong,nonatomic) NSMutableArray*bookedtime_arr;
@property (strong,nonatomic) NSMutableArray*bookeddate_arr;
@property (strong,nonatomic) NSMutableArray*status_arr;

-(IMIHLAppointments*)getAppointmentsList:(NSDictionary*)responseresult;
@end

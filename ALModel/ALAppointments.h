//
//  ALAppointments.h
//  AspireLIMS
//
//  Created by Aparna Reddy Challa on 17/04/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALAppointments : NSObject<NSCoding>
@property (strong,nonatomic) NSString*apointmentId;
@property (strong,nonatomic) NSString*deptId;
@property (strong,nonatomic) NSString*testId;
@property (strong,nonatomic) NSString*testName;
@property (strong,nonatomic) NSString*deptName;
@property (strong,nonatomic) NSString*bookedTime;
@property (strong,nonatomic) NSString*bookedDate;
@property (strong,nonatomic) NSString*status;

@end

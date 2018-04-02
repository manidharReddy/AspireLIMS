//
//  ALRecentActivity.h
//  AspireLIMS
//
//  Created by ihub on 13/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALRecentActivity : NSObject
{
    BOOL isReportDownloadable;
}
@property(strong,nonatomic) NSString*activityType;
@property(strong,nonatomic) NSString*activityId;
@property(strong,nonatomic) NSString*appointmentDate;
@property(strong,nonatomic) NSString*appointmentTime;
@property(strong,nonatomic) NSArray*patientOrderServices;

@property(strong,nonatomic) NSString*appointmentStatus;
@property(strong,nonatomic) NSArray*appointmentServices;
@property(strong,nonatomic) NSString*latitute;
@property(strong,nonatomic) NSString*longitude;
@property(strong,nonatomic) NSString*name;

@end

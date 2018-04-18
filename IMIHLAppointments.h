//
//  IMIHLAppointments.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 30/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALAppointments.h"
@interface IMIHLAppointments : NSObject<NSCoding>
@property (strong,nonatomic) NSMutableArray<ALAppointments*>*appoinments;
-(IMIHLAppointments*)getAppointmentsList:(NSDictionary*)responseresult;
@end

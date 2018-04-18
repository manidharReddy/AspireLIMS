//
//  IMIHDDoctorTimes.h
//  iMediHubLIMS
//
//  Created by ihub on 12/29/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHDDoctorTimes : NSObject
@property (strong,nonatomic) NSMutableArray*drtimeflag_arr;
@property (strong,nonatomic) NSDictionary*drtimes_dict;
@property (strong,nonatomic) NSMutableArray*drtimes_arr;
@property (strong,nonatomic) NSMutableArray*drdates_arr;
@property (strong,nonatomic) NSMutableDictionary*drdatewisetimes_dict;
-(IMIHDDoctorTimes*)getDoctorTimesResult:(NSDictionary*)responseresult;
-(IMIHDDoctorTimes*)getTimeSlotByDate:(NSDictionary*)timeslotdict;
@end

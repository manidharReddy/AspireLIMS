//
//  IMIHLDoctorDates.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 20/10/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLDoctorDates : NSObject
@property (strong,nonatomic) NSString*doctid_srt;
@property (strong,nonatomic) NSString*startdate_str;
@property (strong,nonatomic) NSString*enddate_str;
@property (strong,nonatomic) NSMutableArray*doctavalbl_arr;
-(IMIHLDoctorDates*)getDoctorDatesResult:(NSDictionary*)responseresult;

@end

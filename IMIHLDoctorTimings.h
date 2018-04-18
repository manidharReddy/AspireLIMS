//
//  IMIHLDoctorTimings.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 03/11/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLDoctorTimings : NSObject

@property (strong,nonatomic) NSMutableArray*doctslottimes_arr;
-(IMIHLDoctorTimings*)getDoctorTimesResult:(NSDictionary*)responseresult;

@end

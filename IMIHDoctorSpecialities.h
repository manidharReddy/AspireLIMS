//
//  IMIHDoctorSpecialities.h
//  iMediHubLIMS
//
//  Created by ihub on 12/21/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHDoctorSpecialities : NSObject
@property (strong,nonatomic) NSMutableArray*deptid_arr;
@property (strong,nonatomic) NSMutableArray*specialityname_arr;
-(IMIHDoctorSpecialities*)getSpecialitesResult:(NSDictionary*)responseresult;

@end

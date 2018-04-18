//
//  IMIHLDoctorList.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 19/10/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLDoctorList : NSObject
@property (strong,nonatomic) NSMutableArray*doctid_arr;
@property (strong,nonatomic) NSMutableArray*doctname_arr;
@property (strong,nonatomic) NSMutableArray*doctstds_arr;
@property (strong,nonatomic) NSMutableArray*doctspecialty_arr;
@property (strong,nonatomic) NSMutableArray*doctfee_arr;
@property (strong,nonatomic) NSMutableArray*doctexp_arr;
@property (strong,nonatomic) NSMutableArray*doctprofileimg_arr;

-(IMIHLDoctorList*)getDoctorListResult:(NSDictionary*)responseresult;

@end

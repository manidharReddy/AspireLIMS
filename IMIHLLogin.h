//
//  IMIHLLogin.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 22/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLLogin : NSObject<NSCoding>

@property (strong,nonatomic) NSString*patientid;
@property (strong,nonatomic) NSString*firstname;
@property (strong,nonatomic) NSString*lastname;
@property (strong,nonatomic) NSString*gender;
@property (strong,nonatomic) NSString*dob;
@property (strong,nonatomic) NSString*emailid;
@property (strong,nonatomic) NSString*mobile;
@property (strong,nonatomic) NSString*bloodgroup;
@property (strong,nonatomic) NSData*profileimage;
-(IMIHLLogin*)getLoginResult:(NSDictionary*)responseresult;

@end

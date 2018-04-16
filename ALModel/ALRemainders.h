//
//  ALRemainders.h
//  AspireLIMS
//
//  Created by ihub on 21/03/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALRemainders : NSObject<NSCoding>
@property(strong,nonatomic) NSString*apptmtId;
@property(strong,nonatomic) NSString*name;
@property(strong,nonatomic) NSString*appointmentDate;
@property(strong,nonatomic) NSString*appointmentTime;

@property(strong,nonatomic) NSString*status;

@property(strong,nonatomic) NSString*latitute;

@property(strong,nonatomic) NSString*longitude;

@end

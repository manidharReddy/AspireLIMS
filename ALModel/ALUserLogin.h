//
//  ALUserLogin.h
//  AspireLIMS
//
//  Created by ihub on 06/04/18.
//  Copyright © 2018 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALUserLogin : NSObject<NSCoding>
@property (strong,nonatomic) NSString*userid;
@property (strong,nonatomic) NSString*password;
@end

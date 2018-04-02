//
//  IMIHDLocations.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 27/10/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHDLocations : NSObject
@property (strong,nonatomic) NSMutableArray*locatid_arr;
@property (strong,nonatomic) NSMutableArray*locatname_arr;
-(IMIHDLocations*)getLocationResult:(NSDictionary*)responseresult;

@end

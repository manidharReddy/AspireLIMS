//
//  IMIHLLocations.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 22/08/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLLocations : NSObject
@property (strong,nonatomic) NSMutableArray*locatid_arr;
@property (strong,nonatomic) NSMutableArray*locatname_arr;
-(IMIHLLocations*)getLocationResult:(NSDictionary*)responseresult;

@end

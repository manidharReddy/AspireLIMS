//
//  IMIHLTest.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 27/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHLTest : NSObject<NSCoding>
@property (strong,nonatomic) NSMutableArray*testid_arr;
@property (strong,nonatomic) NSMutableArray*testname_arr;
@property (strong,nonatomic) NSMutableArray*tesprice_arr;
@property (strong,nonatomic) NSMutableDictionary<NSString*,NSString*>*tmptestdict;

-(IMIHLTest*)getDepartmentTestsResult:(NSDictionary*)responseresult;

@end

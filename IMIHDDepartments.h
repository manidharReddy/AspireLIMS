//
//  IMIHDDepartments.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 27/10/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IMIHDDepartments : NSObject
@property (strong,nonatomic) NSMutableArray*deptid_arr;
@property (strong,nonatomic) NSMutableArray*deptname_arr;
-(IMIHDDepartments*)getDepartmentResult:(NSDictionary*)responseresult;

@end

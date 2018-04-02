//
//  IMIHLAboutUs.h
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 12/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"

@interface IMIHLAboutUs : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *vision_txtview;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backBarBtn;
@property (strong, nonatomic) NSString*patientid_str;
- (IBAction)backBarClick:(id)sender;

@end

//
//  IMIHLMyProfile.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 12/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLMyProfile.h"
//#import "IMIHLDBManager.h"
#import "IMIHLEditProfileVC.h"
//#import "IMIHLDashboardVC.h"
#import "IMIHLRestService.h"
#import "IMIHLLogin.h"
#import "IMIHLPassword.h"
#import "ViewController.h"
@interface IMIHLMyProfile (){
    NSString*patientfirstname_str;
    NSString*patientlastname_str;
    NSData*image_data;
}

@end

@implementation IMIHLMyProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.backBarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    
        //[self retrivePatientInfo];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";
    [self.edit_btn setImage:[UIImage imageWithIcon:@"fa-pencil-square-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forState:UIControlStateNormal];
    
    //[self retrivePatientInfo];
    [self retriveProfile];
    //[self performSelector:@selector(getUserDetailsService) withObject:nil afterDelay:0.1];
    
    //[self getUserDetailsService];
    self.changePassword.layer.cornerRadius = self.changePassword.bounds.size.height/2;
    self.changePassword.clipsToBounds = YES;
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.navigationController.navigationBarHidden = NO;
    self.backBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backBarItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backBarItem];
}

- (void)goBack
{
    self.navigationController.navigationBarHidden = YES;
   // [self.navigationController popViewControllerAnimated:YES];
    [self loadViewControllerFromStoryBoard:@"dashboard"];
}

-(IMIHLLogin*)getUserInfo{
    NSUserDefaults*userdefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userdefaults objectForKey:@"userprofiles"];
    IMIHLLogin*login = (IMIHLLogin*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"login object:%@",login);
    return login;
}

-(void)retriveProfile{
    IMIHLLogin*loginInfo = [self getUserInfo];
    //NSString*userName = loginInfo.firstname
    self.patientname_lbl.text =[NSString stringWithFormat:@"%@ %@ %@",@" ",loginInfo.firstname,loginInfo.lastname];
    self.patientname_str = self.patientname_lbl.text ;
    if ([loginInfo.gender intValue]==2) {
        self.patientgender_lbl.text = @"Female";
    }else{
        self.patientgender_lbl.text = @"Male";
    }
    self.patientid_lbl.text = loginInfo.patientid;
    self.nationality_lbl.text=@"Indian";
    self.patientdob_lbl.text = loginInfo.dob;
    
    self.patientemail_lbl.text = loginInfo.emailid;
    
    self.patientmobile_lbl.text = [NSString stringWithFormat:@"+91 %@",loginInfo.mobile];
    self.mobilenumber_top_lbl.text = self.patientmobile_lbl.text;
    
    self.patientbloodgrp_lbl.text = loginInfo.bloodgroup;
    
    
    // //NSLog(@"image check out:%@",[patientinfo_arr objectAtIndex:8]);
    image_data = loginInfo.profileimage;
    //NSLog(@"image_data:%@",image_data);
    /*
     NSString*imglength = [patientinfo_arr objectAtIndex:8];
     //NSLog(@"imglength:%d",(int)imglength.length);
     NSData*tempimg =[patientinfo_arr objectAtIndex:8];
     image_data = [NSData dataWithBytes:[tempimg bytes] length:tempimg.length] ;
     
     //NSLog(@"image_data:%@",image_data);
     if ([image_data isEqual:[NSNull null]]||[image_data isEqual:@"<31>"]||imglength.length<=10) {
     //NSLog(@"image check:%@",[patientinfo_arr objectAtIndex:8]);
     }else{
     
     self.profileicon_imgview.image = [UIImage imageWithData:image_data];
     }
     */
    if (image_data==nil) {
        [self.profileicon_imgview setImage:[UIImage imageWithIcon:@"fa-user" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:self.profileicon_imgview.frame.size.width / 2]];
        
    }else{
        //NSLog(@"else entred");
        [self.profileicon_imgview setImage:[UIImage imageWithData:image_data]];
    }
    //self.profileicon_imgview.layer.cornerRadius = self.profileicon_imgview.frame.size.height/2;
    //self.profileicon_imgview.layer.cornerRadius = 20;
    self.profileicon_imgview.layer.masksToBounds = YES;
    self.profileicon_imgview.layer.borderWidth=0;
    self.profileicon_imgview.clipsToBounds=YES;
    [self.profileicon_imgview setContentMode:UIViewContentModeScaleAspectFill];
    [self.profileicon_imgview.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.profileicon_imgview.layer setBorderWidth:2.0];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
-(CGSize)screenSize {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    return screenSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"My Profile"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:alrtmsg
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"OK"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    [alert addAction:button0];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if([identifiername isEqualToString:@"dashboard"]){
    //IMIHLDashboardVC * dvc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    ViewController*viewcontrl =[storyboard instantiateViewControllerWithIdentifier:identifiername];
   // dvc.patientname_str = self.patientname_str;
    [self.navigationController pushViewController:viewcontrl animated:YES];
    }else if([identifiername isEqualToString:@"changepassword"]){
        
        IMIHLPassword * pvc = [storyboard instantiateViewControllerWithIdentifier:@"changepassword"];
        pvc.patientid_str = self.patientid_str;
        [self.navigationController pushViewController:pvc animated:YES];
        
    }
    
}


- (IBAction)backBarClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
}

- (IBAction)editProfileClick:(id)sender {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    IMIHLEditProfileVC * epvc = [storyboard instantiateViewControllerWithIdentifier:@"editprofileid"];
    epvc.pageid_str = @"edit";
    epvc.patientid_str = self.patientid_str;
    //NSLog(@"patientid_str epvc:%@",epvc.patientid_str);
    epvc.firstname_str = patientfirstname_str;
    epvc.lastname_str = patientlastname_str;
    
    epvc.emailid_str = self.patientemail_lbl.text;
    epvc.dob_str = self.patientdob_lbl.text;
    //NSLog(@"patientdob_lbl:%@",epvc.dob_str);
    //NSLog(@"dob_txtfld:%@",epvc.dob_str);
    if ([self.patientgender_lbl.text isEqualToString:@"male"]) {
        
        epvc.genderstr = @"1";
        
    }else if ([self.patientgender_lbl.text isEqualToString:@"female"]){
        
        epvc.genderstr = @"2";
    }
    
    epvc.imagedata = image_data;
    
    
    
    [self.navigationController pushViewController:epvc animated:YES];

}

- (IBAction)changePasswordTouch:(id)sender {
    [self loadViewControllerFromStoryBoard:@"changepassword"];
}
@end

//
//  IMIHLEditProfileVC.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 23/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLEditProfileVC.h"
#import "IMIHLRestService.h"
#import "AppDelegate.h"
#import "IMIHLLogin.h"
#import "IMIHLDBManager.h"
#import "IMIHLMyProfile.h"
#import "TOCropViewController.h"
#import "IMIHLLogin.h"
#define REGEX_USER_NAME_LIMIT @"^.{1,10}$"
#define REGEX_USER_NAME @"[A-Za-z0-9]{1,10}"
#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define REGEX_PASSWORD_LIMIT @"^.{6,20}$"
#define REGEX_PASSWORD @"[A-Za-z0-9]{6,20}"
#define REGEX_PHONE_DEFAULT @"[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"

@interface IMIHLEditProfileVC () <UINavigationControllerDelegate,UIImagePickerControllerDelegate, TOCropViewControllerDelegate>

//@property (nonatomic, strong) UIButton *image;
//@property (nonatomic, strong) UIButton *image;
@property (nonatomic, strong) UIImage *image;           // The image we'll be cropping
@property (nonatomic, strong) UIImageView *imageView;   // The image view to present the cropped image
@property (nonatomic, assign) TOCropViewCroppingStyle croppingStyle; //The cropping style
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, assign) CGRect croppedFrame;
@property (nonatomic, assign) NSInteger angle;
@property (nonatomic, readonly) UIButton *buttonImage;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) UIPopoverController *activityPopoverController;
#pragma clang diagnostic pop

- (void)cameraAlert;
- (void)sharePhoto;

- (void)layoutImageView;
- (void)didTapImageView;

- (void)updateImageViewWithImage:(UIImage *)image fromCropViewController:(TOCropViewController *)cropViewController;


@property (strong,nonatomic)UIDatePicker *datepicker;
@end

@implementation IMIHLEditProfileVC




- (void)viewDidLoad {
    
   // self.imageView = [[UIImageView alloc] init];
    //self.imageView.userInteractionEnabled = YES;
    //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //[self.view addSubview:self.imageView];
    
    //UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImageView)];
    //[self.imageView addGestureRecognizer:tapRecognizer];
    
    self.update_btn.layer.cornerRadius = self.update_btn.bounds.size.height/2;
    self.update_btn.clipsToBounds = YES;
   //_update_btn.enabled=NO;
    _dob_txtfld.enabled=NO;
   // _emailid_txtfld.enabled=NO;
    _firstname_txtfld.enabled=NO;
    _patientname_txtfld.enabled=NO;
    //_genderflag_btn.enabled=NO;
//_genderflagfmail_btn.enabled=NO;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"name:%@",self.patientname_txtfld.text);
    [self retriveProfile];
    [self setIcons];
    [self textFieldErrorsMesseges];
    // [self retrivePatientInfo];
    
    //[self getUserDetailsService];
    
    //MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   // hud.labelText = @"Loading....";
   // [self performSelector:@selector(retriveProfile) withObject:nil afterDelay:0.1];
    //[self retrivePatientInfo];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.backbarbtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backbarbtn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backbarbtn];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IMIHLLogin*)getUserInfo{
    NSUserDefaults*userdefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userdefaults objectForKey:@"userprofiles"];
    IMIHLLogin * login = (IMIHLLogin*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSLog(@"login object:%@",login);
    return login;
}

-(void)retriveProfile{
    self.loginInfo = [self getUserInfo];
    //NSString*userName = loginInfo.firstname
    //self.firstname_txtfld.text = @"Helloo";
    [MBProgressHUD hideHUDForView:self.view animated:YES];
   
    self.firstname_txtfld.text =[NSString stringWithFormat:@"%@",self.loginInfo.firstname];
    NSLog(@"FirstNameCheck:%@",self.firstname_txtfld.text);
    self.patientname_txtfld.text = [NSString stringWithFormat:@"%@",self.loginInfo.firstname];
    NSLog(@"FirstName:%@",self.loginInfo.firstname);
    [self.genderflag_btn setTitle:@"" forState:UIControlStateNormal];
    [self.genderflagfmail_btn setTitle:@"" forState:UIControlStateNormal];
    if ([self.loginInfo.gender intValue]==2) {
       
        
        [self.genderflag_btn setImage:[UIImage imageWithIcon:@"fa-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
        
        [self.genderflagfmail_btn setImage:[UIImage imageWithIcon:@"fa-dot-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
    }else{
        [self.genderflag_btn setImage:[UIImage imageWithIcon:@"fa-dot-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
        
        [self.genderflagfmail_btn setImage:[UIImage imageWithIcon:@"fa-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
    }
    self.patientid_str = [NSString stringWithFormat:@"%@",self.loginInfo.patientid];
    self.genderstr = [NSString stringWithFormat:@"%@",self.loginInfo.gender];
    self.dob_txtfld.text = [NSString stringWithFormat:@"%@",self.loginInfo.dob];
    self.dob_str = [NSString stringWithFormat:@"%@",self.loginInfo.dob];
    
    self.emailid_txtfld.text = [NSString stringWithFormat:@"%@",self.loginInfo.emailid];
    
    
    
    
    
    
    
    // //NSLog(@"image check out:%@",[patientinfo_arr objectAtIndex:8]);
    self.imagedata = self.loginInfo.profileimage;
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
    if (self.imagedata==nil) {
       
        
    }else{
        //NSLog(@"else entred");
        [self.profilepicupload_btn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.profilepicupload_btn setImage:[UIImage imageWithData:self.imagedata] forState:UIControlStateNormal];
    }
    //self.profileicon_imgview.layer.cornerRadius = self.profileicon_imgview.frame.size.height/2;
    //self.profileicon_imgview.layer.cornerRadius = 20;
   
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutImageView];
}
/*
-(void)setUserDetails{
    self.firstname_txtfld.text = self.firstname_str;
    self.patientname_txtfld.text = self.lastname_str;
    
    self.emailid_txtfld.text = [self.emailid_str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    self.dob_txtfld.text = self.dob_str;
    //NSLog(@"patientdob_lbl:%@",self.dob_txtfld.text);
    // //NSLog(@"dob_txtfld:%@",epvc.dob_txtfld.text);
    [self.genderflag_btn setTitle:@"" forState:UIControlStateNormal];
    [self.genderflagfmail_btn setTitle:@"" forState:UIControlStateNormal];
    //NSLog(@"genderstr:%@",self.genderstr);
    if ([self.genderstr isEqualToString:@"1"]) {
        //NSLog(@"zerooooo");
        [self.genderflag_btn setImage:[UIImage imageWithIcon:@"fa-dot-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
        
        [self.genderflagfmail_btn setImage:[UIImage imageWithIcon:@"fa-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
        
    }else if ([self.genderstr isEqualToString:@"2"]){
        
        [self.genderflag_btn setImage:[UIImage imageWithIcon:@"fa-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
        
        [self.genderflagfmail_btn setImage:[UIImage imageWithIcon:@"fa-dot-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
        
    }
    //NSLog(@"imagedata lenght value:%lu",self.imagedata.length);
    if (self.imagedata.length<=10) {
        
    }else{
        
 
        //[self.profilepicupload_btn setImage:img forState:UIControlStateNormal];
        //[self.profilepicupload_btn b]
        
        [self.profilepicupload_btn setBackgroundImage:nil forState:UIControlStateNormal];
        [self.profilepicupload_btn setImage:[UIImage imageWithData:self.imagedata] forState:UIControlStateNormal];
        
    }
}

-(void)retrivePatientInfo{
    
    IMIHLDBManager*imihldb = [IMIHLDBManager getSharedInstance];
    NSArray* patientinfo_arr = [imihldb getPatientInfoDB];
    
    if (patientinfo_arr!=nil) {
        self.patientid_str = [patientinfo_arr objectAtIndex:0];
        NSString*patname_str = [patientinfo_arr objectAtIndex:1];
        self.firstname_str = patname_str;
        self.lastname_str = [patientinfo_arr objectAtIndex:2];
        
         //patname_str = [patname_str stringByAppendingFormat:@"%@ %@",@" ",[patientinfo_arr objectAtIndex:2]];
         //self.firstname_txtfld.text = patname_str;
        // self.patientname_str =  patname_str;
        
        if ([[patientinfo_arr objectAtIndex:3]intValue]==1) {
            self.genderstr=@"1";
        }else{
            self.genderstr=@"2";
        }
        
        self.dob_str = [patientinfo_arr objectAtIndex:4];
        
        self.emailid_str = [patientinfo_arr objectAtIndex:5];
        ////NSLog(@"image local db:%@",[patientinfo_arr objectAtIndex:8]);
        self.imagedata = [patientinfo_arr objectAtIndex:8];
        
        
        //self.patientmobile_lbl.text = [patientinfo_arr objectAtIndex:6];
        //self.mobilenumber_top_lbl.text = self.patientmobile_lbl.text;
        
        //self.patientbloodgrp_lbl.text = [patientinfo_arr objectAtIndex:7];
        // //NSLog(@"image check out:%@",[patientinfo_arr objectAtIndex:8]);
        //image_data = (NSData*)[patientinfo_arr objectAtIndex:8];
 
        [self setUserDetails];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }else{
        [self getUserDetailsService];
    }
    
    
}



-(void)getUserDetailsService{
    IMIHLRestService*retriveProfile = [IMIHLRestService getSharedInstance];
    //NSLog(@"looogggggggggggg1");
    int statuscode =[retriveProfile getpatientInfo:self.patientid_str];
    if (statuscode==200) {
        //NSLog(@"looogggggggggggg2");
        IMIHLLogin *patientdetails = [[IMIHLLogin alloc]init];
        //NSLog(@"looogggggggggggg3");
        patientdetails = [patientdetails getLoginResult:retriveProfile.restresult_dict];
        
        self.patientid_str = patientdetails.patientid;
        NSString*patname_str = patientdetails.firstname;
        self.firstname_str = patname_str;
        self.lastname_str = patientdetails.lastname;
 
        if ([patientdetails.gender intValue]==1) {
            self.genderstr=@"1";
        }else{
            self.genderstr=@"2";
        }
        
        self.dob_str = patientdetails.dob;
        
        self.emailid_str = patientdetails.emailid;
        
        //self.patientmobile_lbl.text = [patientinfo_arr objectAtIndex:6];
        //self.mobilenumber_top_lbl.text = self.patientmobile_lbl.text;
        
        //self.patientbloodgrp_lbl.text = [patientinfo_arr objectAtIndex:7];
        // //NSLog(@"image check out:%@",[patientinfo_arr objectAtIndex:8]);
        //image_data = (NSData*)[patientinfo_arr objectAtIndex:8];
        // NSString*imglength = patientdetails.profileimage;
        ////NSLog(@"imglength:%d",(int)imglength.length);
        //NSLog(@"loooggggggggggg4");
        //NSData*tempimg =patientdetails.profileimage;
        //NSLog(@"looogggggggggggg5");
        
        //NSString*bytearry = [patientdetails.profileimage base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
        //self.imagedata = [NSData dataWithBytes:(__bridge const void * _Nullable)(patientdetails.profileimage) length:patientdetails.profileimage.length] ;
        
        self.imagedata = patientdetails.profileimage;
        //NSLog(@"image_data:%@",_imagedata);
        if ([self.imagedata isEqual:[NSNull null]]||[self.imagedata isEqual:@"<31>"]||self.imagedata.length<=10) {
            //NSLog(@"image check:%@",patientdetails.profileimage);
        }else{
            
            
            [self.profilepicupload_btn setImage:[UIImage imageWithData:patientdetails.profileimage] forState:UIControlStateNormal];
            //[self.profilepicupload_btn setImage:[UIImage imageWithData:_imagedata] forState:UIControlStateNormal];
        }
        [self setUserDetails];
        
    }else{
        [self retrivePatientInfo];
    }
    //[self setUserDetails];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
*/
#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField==self.dob_txtfld) {
        // [self.view endEditing:YES];
        //NSLog(@"helloooooooooooo2");
        
        
        
        self.datepicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        [self.datepicker setDatePickerMode:UIDatePickerModeDate];
        self.datepicker.backgroundColor = [UIColor whiteColor];
        // [self.datepicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        /*
         UIToolbar*toolbar = [[UIToolbar alloc]initWithFrame:CGRectZero];
         [toolbar setTintColor:[UIColor grayColor]];
         UIBarButtonItem*donebarbtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDatePickerValueChanged:)];
         
         UIBarButtonItem*spacebaritem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
         */
        //UIBarButtonItem*cancelbarbtn = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:nil];
        
        
        
        // [toolbar setItems:[NSArray arrayWithObjects:spacebaritem,donebarbtn, nil]];
        
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(onDatePickerValueChanged:)];
        UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        toolBar.items = @[flex, doneBtn];
        
        
        //toolbar.items = @[spacebaritem,donebarbtn];
        self.dob_txtfld.inputView = self.datepicker;
        self.dob_txtfld.inputAccessoryView = toolBar;
        
        
        
        
        
    }
    
    
    
    //if(txtDemo==textField){
    //[scrlView setContentOffset:CGPointMake(0, 50) animated:YES];
    //}
}
/*
 - (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
 {
 //NSLog(@"helloooooooooooo");
 
 
 return YES;
 
 }
 */
/*
 -(void)textFieldDidEndEditing:(UITextField *)textField{
 
 }
 */

-(void)datePickerDown{
    [self.datepicker resignFirstResponder];
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    //NSLog(@"fgdjjdkkdf");
    if (textField==self.dob_txtfld) {
        //NSLog(@"textfld entreddddddd endiiggggg");
        [self.datepicker resignFirstResponder];
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    //[self.username_txtfld resignFirstResponder];
    //[self.usrpasswrd_txt resignFirstResponder];
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)onDatePickerValueChanged:(id)sender
{
    //NSLog(@"selectedddddd");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    // formatter.dateFormat = @"dd-MM-yyyy";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    self.dob_txtfld.text = [formatter stringFromDate:self.datepicker.date];
    //[self.datepicker resignFirstResponder];
    //self.datepicker=nil;
    
    [self.dob_txtfld resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textFieldErrorsMesseges{
    [self.firstname_txtfld addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaters limit should be come between 3-10"];
    [self.patientname_txtfld addRegx:REGEX_USER_NAME_LIMIT withMsg:@"User name charaters limit should be come between 3-10"];
    [self.firstname_txtfld addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    [self.patientname_txtfld addRegx:REGEX_USER_NAME withMsg:@"Only alpha numeric characters are allowed."];
    self.firstname_txtfld.validateOnResign=NO;
    self.patientname_txtfld.validateOnResign=NO;
    [self.emailid_txtfld addRegx:REGEX_EMAIL withMsg:@"Enter valid email."];
    
    
    //[txtPassword addRegx:REGEX_PASSWORD_LIMIT withMsg:@"Password characters limit should be come between 6-20"];
    //[txtPassword addRegx:REGEX_PASSWORD withMsg:@"Password must contain alpha numeric characters."];
    
    //[txtConfirmPass addConfirmValidationTo:txtPassword withMsg:@"Confirm password didn't match."];
    
    //[txtPhone addRegx:REGEX_PHONE_DEFAULT withMsg:@"Phone number must be in proper format (eg. ###-###-####)"];
    //txtPhone.isMandatory=NO;
}


-(void)setIcons{
    
    [self.maleicon_btn setImage:[UIImage imageWithIcon:@"fa-male" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] forState:UIControlStateNormal];
    [self.femaleicon_btn setImage:[UIImage imageWithIcon:@"fa-female" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] forState:UIControlStateNormal];
    
    //[self.backbarbtn setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
}


////////////////////////////////////////////////////////////////////////////////////////////
- (void)cameraAlert{
    
    
    UIAlertController *alertContrl = [UIAlertController alertControllerWithTitle:@"Picture" message:@"" preferredStyle:UIAlertControllerStyleAlert ];
    
    UIAlertAction*actionTakePic = [UIAlertAction actionWithTitle:@"Take Pic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
           /*
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                  message:@"Device has no camera"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
            */
           UIAlertController *alertContrlNext = [UIAlertController alertControllerWithTitle:@"Error" message:@"Device has no camera" preferredStyle:UIAlertControllerStyleAlert ];
            
            UIAlertAction*actioncancel = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertContrlNext addAction:actioncancel];
            
        }else{
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }];
    
    UIAlertAction*actionSelectPic = [UIAlertAction actionWithTitle:@"Select Pic" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    UIAlertAction*actioncancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertContrl addAction:actionTakePic];
    [alertContrl addAction:actionSelectPic];
    [alertContrl addAction:actioncancel];
    
    [self presentViewController:alertContrl animated:YES completion:nil];
    
   /*UIAlertView *nwAlert = [[UIAlertView alloc] initWithTitle:@"Picture"
                                                      message:@""
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"Take Pic",@"Select Pic",nil];
    [nwAlert show];
    */
    
}

/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonmeetingscamera
{
    //NSLog(@"Alert meetingscamera:%d",(int)buttonmeetingscamera);
    
    
    
    if(buttonmeetingscamera==0)
    {
        //NSLog(@"Heelo0");
        
    }
    else  if(buttonmeetingscamera==1)
    {
        //NSLog(@"Heelo1");
        
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                  message:@"Device has no camera"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
            
            [myAlertView show];
            
        }else{
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
    else  if(buttonmeetingscamera==2){
        //NSLog(@"Heelo2");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}
*/
//- (UIImage *)centerCropImage:(UIImage *)image
//{
//    // Use smallest side length as crop square length
//    CGFloat squareLength = MIN(image.size.width, image.size.height);
//    // Center the crop area
//    CGRect clippedRect = CGRectMake((image.size.width - squareLength) / 4, (image.size.height - squareLength) / 4, squareLength, squareLength);
//    
//    // Crop logic
//    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], clippedRect);
//    UIImage * croppedImage = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
//    return croppedImage;
//}
//
//
//
/////////////////////////////////////////////////////////////////////////////////////////
//#pragma mark - Image Picker Controller delegate methods
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    
//    /* self.chosenImage =[[UIImage alloc]init];
//     self.chosenImage = info[UIImagePickerControllerEditedImage];
//     self.imageView = [[UIImageView alloc] init];
//     self.imageView.image = info[UIImagePickerControllerEditedImage];
//     */
//    // [self.profilepicupload_btn setImage:info[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
//    
//    UIImage*imagev = [[UIImage alloc]init];
//    imagev = info[UIImagePickerControllerEditedImage];
//    
//    imagev = [self centerCropImage:imagev];
//    
//    self.imagedata = UIImageJPEGRepresentation(imagev, 1.0);
//    // self.imagedata =  UIImagePNGRepresentation(imagev);
//    
//    // //NSLog(@"ImageViewDisplay:%@",self.chosenImage);
//    //[self uploadImage];
//    //self.imageView.image = chosenImage;
//    
//    /*
//     UIGraphicsBeginImageContext(CGSizeMake(720, 960));
//     [imagev drawInRect: CGRectMake(0, 0, 720, 960)];
//     UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
//     UIGraphicsEndImageContext();
//     
//     CGRect cropRect = CGRectMake(40, 0, 640, 960);
//     
//     CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
//     self.imagedata = UIImageJPEGRepresentation([UIImage imageWithCGImage:imageRef], 1.0);
//     */
//    // [self.imageView setImage:[UIImage imageWithCGImage:imageRef]];
//    
//    
//    
//    
//    
//    [self.profilepicupload_btn setImage:[UIImage imageWithData:self.imagedata] forState:UIControlStateNormal];
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//}
//
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    //[self backtoUrl];
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//}
//
//////////////////Image downloading///////////////////////////////////////
-(void)imageDownload:(UIImage*)img{
    
    
    
    //NSLog(@"Downloading...");
    // Get an image from the URL below
    
    //NSLog(@"%f,%f",img.size.width,img.size.height);
    
    // Let's save the file into Document folder.
    // You can also change this to your desktop for testing. (e.g. /Users/kiichi/Desktop/)
    // NSString *deskTopDir = @"/Users/kiichi/Desktop";
    @try{
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
        //NSLog(@"%@",docDir);
        
        //NSLog(@"saving png");
        NSString *pngFilePath = [NSString stringWithFormat:@"%@/test.png",docDir];
        NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(img)];
        [data1 writeToFile:pngFilePath atomically:YES];
        
        //NSLog(@"saving jpeg");
        NSString *jpegFilePath = [NSString stringWithFormat:@"%@/test.jpeg",docDir];
        NSData *data2 = [NSData dataWithData:UIImageJPEGRepresentation(img, 1.0f)];//1.0f = 100% quality
        [data2 writeToFile:jpegFilePath atomically:YES];
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
        
        //NSLog(@"saving image done");
        
        
        
    }
    @catch (NSException *exception) {
        
        //NSLog(@"Exception Image:%@",exception);
    }
    @finally {
        
        //NSLog(@"Finally");
    }
    
}


#pragma mark - Bar Button Items -
- (void)showCropViewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Gallery"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              //NSLog(@"alert action");
                                                              self.croppingStyle = TOCropViewCroppingStyleDefault;
                                                              
                                                              UIImagePickerController *standardPicker = [[UIImagePickerController alloc] init];
                                                              standardPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                              standardPicker.allowsEditing = NO;
                                                              standardPicker.delegate = self;
                                                              [self presentViewController:standardPicker animated:YES completion:nil];
                                                          }];
    
    [defaultAction setValue:[UIImage imageWithIcon:@"fa-picture-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
    
    
    [alertController addAction:defaultAction];

    
  /*  UIAlertAction *profileAction = [UIAlertAction actionWithTitle:@"Make Profile Picture"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              self.croppingStyle = TOCropViewCroppingStyleCircular;
                                                              
                                                              UIImagePickerController *profilePicker = [[UIImagePickerController alloc] init];
                                                              profilePicker.modalPresentationStyle = UIModalPresentationPopover;
                                                              profilePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                              profilePicker.allowsEditing = NO;
                                                              profilePicker.delegate = self;
                                                              profilePicker.preferredContentSize = CGSizeMake(512,512);
                                                              profilePicker.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItem;
                                                              [self presentViewController:profilePicker animated:YES completion:nil];
                                                          }];
    
    [alertController addAction:profileAction];
   
   */
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action)
                             {
                                 [self handleCamera];
                             }];
    
    
    [camera setValue:[UIImage imageWithIcon:@"fa-camera" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
    
    [alertController addAction:camera];

    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    
    
    [button0 setValue:[UIImage imageWithIcon:@"fa-times" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:25] forKey:@"image"];
    [alertController addAction:button0];
       [alertController setModalPresentationStyle:UIModalPresentationPopover];
    
   // UIPopoverPresentationController *popPresenter = [alertController popoverPresentationController];
   // popPresenter.barButtonItem = self.navigationItem.leftBarButtonItem;
    
    alertController.popoverPresentationController.sourceView = self.profilepicupload_btn;
    //alert.popoverPresentationController.sourceRect = CGRectMake(self.dashboard_collection.bounds.size.width / 1.2, self.dashboard_collection.bounds.size.height / 2.0, 1.0, 1.0);
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)handleCamera
{
#if TARGET_IPHONE_SIMULATOR
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Camera is not available on simulator"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action)
                         {
                             [self dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
#elif TARGET_OS_IPHONE
    //Some code for iPhone
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
#endif
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)profileImageUploadClick:(id)sender {
    //[self cameraAlert];
    [ self showCropViewController];
}

- (IBAction)genderMaleClick:(id)sender {
    
    self.genderstr=@"1";
    [self.genderflag_btn setImage:[UIImage imageWithIcon:@"fa-dot-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
    
    [self.genderflagfmail_btn setImage:[UIImage imageWithIcon:@"fa-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
    
}

- (IBAction)genderFemaleClick:(id)sender {
    self.genderstr=@"2";
    [self.genderflag_btn setImage:[UIImage imageWithIcon:@"fa-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
    
    [self.genderflagfmail_btn setImage:[UIImage imageWithIcon:@"fa-dot-circle-o" backgroundColor:[UIColor clearColor] iconColor:[UIColor blackColor] fontSize:25] forState:UIControlStateNormal];
}

-(void)callLoader{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Updating....";
}
- (IBAction)submit:(id)sender {
    if([self.patientname_txtfld validate] & [self.firstname_txtfld validate]&[self.emailid_txtfld validate] & self.genderstr!=nil & self.genderstr!=NULL&self.imagedata!=nil&self.imagedata!=NULL){
        [self callLoader];
        //[self performSelector:@selector(patientInfoUpdate) withObject:nil afterDelay:0.1];
        [self patientInfoUpdate];
    }
    
}


-(void)patientInfoUpdate{
    IMIHLRestService*restupdate = [IMIHLRestService getSharedInstance];
    //IMIHLRestService*restupdate = [[IMIHLRestService alloc]init];
    
    
    // if ([restlogin login:txtUserName.text :txtPassword.text]==200) {
    
   // int statuscode =[restupdate profileUpdateService:self.patientid_str :self.firstname_txtfld.text :self.patientname_txtfld.text :self.genderstr :self.dob_txtfld.text :self.emailid_txtfld.text :self.imagedata];
    NSLog(@"self.genderstr:%@",self.genderstr);
    NSLog(@"self.patientid_str:%@",self.patientid_str);
    NSLog(@"self.firstname_txtfld.text:%@",self.firstname_txtfld.text);
    NSLog(@"self.patientname_txtfld.text:%@",self.patientname_txtfld.text);
    NSLog(@"self.dob_txtfld.text:%@",self.dob_txtfld.text);
    NSLog(@"self.emailid_txtfld.text:%@",self.emailid_txtfld.text);
    NSLog(@"self.loginInfo.mobile:%@",self.loginInfo.mobile);
    NSLog(@"self.imagedata:%@",self.imagedata);
    
    
    [restupdate profileUpdateService:self.patientid_str :self.firstname_txtfld.text :self.patientname_txtfld.text :self.genderstr :self.dob_txtfld.text :self.emailid_txtfld.text :self.loginInfo.mobile :self.imagedata :^(NSInteger response) {
    
        if (response==200) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.loginInfo setProfileimage:self.imagedata];
            [self.loginInfo setFirstname:self.firstname_txtfld.text];
            [self.loginInfo setLastname:self.patientname_txtfld.text];
            [self.loginInfo setGender:self.genderstr];
            [self.loginInfo setDob:self.dob_txtfld.text];
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.loginInfo];
            
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userprofiles"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            self.pageid_str=@"edit";
            [self loadViewControllerFromStoryBoard:@"myprofileid"];
            //[self goBack];
           
            [self showAlertController:@"Your profile has been successfully updated"];
            
            // }else{
            //NSLog(@"PatientInfo insert in db failed");
            //}
            
        }else if(response==0){
            [self showAlertController:@"No Network Connection"];
        }else{
            NSLog(@"Status Code:%ldl",(long)response);
            NSLog(@"Error Message:%@",[restupdate.restresult_dict objectForKey:@"message"]);
            
            [self showAlertController:@"ProfileUpdate failed"];
            
        }
    }];
    
   
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)showAlertController:(NSString*)alrtmsg{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Message"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
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


- (IBAction)backButtonClick:(id)sender {
    
    [self loadViewControllerFromStoryBoard:@"myprofileid"];
}


-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    if ([self.pageid_str isEqualToString:@"edit"]) {
        //NSLog(@"identifier check");
        IMIHLMyProfile * mpvc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
        mpvc.patientid_str = self.patientid_str;
        [self.navigationController pushViewController:mpvc animated:YES];
        
    }else{
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"dashboardvc"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark - Image Picker Delegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:image];
    cropController.delegate = self;
    
    
    self.image = image;
    
    //If profile picture, push onto the same navigation stack
    if (self.croppingStyle == TOCropViewCroppingStyleCircular) {
        [picker pushViewController:cropController animated:YES];
    }
    else { //otherwise dismiss, and then present from the main controller
        [picker dismissViewControllerAnimated:YES completion:^{
            [self presentViewController:cropController animated:YES completion:nil];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Gesture Recognizer -
- (void)didTapImageView
{
    //When tapping the image view, restore the image to the previous cropping state
    
    TOCropViewController *cropController = [[TOCropViewController alloc] initWithCroppingStyle:self.croppingStyle image:self.image];
    cropController.delegate = self;
    CGRect viewFrame = [self.view convertRect:self.profilepicupload_btn.frame toView:self.navigationController.view];
    [cropController presentAnimatedFromParentViewController:self
                                                  fromImage:self.imageView.image
                                                   fromView:nil
                                                  fromFrame:viewFrame
                                                      angle:self.angle
                                               toImageFrame:self.croppedFrame
                                                      setup:^{ self.imageView.hidden = YES; }
                                                 completion:nil];
}


#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)cropViewController:(TOCropViewController *)cropViewController didCropToCircularImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.croppedFrame = cropRect;
    self.angle = angle;
    [self updateImageViewWithImage:image fromCropViewController:cropViewController];
}

- (void)updateImageViewWithImage:(UIImage *)image fromCropViewController:(TOCropViewController *)cropViewController
{
    
    
    //NSLog(@"updateImageViewWithImage");
    
    
    
    self.imagedata = [self resizeImage:image];
    
    [self.profilepicupload_btn setImage:image forState:UIControlStateNormal];
    [cropViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    
    /*
     self.imageView.image = image;
     [self layoutImageView];
     
     self.navigationItem.rightBarButtonItem.enabled = YES;
     
     if (cropViewController.croppingStyle != TOCropViewCroppingStyleCircular) {
     self.imageView.hidden = YES;
     [cropViewController dismissAnimatedFromParentViewController:self
     withCroppedImage:image
     toView:self.imageView
     toFrame:CGRectZero
     setup:^{ [self layoutImageView]; }
     completion:
     ^{
     self.profilepicupload_btn.hidden = NO;
     }];
     }
     else {
     self.profilepicupload_btn.hidden = NO;
     [cropViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
     }
     */
}

-(NSData*)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 300.0;
    float maxWidth = 400.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return imageData;
    
}
#pragma mark - Image Layout -
- (void)layoutImageView
{
    if (self.imageView.image == nil)
        return;
    
    CGFloat padding = 20.0f;
    
    CGRect viewFrame = self.view.bounds;
    viewFrame.size.width -= (padding * 2.0f);
    viewFrame.size.height -= ((padding * 2.0f));
    
    CGRect imageFrame = CGRectZero;
    imageFrame.size = self.imageView.image.size;
    
    if (self.imageView.image.size.width > viewFrame.size.width ||
        self.imageView.image.size.height > viewFrame.size.height)
    {
        CGFloat scale = MIN(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height);
        imageFrame.size.width *= scale;
        imageFrame.size.height *= scale;
        imageFrame.origin.x = (CGRectGetWidth(self.view.bounds) - imageFrame.size.width) * 0.5f;
        imageFrame.origin.y = (CGRectGetHeight(self.view.bounds) - imageFrame.size.height) * 0.5f;
        self.imageView.frame = imageFrame;
    }
    else {
        self.profilepicupload_btn.frame = imageFrame;
        self.profilepicupload_btn.center = (CGPoint){CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds)};
    }
}

- (void)sharePhoto
{
    if (self.imageView.image == nil)
        return;
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[self.imageView.image] applicationActivities:nil];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:activityController animated:YES completion:nil];
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [self.activityPopoverController dismissPopoverAnimated:NO];
        self.activityPopoverController = [[UIPopoverController alloc] initWithContentViewController:activityController];
        [self.activityPopoverController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
#pragma clang diagnostic pop
    }
}


@end

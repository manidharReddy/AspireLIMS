//
//  IMIHLFeedback.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 12/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLFeedback.h"
#import "IMIHLRestService.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
@interface IMIHLFeedback ()<UITextViewDelegate>

@end

@implementation IMIHLFeedback

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
   // self.feedback_txtview.layer.borderColor = [UIColor grayColor].CGColor;
    self.sendBtn.layer.cornerRadius = self.sendBtn.bounds.size.height/2;
    
    [self.feedback_txtview.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    self.feedback_txtview.layer.borderWidth=1.0;
    self.feedback_txtview.clipsToBounds = YES;
   // self.feedback_txtview.backgroundColor = [UIColor greenColor];
    self.feedbcktype_str=@"App Related";
    [self feedbackSetType];
    self.feedback_txtview.delegate=self;
    
}
-(void)viewWillAppear:(BOOL)animated{
//[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.navigationController.navigationBarHidden = NO;
    self.backbarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backbarItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backbarItem];
}
-(void)feedbackSetType{
   // self.feedbcktype_arr = @[@"App Related",@"Other"];
    self.feedbcktype_arr = [[NSArray alloc]initWithObjects:@"App Related",@"Other", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -kDropDown
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    _Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    _Dropobj.delegate = self;
    [_Dropobj showInView:self.view animated:YES];
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [_Dropobj SetBackGroundDropDown_R:0.0 G:108.0 B:194.0 alpha:0.70];
    
}
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    /*----------------Get Selected Value[Single selection]-----------------*/
    //NSLog(@"seledt:%@",[self.feedbcktype_arr objectAtIndex:anIndex]);
    
    
    [self.feedtypbtn setTitle:[self.feedbcktype_arr objectAtIndex:anIndex] forState:UIControlStateNormal];
    self.feedbcktype_str =[self.feedbcktype_arr objectAtIndex:anIndex];
    
    
}

- (void)DropDownListView:(DropDownListView *)dropdownListView Datalist:(NSMutableArray*)ArryData{
    
    ///----------------Get Selected Value[Multiple selection]-----------------//
    /*
     if (ArryData.count>0) {
     _lblSelectedCountryNames.text=[ArryData componentsJoinedByString:@"\n"];
     CGSize size=[self GetHeightDyanamic:_lblSelectedCountryNames];
     _lblSelectedCountryNames.frame=CGRectMake(16, 240, 287, size.height);
     }
     else{
     _lblSelectedCountryNames.text=@"";
     }
     */
}

- (void)DropDownListViewDidCancel{
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIView class]]) {
        [_Dropobj fadeOut];
    }
}

-(CGSize)GetHeightDyanamic:(UILabel*)lbl
{
    NSRange range = NSMakeRange(0, [lbl.text length]);
    CGSize constraint;
    constraint= CGSizeMake(288 ,MAXFLOAT);
    CGSize size;
    
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)) {
        NSDictionary *attributes = [lbl.attributedText attributesAtIndex:0 effectiveRange:&range];
        CGSize boundingBox = [lbl.text boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else{
        
        
        size = [lbl.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    }
    return size;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)goBack
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
///////////////////////////////End Of Table Delegate////////////////////////
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)feedtypeButtonClick:(id)sender {
    //NSLog(@"feedbck_arr:%@",self.feedbcktype_arr);
    [_Dropobj fadeOut];
    [self showPopUpWithTitle:@"Select FeedbackType" withOption:self.feedbcktype_arr xy:CGPointMake(self.feedtypbtn.frame.origin.x,self.feedtypbtn.frame.origin.y+50) size:CGSizeMake((self.feedtypbtn.frame.size.width), (self.view.frame.size.height-50)) isMultiple:NO];

}

- (IBAction)backBarClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
}

- (IBAction)sendButtonClick:(id)sender {
    
   
    if(![self.feedback_txtview.text isEqualToString:@""]){
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Sending....";

        IMIHLRestService*restfeedback = [IMIHLRestService getSharedInstance];
        //int statuscode =[restfeedback feedbackService:self.patientid_str :self.feedbcktype_str :self.feedback_txtview.text];

        [restfeedback feedbackService:self.patientid_str :self.feedbcktype_str :self.feedback_txtview.text withCompletionHandler:^(NSInteger response) {
            if (response==200) {
                //NSLog(@"status of restfeedback:%@",restfeedback.restresult_dict);
                [self showAlertController:@"Successfully sended"];
                self.feedbcktype_str=@"App Related";
                [self.feedtypbtn setTitle:self.feedbcktype_str forState:UIControlStateNormal];
                self.feedback_txtview.text=@"Enter your feedback";
                
            }else if(response==0){
                [self showAlertController:@"No Network Connection"];
                
            } else{
                //NSLog(@"Error Message:%@",[restfeedback.restresult_dict objectForKey:@"message"]);
                [self showAlertController:[restfeedback.restresult_dict objectForKey:@"message"]];
            }
            
        }];
       
    }
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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //NSLog(@"textViewShouldBeginEditing:");
    textView.text=@"";
    return YES;
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//NSLog(@"textview delegate entred");
    NSRange resultRange = [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet] options:NSBackwardsSearch];
    if ([text length] == 1 && resultRange.location != NSNotFound) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end

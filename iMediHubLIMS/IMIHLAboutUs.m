//
//  IMIHLAboutUs.m
//  iMediHubLIMS
//
//  Created by Aparna Reddy Challa on 12/07/16.
//  Copyright © 2016 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLAboutUs.h"
#import "IMIHLRestService.h"
#import "MBProgressHUD.h"
@interface IMIHLAboutUs ()

@end

@implementation IMIHLAboutUs

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.backBarBtn setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";
    [self performSelector:@selector(setAboutusText) withObject:nil afterDelay:0.1];
    //[self setAboutusText];
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBarHidden = NO;
    self.backBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backBarBtn setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backBarBtn];
}

- (void)goBack
{
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAboutusText{
    IMIHLRestService*restabout = [IMIHLRestService getSharedInstance];
     //IMIHLRestService*restabout = [[IMIHLRestService alloc]init];
    //[restabout getAboutUsService:@"1"];
    
   // int statuscode =[restabout getAboutUsService:@"1"];
    
    [restabout getAboutUsService:@"1" withCompletionHandler:^(NSInteger response) {
        if (response==200) {
            
            [[NSUserDefaults standardUserDefaults] setObject:restabout.restresult_dict forKey:@"aboutus"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //NSLog(@"Description:%@",[restabout.restresult_dict objectForKey:@"description"]);
            self.vision_txtview.text = [restabout.restresult_dict objectForKey:@"description"];
        }else if(response==0){
            //NSLog(@"aboutus dict:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"aboutus"]);
            restabout.restresult_dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"aboutus"];
            self.vision_txtview.text = [restabout.restresult_dict objectForKey:@"description"];
            [self showAlertController:@"No Network Connection"];
        }else{
            
            NSLog(@"Error Message:%@",[restabout.restresult_dict objectForKey:@"message"]);
            [self showAlertController:[restabout.restresult_dict objectForKey:@"message"]];
        }
    }];
    
     [MBProgressHUD hideHUDForView:self.view animated:YES];
}
-(void)showAlertController:(NSString*)msgshow{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Message"      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:msgshow
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loadViewControllerFromStoryBoard:(NSString*)identifiername{
    //NSLog(@"identifier:%@",identifiername);
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:identifiername];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)backBarClick:(id)sender {
    [self loadViewControllerFromStoryBoard:@"dashboardvc"];
}
@end

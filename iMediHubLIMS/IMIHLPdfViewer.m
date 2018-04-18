//
//  IMIHLPdfViewer.m
//  iMediHubLIMS
//
//  Created by ihub on 1/7/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import "IMIHLPdfViewer.h"
#import "MBProgressHUD.h"

@interface IMIHLPdfViewer ()

@end

@implementation IMIHLPdfViewer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading....";

      [self showInPdf];
   // [self performSelector:@selector(showInPdf) withObject:nil afterDelay:0.1];

}
-(void)viewWillAppear:(BOOL)animated{
    //[self.backbarItem setImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20]];
    self.backItemBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithIcon:@"fa-arrow-left" backgroundColor:[UIColor clearColor] iconColor:[UIColor whiteColor] fontSize:20] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    [self.backItemBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:self.backItemBar];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)showInPdf{
    
    //NSLog(@"Show In PDF ");
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //NSArray *resultArray = [fileManager subpathsOfDirectoryAtPath:documentsDirectory error:nil];
    //NSLog(@"%@",resultArray);
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",self.orderid_str]];
    NSLog(@"pathname:%@",filePath);
    self.path_str = filePath;
    //NSLog(@"filepath:%@",filePath);
   
    if ([fileManager fileExistsAtPath:filePath]) {
        
        //NSLog(@"file exist");
        self.urlstr = [NSURL fileURLWithPath:filePath];
        NSMutableURLRequest*urlrequest = [[NSMutableURLRequest alloc]initWithURL:self.urlstr];
        [self.reportPdfInWebview loadRequest:urlrequest];
    }else{
        [self showAlertController:@"Report is not avialable"];

    }
    
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

- (IBAction)sharePdfClick:(id)sender {
    /*
    NSArray*arryitems = [NSArray arrayWithObjects:self.path_str, nil];
    UIActivityViewController*activitycontrol = [[UIActivityViewController alloc]initWithActivityItems:arryitems applicationActivities:nil];
    activitycontrol.excludedActivityTypes = @[UIActivityTypePostToTwitter,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypePostToFacebook,UIActivityTypePostToWeibo];
    activitycontrol.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activitycontrol animated:YES completion:nil];
     */
    //NSLog(@"URL Link:%@",self.urlstr);
    
    
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:self.urlstr];
    [self.documentInteractionController presentOpenInMenuFromRect:CGRectMake(self.view.frame.size.width, 60, 300, 300) inView:self.view animated:YES];
}
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller {
    self.documentInteractionController = nil;
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application {
    
    //Check if the app that is calling is Instagram
    if ([application isEqualToString:@"com.burbn.instagram"]) {
        NSURL *newPath;
        
        NSString *oldPathStr = [controller.URL absoluteString];
        NSString *newPathStr = [oldPathStr stringByReplacingOccurrencesOfString:@"jpg" withString:@"ig"];
        newPath = [NSURL URLWithString:newPathStr];
        
        controller.URL = newPath;
    }

}

@end

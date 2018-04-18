//
//  IMIHLPdfViewer.h
//  iMediHubLIMS
//
//  Created by ihub on 1/7/17.
//  Copyright © 2017 Aparna Reddy Challa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"
#import "FAImageView.h"
#import "UIImage+FontAwesome.h"

@interface IMIHLPdfViewer : UIViewController<UIDocumentInteractionControllerDelegate>
- (IBAction)sharePdfClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *reportPdfInWebview;
@property (strong,nonatomic) NSString*path_str;
@property (strong, nonatomic) NSString*orderid_str;
@property (strong,nonatomic) NSURL*urlstr;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backItemBar;
@property (nonatomic, strong) UIDocumentInteractionController *documentInteractionController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sharebtnitem;

@end

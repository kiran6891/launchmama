//
//  ScanViewController.m
//  LaunchMama
//
//  Created by Kiran Ruth on 27/08/15.
//  Copyright (c) 2015 Kiran Ruth. All rights reserved.
//

#import "ScanViewController.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeReader.h"
#import "AFHTTPRequestOperation.h"
#import "MBProgressHUD.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

@synthesize btnScan;

- (void)viewDidLoad {
    [super viewDidLoad];
    //rgb(46, 204, 113)
    btnScan.backgroundColor = [UIColor greenColor];
    btnScan.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20.0f];
    btnScan.titleLabel.textColor = [UIColor  grayColor];
    
    [self startReader];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startReader{
    
    if ([QRCodeReader supportsMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]]) {
        static QRCodeReaderViewController *reader = nil;
        static dispatch_once_t onceToken;
        
        dispatch_once(&onceToken, ^{
            reader                        = [QRCodeReaderViewController new];
            reader.modalPresentationStyle = UIModalPresentationFormSheet;
        });
        reader.delegate = self;
        
        [reader setCompletionWithBlock:^(NSString *resultAsString) {
            NSLog(@"Completion with result: %@", resultAsString);
        }];
        
        UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
        [window.rootViewController presentViewController:reader animated:NO completion:NULL];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Reader not supported by the current device" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Verifying";
        
        
        NSString *BaseURLString = @"http://52.2.92.136/api/i/1/";
        // 1
        NSString *string = [NSString stringWithFormat:@"%@verify_qr_code?qr_id=%@", BaseURLString,result];
        NSURL *url = [NSURL URLWithString:string];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // 2
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [hud hide:YES];
            NSDictionary *result = (NSDictionary *)responseObject;
            if ([[result valueForKey:@"status"] isEqualToString:@"200"]) {
                UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200,200)];
                [imView setImage:[UIImage imageNamed:@"success"]];
                [imView setContentMode:UIViewContentModeCenter];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:[result valueForKey:@"offer_description"] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                alertView.alertViewStyle = UIAlertViewStyleDefault;
                alertView.tintColor = [UIColor greenColor];
                [alertView setValue:imView forKey:@"accessoryView"];
                [alertView show];
            }else{
                UIImageView *imView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200,200)];
                [imView setImage:[UIImage imageNamed:@"failure"]];
                [imView setContentMode:UIViewContentModeCenter];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Erro" message:@"This QR code was already used." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                alertView.alertViewStyle = UIAlertViewStyleDefault;
                alertView.tintColor = [UIColor greenColor];
                [alertView setValue:imView forKey:@"accessoryView"];
                [alertView show];
            }

            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [hud hide:YES];
        }];
        
        [hud show:YES];
        [operation start];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)onClickScan:(id)sender{
    [self startReader];
}


@end

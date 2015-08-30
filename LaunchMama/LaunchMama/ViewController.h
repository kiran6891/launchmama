//
//  ViewController.h
//  LaunchMama
//
//  Created by Kiran Ruth on 24/08/15.
//  Copyright (c) 2015 Kiran Ruth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"

@interface ViewController : UIViewController<QRCodeReaderDelegate>

- (IBAction)onClickScan:(id)sender;

@end


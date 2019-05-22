//
//  ViewController.h
//  vote-bot
//
//  Created by Timothy Roe Jr. on 5/22/19.
//  Copyright © 2019 Timothy Roe Jr. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface ViewController : NSViewController <WebUIDelegate, WebFrameLoadDelegate, WKNavigationDelegate>
@property (strong) IBOutlet WKWebView *web;

@property int ran;

@property (strong) IBOutlet NSTextField *url;
@property (strong) IBOutlet NSTextField *times;
- (IBAction)run:(id)sender;

@end


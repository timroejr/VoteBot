//
//  ViewController.m
//  vote-bot
//
//  Created by Timothy Roe Jr. on 5/22/19.
//  Copyright © 2019 Timothy Roe Jr. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"

@implementation ViewController

- (void)viewDidLoad {
    self.ran = 0;
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)run:(id)sender {
    
    self.web.navigationDelegate = self;
    
/////////////////////////REDACTED FOR PRIVACY REASONS/////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
    NSURL *url = [NSURL URLWithString:@"https://poll.fm/"];
/////////////////////////REDACTED FOR PRIVACY REASONS/////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
   
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [self.web loadRequest:request];

}

-(void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self.web evaluateJavaScript:@"document.documentElement.innerHTML.toString()" completionHandler:^(NSString *string, NSError *error) {
        if (error) {
            NSLog(@"ERROR: %@, %@", [error localizedDescription], error);
        } else {
            NSData *d = [string dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple *parse = [TFHpple hppleWithHTMLData:d];
            NSArray *elements = [parse searchWithXPathQuery:@"//*[@id='stage-inner']/div/div/form/div[1]/fieldset/ul/li"];
            for (TFHppleElement *element in elements) {
                TFHppleElement *label = [element firstChildWithTagName:@"label"];
                NSString *person = [label text];
                
/////////////////////////REDACTED FOR PRIVACY REASONS/////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
                if ([person containsString:@""]) {
//////////////////////////////////////////////////////////////////////////////////
/////////////////////////REDACTED FOR PRIVACY REASONS/////////////////////////////

                    NSLog(@"FOUND!");
                    TFHppleElement *checkboxDiv = [element firstChildWithTagName:@"div"];
                    TFHppleElement *checkbox = [checkboxDiv firstChildWithTagName:@"input"];
                    NSDictionary *attr = [checkbox attributes];
                    NSString *identification = [attr objectForKey:@"id"];
                    NSString *injection = [NSString stringWithFormat:@"document.getElementById('%@').checked = true;", identification];
                    [self.web evaluateJavaScript:injection completionHandler:^(NSString *result, NSError *error) {
                        if (!error) {
                            NSString *clickButton = @"document.querySelector('.vote-button').click();";
                            [self.web evaluateJavaScript:clickButton completionHandler:^(NSString *status, NSError *error) {
                                NSLog(@"FINISHED!");
                                if (self.ran < [self.times.stringValue integerValue]) {
                                    self.ran++;
                                    [NSThread sleepForTimeInterval:2.5];
                                    [self run:self];
                                } else {
                                    NSAlert *alert = [[NSAlert alloc] init];
                                    [alert setMessageText:@"Completed!"];
                                    [alert setInformativeText:[NSString stringWithFormat:@"Completed %@ votes!", self.times.stringValue]];
                                    [alert addButtonWithTitle:@"OK"];
                                    [alert runModal];
                                }
                            }];
                        }
                    }];
                }
            }
        }
    }];
}



@end

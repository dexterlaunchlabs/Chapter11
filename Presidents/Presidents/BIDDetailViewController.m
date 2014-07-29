//
//  BIDDetailViewController.m
//  Presidents
//
//  Created by Dexter Launchlabs on 7/29/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "BIDDetailViewController.h"
#import "BIDLanguageListController.h"
@interface BIDDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation BIDDetailViewController
@synthesize webView;
@synthesize languageButton;
@synthesize languagePopoverController;
@synthesize languageString;
static NSString * modifyUrlForLanguage(NSString *url, NSString *lang) { if (!lang) {
    return url; }
    // We're relying on a particular Wikipedia URL format here. This
    // is a bit fragile!
    NSRange languageCodeRange = NSMakeRange(7, 2);
    if ([[url substringWithRange:languageCodeRange] isEqualToString:lang]) {
        return url;
    } else {
        NSString *newUrl = [url stringByReplacingCharactersInRange:languageCodeRange withString:lang];
        return newUrl; }
}
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        //_detailItem = newDetailItem;
        _detailItem = modifyUrlForLanguage(newDetailItem, languageString);
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
    NSURL *url = [NSURL URLWithString:self.detailItem]; NSURLRequest *request = [NSURLRequest requestWithURL:url]; [self.webView loadRequest:request];
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.languageButton = [[UIBarButtonItem alloc] init]; languageButton.title = @"Choose Language";
    languageButton.target = self;
    languageButton.action = @selector(touchLanguageButton); self.navigationItem.rightBarButtonItem = self.languageButton;
    [self configureView];
}
- (void)viewDidUnload {
    // Release any retained subviews of the main view. // e.g. self.myOutlet = nil;
    self.webView = nil;
    self.languageButton = nil;
    self.languagePopoverController = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Presidents", @"Presidents");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}
- (void)setLanguageString:(NSString *)newString {
    if (![newString isEqualToString:languageString]) {
        languageString = [newString copy];
        self.detailItem = modifyUrlForLanguage(_detailItem, languageString); }
    if (languagePopoverController != nil) { [languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    } }
- (IBAction)touchLanguageButton {
    if (self.languagePopoverController == nil) {
        BIDLanguageListController *languageListController = [[BIDLanguageListController alloc] init];
        languageListController.detailViewController = self; UIPopoverController *poc = [[UIPopoverController alloc]
                                                                                        initWithContentViewController:languageListController]; [poc presentPopoverFromBarButtonItem:languageButton
                                                                                                                                                           permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.languagePopoverController = poc; } else {
            if (languagePopoverController != nil) { [languagePopoverController dismissPopoverAnimated:YES]; self.languagePopoverController = nil;
            } }
}
@end

//
//  RMBUnauthViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBUnauthViewController.h"
#import "Masonry.h"
#import "UIView+RMBAdditions.h"
#import "RMBActiveUser.h"
#import "UIColor+RMBAdditions.h"
#import "RMBSignupViewController.h"
#import "MBProgressHUD.h"

@interface RMBUnauthViewController ()

@property (strong, nonatomic, readwrite) UILabel *titleLabel;
@property (strong, nonatomic, readwrite) UITextField *usernameTextField;
@property (strong, nonatomic, readwrite) UITextField *passwordTextField;
@property (strong, nonatomic, readwrite) UIButton *loginButton;
@property (strong, nonatomic, readwrite) UILabel *signupLabel;

@end

@implementation RMBUnauthViewController

- (void)viewDidLoad {
  UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bismillah"]];
  titleView.contentMode = UIViewContentModeScaleAspectFit;
  self.navigationItem.titleView = titleView;
  self.view.backgroundColor = [UIColor renovatioRed];
  self.usernameTextField = [[UITextField alloc] init];
  self.usernameTextField.backgroundColor = [UIColor whiteColor];
  self.usernameTextField.textContentType = UITextContentTypeUsername;
  self.usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.usernameTextField.placeholder = @"Username";
  self.usernameTextField.layer.cornerRadius = 5;
  UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
  self.usernameTextField.leftView = paddingView;
  self.usernameTextField.leftViewMode = UITextFieldViewModeAlways;
  self.usernameTextField.tintColor = [UIColor renovatioRed];
  [self.view addSubview:self.usernameTextField];
  
  self.passwordTextField = [[UITextField alloc] init];
  self.passwordTextField.backgroundColor = [UIColor whiteColor];
  self.passwordTextField.textContentType = UITextContentTypePassword;
  self.passwordTextField.secureTextEntry = YES;
  self.passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.passwordTextField.placeholder = @"Password";
  self.passwordTextField.layer.cornerRadius = 5;
  UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
  self.passwordTextField.leftView = paddingView2;
  self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
  self.passwordTextField.tintColor = [UIColor renovatioRed];
  [self.view addSubview:self.passwordTextField];
  
  self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
  [self.loginButton setTitleColor:[UIColor renovatioRed] forState:UIControlStateNormal];
  self.loginButton.backgroundColor = [UIColor renovatioBackground];
  [self.loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  self.loginButton.layer.cornerRadius = 5;
  self.loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
  [self.view addSubview:self.loginButton];

  self.titleLabel = [[UILabel alloc] init];
  self.titleLabel.textColor = [UIColor renovatioBackground];
  self.titleLabel.font = [UIFont fontWithName:@"Cardo" size:30];
  self.titleLabel.text = @"Remembrance";
  [self.titleLabel sizeToFit];
  [self.view addSubview:self.titleLabel];

  self.signupLabel = [[UILabel alloc] init];
  self.signupLabel.textColor = [UIColor renovatioBackground];
  NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"or Signup."];
  [attributeString addAttribute:NSUnderlineStyleAttributeName
                          value:@(1)
                          range:(NSRange){3, [attributeString length] - 3}];
  self.signupLabel.attributedText = attributeString;
  [self.signupLabel sizeToFit];
  [self.signupLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signupButtonPressed)]];
  self.signupLabel.userInteractionEnabled = YES;
  [self.view addSubview:self.signupLabel];

  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(@(40));
    make.centerX.equalTo(self.view);
  }];

  [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
    make.width.equalTo(@(250));
    make.height.equalTo(@(48));
    make.centerX.equalTo(self.view);
  }];
  
  [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.equalTo(@(250));
    make.height.equalTo(@(48));
    make.centerX.equalTo(self.usernameTextField);
    make.top.equalTo(self.usernameTextField.mas_bottom).offset(24);
  }];
  
  [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.width.equalTo(@(100));
    make.height.equalTo(@(48));
    make.centerX.equalTo(self.usernameTextField);
    make.top.equalTo(self.passwordTextField.mas_bottom).offset(24);
  }];
  
  [self.signupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.usernameTextField);
    make.top.equalTo(self.loginButton.mas_bottom).offset(12);
  }];
}

- (void)viewDidAppear:(BOOL)animated {
  [self.usernameTextField becomeFirstResponder];
}

- (void)loginButtonPressed {
  NSString *username = self.usernameTextField.text;
  NSString *password = self.passwordTextField.text;
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  hud.label.text = @"Logging in...";
  [RMBActiveUser authorizeWithUsername:username
                              password:password
                               success:^{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (self.delegate) {
      [self.delegate userLoggedIn];
    }
  }
                               failure:^(NSString *message) {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops"
                                                    message:@"Login failure."
                                                   delegate:nil
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:nil];
    [alert show];
  }];
}

- (void)signupButtonPressed {
  RMBSignupViewController *signupViewController = [[RMBSignupViewController alloc] init];
  signupViewController.delegate = self.delegate;
  [self.navigationController pushViewController:signupViewController animated:YES];
}

@end

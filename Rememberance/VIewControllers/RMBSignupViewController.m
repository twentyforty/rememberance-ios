//
//  RMBUnauthViewController.m
//  Rememberance
//
//  Created by Aly Ibrahim on 7/16/18.
//  Copyright © 2018 Aly Ibrahim. All rights reserved.
//

#import "RMBSignupViewController.h"
#import "Masonry.h"
#import "UIView+RMBAdditions.h"
#import "RMBActiveUser.h"
#import "UIColor+RMBAdditions.h"
#import "MBProgressHUD.h"

@interface RMBSignupViewController ()

@property (strong, nonatomic, readwrite) UITextField *usernameTextField;
@property (strong, nonatomic, readwrite) UITextField *emailTextField;
@property (strong, nonatomic, readwrite) UITextField *passwordTextField;
@property (strong, nonatomic, readwrite) UITextField *password2TextField;
@property (strong, nonatomic, readwrite) UIButton *signupButton;

@end

@implementation RMBSignupViewController

- (void)viewDidLoad {
//  UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bismillah"]];
//  titleView.contentMode = UIViewContentModeScaleAspectFit;
//  self.navigationItem.titleView = titleView;
  self.title = @"Signup";
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
  
  self.emailTextField = [[UITextField alloc] init];
  self.emailTextField.backgroundColor = [UIColor whiteColor];
  self.emailTextField.textContentType = UITextContentTypeEmailAddress;
  self.emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.emailTextField.placeholder = @"Email";
  self.emailTextField.layer.cornerRadius = 5;
  UIView *paddingView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
  self.emailTextField.leftView = paddingView4;
  self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
  self.emailTextField.tintColor = [UIColor renovatioRed];
  [self.view addSubview:self.emailTextField];

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
  
  self.password2TextField = [[UITextField alloc] init];
  self.password2TextField.backgroundColor = [UIColor whiteColor];
  self.password2TextField.textContentType = UITextContentTypePassword;
  self.password2TextField.secureTextEntry = YES;
  self.password2TextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.password2TextField.placeholder = @"Confirm password";
  self.password2TextField.layer.cornerRadius = 5;
  UIView *paddingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
  self.password2TextField.leftView = paddingView3;
  self.password2TextField.leftViewMode = UITextFieldViewModeAlways;
  self.password2TextField.tintColor = [UIColor renovatioRed];
  [self.view addSubview:self.password2TextField];

  self.signupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [self.signupButton setTitle:@"Signup" forState:UIControlStateNormal];
  [self.signupButton setTitleColor:[UIColor renovatioRed] forState:UIControlStateNormal];
  self.signupButton.backgroundColor = [UIColor renovatioBackground];
  [self.signupButton addTarget:self action:@selector(signupButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  self.signupButton.layer.cornerRadius = 5;
  self.signupButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
  [self.view addSubview:self.signupButton];
  
  [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view).offset(24);
    make.width.equalTo(@(250));
    make.height.equalTo(@(48));
    make.centerX.equalTo(self.view);
  }];
  
  [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.usernameTextField.mas_bottom).offset(24);
    make.width.equalTo(@(250));
    make.height.equalTo(@(48));
    make.centerX.equalTo(self.view);
  }];

  [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.emailTextField.mas_bottom).offset(24);
    make.width.equalTo(@(250));
    make.height.equalTo(@(48));
    make.centerX.equalTo(self.usernameTextField);
  }];
  
  [self.password2TextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.passwordTextField.mas_bottom).offset(24);
    make.width.equalTo(@(250));
    make.height.equalTo(@(48));
    make.centerX.equalTo(self.usernameTextField);
  }];

  [self.signupButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.password2TextField.mas_bottom).offset(24);
    make.width.equalTo(@(100));
    make.height.equalTo(@(48));
    make.centerX.equalTo(self.usernameTextField);
  }];
}

- (void)signupButtonPressed {
  NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSString *email = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSString *password1 = self.passwordTextField.text;
  NSString *password2 = self.password2TextField.text;
  
  NSString *error;

  if ([username isEqualToString:@""] || [email isEqualToString:@""] || [password1 isEqualToString:@""] || [password2 isEqualToString:@""]) {
    [self showError:@"All fields are required"];
    return;
  }
  
  if ([self isEmailValid:email] == NO) {
    [self showError:@"Email address is invalid"];
    return;
  }
  
  if ([password1 isEqualToString:password2] == NO) {
    [self showError:@"Passwords do not match"];
    return;
  }
  
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  hud.label.text = @"Signing up...";
  [RMBActiveUser registerWithUsername:username password:password1 email:email success:^{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.delegate userLoggedIn];
  } failure:^(NSString *message) {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self showError:message];
  }];
}

- (void)showError:(NSString *)error {
  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alertView show];
}

- (BOOL)isEmailValid:(NSString *)email {
  BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
  NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
  NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
  NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
  NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailTest evaluateWithObject:email];
}

@end


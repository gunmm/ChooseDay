//
//  RegisterViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "RegisterViewController.h"
#import <MaxLeap/MaxLeap.h>
#import "MBProgressHUD+Add.h"
#import "MBProgressHUD.h"

@interface RegisterViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    
    UITextField *nameText;
    
    UITextField *pwdText;
    
    UITextField *sexText;
    
    UITextField *addText;
    
    UIImageView *_imgV;
    
    UIButton *_imgBtn;
    
    UIImage *img;
}

@property (nonatomic, strong) NSMutableArray *lists;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册账号";
    
    self.view.backgroundColor = kBgColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    //创建注册textField
    [self createRegisterTextField];
    
    //创建注册按钮
    [self createRegisterBtn];
    
}

//创建注册textField
-(void)createRegisterTextField{
    
    //用户名
    nameText = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, kScreenW-60, 30)];
    
    nameText.placeholder = @"用户名 2-20位字符";
    
    nameText.layer.borderWidth = .5;
    
    nameText.layer.borderColor = [[UIColor grayColor]CGColor];
    
    nameText.layer.cornerRadius = 5.f;
    
    nameText.clearButtonMode = UITextFieldViewModeAlways;
    
    //设置输入光标不靠左
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, nameText.height)];
    
    nameView.backgroundColor = [UIColor clearColor];
    
    nameText.leftView = nameView;
    
    nameText.leftViewMode = UITextFieldViewModeAlways;
    
    nameText.delegate = self;
    
    [self.view addSubview:nameText];
    
    //密码
    pwdText = [[UITextField alloc]initWithFrame:CGRectMake(nameText.frame.origin.x, nameText.bottom+20, nameText.width, nameText.height)];
    
    pwdText.placeholder = @"密码 6-20位字符";
    
    pwdText.layer.borderWidth = .5;
    
    pwdText.layer.borderColor = [[UIColor grayColor]CGColor];
    
    pwdText.layer.cornerRadius = 5.f;
    
    //密文
    pwdText.secureTextEntry = YES;
    
    pwdText.clearButtonMode = UITextFieldViewModeAlways;
    
    //设置输入光标不靠左
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, pwdText.height)];
    
    pwdView.backgroundColor = [UIColor clearColor];
    
    pwdText.leftView = pwdView;
    
    pwdText.leftViewMode = UITextFieldViewModeAlways;
    
    pwdText.delegate = self;
    
    [self.view addSubview:pwdText];
    
    //性别
    sexText = [[UITextField alloc]initWithFrame:CGRectMake(nameText.origin.x, pwdText.bottom+20, pwdText.width, pwdText.height)];
    
    sexText.placeholder = @"性别：(男 | 女 | 未知)";
    
    sexText.layer.borderWidth = .5;
    
    sexText.layer.borderColor = [[UIColor grayColor]CGColor];
    
    sexText.layer.cornerRadius = 5.f;
    
    sexText.clearButtonMode = UITextFieldViewModeAlways;
    
    //设置输入光标不靠左
    UIView *sexView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, sexText.height)];
    
    sexView.backgroundColor = [UIColor clearColor];
    
    sexText.leftView = sexView;
    
    sexText.leftViewMode = UITextFieldViewModeAlways;
    
    sexText.delegate = self;
    
    [self.view addSubview:sexText];

    
    //地址信息
    addText = [[UITextField alloc]initWithFrame:CGRectMake(nameText.origin.x, sexText.bottom+20, sexText.width, sexText.height)];
    
    addText.placeholder = @"例如：中国山东省济南市";
    
    addText.layer.borderWidth = .5;
    
    addText.layer.borderColor = [[UIColor grayColor]CGColor];
    
    addText.layer.cornerRadius = 5.f;
    
    addText.clearButtonMode = UITextFieldViewModeAlways;
    
    //设置输入光标不靠左
    UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, addText.height)];
    
    addView.backgroundColor = [UIColor clearColor];
    
    addText.leftView = addView;
    
    addText.leftViewMode = UITextFieldViewModeAlways;
    
    addText.delegate = self;
    
    [self.view addSubview:addText];
    
    //上传图片
    _imgV = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenW-pwdText.width/2)/2, addText.bottom+20, pwdText.width/2, pwdText.width/2)];
    
    _imgV.layer.borderWidth = 1;
    
    _imgV.layer.borderColor = [[UIColor grayColor]CGColor];
    
    _imgV.layer.cornerRadius = 5.f;
    
    _imgV.userInteractionEnabled = YES;
    
    _imgV.clipsToBounds = YES;
    
    [self.view addSubview:_imgV];
    
    _imgBtn = [[UIButton alloc]initWithFrame:_imgV.bounds];
    
    [_imgBtn setTitle:@"上传头像" forState:UIControlStateNormal];
    
    [_imgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [_imgBtn addTarget:self action:@selector(imgBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [_imgV addSubview:_imgBtn];
    
}

//创建注册按钮
-(void)createRegisterBtn{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(88, _imgV.bottom+30, kScreenW-88*2, 50)];
    
    NSMutableArray *arr = kMainColor;
    btn.backgroundColor=[UIColor colorWithRed:[arr[0] floatValue] green:[arr[1] floatValue] blue:[arr[2] floatValue] alpha:1];
    
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 10.f;
    
    [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}


//注册btn的点击方法
-(void)btnAct:(UIButton *)btn{
    
    NSArray *sex = @[@"男",@"女",@"未知"];
    
    if (nameText.text.length == 0 || pwdText.text.length == 0) {
        
        [MBProgressHUD showError:@"用户名或密码不能为空" toView:self.view];
        
    }else if ((nameText.text.length < 2 && nameText.text.length > 20) || (pwdText.text.length < 6 && pwdText.text.length > 20)){
    
        [MBProgressHUD showError:@"用户名或密码格式不合法" toView:self.view];
    
    }else if ([sex containsObject:sexText.text]) {
    
        MLUser *user = [MLUser user];

        user.username = nameText.text;
        
        user.password = pwdText.text;
        
        user[@"sex"] = sexText.text;
        
        user[@"address"] = addText.text;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
            if (!error) {
                
                [self createMBProgress];
                
            }else {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名已存在！请重新注册！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
                alert.alertViewStyle = UIAlertViewStyleDefault;
                
                alert.tag = 11;
                
                [alert show];
                
                nameText.text = nil;
                
                pwdText.text = nil;
                
                sexText.text = nil;
                
                addText.text = nil;
                
                _imgV.image = nil;
            
            }
            
        }];
        
    }else {
    
        [MBProgressHUD showError:@"性别输入不合法" toView:self.view];
    
    }
    
}

//上传图片
-(void)loadImgData{

    //上传图片
    NSData *imgData = UIImagePNGRepresentation(img);
    
    NSString *imgName = [NSString stringWithFormat:@"%@.png",nameText.text];
    
    MLFile *imgFile = [MLFile fileWithName:imgName data:imgData];
    
    MLObject *userPhoto = [MLObject objectWithClassName:@"Photo"];
    
    userPhoto[@"Name"] = nameText.text;
    
    userPhoto[@"image"] = imgFile;
    
    [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"----------%d %@",succeeded,error);
        
    }];

}

//创建正在加载提示
-(void)createMBProgress{

    MBProgressHUD *HUD = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:HUD];
    
    HUD.labelText = @"正在加载";
    
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        float progress = 0.0f;
        
        while (progress < 1.0f) {
            
            progress += 0.01f;
            
            HUD.progress = progress;
            
            usleep(30000);
            
        }
        
        [self loadImgData];
        
    }completionBlock:^{
        
        [HUD removeFromSuperview];
        
//        HUD = nil;
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        //                    alert.delegate = self;
        
        alert.tag = 10;
        
        [alert show];
        
    }];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag == 10) {
        
        [self.navigationController popViewControllerAnimated:YES];

    }else {
    
        [self.view endEditing:YES];
        
    }
    
    
}

//上传图片的点击方法
-(void)imgBtnAct:(UIButton *)btn{
    
    UIAlertController *imgAlertController = [UIAlertController alertControllerWithTitle:@"上传头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *openPhotosAction = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //打开相册
        [self openPhotos];
        
    }];
    
    UIAlertAction *openCameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //打开相机
        [self openCamera];
        
    }];
    
    [imgAlertController addAction:cancleAction];
    
    [imgAlertController addAction:openPhotosAction];
    
    [imgAlertController addAction:openCameraAction];
    
    [self presentViewController:imgAlertController animated:YES completion:nil];
    
}

//打开相册
-(void)openPhotos{
    
    UIImagePickerController *pickerC = [[UIImagePickerController alloc]init];
    
    //类型
    pickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //设置代理
    pickerC.delegate = self;
    
    //推出
    [self presentViewController:pickerC animated:YES completion:nil];
    
}

//图片被选中后调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //获取点击的图片
    img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _imgV.image = img;
    
    //相册界面消失
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [_imgBtn setTitle:@"更改头像" forState:UIControlStateNormal];
    
    [_imgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
}

//打开相机
-(void)openCamera{
    
    UIImagePickerController *pickerC = [[UIImagePickerController alloc]init];
    
    pickerC.delegate = self;
    
    //设置摄像头是否可用--前置摄像头
    BOOL isFrontCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    
    BOOL isPostCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    
    if (!isFrontCamera && !isPostCamera) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        [alert show];
        
        return;
        
    }else if (!isFrontCamera) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有前置摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        [alert show];
        
        return;
        
    }else if (!isPostCamera) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有后置摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        [alert show];
        
        return;
        
    }
    
    //设置类型是相机
    pickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //推出
    [self presentViewController:pickerC animated:YES completion:nil];
    
    [_imgBtn setTitle:@"更改头像" forState:UIControlStateNormal];
    
    [_imgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
}

//return后收起键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

//点击空白背景收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
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

@end

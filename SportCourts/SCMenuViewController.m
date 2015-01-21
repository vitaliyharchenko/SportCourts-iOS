//
//  SCMenuViewController.m
//  SportCourts
//
//  Created by Vitaliy Harchenko on 07.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCAppDelegate.h"

#import "SCMenuViewController.h"
#import "SCMenuCell.h"

#import "SCProfileViewController.h"
#import "SCUsersTableViewController.h"

#import "SCLoginViewController.h"

NSString * const SCMenuCellReuseIdentifier = @"Menu Cell with Icon";

@interface SCMenuViewController ()

@property (nonatomic, strong) NSDictionary *paneViewControllerTitles;
@property (nonatomic, strong) NSDictionary *paneViewControllerIdentifiers;

@property (nonatomic, strong) UIBarButtonItem *paneStateBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *paneRevealLeftBarButtonItem;

@end

@implementation SCMenuViewController

#pragma mark - NSObject

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

#pragma mark - UIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

// создаем вложенный TableView
- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // присваеваем классы ячейкам меню
    [self.tableView registerClass:[SCMenuCell class] forCellReuseIdentifier:SCMenuCellReuseIdentifier];
    
    //делаем таблицу прозрачной, чтобы видеть фон
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor colorWithWhite:1.0 alpha:0.25];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// поддержка ориентаций кроме как кверх ногами
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

#pragma mark - MSMenuViewController

- (void)initialize
{
    // инициализируем словарь
    self.paneViewControllerType = NSUIntegerMax;
    
    self.paneViewControllerTitles =
    @{
      @(SCPaneViewControllerTypeProfile) : @"Мой профиль",
      @(SCPaneViewControllerTypeUsers) : @"Игроки",
      @(SCPaneViewControllerTypeLogout) : @"Выход"
      };
    
    // присваиваем идентефикаторы соответствующим вьюшкам
    self.paneViewControllerIdentifiers =
    @{
      @(SCPaneViewControllerTypeProfile) : @"Profile",
      @(SCPaneViewControllerTypeUsers) : @"Users",
      @(SCPaneViewControllerTypeLogout) : @"Logout",
      @(SCPaneViewControllerTypeLogin) : @"Login"
      };
}

// функция возвращает соответствующий контроллер по пути нажатой ячейки
- (SCPaneViewControllerType)paneViewControllerTypeForIndexPath:(NSIndexPath *)indexPath
{
    SCPaneViewControllerType paneViewControllerType;
    paneViewControllerType = indexPath.row;
    return paneViewControllerType;
}

// функция перехода на другой контроллер
- (void)transitionToViewController:(SCPaneViewControllerType)paneViewControllerType
{
    // Close pane if already displaying the pane view controller
    if (paneViewControllerType == self.paneViewControllerType) {
        [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateClosed animated:YES allowUserInterruption:YES completion:nil];
        return;
    }
    
    BOOL animateTransition = self.dynamicsDrawerViewController.paneViewController != nil;
    
    // меняем pane view controller на аргумент в запросе
    UIViewController *paneViewController = [self.storyboard instantiateViewControllerWithIdentifier:self.paneViewControllerIdentifiers[@(paneViewControllerType)]];
    
    // ставим заголовок в навигацию
    paneViewController.navigationItem.title = self.paneViewControllerTitles[@(paneViewControllerType)];
    
    #warning переделать иконку меню
    // создаем кнопку, ведущую в меню, определяем экшн для нее, добавляем
    self.paneRevealLeftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Left Reveal Icon"] style:UIBarButtonItemStylePlain target:self action:@selector(dynamicsDrawerRevealLeftBarButtonItemTapped:)];
    paneViewController.navigationItem.leftBarButtonItem = self.paneRevealLeftBarButtonItem;
    
    // создаем navigation controller и на лету добавляем его
    UINavigationController *paneNavigationViewController = [[UINavigationController alloc] initWithRootViewController:paneViewController];
    [self.dynamicsDrawerViewController setPaneViewController:paneNavigationViewController animated:animateTransition completion:nil];
    self.paneViewControllerType = paneViewControllerType;
}

// функция перехода на login контроллер
- (void)transitionToLoginController
{
    
    BOOL animateTransition = self.dynamicsDrawerViewController.paneViewController != nil;
    
    // ищем логин контроллер
    UIViewController *paneViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];

    [self.dynamicsDrawerViewController setPaneViewController:paneViewController animated:animateTransition completion:nil];
    
    self.paneViewControllerType = SCPaneViewControllerTypeLogin;
}

//определяем экшн нажатия левой кнопки
- (void)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
    [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionLeft animated:YES allowUserInterruption:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.paneViewControllerTitles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Menu Cell with Icon" forIndexPath:indexPath];
    
    cell.textLabel.text = self.paneViewControllerTitles[@([self paneViewControllerTypeForIndexPath:indexPath])];
    
    return cell;
}

#pragma mark - UITableViewDelegate

// обработка нажатия
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCPaneViewControllerType paneViewControllerType = [self paneViewControllerTypeForIndexPath:indexPath];
    
    if (paneViewControllerType == SCPaneViewControllerTypeLogout) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"SCSettingUserToken"];
        [userDefaults removeObjectForKey:@"SCSettingUserId"];
        [userDefaults synchronize];
        
        // [self transitionToLoginController];
        
        SCAppDelegate *app = [[UIApplication sharedApplication] delegate];
        [app initWindowWithLogin];
        
        return;
    }
    
    [self transitionToViewController:paneViewControllerType];
    
    // Prevent visual display bug with cell dividers
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    double delayInSeconds = 0.3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.tableView reloadData];
    });
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

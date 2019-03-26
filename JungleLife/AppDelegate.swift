//
//  AppDelegate.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/1.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var list1 = ["Apple","Coffee","Tea","Cake","Banana","Lemon","Cookies","Orange","Milk","Chicken","Candy","Cherry","Pizza","Fish","Ice cream","Soup","Rice","Egg","Cheese","Tomato","Mango","Sandwich","Juice","Steak","Pineapple","Kiwi","Hot dog","Toast","Pear","French fries","Corn","Noodle","Donut","Strawberry","Chocolate","Grape","Pea","Bread","Fried rice","Hamburger","Mushroom","Muffins","Watermelon","Starfruit","Coconut","Cucumber","Meat bun","Potato","Dumplings","Pumpkin","Sugar cane","Broccoli","Guava","Peach","Papaya","Onion","Carrot","Peanut","Green paper","Eggpalant","Pencil","Paper","Brush","Palette","Knife","Chopping block","Kettle","Cup","Mop","Bucket","Broom","Dustpan","Needle","Thread","Pillow","Duvet","Toothbrush","Toothpaste","Towel","Soap","Table lamp","Book","Computer","Mouse","Radio","Recode","Scouring pad","Dish soap","Chopsticks","Bowl","Spatula","Pot","Wrench","Screwdriver","Saws","Ax","Sprinklers","Water pipe","Television","Remote control","Jump rope","Dumbbell","Iron","Ironing board","Clothes","Washboard","Comb","Mirror","Detergent","Scrub brushes","Eagle","Rabbit","Fox","Turkey","Bear","Gorilla","Horse","Giraffe","Monkey","Elephant","Frog","Owl","Squirrel","Lion","Hippo","Zebra","Snake","Coon","Wolf","Tiger","Sloth","Deer","Bat","Kangaroo","Ostrich","Peacock","Duck","Yak","Parrot","Goat","Rhinoceros","Crow","Koala","Turtle","Donkey","Goose","Crocodile","Panda","Wild boar","Leopard","Anteater","Platypus","Alpaca","Taiwan black bear","Vulture","Flamingo","Malayan tapir","Lizard","Leopard cat","Sugar glider","Pangolin","Meerket","Sparrow","Hedgehog","Chameleon","Groundhog","Skunk","Woodpecker","Heron","Penguin"]

    
    var list2 = ["蘋果","咖啡","茶","蛋糕","香蕉","檸檬","餅乾","橘子","牛奶","雞","糖果","櫻桃","披薩","魚","冰淇淋","湯","飯","蛋","起司","番茄","芒果","三明治","果汁","牛排","鳳梨","奇異果","熱狗","吐司","梨子","薯條","玉米","麵","甜甜圈","草莓","巧克力","葡萄","豌豆","麵包","炒飯","漢堡","香菇","鬆餅","西瓜","楊桃","椰子","小黃瓜","包子","馬鈴薯","水餃","南瓜","甘蔗","花椰菜","芭樂","桃子","木瓜","洋蔥","紅蘿蔔","花生","青椒","茄子","鉛筆","紙","畫筆","調色盤","刀","沾板","茶壺","杯子","拖把","水桶","掃把","畚箕","針","線","枕頭","棉被","牙刷","牙膏","毛巾","肥皂","檯燈","書","電腦","滑鼠","收音機","唱片","菜瓜布","洗碗精","筷子","碗","鍋鏟","鍋子","板手","螺絲起子","鋸子","斧頭","噴水器","水管","電視","遙控器","跳繩","啞鈴","熨斗","熨斗板","衣服","洗衣板","梳子","鏡子","清潔劑","刷子","老鷹","兔子","狐狸","火雞","熊","猩猩","馬","長頸鹿","猴子","大象","青蛙","貓頭鷹","松鼠","獅子","河馬","斑馬","蛇","浣熊","狼","老虎","樹懶","鹿","蝙蝠","袋鼠","鴕鳥","孔雀","鴨子","犛","鸚鵡","山羊","犀牛","烏鴉","無尾熊","烏龜","驢子","鵝","鱷魚","熊貓","山豬","豹","食蟻獸","鴨嘴獸","羊駝","臺灣黑熊","禿鷹","紅鶴","馬萊摩","蜥蜴","狸貓","蜜袋鼬","穿山甲","狐獴","麻雀","刺蝟","變色龍","土撥鼠","臭鼬","啄木鳥","白鷺鷥","企鵝"]
    
    
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //推播
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted == false {
                print("使用者未授權")
            }
        }
        
        center.setNotificationCategories(Set<UNNotificationCategory>())
        center.delegate = self
        sendNotification()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "JungleLife")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Jungle Life"
        content.body = "快來使用英文能力擊敗獵人吧！"
        content.badge = 0
        content.sound = UNNotificationSound.default
        
        var date = DateComponents()
        date.hour = 12
        
        
        let imageURL:URL = Bundle.main.url(forResource: "Crow1", withExtension: "png")!
        let attachment = try! UNNotificationAttachment(identifier: "image", url: imageURL, options: nil)
        content.attachments = [attachment]
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let request = UNNotificationRequest(identifier: "myid", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("在前景收到通知")
        completionHandler()
    }

}


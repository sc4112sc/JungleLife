//
//  WordViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/15.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit

class WordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var g1Words = ["Apple","Coffee","Tea","Cake","Banana","Lemon","Cookies","Orange","Milk","Chicken","Candy","Cherry","Pizza","Fish","Ice cream","Soup","Rice","Egg","Cheese","Tomato","Mango","Sandwich","Juice","Steak","Pineapple","Kiwi","Hot dog","Toast","Pear","French fries","Corn","Noodle","Donut","Strawberry","Chocolate","Grape","Pea","Bread","Fried rice","Hamburger","Mushroom","Muffins","Watermelon","Starfruit","Coconut","Cucumber","Meat bun","Potato","Dumplings","Pumpkin","Sugar cane","Broccoli","Guava","Peach","Papaya","Onion","Carrot","Peanut","Green paper","Eggpalant"]
    let g2Words = ["Pencil","Paper","Brush","Palette","Knife","Chopping block","Kettle","Cup","Mop","Bucket","Broom","Dustpan","Needle","Thread","Pillow","Duvet","Toothbrush","Toothpaste","Towel","Soap","Table lamp","Book","Computer","Mouse","Radio","Recode","Scouring pad","Dish soap","Chopsticks","Bowl","Spatula","Pot","Wrench","Screwdriver","Saws","Ax","Sprinklers","Water pipe","Television","Remote control","Jump rope","Dumbbell","Iron","Ironing board","Clothes","Washboard","Comb","Mirror","Detergent","Scrub brushes"]
    let g3Words = ["Eagle","Rabbit","Fox","Turkey","Bear","Gorilla","Horse","Giraffe","Monkey","Elephant","Frog","Owl","Squirrel","Lion","Hippo","Zebra","Snake","Coon","Wolf","Tiger","Sloth","Deer","Bat","Kangaroo","Ostrich","Peacock","Duck","Yak","Parrot","Goat","Rhinoceros","Crow","Koala","Turtle","Donkey","Goose","Crocodile","Panda","Wild boar","Leopard","Anteater","Platypus","Alpaca","Taiwan black bear","Vulture","Flamingo","Malayan tapir","Lizard","Leopard cat","Sugar glider","Pangolin","Meerket","Sparrow","Hedgehog","Chameleon","Groundhog","Skunk","Woodpecker","Heron","Penguin"]
    
    let g1WordsCh = ["蘋果","咖啡","茶","蛋糕","香蕉","檸檬","餅乾","橘子","牛奶","雞","糖果","櫻桃","披薩","魚","冰淇淋","湯","飯","蛋","起司","番茄","芒果","三明治","果汁","牛排","鳳梨","奇異果","熱狗","吐司","梨子","薯條","玉米","麵","甜甜圈","草莓","巧克力","葡萄","豌豆","麵包","炒飯","漢堡","香菇","鬆餅","西瓜","楊桃","椰子","小黃瓜","包子","馬鈴薯","水餃","南瓜","甘蔗","花椰菜","芭樂","桃子","木瓜","洋蔥","紅蘿蔔","花生","青椒","茄子"]
    let g2WordsCh = ["鉛筆","紙","畫筆","調色盤","刀","沾板","茶壺","杯子","拖把","水桶","掃把","畚箕","針","線","枕頭","棉被","牙刷","牙膏","毛巾","肥皂","檯燈","書","電腦","滑鼠","收音機","唱片","菜瓜布","洗碗精","筷子","碗","鍋鏟","鍋子","板手","螺絲起子","鋸子","斧頭","噴水器","水管","電視","遙控器","跳繩","啞鈴","熨斗","熨斗板","衣服","洗衣板","梳子","鏡子","清潔劑","刷子"]
    let g3WordsCh = ["老鷹","兔子","狐狸","火雞","熊","猩猩","馬","長頸鹿","猴子","大象","青蛙","貓頭鷹","松鼠","獅子","河馬","斑馬","蛇","浣熊","狼","老虎","樹懶","鹿","蝙蝠","袋鼠","鴕鳥","孔雀","鴨子","犛","鸚鵡","山羊","犀牛","烏鴉","無尾熊","烏龜","驢子","鵝","鱷魚","熊貓","山豬","豹","食蟻獸","鴨嘴獸","羊駝","臺灣黑熊","禿鷹","紅鶴","馬萊摩","蜥蜴","狸貓","蜜袋鼬","穿山甲","狐獴","麻雀","刺蝟","變色龍","土撥鼠","臭鼬","啄木鳥","白鷺鷥","企鵝"]
    
    @IBOutlet weak var myTableView: UITableView!
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return g1Words.count
        }else if section == 1 {
            return g2Words.count
        }else{
            return g3Words.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = g1Words[indexPath.row]
            cell.detailTextLabel?.text = g1WordsCh[indexPath.row]
            cell.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
            cell.imageView?.image = UIImage(named: g1Words[indexPath.row]+"1")
        } else if indexPath.section == 1 {
            cell.textLabel?.text = g2Words[indexPath.row]
            cell.detailTextLabel?.text = g2WordsCh[indexPath.row]
            cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            cell.imageView?.image = UIImage(named: g2Words[indexPath.row]+"1")
        } else {
            cell.textLabel?.text = g3Words[indexPath.row]
            cell.detailTextLabel?.text = g3WordsCh[indexPath.row]
            cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cell.imageView?.image = UIImage(named: g3Words[indexPath.row]+"1")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "FRUIT"
        }else if section == 1 {
            return "TOOL"
        }else{
            return "ANIMAL"
        }
    }
    
    @IBAction func calMove(_ sender: UIBarButtonItem) {
        if sender.title! == "Edit"{
            sender.title = "Done"
            myTableView.isEditing = true
        } else {
            sender.title = "Edit"
            myTableView.isEditing = false
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tmp = g1Words[sourceIndexPath.row]
        g1Words.remove(at: sourceIndexPath.row)
        g1Words.insert(tmp, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func calBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

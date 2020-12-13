//
//  Page1ViewController.swift
//  Swift5introApp2
//
//  Created by 玉城秀大 on 2020/12/13.
//

import UIKit
import SegementSlide

class Page5ViewController: UITableViewController,SegementSlideContentScrollViewDelegate,XMLParserDelegate {
    
    //XMLParserのインスタンスを作成
    var parser = XMLParser()
    
    //RSSのパース内の現在の要素名
    var currentElementName:String!
    
    var newsItems = [NewsItems]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .clear
        //画像をtableViewの下に置く
        let image = UIImage(named: "4")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: tableView.frame.size.height))
        imageView.image = image  //画像を反映
        self.tableView.backgroundView = imageView
        
        //XMLパース
        let urlString = "https://news.yahoo.co.jp/rss/media/bballk/all.xml"
        let  url:URL = URL(string: urlString)!
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.parse()
        
        
        
        
    }
    
    @objc var scrollView: UIScrollView {
        return tableView
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //1つのセクション中のセルの数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 5
    }

    
    //セルを構築・設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")  //UITableViewを親に持つとこう書ける

        cell.backgroundColor = .clear
        
        let newsItem =  self.newsItems[indexPath.row]
        cell.textLabel?.text = newsItem.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .white
        cell.textLabel?.numberOfLines = 3  //最大の行数
        cell.detailTextLabel?.text = newsItem.url
        cell.detailTextLabel?.textColor = .white

        return cell
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElementName = nil
        //もしXMLパースの中で、elementNameがitemという要素に当たったら、newsItemsを初期化(実体化)した物をnewsItemsに入れる(NewsItemsは、ModelクラスにあるNewsItems.swiftのこと)
        if elementName == "item" {
            self.newsItems.append(NewsItems())
        }else {
            currentElementName = elementName
            //currentElementNameにelementName(格要素)を全部入れている状態
            //まだ配列の中には入っていない状態
        }
    }

    //目的のものがあった場合、階層上 itemの下にある要素(title,url,pubDate)を判定して、入れる
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if self.newsItems.count > 0 {
            
            //lastItemには、title,url,pubDate全部入ってる
            let lastItem = self.newsItems[self.newsItems.count - 1]
            switch self.currentElementName {
            case "title":
                lastItem.title = string  //ここのstringは、上のfoundCharacters(見つかった物)の変数のこと
            case "link":
                lastItem.url = string
            case "pubDate":
                lastItem.pubDate = string
            default:
                break
            }
        }
    }
    
    //didEndElementは、下のようなXMLデータの</title>の部分に来た時の処理
    //<title>タイトル</title>
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        self.currentElementName = nil
        //currentElementNameを空にして、次の要素が入るようにしている
    }
    
    //parserの処理が全部終わったらする処理
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()  //全部のセルをアップデート（全部のニュースがテーブルビューに表示される）
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //WebViewControllerにurlを渡して表示
        let webViewController = WebViewController() //WebViewControllerを定数として生成
        webViewController.modalTransitionStyle = .crossDissolve
        let newsItem = newsItems[indexPath.row] //タップされた番号(indexpath.row)の格要素が入る
        UserDefaults.standard.set(newsItem.url, forKey: "url")
        present(webViewController, animated: true, completion: nil)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


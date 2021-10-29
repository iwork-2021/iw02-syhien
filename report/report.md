# iw02 杨茂琛 191180164

## 概述

iOS代办事项App开发

## Demo

在线查看Demo演示视频：https://www.bilibili.com/video/BV1bq4y1R7PD/

## 需求

1. 待办事项的添加、修改、删除
2. 以Table视图展示待办事项列表
3. 个性化界面

## 技术细节

### 视图布局

#### TableView 展示待办事项

```
TableView
	TableCell
		label // 事项内容
		label // 完成情况
```

#### View 事项编辑

```
View
	
```



### 事项的存储

定义了类`JobToDo`包含两个成员：

- `title: String`表示事项的描述
- `isFinished: Bool`表示事项的完成情况

在`T0DoTableViewController`中定义数组`jobs`存储所有的事项，并实现两个方法以从`json`读取事项或保存事项：

```swift
    func saveAll() {
        do {
            let data = try JSONEncoder().encode(jobs)
            try data.write(to: dataFilePath(), options: .atomic)
        } catch {
            print("Unable to save: \(error.localizedDescription)")
        }
    }
    
    func loadAll() {
        if let data = try? Data(contentsOf: dataFilePath()) {
            do {
                jobs = try JSONDecoder().decode([JobToDo].self, from: data)
            } catch {
                print("Error loading from: \(error.localizedDescription)")
            }
        }
    }
```

在类`T0DoTableViewController`的初始化视图方法`viewDidLoad`中调用自己的`loadAll`方法，以实现读取

在类`SceneDelegate`的`sceneDidDisconnect`和`sceneDidEnterBackground`两方法中调用`T0DoTableViewController`的`saveAll`方法，以实现保存

### TableCell左右滑动

#### 左滑以删除

覆盖`editingStyle`即自动允许左滑，在左滑中实现对`jobs`的内容的修改并即时更新TableView

```
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        jobs.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
```

#### 右滑标为完成或未完成

覆盖`leadingSwipeActionsConfigurationForRowAt`即自动允许右滑，方法返回一个`UISwipeActionsConfiguration`其实就是一个actions的数组

实现两个方法`finishAction`、`unfinishAction`将事项标记为完成、未完成，**不会考虑事项原先的状态，不会触发事项排序**

*此处有个问题是，右滑我总感觉没有左滑那么自然、流畅*

ViewController中没有刻意禁止右滑到底，右滑到底将触发第1个action即`finishAction`

```swift
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let finishAction = UIContextualAction(style: .normal, title: "✅") { (action, view, completionHandler) in
            self.jobs[indexPath.row].isFinished = true
            completionHandler(true)
            self.tableView.reloadData()
        }
        finishAction.backgroundColor = .green
        let unfinishAction = UIContextualAction(style: .normal, title: "🥱") { (action, view, completionHandler) in
            self.jobs[indexPath.row].isFinished = false
            completionHandler(true)
            self.tableView.reloadData()
        }
        unfinishAction.backgroundColor = .orange
        return UISwipeActionsConfiguration(actions: [finishAction, unfinishAction])
    }
```

### 视图切换与视图协作


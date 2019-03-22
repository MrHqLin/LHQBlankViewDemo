# LHQBlankViewDemo
# Swift 自定义空界面占位图
```
@objc func tap(sender: UIButton) -> Void {
        switch sender.tag {
        case 0:
            self.view.configEasyBlankPageView(type: .noNetwork, hasData: true, reload: nil)
        case 1:
            self.view.configEasyBlankPageView(type: .noNetwork, hasData: false) {
                print("nodata")
            }
        case 2:
            self.view.configEasyBlankPageView(type: .loading, hasData: false, reload: nil)
        case 3:
            self.view.configEasyBlankPageView(type: .error, hasData: false) {
                print("error")
            }
        default: break
            
        }
    }
```

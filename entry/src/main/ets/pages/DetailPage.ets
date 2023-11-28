import web_webview from '@ohos.web.webview';
import router from '@ohos.router';
import Toolbar from './Toolbar';

@Entry
@Component
export default struct DetailPage {
  private webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  @State params: Object = ""
  @State url: string = ""
  @State title: string = ""
  @State visibilityUp: boolean = false

  aboutToAppear() {
    let params = router.getParams();
    this.url = params['link']
    this.title = params['title']
  }

  build() {
    Column() {
      Toolbar({ title: this.title, bgColor: '#ffffff', backOnClick: () => {
        if (this.webviewController.accessBackward()) {
          this.webviewController.backward();
        } else {
          router.back()
        }
      } })

      Stack({ alignContent: Alignment.Center }) {
        Web({ src: this.url, controller: this.webviewController })
          .onScroll(event => {
            this.visibilityUp = event.yOffset > 500
          }).width('100%')
          .height('100%')

        Image($r('app.media.ic_arrowup'))
          .width(40)
          .height(40)
          .padding(8)
          .align(Alignment.BottomEnd)
          .shadow({ radius: 4 })
          .backgroundColor("#ffe0dede")
          .visibility(this.visibilityUp ? Visibility.Visible : Visibility.Hidden)
          .clip(true) // 如这里不设置clip为true，则Row组件的圆角不会限制其中的Image组件，Image组件的四个角会超出Row
          .borderRadius(50)
          .onClick(ev => {
            this.webviewController.scrollTo(0,0)
          })
      }
    }
  }
}
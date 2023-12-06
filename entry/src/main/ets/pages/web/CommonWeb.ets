import web_webview from '@ohos.web.webview';
import router from '@ohos.router';
import Toolbar from '../Toolbar'
import PermissionUtil from '../../utils/PermissionUtil';

@Entry
@Preview
@Component
export default struct CommonWeb {
  private webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  @State params: Object = ""
  @State url: string = ""
  @State title: string = ""

  aboutToAppear() {
    // let params = router.getParams();
    // this.url = params['url']
    // this.title = params['title']
  }

  build() {
    Column() {
      Toolbar({ title: this.title })
      Web({ src: this.url, controller: this.webviewController })
        .onScroll(event => {

        })
        .width('100%')
        .height('100%')
    }
  }
}
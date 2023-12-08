import web_webview from '@ohos.web.webview';
import router from '@ohos.router';
import Toolbar from '../Toolbar'
import PermissionUtil from '../../utils/PermissionUtil';
import LocationUtil from '../../utils/LocationUtil';
import Jssdk from './Jssdk';

@Entry
@Preview
@Component
export default struct CommonWeb {
  private webviewController: web_webview.WebviewController = new web_webview.WebviewController();
  @State params: Object = ""
  @State url: string = ""
  @State title: string = ""
  @State testObj: Jssdk = new Jssdk()

  aboutToAppear() {
    // let params = router.getParams();
    // this.url = params['url']
    // this.title = params['title']
    this.getLocation();
  }

  onPageShow() {
    try {
      this.webviewController.registerJavaScriptProxy(this.testObj, "android", ["getLocation"]);
    } catch (error) {
      // let e: business_error.BusinessError = error as business_error.BusinessError;
      console.error(`ErrorCode: ${JSON.stringify(error)}`);
    }
  }

  getLocation() {

    LocationUtil.getCurrentLocation()
      .then(location => {

        console.log('locationChanger: location=' + JSON.stringify(location));
      }).catch(err => {
      console.log('locationChanger: location=' + JSON.stringify(err));
    })
  }

  build() {
    Column() {
      Toolbar({ title: this.title })
      Web({ src: this.url, controller: this.webviewController })
        .onScroll(event => {

        })
        .onAlert((event) => {
          return true
        })
        .width('100%')
        .height('100%')
    }
  }
}
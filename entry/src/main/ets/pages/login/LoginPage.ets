import { httpPost } from '../../utils/HttpUtil'
import { Api } from '../net/ApiConstants'
import Toolbar from '../Component/Toolbar'
import promptAction from '@ohos.promptAction'
import router from '@ohos.router'
import PreferencesUtil from '../../utils/PreferencesUtil';

@Entry
@Component
@Preview
export default struct LoginPage {
  @State loginName: string = ""
  @State password: string = ""
  @State clickable: boolean = false
  @State btnOpacity: number = 0.4

  aboutToAppear(){
    PreferencesUtil.getInstance().get("password")
      .then((data)=>{
        this.password = <string>data
      }).catch(err=>{
      console.error(err)
    })
    PreferencesUtil.getInstance().get("loginName")
      .then((data)=>{
        this.loginName = <string>data
      }).catch(err=>{
      console.error(err)
    })
  }

  @Builder NavigationTitle() {
    Column() {
      Text($r('app.string.login'))
        .fontColor('#182431')
        .fontSize(20)
        .lineHeight(41)
        .fontWeight(700)
    }.alignItems(HorizontalAlign.Start)
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {

    Navigation() {
      Column() {
        TextInput({ placeholder: $r('app.string.login_placeholder'), text: this.loginName })
          .height(45)
          .onChange(string => {
            this.loginName = string
            this.checkInput()
          })

        TextInput({ placeholder: $r('app.string.password_placeholder'), text: this.password })
          .type(InputType.Password)
          .height(45)
          .margin({ top: 20 })
          .onChange(string => {
            this.password = string
            this.checkInput()
          })

        Button($r('app.string.login'), { stateEffect: this.clickable })
          .onClick(ev => {
            this.login()
          })
          .width('100%')
          .height(45)
          .touchable(this.clickable)
          .opacity(this.btnOpacity)
          .backgroundColor($r('app.color.blue'))
          .margin({ top: 20, bottom: 20 })

        Text($r('app.string.register'))
          .onClick(ev => {
            router.pushUrl({ url: "pages/login/RegisterPage" })
          })
      }.width('90%')
      .margin({ top: 50 })
    }
    .title(this.NavigationTitle)
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
  }

  /**
   *
   */
  checkInput() {
    this.clickable = !(this.loginName == "" || this.password == "")
    this.btnOpacity = this.clickable ? 1 : 0.4
  }

  login() {
    let par = {
      username: this.loginName,
      password: this.password
    }
    // + `?username=${this.loginName}&password=pass`
    httpPost(Api.user.login + `?username=${encodeURIComponent(this.loginName)}&password=${this.password}`, {}, data => {
      promptAction.showToast({ message: "登录成功" })
      router.replaceUrl({ url: "pages/main/MainPage" })
      this.saveCookie(data)
    }, error => {
      promptAction.showToast({ message: error })
    })
  }

  saveCookie(data) {

    PreferencesUtil.getInstance().put("user", JSON.stringify(data))
      .then(()=>{
        console.info("success")
      }).catch(err=>{
        console.error(err)
    })

    PreferencesUtil.getInstance().put("loginName", this.loginName)
      .then(()=>{
        console.info("success")
      }).catch(err=>{
        console.error(err)
    })
    PreferencesUtil.getInstance().put("password", this.password)
      .then(()=>{
        console.info("success")
      }).catch(err=>{
        console.error(err)
    })
    PreferencesUtil.getInstance().flush()
      .then(()=>{
        console.info("success")
      }).catch(err=>{
        console.error(err)
    })
  }
}
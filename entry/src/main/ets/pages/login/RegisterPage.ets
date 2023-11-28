import { httpPost } from '../../utils/HttpUtil'
import { Api } from '../net/ApiConstants'

@Component
@Entry
export default struct RegisterPage {
  @State loginName: string = ""
  @State password: string = ""
  @State rePassword: string = ""
  @State clickable: boolean = false
  @State loginBtnBg: Resource = $r('app.color.disable')

  @Builder NavigationTitle() {
    Column() {
      Text($r('app.string.register'))
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
        TextInput({ placeholder: $r('app.string.login_placeholder') })
          .height(45)
          .onChange(string => {
            this.loginName = string
            this.checkInput()
          })

        TextInput({ placeholder: $r('app.string.password_placeholder') })
          .type(InputType.Password)
          .height(45)
          .margin({ top: 20 })
          .onChange(string => {
            this.password = string
            this.checkInput()
          })

        TextInput({ placeholder: $r('app.string.re_password_placeholder') })
          .type(InputType.Password)
          .height(45)
          .margin({ top: 20 })
          .onChange(string => {
            this.rePassword = string
            this.checkInput()
          })

        Button($r('app.string.register', { stateEffect: this.clickable }))
          .onClick(ev => {
            this.registerUser()
          })
          .width('100%')
          .height(45)
          .touchable(this.clickable)
          .backgroundColor(this.loginBtnBg)
          .margin({ top: 20, bottom: 20 })

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
    this.clickable = !(this.loginName == "" || this.password == "" || this.rePassword == "")
    this.loginBtnBg = this.clickable ? $r('app.color.disable') : $r('app.color.blue')
  }

  registerUser() {
    httpPost(Api.user.register,{}, data => {

    }, error => {

    })
  }
}
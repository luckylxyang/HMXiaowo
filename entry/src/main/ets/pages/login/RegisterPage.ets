import { httpPost } from '../../utils/HttpUtil'
import { Api } from '../net/ApiConstants'

@Component
@Entry
export default struct RegisterPage {
  @State loginName: string = ""
  @State password: string = ""
  @State rePassword: string = ""
  @State clickable: boolean = false
  @State btnOpacity: number = 0.4

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
          .opacity(this.btnOpacity)
          .backgroundColor($r('app.color.blue'))
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
    this.btnOpacity = this.clickable ? 1 : 0.4
  }

  registerUser() {
    httpPost(Api.user.register,{}, data => {

    }, error => {

    })
  }
}
import Toolbar from '../Toolbar'

@Entry
@Component
@Preview
export default struct LoginPage {
  @State loginName: string = ""
  @State password: string = ""
  @State clickable: boolean = false
  @State loginBtnBg: Resource =

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

        Button($r('app.string.login')).onClick(ev => {
          console.info("clicked me")
        }).width('100%')
          .height(45)
          .touchable(this.clickable)
          .margin({ top: 20, bottom: 20 })

        Text($r('app.string.register'))
          .onClick(ev => {

          })
      }.width('90%')
      .margin({ top: 50 })
    }
    .title(this.NavigationTitle)
    .mode(NavigationMode.Stack)
    .titleMode(NavigationTitleMode.Mini)
  }

  checkInput() {
    console.log("accc")
    this.clickable = !(this.loginName == "" || this.password == "")
  }
}
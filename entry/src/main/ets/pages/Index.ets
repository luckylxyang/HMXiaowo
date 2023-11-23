import httpGet from '../utils/HttpUtil'
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  path: Resource = $r('app.media.home')

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Image(this.path)
          .width(24)
          .height(24)
          .onClick(ev=>{
             let url = 'https://www.wanandroid.com/article/list/1/json'
            // httpGet(url)
          })

        TextInput({ placeholder: 'search...' })
          .width('90%')
          .height(40)
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })
      }
      .width('100%')
    }
    .height('100%')
  }
}
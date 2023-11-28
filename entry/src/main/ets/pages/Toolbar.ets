import router from '@ohos.router';

@Preview
@Component
export default struct Toolbar {
  @Link title: string
  @State bgColor: string = '#FFFFFF'
  private backOnClick: () => void

  build() {
    Row() {
      Image($r('app.media.ic_back'))
        .width(24)
        .height(24)
        .margin(12)
        .onClick(event => {
          if (this.backOnClick) {
            this.backOnClick()
          } else {
            router.back()
          }
        })
      Text(this.title)
        .maxLines(1)
        .textAlign(TextAlign.Center)
        .textOverflow({overflow: TextOverflow.Ellipsis})
        .layoutWeight(1)
        .margin(10)

      Image($r('app.media.ic_more'))
        .width(24)
        .height(24)
        .margin(12)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .height(50)
    .backgroundColor(this.bgColor)
    .shadow({radius: 3})
  }
}
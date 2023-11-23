/**
 * 个人主页
 */
@Preview
@Entry
@Component
export default struct PersonPage {
  build() {
    Column() {
      Text($r('app.string.title'))
      Text($r('app.string.my_collect'))
    }.height('100%')
    .width(200)

  }
}
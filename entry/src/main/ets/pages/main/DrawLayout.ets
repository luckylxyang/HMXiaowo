import MainPage from './MainPage'
import PersonPage from './PersonPage'


@Preview
@Entry
@Component
export default struct DrawLayout {
  build() {
    Column() {

      // RelativeContainer() {
      //   // Row() {
      //   //   PersonPage()
      //   // }
      //   // .width('100%')
      //   // .height('100%')
      //   // .backgroundColor("#FF9966")
      //   // .id("person")
      //
      //   Row() {
      //     MainPage()
      //   }
      //   .backgroundColor("#FF66FF")
      //   .id("mainPage")
      //   .width('100%')
      //   .height('100%')
      // }
      // .width('100%')
      // .height('100%')

      MainPage()
    }
    .height('100%')
  }
}

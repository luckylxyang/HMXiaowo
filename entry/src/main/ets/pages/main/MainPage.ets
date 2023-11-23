
import HomePage from '../home/HomePage'

@Entry
@Component
export default struct MainPage {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  @State currentIndex: number = 0
  @State Build: Array<Object> = [
    {
      text: '首页',
      num: 0,
      iconId: $r('app.media.home'),
      selectIconId: $r('app.media.home_select')
    },
    {
      text: '导航',
      num: 1,
      iconId: $r('app.media.icon_bag'),
      selectIconId: $r('app.media.icon_bag_select')
    },
    {
      text: '体系',
      num: 2,
      iconId: $r('app.media.person'),
      selectIconId: $r('app.media.person_select')
    },
    {
      text: '项目',
      num: 3,
      iconId: $r('app.media.person'),
      selectIconId: $r('app.media.person_select')
    },
    {
      text: '公众号',
      num: 4,
      iconId: $r('app.media.person'),
      selectIconId: $r('app.media.person_select')
    }
  ]

  @Builder NavigationTitle() {
    Column() {
      Text('Title')
        .fontColor('#182431')
        .fontSize(30)
        .lineHeight(41)
        .fontWeight(700)
      Text('subtitle')
        .fontColor('#182431')
        .fontSize(14)
        .lineHeight(19)
        .opacity(0.4)
        .margin({ top: 2, bottom: 20 })
    }.alignItems(HorizontalAlign.Start)
  }

  @Builder NavigationMenus() {
    Row() {
      Image('common/navigation_icon1.svg')
        .width(24)
        .height(24)
      Image('common/navigation_icon1.svg')
        .width(24)
        .height(24)
        .margin({ left: 24 })
      Image('common/navigation_icon2.svg')
        .width(24)
        .height(24)
        .margin({ left: 24 })
    }
  }

  @Builder NavigationToolbar() {
    Row() {
      ForEach(this.Build, item => {
        Column() {
          Image(this.currentIndex == item.num ? item.selectIconId : item.iconId)
            .width(24)
            .height(24)
          Text(item.text)
            .fontColor(this.currentIndex == item.num ? '#007DFF' : '#182431')
            .fontSize(10)
            .lineHeight(14)
            .fontWeight(500)
            .margin({ top: 3 })
        }.width(104).height(56)
        .onClick(() => {
          this.currentIndex = item.num
        })
      })
    }.margin({ left: 24 })
  }

  build() {
    Column() {
      Navigation() {
        HomePage()
      }
      .title(this.NavigationTitle)
      .menus(this.NavigationMenus)
      .titleMode(NavigationTitleMode.Full)
      .toolBar(this.NavigationToolbar)
      .hideTitleBar(false)
      .hideToolBar(false)
      .mode(NavigationMode.Auto)
      .onTitleModeChange((titleModel: NavigationTitleMode) => {
        console.info('titleMode' + titleModel)
      })
    }.width('100%').height('100%').backgroundColor('#F1F3F5')
  }
}
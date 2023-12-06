import HomePage from '../home/HomePage'
import OfficePage from '../office/OfficePage'
import ProjectPage from '../project/ProjectPage'
import Map from '../web/Map'

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
      selectIconId: $r('app.media.home_select'),
    },
    {
      text: '导航',
      num: 1,
      iconId: $r('app.media.icon_bag'),
      selectIconId: $r('app.media.icon_bag_select'),
    },
    {
      text: '体系',
      num: 2,
      iconId: $r('app.media.person'),
      selectIconId: $r('app.media.person_select'),
    },
    {
      text: '项目',
      num: 3,
      iconId: $r('app.media.person'),
      selectIconId: $r('app.media.person_select'),
    },
    {
      text: '公众号',
      num: 4,
      iconId: $r('app.media.person'),
      selectIconId: $r('app.media.person_select'),
    }
  ]

  @Builder TabBuilder(item: any) {
    Column() {
      Image(this.currentIndex == item.num ? item.selectIconId : item.iconId)
        .size({ width: 25, height: 25 })
      Text(item.text)
        .fontColor(this.currentIndex == item.num ? '#1698CE' : '#6B6B6B')
    }
    .height(50)
    .justifyContent(FlexAlign.Center)
    .width('100%')
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          HomePage()
            .width('100%')
            .height('100%')
        }
        .tabBar(this.TabBuilder(this.Build[0]))

        TabContent() {
          Map()
            .width('100%')
            .height('100%')
        }
        .tabBar(this.TabBuilder(this.Build[1]))

        TabContent() {
          ProjectPage()
            .width('100%')
            .height('100%')
        }
        .tabBar(this.TabBuilder(this.Build[2]))

        TabContent() {
          ProjectPage()
            .width('100%')
            .height('100%')
        }
        .tabBar(this.TabBuilder(this.Build[3]))

        TabContent() {
          OfficePage()
            .width('100%')
            .height('100%')
        }
        .tabBar(this.TabBuilder(this.Build[4]))
      }.barMode(BarMode.Fixed)
      .onChange(index => {
        this.currentIndex = index
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}